module fluxo_ram(
    input clk,
    input [7:0] endereco,         // Endereço de 8 bits (endereça de 0 a 127)
    input [8:0] dado_entrada,     // Dado de entrada
    input grava,                  // Grava com 1 e Lê com 0.
    output reg [8:0] dado_saida   // Dado de saída (9 bits)
);
wire [8:0] saida;

    ram ram1(
        .address(endereco),
        .clock(clk),
        .data(dado_entrada),
        .wren(grava),
        .q(saida)
    );

always@(posedge clk) begin
	dado_saida <= saida[8:0];
end
	 
endmodule