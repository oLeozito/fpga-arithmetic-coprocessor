`timescale 1ns/1ps

module tb_mod_mult;
    reg [7:0] a, b;
    wire [7:0] resultado;
    wire flag_overflow;

    // Instancia o módulo multiplicador
    mod_mult uut (
        .a(a),
        .b(b),
        .resultado(resultado),
        .flag_overflow(flag_overflow)
    );

    initial begin
        // Teste 1: Positivo x Positivo (sem overflow)
        a = 8'd5;  
        b = 8'd3;  
        #10;
        $display("Teste 1: 5 * 3 | Esperado: 15 (00001111) | Obtido: %d (%b) | Overflow: %b", resultado, resultado, flag_overflow);

        // Teste 2: Positivo x Negativo (sem overflow)
        a = 8'd10;  
        b = 8'b11111110;  // Corrigido para 8'b11111110
        #10;
        $display("Teste 2: 10 * (-2) | Esperado: -20 (11101100) | Obtido: %b (%b) | Overflow: %b", resultado, resultado, flag_overflow);

        // Teste 3: Negativo x Positivo (sem overflow)
        a = -8'd7;  
        b = 8'd4;  
        #10;
        $display("Teste 3: (-7) * 4 | Esperado: -28 (11100100) | Obtido: %d (%b) | Overflow: %b", resultado, resultado, flag_overflow);

        // Teste 4: Negativo x Negativo (sem overflow)
        a = -8'd6;  
        b = -8'd5;  
        #10;
        $display("Teste 4: (-6) * (-5) | Esperado: 30 (00011110) | Obtido: %d (%b) | Overflow: %b", resultado, resultado, flag_overflow);

        // Teste 5: Positivo x Positivo (com overflow)
        a = 8'd50;  
        b = 8'd6;  
        #10;
        $display("Teste 5: 50 * 6 | Esperado: Overflow | Obtido: %d (%b) | Overflow: %b", resultado, resultado, flag_overflow);

        // Teste 6: Negativo x Positivo (com overflow)
        a = -8'd70;  
        b = 8'd3;  
        #10;
        $display("Teste 6: (-70) * 3 | Esperado: Overflow | Obtido: %d (%b) | Overflow: %b", resultado, resultado, flag_overflow);

        // Teste 7: Negativo x Negativo (com overflow)
        a = -8'd90;  
        b = -8'd2;  
        #10;
        $display("Teste 7: (-90) * (-2) | Esperado: Overflow | Obtido: %d (%b) | Overflow: %b", resultado, resultado, flag_overflow);

        // Teste 8: Multiplicação por zero
        a = 8'd0;  
        b = 8'd100;  
        #10;
        $display("Teste 8: 0 * 100 | Esperado: 0 (00000000) | Obtido: %d (%b) | Overflow: %b", resultado, resultado, flag_overflow);

        // Finaliza a simulação
        $finish;
    end
endmodule
