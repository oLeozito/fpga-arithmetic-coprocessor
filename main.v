module main (
    input clk,
    input rst,
    input sinal,                 // Sinal de início direto (nível alto)
    input [2:0] operacao,
    output reg [8:0] leds
);

    // ============================
    // Estados da máquina de estados
    // ============================
	 
    parameter IDLE      = 3'd0;
    parameter READ      = 3'd1;
    parameter PROCESS   = 3'd2;
    parameter WAIT_DONE = 3'd3;
    parameter WRITE     = 3'd4;

    reg [2:0] state, next_state;

    // Matrizes e registradores
    wire [224:0] matriz1;
    wire [224:0] matriz2;
    wire done;
    wire [224:0] resultado_intermediario;

    reg [224:0] reg_matriz1;
    reg [224:0] reg_matriz2;
    reg [224:0] matriz_resultado;

    reg start_processamento;

    // ==========================
    // Sinal Level-to-Pulse
    // ==========================
    reg sinal_d, sinal_pulse;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sinal_d <= 0;
            sinal_pulse <= 0;
        end else begin
            sinal_d <= sinal;  // Captura o sinal
            sinal_pulse <= sinal & ~sinal_d;  // Gera o pulso na borda de subida
        end
    end

    // =====================
    // Instâncias dos módulos
    // =====================
    gerencia_matriz gm (
        .clk(clk),
        .start(sinal_pulse),                       // Usa o pulso gerado
        .grava(state == WRITE),
        .matriz_resultante(matriz_resultado),
        .matriz1(matriz1),
        .matriz2(matriz2)
    );

    unidade_logica ul (
        .clk(clk),
        .start(start_processamento),
        .operacao(operacao),
        .matriz_A(reg_matriz1),
        .matriz_B(reg_matriz2),
        .matriz_resultado(resultado_intermediario),
        .done(done)
    );

    // ===============================
    // Máquina de estados sequencial
    // ===============================
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // ===============================
    // Lógica de transição de estados
    // ===============================
    always @(*) begin
        next_state = state;
        start_processamento = 0;

        case (state)
            IDLE: begin
                if (sinal_pulse)  // Usando o pulso em vez do sinal contínuo
                    next_state = READ;
            end

            READ: begin
                next_state = PROCESS;
            end

            PROCESS: begin
                start_processamento = 1;
                next_state = WAIT_DONE;
            end

            WAIT_DONE: begin
                if (done)
                    next_state = WRITE;
            end

            WRITE: begin
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // ===============================
    // Lógica sequencial de controle
    // ===============================
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_matriz1 <= 0;
            reg_matriz2 <= 0;
            matriz_resultado <= 0;
            //leds <= 0;
        end else begin
            case (state)
                READ: begin
                    reg_matriz1 <= matriz1;
                    reg_matriz2 <= matriz2;
                end

                WAIT_DONE: begin
                    if (done)
                        matriz_resultado <= resultado_intermediario;
                end

                WRITE: begin
                    // leds <= reg_matriz1[8:0]; // Apenas os primeiros 9 bits
                end

                default: begin
                    // Sem ação
                end
            endcase
        end
    end
	 
    always @(posedge clk) begin
        leds[3:0] <= matriz1[8:0];
        if(done) begin
            leds[7:4] <= resultado_intermediario[224:216];
        end
    end

endmodule
