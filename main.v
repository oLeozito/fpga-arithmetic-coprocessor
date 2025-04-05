module main(
    input [2:0] operacao,       // Código da operação
    input [4:0] tamanho,        // Tamanho da matriz (suporta até 5x5)
    input clk,                  // Clock para sincronização
    input sinal,                // Sinal para carregar os dados na memória interna
    input grava,                // Entrada temporária
    output reg [8:0] leds
);

    wire [224:0] matriz1;
    wire [224:0] matriz2;
    reg [224:0] matriz3;  // Definido como reg para permitir atribuição em always

    // Atribuindo valores iniciais à matriz3
    always @(posedge clk) begin
        if (sinal) begin
            // Inicialize a matriz3 com alguns valores para teste
            matriz3[8:0] <= 9'b000000001;   // Exemplo de valor na posição 0
            matriz3[17:9] <= 9'b000000010;  // Exemplo de valor na posição 1
            matriz3[224:216] <= 9'b000000011; // Exemplo de valor na posição 2
            // Continue preenchendo conforme necessário para testar
        end
    end

    // Instância do módulo de gerenciamento da matriz
    gerencia_matriz(
        .clk(clk),
        .start(sinal),
        .grava(grava),
        .matriz_resultante(matriz3),
        .matriz1(matriz1),
        .matriz2(matriz2)
    );

    // Exibindo valores de matriz1 nos LEDs
    always @(posedge clk) begin
        leds[8:6] <= matriz3[224:216];  // Exibindo o início de matriz1
		  leds[5:0] <= matriz1[8:0];
    end

endmodule
