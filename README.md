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
2. **`preset_ram.v`** - Responsável por inicializar e gravar duas matrizes 5×5 na RAM ao receber um sinal de `start`.

#### 📝 Descrição do `fluxo_ram.v`

Este módulo implementa uma memória RAM de porta única utilizando o IP **altsyncram** da Intel Quartus. As principais características incluem:

- Tamanho de **256 palavras** de **16 bits**
- Operação no modo **SINGLE_PORT**
- Modo de leitura **NEW_DATA_NO_NBE_READ**
- Inicialização **não definida** (`POWER_UP_UNINITIALIZED = "FALSE"`)
- Controle de escrita via sinal **wren**

#### 📝 Descrição do `preset_ram.v`

Este módulo é responsável por **preencher automaticamente** a RAM com duas matrizes 5×5. Ele utiliza um **sinal de controle `start`**, que, ao ser acionado, grava os valores predefinidos nas posições de memória corretas.

- **Matriz 1**: Armazenada nos endereços **0 a 24**
- **Matriz 2**: Armazenada nos endereços **25 a 49**

A gravação ocorre de forma sequencial, avançando um endereço por ciclo de clock, até que ambas as matrizes estejam carregadas.

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
