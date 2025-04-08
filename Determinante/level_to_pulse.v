module level_to_pulse (
    input wire clk,
    input wire rst,
    input wire level_in,   // sinal de entrada (nível)
    output reg pulse_out   // saída: 1 pulso de 1 ciclo quando level_in sobe
);

    reg level_d;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            level_d <= 1'b0;
            pulse_out <= 1'b0;
        end else begin
            level_d <= level_in;
            pulse_out <= level_in & ~level_d;
        end
    end

endmodule
