module modulo_oposto(
    input  [7:0] entrada,  // Entrada de 8 bits sem sinal
    output [8:0] saida     // Saída de 9 bits com complemento de dois
);

    wire [8:0] entrada_ext; // Extensão para 9 bits

    // Extende a entrada para 9 bits, adicionando um bit de sinal correto
    assign entrada_ext = {1'b0, entrada}; 

    // Faz complemento de dois corretamente
    assign saida = (~entrada_ext + 1); 

endmodule
