`timescale 1ns / 1ps

module tb_mod_det_5x5();
    reg [7:0] a, b, c, d, e,
              f, g, h, i, j,
              k, l, m, n, o,
              p, q, r, s, t,
              u, v, w, x, y;
    
    wire [7:0] resultado;
    
    mod_det_5x5 uut (
        .a(a), .b(b), .c(c), .d(d), .e(e),
        .f(f), .g(g), .h(h), .i(i), .j(j),
        .k(k), .l(l), .m(m), .n(n), .o(o),
        .p(p), .q(q), .r(r), .s(s), .t(t),
        .u(u), .v(v), .w(w), .x(x), .y(y),
        .resultado(resultado)
    );
    
    initial begin
        // Definir uma matriz 5x5 com valores baixos
        a = 2; b = 6; c = 4; d = 1; e = 5;
        f = 9; g = 7; h = 2; i = 6; j = 3;
        k = 5; l = 5; m = 1; n = 4; o = 1;
        p = 2; q = 6; r = 4; s = 1; t = 4;
        u = 2; v = 4; w = 3; x = 1; y = 5;
        
        #10;
        
        // Exibir valores da matriz
        $display("Matriz 5x5:");
        $display("%d %d %d %d %d", a, b, c, d, e);
        $display("%d %d %d %d %d", f, g, h, i, j);
        $display("%d %d %d %d %d", k, l, m, n, o);
        $display("%d %d %d %d %d", p, q, r, s, t);
        $display("%d %d %d %d %d", u, v, w, x, y);
        
        // Exibir o determinante
        $display("\nDeterminante (binário): %b", resultado);
        $display("Determinante (decimal): %d", resultado);
        
        #10;
        $finish;
    end
endmodule
