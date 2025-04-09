`timescale 1ns / 1ps

module tb_mod_det_4x4;

    reg clk = 0;
    always #5 clk = ~clk; // Clock de 10ns

    reg start;
    reg signed [7:0] a, b, c, d,
                     e, f, g, h,
                     i, j, k, l,
                     m, n, o, p;

    wire signed [15:0] resultado;
    wire done;

    // Instanciando o módulo
    mod_det_4x4 uut (
        .clk(clk),
        .start(start),
        .a(a), .b(b), .c(c), .d(d),
        .e(e), .f(f), .g(g), .h(h),
        .i(i), .j(j), .k(k), .l(l),
        .m(m), .n(n), .o(o), .p(p),
        .resultado(resultado),
        .done(done)
    );

    initial begin
        $display("Iniciando teste 4x4...");
        start = 0;

        a = 2;  b = 1;  c = 2;  d = 2;
        e = 1;  f = 2;  g = 3;  h = 1;
        i = 2;  j = 2;  k = 1;  l = 2;
        m = 2;  n = 1;  o = 1;  p = 1;

        #20 start = 1;
        #10 start = 0;

        wait(done == 1);

        $display("Determinante 4x4: %d", resultado);
        $finish;
    end

endmodule
