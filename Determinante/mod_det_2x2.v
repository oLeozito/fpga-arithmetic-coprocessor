module mod_determinante_2x2 (
    input [7:0] a, b, c, d,  // Elementos da matriz 2x2
    output [7:0] resultado  // Determinante 2x2
);
    wire [7:0] ad, bc;  // Resultados das multiplicações ad e bc

    // Instancia o módulo de multiplicação para ad
    mod_mult mult_ad (
        .a(a),
        .b(d),
        .resultado(ad)
    );

    // Instancia o módulo de multiplicação para bc
    mod_mult mult_bc (
        .a(b),
        .b(c),
        .resultado(bc)
    );

    // Calcula o determinante
    assign resultado = ad - bc;
endmodule
