`timescale 1ns / 1ps

module tb_mod_det_5x5;

    reg clk = 0;
    always #5 clk = ~clk; // Clock de 10ns (100MHz)

    reg start;
    reg signed [7:0] a, b, c, d, e,
                     f, g, h, i, j,
                     k, l, m, n, o,
                     p, q, r, s, t,
                     u, v, w, x, y;

    wire signed [15:0] resultado;
    wire done;

    // Instanciando o módulo
    mod_det_5x5 uut (
        .clk(clk),
        .start(start),
        .a(a), .b(b), .c(c), .d(d), .e(e),
        .f(f), .g(g), .h(h), .i(i), .j(j),
        .k(k), .l(l), .m(m), .n(n), .o(o),
        .p(p), .q(q), .r(r), .s(s), .t(t),
        .u(u), .v(v), .w(w), .x(x), .y(y),
        .resultado(resultado),
        .done(done)
    );

    initial begin
        $display("Iniciando teste...");
        start = 0;

        // Matriz de exemplo 5x5 (valores simples para validar resultado)
        a = 1;  b = 2;  c = 2;  d = 2;  e = 1;
        f = 2;  g = 1;  h = 2;  i = 2;  j = 1;
        k = 1;  l = 2;  m = 3;  n = 1;  o = 2;
        p = 2;  q = 2;  r = 1;  s = 2;  t = 1;
        u = 2;  v = 1;  w = 1;  x = 1;  y = 2;

        // Esperado: determinante = 1 (matriz identidade)

        #20 start = 1;
        #10 start = 0;

        // Esperar pelo sinal de conclusão
        wait(done == 1);

        $display("Determinante calculado: %b = %d", resultado, resultado);
        $finish;
    end

endmodule
