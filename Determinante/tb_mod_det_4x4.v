module tb_mod_det_4x4;

    // Definir os sinais de entrada e saída
    reg [7:0] a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p; 
    wire [7:0] resultado;

    // Instanciar o módulo de determinante 4x4
    mod_det_4x4 uut (
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h),
        .i(i), .j(j), .k(k), .l(l), .m(m), .n(n), .o(o), .p(p),
        .resultado(resultado)
    );

    // Inicialização e estímulos do testbench
    initial begin
        // Teste 1: Matriz de exemplo 4x4
        a = 8'd2; b = 8'd3; c = 8'd1; d = 8'd4;
        e = 8'd1; f = 8'd1; g = 8'd2; h = 8'd3;
        i = 8'd3; j = 8'd4; k = 8'd5; l = 8'd6;
        m = 8'd7; n = 8'd8; o = 8'd9; p = 8'd10;

        // Exibir os valores das submatrizes e os resultados
        #10; // Esperar um ciclo para o cálculo

        // Exibir os resultados
        $display("Matriz 4x4:");
        $display("A = %d B = %d C = %d D = %d", a, b, c, d);
        $display("E = %d F = %d G = %d H = %d", e, f, g, h);
        $display("I = %d J = %d K = %d L = %d", i, j, k, l);
        $display("M = %d N = %d O = %d P = %d", m, n, o, p);

        // Exibir o resultado esperado (você pode calcular manualmente ou usar uma ferramenta externa)
        $display("\nResultado Esperado (determinante): 0");

        // Exibir o resultado obtido
        $display("\nResultado Calculado pelo Módulo 4x4:");
        $display("Resultado = %d (Decimal)", resultado);
        $display("Resultado (Binário) = %b", resultado);
        
        // Finalizar a simulação
        $finish;
    end

endmodule
