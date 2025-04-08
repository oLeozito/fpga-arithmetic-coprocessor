`include "mod_det_3x3.v"

module mod_det_4x4 (
    input clk,
    input start,
    input [7:0] a, b, c, d,
                e, f, g, h,
                i, j, k, l,
                m, n, o, p, // Elementos da matriz 4x4
    output reg [15:0] resultado, // Determinante 4x4 (precisa ser maior por causa da multiplicação)
    output reg done
);

    // Registradores para as submatrizes
    reg signed [7:0] aa, bb, cc, dd, ee, ff, gg, hh, ii;
    wire signed [7:0] resultado_3x3;

    // Instância do módulo de determinante 3x3
    mod_det_3x3 det3x3 (
        .a(aa), .b(bb), .c(cc),
        .d(dd), .e(ee), .f(ff),
        .g(gg), .h(hh), .i(ii),
        .resultado(resultado_3x3)
    );

    reg [1:0] count = 0;
    reg [1:0] state = 0;
    reg signed [15:0] temp[3:0];

    always @(posedge clk) begin
        case (state)
            0: begin
                if (start) begin
                    count <= 0;
                    done <= 0;
                    resultado <= 0;
                    state <= 1;
                end else begin
                    done <= 0;
                    resultado <= 0;
                end
            end

            1: begin
                // Preenche os valores da submatriz 3x3 conforme a cofactoração da primeira linha
                case (count)
                    2'd0: begin aa <= f; bb <= g; cc <= h;
                                   dd <= j; ee <= k; ff <= l;
                                   gg <= n; hh <= o; ii <= p; end

                    2'd1: begin aa <= e; bb <= g; cc <= h;
                                   dd <= i; ee <= k; ff <= l;
                                   gg <= m; hh <= o; ii <= p; end

                    2'd2: begin aa <= e; bb <= f; cc <= h;
                                   dd <= i; ee <= j; ff <= l;
                                   gg <= m; hh <= n; ii <= p; end

                    2'd3: begin aa <= e; bb <= f; cc <= g;
                                   dd <= i; ee <= j; ff <= k;
                                   gg <= m; hh <= n; ii <= o; end
                endcase
                state <= 2;
            end

            2: begin
                // Armazena o resultado do determinante 3x3
                temp[count] <= resultado_3x3;
                if (count == 3) begin
                    state <= 3;
                end else begin
                    count <= count + 1;
                    state <= 1;
                end
            end

            3: begin
                // Cofator expandido na primeira linha da matriz 4x4
                resultado <= (a * temp[0]) - (b * temp[1]) + (c * temp[2]) - (d * temp[3]);
                done <= 1;
                state <= 0; // Volta ao estado inicial
            end
        endcase
    end

endmodule
