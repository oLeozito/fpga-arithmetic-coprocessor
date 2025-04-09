`include "mod_det_2x2.v"
`include "mod_mult.v"


module mod_det_3x3 (
    input signed [7:0] a, b, c, d, e, f, g, h, i, // Elementos da matriz 3x3
    output signed [7:0] resultado // Determinante 3x3
);
    
     assign resultado = a * (e * i - f * h) -
			            b * (d * i - f * g) +
			            c * (d * h - e * g);

endmodule
