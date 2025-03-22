`timescale 1ns/1ps

module testbench_soma_sub;
    reg  [7:0] a, b;
    reg op;
    wire [8:0] resultado;
	 reg signed [8:0]resultado_sinal;

    // Instancia o módulo a ser testado
    modulo_somador_subtrator uut (
        .a(a),
        .b(b),
        .op(op),
        .resultado(resultado)
    );

    initial begin
        $dumpfile("simulacao.vcd"); // Arquivo para GTKWave
        $dumpvars(0, testbench_soma_sub); // Salva todas as variáveis

        $monitor("Tempo = %0t ns | a = %d | b = %d | op = %b | resultado = %d | Overflow/Negativo = %b", 
        $time, a, b, op, resultado[7:0], resultado[8]);
		  
        // Teste 1: 10 + 5
        a = 8'd10; b = 8'd5; op = 0; #10;
        
        // Teste 2: 25 + 30
        a = 8'd25; b = 8'd30; op = 0; #10;

        // Teste 3: 255 + 1 (overflow esperado)
        a = 8'd255; b = 8'd1; op = 0; #10;

        // Teste 4: 50 - 10
        a = 8'd50; b = 8'd10; op = 1; #10;

        // Teste 5: 20 - 25 (resultado negativo em complemento de dois)
        a = 8'd20; b = 8'd25; op = 1; #10;

        // Teste 6: 0 - 1 (maior valor negativo possível para 8 bits)
        a = 8'd0; b = 8'd1; op = 1; #10;

        $finish; // Termina a simulação
    end
	 always @(*) begin
        resultado_sinal = resultado; // Converte implicitamente para signed
    end
endmodule
