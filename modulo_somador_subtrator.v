module modulo_somador_subtrator(
    input  [7:0] a, b,   // Entradas de 8 bits
    input op,            // Se op = 0 → soma; se op = 1 → subtração
    output [8:0] resultado // Resultado de 9 bits
);
	 wire [8:0] operando_a;
    wire [8:0] operando_b;
    wire [8:0] soma;

    // Se op = 1 (subtração), fazemos complemento de dois de 'b'
    assign operando_b = op ? {1'b0, ~b} + 1 : {1'b0, b};
	 assign operando_a = {1'b0,a};

    // Soma com bit extra para overflow
    assign soma = operando_a + operando_b;

    // O bit 8 do resultado é simplesmente soma[8]
    assign resultado = {(soma[8] & !op) | (!soma[8] & op), soma[7:0]};
	 
endmodule
