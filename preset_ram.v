module preset_ram(
    input clk,                // Clock para sincronização
    input start          // Sinal para iniciar a gravação
);

    reg [7:0] endereco1;      // Endereço da memória para matriz1 (0 a 24)
    reg [7:0] endereco2;      // Endereço da memória para matriz2 (25 a 49)
    reg [8:0] matriz1 [0:24]; // Matriz 1 (5x5) - 25 posições
    reg [8:0] matriz2 [0:24]; // Matriz 2 (5x5) - 25 posições
    reg grava;                // Sinal para controle de gravação

    // Instâncias do módulo fluxo_ram fora do bloco always
    fluxo_ram ram_inst1 (
        .clk(clk),
        .endereco(endereco1),
        .dado_entrada(matriz1[endereco1]),
        .grava(grava),
        .dado_saida()
    );

    fluxo_ram ram_inst2 (
        .clk(clk),
        .endereco(endereco2),
        .dado_entrada(matriz2[endereco2]),
        .grava(grava),
        .dado_saida()
    );

    // Inicialização dos valores das matrizes
    initial begin
        matriz1[0] = 9'd1; matriz1[1] = 9'd2; matriz1[2] = 9'd3; matriz1[3] = 9'd4; matriz1[4] = 9'd5;
        matriz1[5] = 9'd6; matriz1[6] = 9'd7; matriz1[7] = 9'd8; matriz1[8] = 9'd9; matriz1[9] = 9'd10;
        matriz1[10] = 9'd11; matriz1[11] = 9'd12; matriz1[12] = 9'd13; matriz1[13] = 9'd14; matriz1[14] = 9'd15;
        matriz1[15] = 9'd16; matriz1[16] = 9'd17; matriz1[17] = 9'd18; matriz1[18] = 9'd19; matriz1[19] = 9'd20;
        matriz1[20] = 9'd21; matriz1[21] = 9'd22; matriz1[22] = 9'd23; matriz1[23] = 9'd24; matriz1[24] = 9'd25;
        
        matriz2[0] = 9'd26; matriz2[1] = 9'd27; matriz2[2] = 9'd28; matriz2[3] = 9'd29; matriz2[4] = 9'd30;
        matriz2[5] = 9'd31; matriz2[6] = 9'd32; matriz2[7] = 9'd33; matriz2[8] = 9'd34; matriz2[9] = 9'd35;
        matriz2[10] = 9'd36; matriz2[11] = 9'd37; matriz2[12] = 9'd38; matriz2[13] = 9'd39; matriz2[14] = 9'd40;
        matriz2[15] = 9'd41; matriz2[16] = 9'd42; matriz2[17] = 9'd43; matriz2[18] = 9'd44; matriz2[19] = 9'd45;
        matriz2[20] = 9'd46; matriz2[21] = 9'd47; matriz2[22] = 9'd48; matriz2[23] = 9'd49; matriz2[24] = 9'd50;
    end

    // Processamento do preenchimento da RAM para as duas matrizes
    always @(posedge clk) begin
        if (start) begin
            if (endereco1 < 25) begin
                // Gravação da matriz1
                grava <= 1'b1;  
                endereco1 <= endereco1 + 1; // Avança para o próximo endereço da matriz1
            end else begin
                grava <= 1'b0;  // Para a gravação quando terminar a matriz1
            end
            
            if (endereco2 < 25) begin
                // Gravação da matriz2
                grava <= 1'b1;  
                endereco2 <= endereco2 + 1; // Avança para o próximo endereço da matriz2
            end else begin
                grava <= 1'b0;  // Para a gravação quando terminar a matriz2
            end
        end
    end


endmodule
