`timescale 1ns/1ps

module testbench_transpor;
    parameter N = 3;
    reg clk;
    reg rst;
    reg [N*N*8-1:0] matrix_in;
    wire [N*N*8-1:0] matrix_out;

    // Instancia o módulo a ser testado
    modulo_transpor #(.N(N)) uut (
        .clk(clk),
        .rst(rst),
        .matrix_in(matrix_in),
        .matrix_out(matrix_out)
    );

    // Gera clock
    always #5 clk = ~clk;

    // Inicialização e testes
    initial begin
        $dumpfile("simulacao.vcd");
        $dumpvars(0, testbench_transpor);

        clk = 0;
        rst = 1;
        #10;
        rst = 0;

        // Define uma matriz 3x3 como entrada
        matrix_in = {
            8'd1, 8'd2, 8'd3,
            8'd4, 8'd5, 8'd6,
            8'd7, 8'd8, 8'd9
        };
        #20;

        // Exibe a matriz original e a transposta
        $display("Matriz original:");
        print_matrix(matrix_in);

        $display("Matriz transposta:");
        print_matrix(matrix_out);

        $finish;
    end

    // Função para imprimir matriz formatada
    task print_matrix(input [N*N*8-1:0] matrix);
        integer i, j;
        reg [7:0] value;
        begin
            for (i = 0; i < N; i = i + 1) begin
                for (j = 0; j < N; j = j + 1) begin
                    value = matrix[(i*N + j) * 8 +: 8];
                    $write("%d ", value);
                end
                $write("\n");
            end
            $write("\n");
        end
    endtask
endmodule
