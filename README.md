# Coprocessador para Operações entre Matrizes

## 📌 Introdução - Sobre o Projeto

Na disciplina MI - Sistemas Digitais do semestre 2025.1, foi proposto como primeiro problema o desenvolvimento de um **coprocessador** capaz de realizar operações entre matrizes, de modo que cada elemento da matriz é representado por um **número inteiro de 8 bits**, utilizando uma **FPGA na placa DE1-SoC**. O sistema conta com módulos dedicados para operações matriciais e gerenciamento de memória. O projeto foi desenvolvido em **Verilog HDL** e modularizado de acordo com as operações, além do acesso e gerenciamento de memória da placa.

### ✨ Funcionalidades Implementadas
O coprocessador pode executar as seguintes operações:

- **Adição** de duas matrizes
- **Subtração** de duas matrizes
- **Multiplicação** entre matrizes
- **Multiplicação por um inteiro**
- **Cálculo da matriz transposta**
- **Cálculo da matriz oposta**
- **Cálculo do determinante**

Na seção de **Fundamentação Teórica**, serão explicitados os conceitos utilizados como base para a resolução do problema. Na seção de **Metodologia**, serão descritos os processos envolvidos no desenvolvimento do software, como as escolhas de abordagem, a definição dos requisitos e funcionalidades, e a ordem de codificação. Na seção de **Conclusão**, serão informadas brevemente as conclusões e os objetivos cumpridos. Por fim, na seção de **Referências**, serão listadas as fontes utilizadas para a elaboração da resolução.

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

#### 📝 Descrição do `fluxo_ram.v`

Este módulo implementa uma memória RAM de porta única utilizando o IP **altsyncram** da Intel Quartus. As principais características incluem:

- Tamanho de **256 palavras** de **16 bits**
- Operação no modo **SINGLE_PORT**
- Modo de leitura **NEW_DATA_NO_NBE_READ**
- Inicialização **não definida** (`POWER_UP_UNINITIALIZED = "FALSE"`)
- Controle de escrita via sinal **wren**

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

> 💡 **Nota:** Este módulo depende da definição prévia do componente `fluxo_ram`, responsável pela simulação da RAM interna. Certifique-se de incluí-lo corretamente no projeto.


## ⚙️ Como Usar

### 🎯 Requisitos
- **Placa DE1-SoC**
- **Intel Quartus Prime**
- **ModelSim** (para simulação)

### 🛠️ Passos para Implementação
1. **Clone este repositório:**
   ```sh
   git clone https://github.COMPLETAR.git
   ```
2. **Abra o Quartus e carregue o projeto.**
3. **Compile todos os módulos.**
4. **Realize a síntese e simulação usando ModelSim.**
5. **Faça o upload do bitstream para a FPGA.**
6. **Teste as operações utilizando os sinais de controle.**

## 📊 Resultados e Simulações
Os testes foram realizados para validar cada uma das operações suportadas. Os resultados foram analisados usando **ModelSim**, em seguida foram aplicadas na placa para ser testado na prática, e confirmaram a correção das operações matriciais.

## 🚀 Próximos Passos
- **Otimizar o desempenho da multiplicação de matrizes** para reduzir a latência.
- **Criar uma interface de comunicação com um processador principal**.

## 📜 Licença
Este projeto é distribuído sob a licença **MIT**. Sinta-se livre para utilizar, modificar e contribuir!

## Bibliografia
Contribuições são bem-vindas! Se você encontrar algum problema ou tiver sugestões de melhorias, abra uma issue ou envie um pull request.

---
📌 Desenvolvido por **[João Marcelo Nascimento Fernandes, Leonardo Oliveira Almeida da Cruz, João Gabriel]**
