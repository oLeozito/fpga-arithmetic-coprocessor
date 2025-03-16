module oposto(
    input  [7:0] entrada,  // Entrada de 8 bits
    output [7:0] saida    // Saída de 8 bits (inversão do sinal)
);
    
    // Complemento de dois para inverter o sinal
    assign saida = ~entrada + 1;
    
endmodule
