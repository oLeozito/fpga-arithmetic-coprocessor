module Determinante #(
    parameter MAX_N = 5
)(
    input clk,
    input rst,
    input start,
    input [2:0] N, // Tamanho da matriz (1 a 5)
    input signed [MAX_N*MAX_N*8-1:0] matrix,
    output reg signed [31:0] det,
    output reg ready
);

    reg signed [31:0] minor_det;
    reg signed [7:0] submatrix [(MAX_N-1)*(MAX_N-1)-1:0];
    integer i, j, k;
    
    // Definição do estado da FSM
    reg [1:0] state;
    parameter IDLE = 2'b00, COMPUTE = 2'b01, DONE = 2'b10;
    
    function signed [7:0] get_matrix_element;
        input integer row, col, size;
        begin
            get_matrix_element = matrix[(row * size + col) * 8 +: 8];
        end
    endfunction
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            det <= 0;
            state <= IDLE;
            ready <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        ready <= 0;
                        if (N == 1) begin
                            det <= get_matrix_element(0, 0, N);
                            state <= DONE;
                        end else if (N == 2) begin
                            det <= get_matrix_element(0, 0, N) * get_matrix_element(1, 1, N) - 
                                   get_matrix_element(0, 1, N) * get_matrix_element(1, 0, N);
                            state <= DONE;
                        end else begin
                            det <= 0;
                            k <= 0;
                            state <= COMPUTE;
                        end
                    end
                end
                
                COMPUTE: begin
                    if (k < N) begin
                        // Criar a submatriz removendo a linha 0 e coluna k
                        for (i = 1; i < N; i = i + 1) begin
                            for (j = 0; j < N-1; j = j + 1) begin
                                if (j < k)
                                    submatrix[(i-1)*(N-1) + j] = get_matrix_element(i, j, N);
                                else
                                    submatrix[(i-1)*(N-1) + j] = get_matrix_element(i, j+1, N);
                            end
                        end
                        
                        // TODO: Implementar cálculo do determinante da submatriz manualmente (sem chamada recursiva)
                        minor_det = 1; // Apenas um placeholder, deve ser substituído por um cálculo real
                        
                        // Expansão de Laplace
                        if (k % 2 == 0)
                            det <= det + get_matrix_element(0, k, N) * minor_det;
                        else
                            det <= det - get_matrix_element(0, k, N) * minor_det;
                        
                        k <= k + 1;
                    end else begin
                        state <= DONE;
                    end
                end
                
                DONE: begin
                    ready <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
