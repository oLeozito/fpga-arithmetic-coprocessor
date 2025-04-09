# Coprocessador para Operações entre Matrizes

## 📌 Introdução - Sobre o Projeto

Na disciplina MI - Sistemas Digitais do semestre 2025.1, foi proposto como primeiro problema o desenvolvimento de um **coprocessador** capaz de realizar operações entre matrizes até 5x5, de modo que cada elemento da matriz é representado por um **número inteiro de 8 bits**, utilizando uma **FPGA na placa DE1-SoC**. O sistema conta com módulos dedicados para operações matriciais e gerenciamento de memória. O projeto foi desenvolvido em **Verilog HDL** e modularizado de acordo com as operações, além do acesso e gerenciamento de memória da placa.

### ✨ Funcionalidades Implementadas
O coprocessador pode executar as seguintes operações:

- **Adição** de duas matrizes
- **Subtração** de duas matrizes
- **Multiplicação** entre matrizes
- **Multiplicação por um inteiro**
- **Cálculo da matriz transposta**
- **Cálculo da matriz oposta**
- **Cálculo do determinante**

Na seção de **Metodologia**, serão descritos os processos envolvidos no desenvolvimento do software, como as escolhas de abordagem, a definição dos requisitos e funcionalidades, e a ordem de codificação. Na seção de **Conclusão**, serão informadas brevemente as conclusões e os objetivos cumpridos. Por fim, na seção de **Referências**, serão listadas as fontes utilizadas para a elaboração da resolução.

## 🏗️ Metodologia - Arquitetura do Sistema
O projeto é composto pelos seguintes módulos principais:

### 🔹 Módulos de Operação

1. **`modulo_somador_subtrator.v`** - Realiza a soma e subtração de duas matrizes.
2. **`modulo_multiplicador.v`** - Implementa a multiplicação de duas matrizes ou entre uma matriz e um número inteiro.
3. **`modulo_transpor.v`** - Gera a matriz transposta.
4. **`modulo_oposto.v`** - Calcula a matriz oposta.
5. **`modulo_determinante.v`** - Calcula o determinante da matriz.

### 🔹 Módulos de Memória

1. **`fluxo_ram.v`** - Implementa uma memória RAM de porta única para armazenar os valores das matrizes.
2. **`gerencia_matriz.v`** - Responsável por inicializar e gravar duas matrizes 5×5 na RAM ao receber um sinal de `start`.

### 🔹 Módulos de Gerenciamento

1. **`main.v`** - Código principal, que chama e relaciona todas os módulos do projeto.
2. **`unidade_logica.v`** - Responsável pela seleção de qual operação será exibida na memória.

### 🧠 Lógica Desenvolvida

Para a implementação das operações, foi necessário utilizar os métodos para gerenciamento de mémoria e de envio de sinais:

  - Limitação de bits na saída
  - Repretação por meio de complemento a dois
  - Tratamento de overflow
  - Máquina de Estados

### 📑 Descrição de módulos fundamentais

#### 📝 Módulos de Cálculo de Determinante

Este sistema implementa módulos Verilog para o cálculo de determinantes de matrizes 2x2, 3x3 e 4x4, utilizando multiplicações, subtrações e cofactoração. Os módulos são organizados hierarquicamente, favorecendo a reutilização e a modularidade.

#### `mod_determinante_2x2`

Calcula o determinante de uma matriz 2x2 utilizando a fórmula clássica:

\[
\text{det} =
\begin{vmatrix}
a & b \\
c & d
\end{vmatrix}
= ad - bc
\]

**Entradas:**

- `a, b, c, d` (`[7:0]`): Elementos da matriz.

**Saída:**

- `resultado` (`[7:0]`): Valor do determinante.

Este módulo utiliza dois módulos auxiliares de multiplicação (`mod_mult`) para calcular `ad` e `bc`.

#### `mod_det_3x3`

Calcula o determinante de uma matriz 3x3 com a regra de Sarrus ou cofactores da primeira linha:

\[
\text{det} =
\begin{vmatrix}
a & b & c \\
d & e & f \\
g & h & i
\end{vmatrix}
= a(ei - fh) - b(di - fg) + c(dh - eg)
\]

**Entradas:**

- `a` até `i` (`signed [7:0]`): Elementos da matriz 3x3.

**Saída:**

- `resultado` (`signed [7:0]`): Valor do determinante.

As operações são realizadas diretamente com multiplicações e subtrações.

#### `mod_det_4x4`

Calcula o determinante de uma matriz 4x4 utilizando cofactoração da primeira linha, expandindo em 4 submatrizes 3x3:

\[
\text{det} =
\begin{vmatrix}
a & b & c & d \\
e & f & g & h \\
i & j & k & l \\
m & n & o & p
\end{vmatrix}
= a \cdot \text{det}(M_0)
- b \cdot \text{det}(M_1)
+ c \cdot \text{det}(M_2)
- d \cdot \text{det}(M_3)
\]

