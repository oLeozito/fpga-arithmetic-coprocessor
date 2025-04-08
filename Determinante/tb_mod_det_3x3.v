`timescale 1ns/1ps

module tb_mod_determinante_3x3;
    reg [7:0] a, b, c, d, e, f, g, h, i; // Entradas da matriz 3x3
    wire [7:0] resultado; // Saída do determinante

    // Instancia o módulo de determinante 3x3
    mod_determinante_3x3 uut (
        .a(a), .b(b), .c(c), 
        .d(d), .e(e), .f(f), 
        .g(g), .h(h), .i(i),
        .resultado(resultado)
    );

    initial begin
        // Teste 1: Matriz 3x3 simples
        a = 8'b00000001;  // a = 1
        b = 8'b00000001;  // b = 1
        c = 8'b00000001;  // c = 1
        d = 8'b00000001;  // d = 1
        e = 8'b00000001;  // e = 1
        f = 8'b00000001;  // f = 1
        g = 8'b00000001;  // g = 1
        h = 8'b00000001;  // h = 1
        i = 8'b00000001;  // i = 1
        #10;
        $display("Teste 1: Matriz 3x3 simples | Esperado: 0 (00000000) | Obtido: %d (%b)", resultado, resultado);

        // Teste 2: Matrizes diferentes
        a = 8'b00000001;  // a = 1
        b = 8'b00000001;  // b = 1
        c = 8'b00000001;  // c = 1
        d = 8'b00000010;  // d = 2
        e = 8'b00000001;  // e = 1
        f = 8'b00000010;  // f = 2
        g = 8'b00000001;  // g = 1
        h = 8'b00000001;  // h = 1
        i = 8'b00000010;  // i = 2
        #10;
        $display("Teste 2: Matrizes diferentes | Esperado: -1 (11111111) | Obtido: %d (%b)", resultado, resultado);

        // Teste 3: Matrizes com valores negativos (usando 2's complement)
        a = 8'b11111111;  // a = -1
        b = 8'b11111100;  // b = -4
        c = 8'b11111001;  // c = -7
        d = 8'b11111110;  // d = -2
        e = 8'b11111101;  // e = -3
        f = 8'b11111000;  // f = -8
        g = 8'b11111111;  // g = -1
        h = 8'b11111110;  // h = -2
        i = 8'b11111001;  // i = -7
        #10;
        $display("Teste 3: Matrizes com valores negativos | Esperado: 12 (00001100) | Obtido: %d (%b)", resultado, resultado);

        // Teste 4: Matriz com todos os elementos iguais
        a = 8'b00000011;  // a = 3
        b = 8'b00000011;  // b = 3
        c = 8'b00000011;  // c = 3
        d = 8'b00000011;  // d = 3
        e = 8'b00000011;  // e = 3
        f = 8'b00000011;  // f = 3
        g = 8'b00000011;  // g = 3
        h = 8'b00000011;  // h = 3
        i = 8'b00000011;  // i = 3
        #10;
        $display("Teste 4: Matriz com todos os elementos iguais | Esperado: 0 (00000000) | Obtido: %d (%b)", resultado, resultado);

        // Teste 5: Multiplicação por zero
        a = 8'b00000000;  // a = 0
        b = 8'b00000001;  // b = 1
        c = 8'b00000010;  // c = 2
        d = 8'b00000011;  // d = 3
        e = 8'b00000001;  // e = 1
        f = 8'b00000010;  // f = 2
        g = 8'b00000011;  // g = 3
        h = 8'b00000000;  // h = 0
        i = 8'b00000000;  // i = 0
        #10;
        $display("Teste 5: Multiplicação por zero | Esperado: 0 (00000000) | Obtido: %d (%b)", resultado, resultado);

        // Finaliza a simulação
        $finish;
    end
endmodule
