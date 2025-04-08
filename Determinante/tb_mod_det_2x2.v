`timescale 1ns/1ps
`include "mod_mult.v"  // Inclui o módulo de multiplicação

module tb_mod_determinante_2x2;
    reg [7:0] a, b, c, d; // Elementos da matriz 2x2
    wire [7:0] resultado; // Determinante 2x2

    // Instancia o módulo para determinante 2x2
    mod_determinante_2x2 uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .resultado(resultado)
    );

    initial begin
        // Teste 1: Matriz 2x2 com valores binários
        a = 8'b00000001;  // a = 1
        b = 8'b00000010;  // b = 2
        c = 8'b00000011;  // c = 3
        d = 8'b00000100;  // d = 4
        #10;
        $display("Teste 1: Matriz 2x2 | Esperado: 254 | Obtido: %d", resultado);
        $display("Valor esperado (ad): %b", a * d); // ad
        $display("Valor esperado (bc): %b", b * c); // bc
        $display("Valor esperado (ad - bc): %b", (a * d) - (b * c)); // ad - bc
        $display("Valor obtido: %b", resultado);

        // Teste 2: Matrizes diferentes
        a = 8'b00000010;  // a = 2
        b = 8'b00000001;  // b = 1
        c = 8'b00000100;  // c = 4
        d = 8'b00000101;  // d = 5
        #10;
        $display("Teste 2: Matriz 2x2 | Esperado: 3 | Obtido: %d", resultado);
        $display("Valor esperado (ad): %b", a * d); // ad
        $display("Valor esperado (bc): %b", b * c); // bc
        $display("Valor esperado (ad - bc): %b", (a * d) - (b * c)); // ad - bc
        $display("Valor obtido: %b", resultado);

        // Teste 3: Matrizes com valores negativos (usando 2's complement)
        a = 8'b11111111;  // a = -1
        b = 8'b11111100;  // b = -4
        c = 8'b11111001;  // c = -7
        d = 8'b11111110;  // d = -2
        #10;
        $display("Teste 3: Matriz 2x2 com negativos | Esperado: -3 | Obtido: %d", resultado);
        $display("Valor esperado (ad): %b", a * d); // ad
        $display("Valor esperado (bc): %b", b * c); // bc
        $display("Valor esperado (ad - bc): %b", (a * d) - (b * c)); // ad - bc
        $display("Valor obtido: %b", resultado);

        // Teste 4: Matriz com todos os elementos iguais
        a = 8'b00000011;  // a = 3
        b = 8'b00000011;  // b = 3
        c = 8'b00000011;  // c = 3
        d = 8'b00000011;  // d = 3
        #10;
        $display("Teste 4: Matriz 2x2 com todos os elementos iguais | Esperado: 0 | Obtido: %d", resultado);
        $display("Valor esperado (ad): %b", a * d); // ad
        $display("Valor esperado (bc): %b", b * c); // bc
        $display("Valor esperado (ad - bc): %b", (a * d) - (b * c)); // ad - bc
        $display("Valor obtido: %b", resultado);

        // Teste 5: Multiplicação por zero
        a = 8'b00000000;  // a = 0
        b = 8'b00000001;  // b = 1
        c = 8'b00000010;  // c = 2
        d = 8'b00000011;  // d = 3
        #10;
        $display("Teste 5: Matriz 2x2 com zero | Esperado: 0 | Obtido: %d", resultado);
        $display("Valor esperado (ad): %b", a * d); // ad
        $display("Valor esperado (bc): %b", b * c); // bc
        $display("Valor esperado (ad - bc): %b", (a * d) - (b * c)); // ad - bc
        $display("Valor obtido: %b", resultado);

        // Finaliza a simulação
        $finish;
    end
endmodule
