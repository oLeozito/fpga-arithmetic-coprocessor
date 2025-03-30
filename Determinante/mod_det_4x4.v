`include "mod_det_3x3.v"

module mod_det_4x4 (
    input [7:0] a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, // Elementos da matriz 4x4
    output [7:0] resultado // Determinante 4x4
);
    wire [7:0] det_A11, det_A12, det_A13, det_A14; // Determinantes das submatrizes 3x3

    // Calcular determinante 3x3 para as submatrizes
    mod_det_3x3 det1 (
        .a(f), .b(g), .c(h), .d(j), .e(k), .f(l), .g(n), .h(o), .i(p), 
        .resultado(det_A11)
    );

    mod_det_3x3 det2 (
        .a(e), .b(g), .c(h), .d(i), .e(k), .f(l), .g(m), .h(o), .i(p),
        .resultado(det_A12)
    );

    mod_det_3x3 det3 (
        .a(e), .b(f), .c(h), .d(i), .e(j), .f(l), .g(m), .h(n), .i(p),
        .resultado(det_A13)
    );

    mod_det_3x3 det4 (
        .a(e), .b(f), .c(g), .d(i), .e(j), .f(k), .g(m), .h(n), .i(o),
        .resultado(det_A14)
    );

    // Multiplicar as variáveis pelos determinantes das submatrizes
    wire [7:0] temp_A11, temp_A12, temp_A13, temp_A14;

    mod_mult mult1 (
        .a(a), .b(det_A11), 
        .resultado(temp_A11), 
        .flag_overflow()
    );

    mod_mult mult2 (
        .a(b), .b(det_A12),
        .resultado(temp_A12), 
        .flag_overflow()
    );

    mod_mult mult3 (
        .a(c), .b(det_A13),
        .resultado(temp_A13), 
        .flag_overflow()
    );

    mod_mult mult4 (
        .a(d), .b(det_A14),
        .resultado(temp_A14), 
        .flag_overflow()
    );

    assign resultado = (temp_A11 - temp_A12) + (temp_A13 - temp_A14);

endmodule
