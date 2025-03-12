/*
module main(
    input [2:0] operacao, // Agora de 000 (0) até 110 (6)
    input [4:0] tamanho,
    input [7:0] matriz1 [0:24],
    input [7:0] matriz2 [0:24],
    output reg [8:0] matriz_resultante [0:24]
);

    always @(matriz1, matriz2, operacao) begin
        if (operacao == 3'b000) begin
            // Operação 0 - Soma
				modulo_somador();
        end
        else if (operacao == 3'b001) begin
            // Operação 1 - Subtração
        end
        else if (operacao == 3'b010) begin
            // Operação 2 - Multiplicação
        end
        else if (operacao == 3'b011) begin
            // Operação 3 - Multiplicação por num. real.
        end
        else if (operacao == 3'b100) begin
            // Operação 4 - Determinante
        end
        else if (operacao == 3'b101) begin
            // Operação 5 - Transposição
        end
        else if (operacao == 3'b110) begin
            // Operação 6 - Matriz oposta
			end
        else begin
            // Operação inválida
        end
	 end

endmodule
*/