module modulo_transpor #(parameter N = 3) (
    input wire clk,
    input wire rst,
    input wire [N*N*8-1:0] matrix_in,  // Matriz achatada (vetor unidimensional)
    output reg [N*N*8-1:0] matrix_out  // Matriz achatada (vetor unidimensional)
);

    integer i, j;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            matrix_out <= 0;
        end else begin
            for (i = 0; i < N; i = i + 1) begin
                for (j = 0; j < N; j = j + 1) begin
                    // Transposição manual acessando a matriz achatada
                    matrix_out[(j*N + i) * 8 +: 8] <= matrix_in[(i*N + j) * 8 +: 8];
                end
            end
        end
	end
endmodule