Onde cada \( M_i \) é uma submatriz 3x3 obtida da matriz original ao remover a linha 0 e a coluna correspondente ao elemento \( a, b, c \) ou \( d \).

**Entradas:**

- `a` até `p` (`signed [7:0]`): Elementos da matriz 4x4.
- `clk`: Clock do sistema.
- `start`: Sinal para iniciar o cálculo.

**Saídas:**

- `resultado` (`signed [15:0]`): Valor do determinante.
- `done`: Indica quando o cálculo foi concluído.

**Funcionamento:**

- O módulo passa por uma máquina de estados (`state`) que percorre os cofactores da primeira linha.
- Cada submatriz 3x3 é carregada em registradores e enviada para o módulo `mod_det_3x3`.
- O resultado parcial é armazenado em `temp[3:0]` e, ao final, a expressão completa é avaliada com os sinais alternados de cofactores: `+ - + -`.

#### 🧱 Hierarquia de Módulos

```text
mod_det_4x4
 └── mod_det_3x3
      └── (operações diretas)
mod_determinante_2x2
 └── mod_mult (2 instâncias)
```

---

#### 📝 Descrição do `fluxo_ram`

O módulo `fluxo_ram` é responsável por realizar a **interface de leitura e escrita** com uma memória RAM implementada por meio de um IP gerado no Quartus Prime (`altsyncram`) para a FPGA DE1-SoC. Ele abstrai o controle da RAM de porta única, permitindo que outros módulos realizem operações sincronizadas com o clock da placa.

##### Entradas e Saídas

- **Entradas:**
  - `clk`: sinal de clock para sincronização com a RAM.
  - `endereco [7:0]`: endereço de 8 bits utilizado para selecionar uma posição de memória (suporta até 256 posições).
  - `dado_entrada [8:0]`: valor de 9 bits a ser escrito na memória.
  - `grava`: controle de operação (`1` para **gravar**, `0` para **ler**).

- **Saídas:**
  - `dado_saida [8:0]`: valor lido da memória.

##### Funcionamento

O módulo instancia um componente gerado automaticamente pelo Quartus (`ram`), baseado na megafunção `altsyncram`. Esse componente implementa uma RAM síncrona de **porta única**, operando com dados de 16 bits. No entanto, o módulo `fluxo_ram` limita o uso à faixa de 9 bits mais baixos do barramento para compatibilidade com os dados utilizados nas operações matriciais do sistema.

A operação ocorre da seguinte forma:

1. **Escrita (grava = 1):** o dado presente em `dado_entrada` é escrito no endereço indicado por `endereco`.
2. **Leitura (grava = 0):** o conteúdo do endereço é lido e atribuído à saída `dado_saida`, sincronizado na borda de subida do clock.

Internamente, o dado lido é extraído por meio da atribuição:

```verilog
always @(posedge clk) begin
    dado_saida <= saida[8:0]; // Apenas os 9 bits menos significativos
end
```

---

#### 📝 Descrição do 'gerencia_matriz.v'

O módulo `gerencia_matriz` é responsável pela leitura e escrita de dados em memória RAM, organizada para armazenar duas matrizes 5x5 (com 25 elementos cada), utilizando 9 bits por elemento. Esse módulo atua como intermediário entre os blocos de memória e os módulos de operação aritmética, garantindo sincronização e controle adequado dos dados.

##### Entradas e Saídas

- **Entradas:**
  - `clk`: sinal de clock para sincronização.
  - `start`: sinal de controle para iniciar o processo de leitura/gravação.
  - `grava`: sinal de controle externo para gravação.
  - `matriz_resultante [224:0]`: vetor que representa a matriz de saída resultante das operações.

- **Saídas:**
  - `matriz1 [224:0]`: vetor representando a primeira matriz lida.
  - `matriz2 [224:0]`: vetor representando a segunda matriz lida (ainda não atribuída explicitamente no código apresentado, mas prevista na estrutura).

##### Funcionamento

O módulo utiliza duas instâncias de um componente auxiliar chamado `fluxo_ram`:

- `ram_inst1`: opera em modo de **leitura**, acessando os primeiros 50 endereços da RAM para preencher a memória interna `matriz_ler`.
- `ram_inst2`: opera em modo de **escrita**, utilizando dados da memória `matriz_escrita` e gravando a partir do endereço 50.

Um contador é utilizado para garantir um pequeno atraso inicial após a ativação do sinal `start`, evitando conflitos com os endereços iniciais da RAM. Durante o processo:

1. A leitura é feita de forma sequencial, armazenando os dados em `matriz_ler`.
2. Após a leitura dos 50 valores (duas matrizes), o módulo ativa a escrita em `ram_inst2`, enviando os valores armazenados em `matriz_escrita`.
3. Parte dos dados lidos são atribuídos diretamente à saída `matriz1` para uso posterior.

