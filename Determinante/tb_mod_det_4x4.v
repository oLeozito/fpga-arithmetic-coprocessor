// module tb_mod_det_4x4;

//     // Definir os sinais de entrada e saída
//     reg [7:0] a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p; 
//     wire [15:0] resultado;

//     // Instanciar o módulo de determinante 4x4
//     mod_det_4x4 uut (
//         .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h),
//         .i(i), .j(j), .k(k), .l(l), .m(m), .n(n), .o(o), .p(p),
//         .resultado(resultado)
//     );

//     // Inicialização e estímulos do testbench
//     initial begin
//         // Teste 1: Matriz de exemplo 4x4
//         a = 8'd2; b = 8'd3; c = 8'd1; d = 8'd4;
//         e = 8'd1; f = 8'd1; g = 8'd2; h = 8'd3;
//         i = 8'd3; j = 8'd4; k = 8'd5; l = 8'd6;
//         m = 8'd7; n = 8'd8; o = 8'd9; p = 8'd10;

//         // Exibir os valores das submatrizes e os resultados
//         #10; // Esperar um ciclo para o cálculo

//         // Exibir os resultados
//         $display("Matriz 4x4:");
//         $display("A = %d B = %d C = %d D = %d", a, b, c, d);
//         $display("E = %d F = %d G = %d H = %d", e, f, g, h);
//         $display("I = %d J = %d K = %d L = %d", i, j, k, l);
//         $display("M = %d N = %d O = %d P = %d", m, n, o, p);

//         // Exibir o resultado esperado (você pode calcular manualmente ou usar uma ferramenta externa)
//         $display("\nResultado Esperado (determinante): 0");

//         // Exibir o resultado obtido
//         $display("\nResultado Calculado pelo Módulo 4x4:");
//         $display("Resultado = %d (Decimal)", resultado);
//         $display("Resultado (Binário) = %b", resultado);
        
//         // Finalizar a simulação
//         $finish;
//     end

// endmodule

`timescale 1ns / 1ps

module tb_mod_det_4x4;
    reg clk;
    reg [7:0] a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p;
    wire [7:0] resultado;
    
    mod_det_4x4 uut (
        .clk(clk), .a(a), .b(b), .c(c), .d(d),
        .e(e), .f(f), .g(g), .h(h),
        .i(i), .j(j), .k(k), .l(l),
        .m(m), .n(n), .o(o), .p(p),
        .resultado(resultado)
    );
    
    initial begin
        $monitor("Tempo=%0t | Det 4x4 = %b", $time, resultado);
        
        clk = 0;
        
        // Matriz de teste
        a = 1;  b = 2;  c = 1;  d = 2;
        e = 2;  f = 1;  g = 3;  h = 2;
        i = 3;  j = 2; k = 2; l = 1;
        m = 1; n = 2; o = 3; p = 1;
        
        // Garante tempo suficiente para propagação
        #100;
        $finish;
    end
    
    always #5 clk = ~clk; // Clock de 10ns
    
    always @(posedge clk) begin
        $display("------------------------");
        $display("Tempo: %0t", $time);
        
        $display("Determinante 3x3:");
        $display("tp[0] = %b", uut.tp[0]);
        $display("tp[1] = %b", uut.tp[1]);
        $display("tp[2] = %b", uut.tp[2]);
        $display("tp[3] = %b", uut.tp[3]);
        
        $display("Det 4x4 Parcial:");
        $display("a * tp[0] = %b", a * uut.tp[0]);
        $display("b * tp[1] = %b", b * uut.tp[1]);
        $display("c * tp[2] = %b", c * uut.tp[2]);
        $display("d * tp[3] = %b", d * uut.tp[3]);
        
        $display("Det 4x4 Final = %b", resultado);
        $display("------------------------\n");
    end
endmodule
