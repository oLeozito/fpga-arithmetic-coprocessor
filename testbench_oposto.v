`timescale 1ns/1ps

module testbench_oposto;
    // Declaração das variáveis de entrada e saída
    reg [7:0] entrada;
    wire [8:0] saida;

    // Variável auxiliar para armazenar o valor convertido
    reg signed [8:0] saida_signed;

    // Instancia o módulo a ser testado
    modulo_oposto uut (
        .entrada(entrada),
        .saida(saida)
    );

    // Arquivo de saída para o GTKWave
    initial begin
        $dumpfile("simulacao.vcd");
        $dumpvars(0, testbench_oposto);
    end

    // Testes
    initial begin
        $monitor("Tempo = %0t | entrada = %d | saida = %d", $time, entrada, saida_signed);

        // Testes com valores diferentes
        entrada = 8'd0; #10;
        entrada = 8'd1; #10;
        entrada = 8'd10; #10;
        entrada = 8'd127; #10;
        entrada = 8'd128; #10;
        entrada = 8'd255; #10;

        $finish;
    end

    // Atualiza a variável auxiliar em tempo real
    always @(*) begin
        saida_signed = saida; // Converte implicitamente para signed
    end
endmodule
