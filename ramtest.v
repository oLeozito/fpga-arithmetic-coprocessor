module ramtest(
input clock,
input sw0,
output [7:0] barra);

ram(
0,
clock,
10,
sw0,
barra
);
endmodule