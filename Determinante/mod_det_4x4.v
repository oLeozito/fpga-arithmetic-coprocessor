`include "mod_det_3x3.v"

module mod_det_4x4 (
    input clk,
    input [7:0] a, b, c, d,
                e, f, g, h,
                i, j, k, l,
                m, n, o, p, // Elementos da matriz 4x4
    output reg [7:0] resultado // Determinante 4x4
);

    reg signed [7:0] aa, bb, cc, dd, ee, ff, gg, hh, ii;
    wire signed [7:0] resultado_3x3;

    mod_det_3x3 uut (
        .a(aa), .b(bb), .c(cc),
        .d(dd), .e(ee), .f(ff),
        .g(gg), .h(hh), .i(ii),
        .resultado(resultado_3x3)
    );

    reg signed [15:0] tp[3:0]; // Temporários para cálculo (16 bits para evitar truncamento)
    reg [2:0] count = 0; // Contador para estados
    reg [1:0] state = 0; // Estado da FSM
    reg signed [7:0] matriz3x3[3:0][2:0][2:0];

    always @(posedge clk) begin
        case (state)
            0: begin // Inicializa as submatrizes
                matriz3x3[0][0][0] <= f; matriz3x3[0][0][1] <= g; matriz3x3[0][0][2] <= h;
                matriz3x3[0][1][0] <= j; matriz3x3[0][1][1] <= k; matriz3x3[0][1][2] <= l;
                matriz3x3[0][2][0] <= n; matriz3x3[0][2][1] <= o; matriz3x3[0][2][2] <= p;

                matriz3x3[1][0][0] <= e; matriz3x3[1][0][1] <= g; matriz3x3[1][0][2] <= h;
                matriz3x3[1][1][0] <= i; matriz3x3[1][1][1] <= k; matriz3x3[1][1][2] <= l;
                matriz3x3[1][2][0] <= m; matriz3x3[1][2][1] <= o; matriz3x3[1][2][2] <= p;

                matriz3x3[2][0][0] <= e; matriz3x3[2][0][1] <= f; matriz3x3[2][0][2] <= h;
                matriz3x3[2][1][0] <= i; matriz3x3[2][1][1] <= j; matriz3x3[2][1][2] <= l;
                matriz3x3[2][2][0] <= m; matriz3x3[2][2][1] <= n; matriz3x3[2][2][2] <= p;

                matriz3x3[3][0][0] <= e; matriz3x3[3][0][1] <= f; matriz3x3[3][0][2] <= g;
                matriz3x3[3][1][0] <= i; matriz3x3[3][1][1] <= j; matriz3x3[3][1][2] <= k;
                matriz3x3[3][2][0] <= m; matriz3x3[3][2][1] <= n; matriz3x3[3][2][2] <= o;

                count <= 0;
                state <= 1;
            end

            1: begin // Passa os valores para o módulo 3x3
                if (count < 4) begin
                    aa <= matriz3x3[count][0][0]; bb <= matriz3x3[count][0][1]; cc <= matriz3x3[count][0][2];
                    dd <= matriz3x3[count][1][0]; ee <= matriz3x3[count][1][1]; ff <= matriz3x3[count][1][2];
                    gg <= matriz3x3[count][2][0]; hh <= matriz3x3[count][2][1]; ii <= matriz3x3[count][2][2];
                    state <= 2;
                end
            end

            2: begin // Aguarda cálculo do determinante 3x3
                tp[count] <= resultado_3x3; // Armazena o determinante calculado
                if (count == 3) begin
                    state <= 3; // Se todas as submatrizes foram processadas, passa para cálculo final
                end else begin
                    count <= count + 1;
                    state <= 1; // Volta para processar a próxima submatriz
                end
            end

            3: begin // Calcula o determinante final
                resultado <= (a * tp[0]) - (b * tp[1]) + (c * tp[2]) - (d * tp[3]);
                state <= 0; // Reinicia
            end
        endcase
    end

endmodule