Este módulo foi desenvolvido com foco na modularidade e na correta manipulação sequencial dos dados em sistemas embarcados baseados em FPGA.

---

#### 📝 Descrição do `unidade_logica.v`

O módulo `unidade_logica` atua como **unidade central de controle lógico** das operações matriciais no sistema. Ele recebe duas matrizes 5x5 (`matriz_A` e `matriz_B`), além de um código de operação, e entrega como saída uma `matriz_resultado` correspondente à operação escolhida.

Esse módulo é projetado para ser **sincronizado com o clock** do sistema e ativado por meio do sinal `start`, com um sinal de saída `done` indicando o término da operação.

##### Entradas e Saídas

- **Entradas:**
  - `clk`: sinal de clock.
  - `start`: sinal de controle que ativa a operação.
  - `operacao [2:0]`: código binário que seleciona qual operação será realizada.
  - `matriz_A [224:0]`: matriz de entrada A (5x5, 25 elementos de 9 bits).
  - `matriz_B [224:0]`: matriz de entrada B (ou constante no caso de multiplicação por inteiro).

- **Saídas:**
  - `matriz_resultado [224:0]`: resultado da operação selecionada.
  - `done`: sinal que indica quando a operação foi finalizada.

##### Funcionamento

Ao receber um pulso de `start`, o módulo avalia o campo `operacao` e seleciona uma das operações disponíveis:

| Código `operacao` | Operação                         |
|-------------------|----------------------------------|
| `000`             | Soma de matrizes                 |
| `001`             | Subtração de matrizes            |
| `010`             | Matriz oposta (não implementada) |
| `011`             | Multiplicação de matrizes        |
| `100`             | Transposição da matriz A         |
| `101`             | Determinante da matriz A         |
| `110`             | Multiplicação da matriz A por constante (vinda de B) |

O sinal `done` é ativado ao final da execução, indicando que o resultado está pronto.

##### Módulos Internos Utilizados

O módulo `unidade_logica` depende de diversos módulos auxiliares para realizar operações específicas:

- **`modulo_somador_subtrator`**: instanciado 25 vezes para realizar a **soma e subtração** de cada elemento da matriz.
- **`modulo_transpor`**: responsável por transpor a matriz A.
- **`mult_const`**: realiza a multiplicação da matriz A por um valor constante (extraído de `matriz_B[7:0]`).

Outros módulos como **multiplicação de matrizes**, **matriz oposta** e **determinante** são declarados mas **ainda não estão implementados** neste código-fonte.

##### Observações

- A manipulação dos elementos individuais da matriz (cada elemento com 9 bits) é feita manualmente para cada uma das 25 posições, totalizando 25 instâncias para soma e subtração.
- O uso de `wire` para interligar os resultados dos módulos auxiliares permite que a seleção lógica na `always` block seja feita de forma eficiente.

Este módulo é essencial para o sistema de operações aritméticas em hardware, garantindo modularidade e clareza no fluxo de dados.

### 💻 Ambiente de Desenvolvimento

O coprocessador foi desenvolvido no ambiente de desenvolvimento **Quartus Prime Lite 23.1**.

## 📊 Conclusão - Resultados e Simulações

O coprocessador implementado oferece uma robusta gama de funcionalidades no que se refere a cálculos matriciai. Durante o desenvolvimento desse projeto, foi possível compreender os conceitos da utilização dos recursos de hardware para realização de operações, bem como o acesso e gerenciamento de memória.

Os testes foram realizados para validar cada uma das operações suportadas. Os resultados foram analisados usando **ModelSim**, em seguida foram aplicadas na placa para ser testado na prática, e confirmaram a correção das operações matriciais.

### ⚙️ Como Usar

#### 🎯 Requisitos
- **Placa DE1-SoC**
- **Intel Quartus Prime**
- **ModelSim** (para simulação)

#### 🛠️ Passos para Implementação
1. **Clone este repositório:**
   ```sh
   git clone https://github.COMPLETAR.git](https://github.com/oLeozito/fpga-arithmetic-coprocessor.git
   ```
2. **Abra o Quartus e carregue o projeto.**
3. **Compile todos os módulos.**
4. **Realize a síntese e simulação usando ModelSim.**
5. **Conecte a FPGA e envie o projeto**
6. **Teste as operações visualizando atraves In-System Memory Content Editor.**

## 🚀 Próximos Passos
- **Otimizar o desempenho implmentando pipeline e paralelismo**.
- **Criar uma interface de comunicação com um processador principal**.

## 📜 Licença
Este projeto é distribuído sob a licença **MIT**. Sinta-se livre para utilizar, modificar e contribuir!

## Bibliografia
Contribuições são bem-vindas! Se você encontrar algum problema ou tiver sugestões de melhorias, abra uma issue ou envie um pull request.

---
📌 Desenvolvido por **[João Marcelo Nascimento Fernandes, Leonardo Oliveira Almeida da Cruz, João Gabriel Santos Silva]**
