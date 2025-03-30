module tb_mod_soma;
    reg [7:0] a, b; // Entradas
    wire signed [7:0] resultado; // Saída

    // Instancia o módulo mod_soma
    mod_soma uut (
        .a(a),
        .b(b),
        .resultado(resultado)
    );

    initial begin
        // Teste 1: 5 + 3 (sem overflow)
        a = 8'd5;  
        b = 8'd3;  
        #10;
        $display("Teste 1: 5 + 3 | Esperado: 8 (00001000) | Obtido: %d (%b)", resultado, resultado);

        // Teste 2: 10 + (-2) (sem overflow)
        a = 8'd10;  
        b = 8'b11111110;  // -2 em complemento a dois
        #10;
        $display("Teste 2: 10 + (-2) | Esperado: 8 (00001000) | Obtido: %d (%b)", resultado, resultado);

        // Teste 3: (-7) + 4 (sem overflow)
        a = 8'b11111001;  // -7 em complemento a dois
        b = 8'd4;  
        #10;
        $display("Teste 3: (-7) + 4 | Esperado: -3 (11111101) | Obtido: %d (%b)", resultado, resultado);

        // Teste 4: (-6) + (-5) (sem overflow)
        a = 8'b11111010;  // -6 em complemento a dois
        b = 8'b11111011;  // -5 em complemento a dois
        #10;
        $display("Teste 4: (-6) + (-5) | Esperado: -11 (11110101) | Obtido: %d (%b)", resultado, resultado);

        // Teste 5: 50 + 6 (sem overflow)
        a = 8'd50;  
        b = 8'd6;  
        #10;
        $display("Teste 5: 50 + 6 | Esperado: 56 (00111000) | Obtido: %d (%b)", resultado, resultado);

        // Teste 6: 100 + 200 (overflow/truncamento esperado)
        a = 8'd100;  
        b = 8'd200;  
        #10;
        $display("Teste 6: 100 + 200 | Esperado: -156 (10011010) | Obtido: %d (%b)", resultado, resultado);

        // Teste 7: (-70) + 3 (sem overflow)
        a = 8'b10111010;  // -70 em complemento a dois
        b = 8'd3;  
        #10;
        $display("Teste 7: (-70) + 3 | Esperado: -67 (10111101) | Obtido: %d (%b)", resultado, resultado);

        // Teste 8: (-90) + (-2) (sem overflow)
        a = 8'b10100110;  // -90 em complemento a dois
        b = 8'b11111110;  // -2 em complemento a dois
        #10;
        $display("Teste 8: (-90) + (-2) | Esperado: -92 (10100010) | Obtido: %d (%b)", resultado, resultado);

        // Teste 9: 0 + 100 (sem overflow)
        a = 8'd0;  
        b = 8'd100;  
        #10;
        $display("Teste 9: 0 + 100 | Esperado: 100 (01100100) | Obtido: %d (%b)", resultado, resultado);

        // Teste 10: 255 + 1 (overflow/truncamento esperado)
        a = 8'd255;  
        b = 8'd1;  
        #10;
        $display("Teste 10: 255 + 1 | Esperado: 0 (00000000) | Obtido: %d (%b)", resultado, resultado);

        $finish;
    end
endmodule
