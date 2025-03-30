module mod_soma(
    input signed [7:0] a,  
    input signed [7:0] b,  
    output reg signed [7:0] resultado  
);
    reg signed [9:0] soma_ext;  // Aumentado para 10 bits

    always @(*) begin
        soma_ext = a + b;  
        resultado = soma_ext[7:0];  // Pega apenas os 8 bits finais
    end
endmodule




