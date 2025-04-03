module main(
    input [2:0] operacao,       // Código da operação
    input [4:0] tamanho,        // Tamanho da matriz (suporta até 5x5)
    input clk,                  // Clock para sincronização
    input sinal,              // Sinal para carregar os dados na memória interna
	 
	 output reg [8:0] leds,
	 
	 input grava // Entrada temporaria;
);

    wire [224:0] matriz1;
    wire [224:0] matriz2;
    wire [224:0] matriz3; // Matriz Resultante

    // Instância do módulo de RAM
	 
	 gerencia_matriz(     
    .clk(clk),
	 .start(sinal),
	 .grava(grava),
    .matriz_resultante(matriz3),
    .matriz1(matriz1), 
    .matriz2(matriz2)
);

	always@(posedge clk) begin
			leds <= matriz1[8:0];
		end

endmodule
