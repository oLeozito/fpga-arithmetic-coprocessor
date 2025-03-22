module modulo_multiplicador(
    input  [7:0] a, b,  // Entradas de 8 bits
    output [8:0] resultado // Saída de 9 bits: 8 bits do produto + 1 bit de overflow
);
    wire [15:0] produto; // Resultado completo da multiplicação
    wire overflow;

    // Multiplicação sem sinal
    assign produto = a * b;

    // Verifica se há overflow nos 8 bits mais significativos
    assign overflow = |produto[15:8];

    // Saída: 8 bits menos significativos + bit de overflow
    assign resultado = {overflow, produto[7:0]};

endmodule
