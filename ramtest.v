module ramtest(
input clock,
input sw0,
output reg [7:0] barra);

wire [15:0] q1,q2,q3,q;
reg [7:0] a, b;
wire [8:0] resultado;

rammaior ram1(
0,
clock,
5,
sw0,
q1
);

rammaior ram2(
1,
clock,
2,
sw0,
q2
);

modulo_somador_subtrator(q1, q2, 0, resultado);

rammaior ram3(
0,
clock,
resultado,
sw0,
q3
);

always@(posedge clock) begin
	barra <= q3[7:0];
end

endmodule