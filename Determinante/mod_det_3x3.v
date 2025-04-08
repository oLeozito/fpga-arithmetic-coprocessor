`include "mod_det_2x2.v"
`include "mod_mult.v"


module mod_det_3x3 (
    input [7:0] a, b, c, d, e, f, g, h, i, // Elementos da matriz 3x3
    output [7:0] resultado // Determinante 3x3
);
    
     assign resultado = a * (e * i - f * h) -
			            b * (d * i - f * g) +
			            c * (d * h - e * g);


    //wire [7:0] det_2x2_1, det_2x2_2, det_2x2_3; // Determinantes dos 2x2

    // Calcular determinante 2x2 para as submatrizes
    // mod_determinante_2x2 det_1 (
    //     .a(e), .b(f), .c(h), .d(i),
    //     .resultado(det_2x2_1)
    // );

    // mod_determinante_2x2 det_2 (
    //     .a(d), .b(f), .c(g), .d(i),
    //     .resultado(det_2x2_2)
    // );

    // mod_determinante_2x2 det_3 (
    //     .a(d), .b(e), .c(g), .d(h),
    //     .resultado(det_2x2_3)
    // );

    // // Determinante da matriz 3x3
    // wire [7:0] temp1, temp2, temp3;
    // wire [7:0] temp_soma;

    // mod_mult mult1 (
    //     .a(a), .b(det_2x2_1), 
    //     .resultado(temp1), 
    //     .flag_overflow()
    // );

    // mod_mult mult2 (
    //     .a(b), .b(det_2x2_2),
    //     .resultado(temp2), 
    //     .flag_overflow()
    // );

    // mod_mult mult3 (
    //     .a(c), .b(det_2x2_3),
    //     .resultado(temp3), 
    //     .flag_overflow()
    // );

    // // Calcular a soma dos termos: a * det_2x2_1 - b * det_2x2_2 + c * det_2x2_3
    // assign temp_soma = temp1 - temp2;
    // assign resultado = temp_soma + temp3;

endmodule
