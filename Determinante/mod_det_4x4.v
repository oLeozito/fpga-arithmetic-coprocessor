`include "mod_det_3x3.v"

module mod_det_4x4 (
    input clk,
    input start,
    input signed [7:0] a, b, c, d,
                      e, f, g, h,
                      i, j, k, l,
                      m, n, o, p, // Elementos da matriz 4x4
    output reg signed [15:0] resultado, // Tamanho maior para suportar o determinante
    output reg done
);

    // Registradores para submatriz 3x3
    reg signed [7:0] aa, bb, cc, dd, ee, ff, gg, hh, ii;
    wire signed [7:0] resultado_3x3;

    // Instância do módulo 3x3
    mod_det_3x3 det3x3 (
        .a(aa), .b(bb), .c(cc),
        .d(dd), .e(ee), .f(ff),
        .g(gg), .h(hh), .i(ii),
        .resultado(resultado_3x3)
    );

    reg [1:0] count = 0;
    reg [2:0] state = 0;
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
                end
            end

            1: begin
                // Carrega submatriz 3x3 para cofactoração da 1ª linha
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
                // Espera um ciclo para garantir resultado válido
                state <= 3;
            end

            3: begin
                temp[count] <= resultado_3x3;
                if (count == 3)
                    state <= 4;
                else begin
                    count <= count + 1;
                    state <= 1;
                end
            end

            4: begin
                resultado <= (a * temp[0]) - (b * temp[1]) + (c * temp[2]) - (d * temp[3]);
                done <= 1;
                state <= 0;
            end
        endcase
    end

endmodule
