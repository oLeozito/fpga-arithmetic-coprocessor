module modulo_somador_subtrator(
    input  [7:0] a, b,   // Entradas de 8 bits
    input op,            // Se op = 0 → soma; se op = 1 → subtração
    output [8:0] resultado // Resultado de 9 bits
);

	 wire [8:0] operando_b;
    wire [8:0] soma;

    // Se op = 1 (subtração), fazemos complemento de dois de 'b'
    assign operando_b = op ? {1'b0, ~b} + 1 : {1'b0, b};

    // Soma com bit extra
    assign soma = {1'b0, a} + operando_b;

    // O bit 8 (resultado[8]) será:
    // 1 se houve overflow na soma
    // 1 se resultado for negativo na subtração
	 assign resultado = {((~op && (soma[8] ^ soma[7])) || (op && soma[8])),soma[7:0]};
endmodule