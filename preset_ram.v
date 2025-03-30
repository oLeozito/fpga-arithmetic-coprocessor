module preset_ram(
    input clk,                // Clock para sincronização
    input start,              // Sinal para iniciar a gravação
    output reg [8:0] dado     // Dado de saída para verificação (opcional)
);

    reg [7:0] endereco;       // Endereço da memória
    reg [8:0] matriz1 [0:24]; // Matriz 1 (5x5) - 25 posições
    reg [8:0] matriz2 [0:24]; // Matriz 2 (5x5) - 25 posições
    reg grava;                // Sinal para controle de gravação
	 wire [8:0]saida;

    // Instância do módulo fluxo_ram fora do bloco always
    fluxo_ram ram_inst (
        .clk(clk),
        .endereco(endereco),
        .dado_entrada(matriz1[endereco]),
        .grava(grava),
        .dado_saida(saida)
    );

    // Inicialização dos valores das matrizes
    initial begin
        matriz1[0] = 9'd1; matriz1[1] = 9'd2; matriz1[2] = 9'd3; matriz1[3] = 9'd4; matriz1[4] = 9'd5;
        matriz1[5] = 9'd6; matriz1[6] = 9'd7; matriz1[7] = 9'd8; matriz1[8] = 9'd9; matriz1[9] = 9'd10;
        matriz1[10] = 9'd11; matriz1[11] = 9'd12; matriz1[12] = 9'd13; matriz1[13] = 9'd14; matriz1[14] = 9'd15;
        matriz1[15] = 9'd16; matriz1[16] = 9'd17; matriz1[17] = 9'd18; matriz1[18] = 9'd19; matriz1[19] = 9'd20;
        matriz1[20] = 9'd21; matriz1[21] = 9'd22; matriz1[22] = 9'd23; matriz1[23] = 9'd24; matriz1[24] = 9'd25;
        
        matriz2[0] = 9'd1; matriz2[1] = 9'd2; matriz2[2] = 9'd3; matriz2[3] = 9'd4; matriz2[4] = 9'd5;
        matriz2[5] = 9'd6; matriz2[6] = 9'd7; matriz2[7] = 9'd8; matriz2[8] = 9'd9; matriz2[9] = 9'd10;
        matriz2[10] = 9'd11; matriz2[11] = 9'd12; matriz2[12] = 9'd13; matriz2[13] = 9'd14; matriz2[14] = 9'd15;
        matriz2[15] = 9'd16; matriz2[16] = 9'd17; matriz2[17] = 9'd18; matriz2[18] = 9'd19; matriz2[19] = 9'd20;
        matriz2[20] = 9'd21; matriz2[21] = 9'd22; matriz2[22] = 9'd23; matriz2[23] = 9'd24; matriz2[24] = 9'd25;
    end

    // Processamento do preenchimento da RAM
    always @(posedge clk) begin
        if (start) begin
            if (endereco < 25) begin
                // Lógica de controle para o sinal "grava"
                grava <= 1'b1;  // Define que deve gravar
                endereco <= endereco + 1; // Avança para o próximo endereço (atribuição não-bloqueante)
            end else begin
                grava <= 1'b0;  // Para gravação quando terminar
            end
        end
    end
	 
	 always@(posedge clk) begin
	dado <= saida[8:0];
	end

endmodule
