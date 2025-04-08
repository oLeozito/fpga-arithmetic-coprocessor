module mod_mult(
    input signed [7:0] a, b,  // Entradas com sinal de 8 bits
    output reg signed [7:0] resultado,  // Saída com sinal de 8 bits
    output reg flag_overflow  // Flag de overflow
);
    wire signed [15:0] produto;  // Resultado da multiplicação pode ser até 16 bits

    // Realiza a multiplicação considerando o sinal das variáveis
    assign produto = a * b;  

    always @(*) begin
        // Verifica se houve overflow comparando os bits mais significativos
        if (produto[15:8] != {8{produto[7]}}) begin
            flag_overflow = 1;  // Set flag se overflow for detectado
        end else begin
            flag_overflow = 0;  // Caso contrário, não houve overflow
        end
        
        // A saída recebe os 8 bits menos significativos do produto
        resultado = produto[7:0];
    end
endmodule

