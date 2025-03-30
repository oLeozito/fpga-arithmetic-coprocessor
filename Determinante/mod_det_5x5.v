`include "mod_det_4x4.v"

module mod_det_5x5 (
    input [7:0] a, b, c, d, e,
                 f, g, h, i, j,
                 k, l, m, n, o,
                 p, q, r, s, t,
                 u, v, w, x, y, // Elementos da matriz 5x5
    output [7:0] resultado // Determinante 5x5
);
    wire [7:0] det_A11, det_A12, det_A13, det_A14, det_A15; // Determinantes das submatrizes 4x4

    // Calcular determinante 4x4 para as submatrizes
    mod_det_4x4 det1 (
        .a(g), .b(h), .c(i), .d(j),
        .e(l), .f(m), .g(n), .h(o),
        .i(q), .j(r), .k(s), .l(t),
        .m(v), .n(w), .o(x), .p(y),
        .resultado(det_A11)
    );

    mod_det_4x4 det2 (
        .a(f), .b(h), .c(i), .d(j),
        .e(k), .f(m), .g(n), .h(o),
        .i(p), .j(r), .k(s), .l(t),
        .m(u), .n(w), .o(x), .p(y),
        .resultado(det_A12)
    );

    mod_det_4x4 det3 (
        .a(f), .b(g), .c(i), .d(j),
        .e(k), .f(l), .g(n), .h(o),
        .i(p), .j(q), .k(s), .l(t),
        .m(u), .n(v), .o(x), .p(y),
        .resultado(det_A13)
    );

    mod_det_4x4 det4 (
        .a(f), .b(g), .c(h), .d(j),
        .e(k), .f(l), .g(m), .h(o),
        .i(p), .j(q), .k(r), .l(t),
        .m(u), .n(v), .o(w), .p(y),
        .resultado(det_A14)
    );

    mod_det_4x4 det5 (
        .a(f), .b(g), .c(h), .d(i),
        .e(k), .f(l), .g(m), .h(n),
        .i(p), .j(q), .k(r), .l(s),
        .m(u), .n(v), .o(w), .p(x),
        .resultado(det_A15)
    );

    // Multiplicar os coeficientes pelos determinantes das submatrizes
    wire [7:0] temp_A11, temp_A12, temp_A13, temp_A14, temp_A15;

    mod_mult mult1 (.a(a), .b(det_A11), .resultado(temp_A11), .flag_overflow());
    mod_mult mult2 (.a(b), .b(det_A12), .resultado(temp_A12), .flag_overflow());
    mod_mult mult3 (.a(c), .b(det_A13), .resultado(temp_A13), .flag_overflow());
    mod_mult mult4 (.a(d), .b(det_A14), .resultado(temp_A14), .flag_overflow());
    mod_mult mult5 (.a(e), .b(det_A15), .resultado(temp_A15), .flag_overflow());

    assign resultado = (temp_A11 - temp_A12) + (temp_A13 - temp_A14) + temp_A15;

endmodule
