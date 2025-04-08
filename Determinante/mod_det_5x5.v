`include "mod_det_4x4.v"

module mod_det_5x5 (
    input clk,
    input start,
    input signed [7:0] a, b, c, d, e,
                       f, g, h, i, j,
                       k, l, m, n, o,
                       p, q, r, s, t,
                       u, v, w, x, y,
    output reg signed [15:0] resultado, // Pode crescer por multiplicações
    output reg done
);

    // Sinais para o módulo 4x4
    reg signed [7:0] aa, bb, cc, dd, ee, ff, gg, hh, ii, jj, kk, ll, mm, nn, oo, pp;
    wire signed [15:0] resultado_4x4;
    reg start_4x4 = 0;
    wire done_4x4;

    mod_det_4x4 mod4 (
        .clk(clk),
        .start(start_4x4),
        .a(aa), .b(bb), .c(cc), .d(dd),
        .e(ee), .f(ff), .g(gg), .h(hh),
        .i(ii), .j(jj), .k(kk), .l(ll),
        .m(mm), .n(nn), .o(oo), .p(pp),
        .resultado(resultado_4x4),
        .done(done_4x4)
    );

    reg signed [15:0] temp[4:0]; // Determinantes das 4x4
    reg [2:0] count = 0;
    reg [2:0] state = 0;
    reg signed [7:0] linha0[4:0]; // Primeira linha: a b c d e
    reg ativo = 0;

    initial begin
        done = 0;
    end

    always @(posedge clk) begin
        case (state)
            0: begin
                if (start && !ativo) begin
                    // Inicializa primeira linha
                    linha0[0] <= a; linha0[1] <= b; linha0[2] <= c; linha0[3] <= d; linha0[4] <= e;
                    count <= 0;
                    ativo <= 1;
                    state <= 1;
                end
            end

            1: begin // Prepara submatriz 4x4 de acordo com count
                case (count)
                    0: begin aa <= g; bb <= h; cc <= i; dd <= j;
                             ee <= l; ff <= m; gg <= n; hh <= o;
                             ii <= q; jj <= r; kk <= s; ll <= t;
                             mm <= v; nn <= w; oo <= x; pp <= y; end

                    1: begin aa <= f; bb <= h; cc <= i; dd <= j;
                             ee <= k; ff <= m; gg <= n; hh <= o;
                             ii <= p; jj <= r; kk <= s; ll <= t;
                             mm <= u; nn <= w; oo <= x; pp <= y; end

                    2: begin aa <= f; bb <= g; cc <= i; dd <= j;
                             ee <= k; ff <= l; gg <= n; hh <= o;
                             ii <= p; jj <= q; kk <= s; ll <= t;
                             mm <= u; nn <= v; oo <= x; pp <= y; end

                    3: begin aa <= f; bb <= g; cc <= h; dd <= j;
                             ee <= k; ff <= l; gg <= m; hh <= o;
                             ii <= p; jj <= q; kk <= r; ll <= t;
                             mm <= u; nn <= v; oo <= w; pp <= y; end
                             
                    4: begin aa <= f; bb <= g; cc <= h; dd <= i;
                             ee <= k; ff <= l; gg <= m; hh <= n;
                             ii <= p; jj <= q; kk <= r; ll <= s;
                             mm <= u; nn <= v; oo <= w; pp <= x; end
                endcase
                start_4x4 <= 1;
                state <= 2;
            end

            2: begin
                if (done_4x4) begin
                    temp[count] <= resultado_4x4;
                    start_4x4 <= 0;
                    if (count == 4)
                        state <= 3;
                    else begin
                        count <= count + 1;
                        state <= 1;
                    end
                end
            end

            3: begin
                // Cofator expandido pela primeira linha (sinais alternando + - + - +)
                resultado <= (linha0[0] * temp[0]) -
                             (linha0[1] * temp[1]) +
                             (linha0[2] * temp[2]) -
                             (linha0[3] * temp[3]) +
                             (linha0[4] * temp[4]);
                done <= 1;
                ativo <= 0;
                state <= 0;
            end
        endcase
    end

endmodule
