module matriz_soma_subtracao #(parameter N = 3) (
    input  [N*N*8-1:0] matriz_a,  // Matriz A como vetor 1D compactado
    input  [N*N*8-1:0] matriz_b,  // Matriz B como vetor 1D compactado
    input op,                     // Operação: 0 para soma, 1 para subtração
    output [N*N*9-1:0] matriz_resultado  // Matriz Resultado como vetor 1D compactado
);

    genvar i;
    generate
        for (i = 0; i < N*N; i = i + 1) begin : elemento
            modulo_somador_subtrator somador_subtrator_inst (
                .a(matriz_a[i*8 +: 8]),  // Extrai 8 bits para 'a'
                .b(matriz_b[i*8 +: 8]),  // Extrai 8 bits para 'b'
                .op(op),
                .resultado(matriz_resultado[i*9 +: 9])  // Armazena 9 bits no resultado
            );
        end
    endgenerate

endmodule