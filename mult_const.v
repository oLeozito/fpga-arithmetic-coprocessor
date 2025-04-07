module mult_const(
    input [224:0] matriz_A,
    input [7:0] const,
    output reg [224:0] resultado
);
    integer i;
    reg overflow;
    reg [8:0] elemento;
    reg [15:0] produto;

    always @(*) begin
        for (i = 0; i < 25; i = i + 1) begin
            elemento = matriz_A[i*9 +: 9];
            produto = elemento * const;
            overflow = |produto[15:8];
            resultado[i*9 +: 9] = {overflow, produto[7:0]}; // corta para 9 bits (overflow será ignorado)
        end
    end
endmodule
