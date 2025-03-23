module main(
    input [2:0] operacao,       // Código da operação
    input [4:0] tamanho,        // Tamanho da matriz (suporta até 5x5)
    input clk,                  // Clock para sincronização
    input [7:0] entrada_dado,   // Entrada serializada de dados da matriz
    input carga,                // Sinal para carregar os dados na memória interna
    output reg [8:0] saida_dado // Saída serializada do resultado
);

    reg [7:0] matriz1 [0:24];   // Memória interna para matriz1
    reg [7:0] matriz2 [0:24];   // Memória interna para matriz2
    reg [8:0] matriz_resultante [0:24];
    integer i, j, indice;

    always @(posedge clk) begin
        if (carga) begin
            if (indice < 25) begin
                matriz1[indice] <= entrada_dado;
                matriz2[indice] <= entrada_dado; // Simplesmente para teste
                indice <= indice + 1;
            end
        end else begin
            case (operacao)
                3'b000: begin // Soma
                    for (i = 0; i < 25; i = i + 1)
                        matriz_resultante[i] <= matriz1[i] + matriz2[i];
                end
                3'b001: begin // Subtração
                    for (i = 0; i < 25; i = i + 1)
                        matriz_resultante[i] <= matriz1[i] - matriz2[i];
                end
                3'b101: begin // Transposição
                    for (i = 0; i < 5; i = i + 1)
                        for (j = 0; j < 5; j = j + 1)
                            matriz_resultante[j * 5 + i] <= matriz1[i * 5 + j];
                end
                default: begin
                    for (i = 0; i < 25; i = i + 1)
                        matriz_resultante[i] <= 0;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        saida_dado <= matriz_resultante[indice];
    end
endmodule
