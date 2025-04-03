module gerencia_matriz(
    input clk,                // Clock para sincronização
    input start,         // Sinal para iniciar a gravação
	 input grava,
	 input [224:0] matriz_resultante,
	 output reg [224:0] matriz1,
	 output reg [224:0] matriz2
);

    reg [7:0] endereco1,endereco2;      // Endereço da memória (0 a 24)
	 
    reg [8:0] matriz_ler [0:49]; // Matriz 2 (5x5) - 50 posicoes (2 Matrizes);
	 reg [8:0] matriz_escrita[0:24];
	 
	 
    // reg [8:0] matriz2 [0:24]; // Matriz 2 (5x5) - 25 posições
	 reg [4:0] contador;
	 reg gravar;
	 reg [8:0] dado_var;
	 wire [8:0] saida;

	 
	 initial begin
		matriz_escrita[0] = 9'd5;  
		contador = 0;
	 end
	 
	 
    // Instancia que faz SOMENTE leitura.
    fluxo_ram ram_inst1(
        .clk(clk),
        .endereco(endereco1),
        .dado_entrada(),
        .grava(1'b0),
        .dado_saida(saida)
    );
	 
	 fluxo_ram ram_inst2(
        .clk(clk),
        .endereco(endereco2),
        .dado_entrada(dado_var), // matriz_escrita[endereco2]
        .grava(gravar),
        .dado_saida()
    );

    // Inicialização dos valores das matrizes
    initial begin		  
		  
		  endereco1 = 0; endereco2 = 50; contador = 0; gravar = 0;
    end
	 

    // Processamento do preenchimento da RAM para as duas matrizes
	 
    always @(posedge clk) begin
        if (start) begin	  
		  if(contador < 30) begin
				contador <= contador+1; // Atraso pra nao zerar os primeiros endereços
				end
            if (endereco1 < 50) begin
                // Leitura das duas matrizes;
					 matriz_ler[endereco1] = saida;
                endereco1 <= endereco1 + 1; // Avança para o próximo endereço da matriz
					 
            end else if(endereco2 < 75) begin
					gravar <= 1'b1;
					dado_var <= matriz_escrita[endereco2];
					endereco2 <= endereco2 +1; 
					
            end else begin
					gravar <=1'b0;
				end
        end
    end


endmodule
