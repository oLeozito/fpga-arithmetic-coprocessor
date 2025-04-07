module gerencia_matriz(
	input clk,        // Clock para sincronização
	input start,     	// Sinal para iniciar a gravação
 	input grava,      // 0 Indica Leitura - 1 Indica Gravação
 	input [224:0] matriz_resultante,
 	output reg [224:0] matriz1,
 	output reg [224:0] matriz2
);

	reg [7:0] endereco1,endereco2;  	// Endereço da memória (0 a 24)
	 
	reg [8:0] matriz_ler [0:49]; // Matriz 2 (5x5) - 50 posicoes (2 Matrizes);
 	reg [8:0] matriz_escrita[0:24];
	 
	 
	// reg [8:0] matriz2 [0:24]; // Matriz 2 (5x5) - 25 posições
 	reg [4:0] contador;
 	reg gravar;
 	reg [8:0] dado_var,aux;
 	wire [8:0] saida;

	 
 	initial begin  
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
      	endereco1 = 0; endereco2 = 0; contador = 0; gravar = 0;
	end
	 

	// Processamento do preenchimento da RAM para as duas matrizes
	 
	always @(posedge clk) begin
    	if (start) begin 	 
      	if(contador < 2) begin
            	contador <= contador+1; // Atraso pra nao zerar os primeiros endereços
            	end
        	if (endereco1 < 50) begin
            	// Leitura das duas matrizes;
                 	matriz_ler[endereco1] = saida;
						endereco1 <= endereco1 + 1; // Avança para o próximo endereço da matriz
                	 
        	end else if(endereco2 < 25) begin
                	gravar <= 1'b1;
                	dado_var <= matriz_escrita[endereco2];
                	endereco2 <= endereco2 +1;
               	 
        	end else begin
                	gravar <=1'b0;
            	end
    	end
	end

	always@(posedge clk) begin
    	matriz1[8:0] = matriz_ler[0];
    	matriz1[17:9] = matriz_ler[1];
    	matriz1[26:18] = matriz_ler[2];
    	matriz1[35:27] = matriz_ler[3];
    	matriz1[44:36] = matriz_ler[4];
    	matriz1[53:45] = matriz_ler[5];
    	matriz1[62:54] = matriz_ler[6];
    	matriz1[71:63] = matriz_ler[7];
    	matriz1[80:72] = matriz_ler[8];
    	matriz1[89:81] = matriz_ler[9];
    	matriz1[98:90] = matriz_ler[10];
    	matriz1[107:99] = matriz_ler[11];
    	matriz1[116:108] = matriz_ler[12];
    	matriz1[125:117] = matriz_ler[13];
    	matriz1[134:126] = matriz_ler[14];
    	matriz1[143:135] = matriz_ler[15];
    	matriz1[152:144] = matriz_ler[16];
    	matriz1[161:153] = matriz_ler[17];
    	matriz1[170:162] = matriz_ler[18];
    	matriz1[179:171] = matriz_ler[19];
    	matriz1[188:180] = matriz_ler[20];
    	matriz1[197:189] = matriz_ler[21];
    	matriz1[206:198] = matriz_ler[22];
    	matriz1[215:207] = matriz_ler[23];
    	matriz1[224:216] = matriz_ler[24];
   	 
   	matriz2[8:0] = matriz_ler[25];
   	matriz2[17:9] = matriz_ler[26];
   	matriz2[26:18] = matriz_ler[27];
   	matriz2[35:27] = matriz_ler[28];
   	matriz2[44:36] = matriz_ler[29];
   	matriz2[53:45] = matriz_ler[30];
   	matriz2[62:54] = matriz_ler[31];
   	matriz2[71:63] = matriz_ler[32];
   	matriz2[80:72] = matriz_ler[33];
   	matriz2[89:81] = matriz_ler[34];
   	matriz2[98:90] = matriz_ler[35];
   	matriz2[107:99] = matriz_ler[36];
   	matriz2[116:108] = matriz_ler[37];
   	matriz2[125:117] = matriz_ler[38];
   	matriz2[134:126] = matriz_ler[39];
   	matriz2[143:135] = matriz_ler[40];
   	matriz2[152:144] = matriz_ler[41];
   	matriz2[161:153] = matriz_ler[42];
   	matriz2[170:162] = matriz_ler[43];
   	matriz2[179:171] = matriz_ler[44];
   	matriz2[188:180] = matriz_ler[45];
   	matriz2[197:189] = matriz_ler[46];
   	matriz2[206:198] = matriz_ler[47];
   	matriz2[215:207] = matriz_ler[48];
   	matriz2[224:216] = matriz_ler[49];
   	 
    	matriz_escrita[0] = matriz_resultante[8:0];
    	matriz_escrita[1] = matriz_resultante[17:9];
    	matriz_escrita[2] = matriz_resultante[26:18];
    	matriz_escrita[3] = matriz_resultante[35:27];
    	matriz_escrita[4] = matriz_resultante[44:36];
    	matriz_escrita[5] = matriz_resultante[53:45];
    	matriz_escrita[6] = matriz_resultante[62:54];
    	matriz_escrita[7] = matriz_resultante[71:63];
    	matriz_escrita[8] = matriz_resultante[80:72];
    	matriz_escrita[9] = matriz_resultante[89:81];
    	matriz_escrita[10] = matriz_resultante[98:90];
    	matriz_escrita[11] = matriz_resultante[107:99];
    	matriz_escrita[12] = matriz_resultante[116:108];
    	matriz_escrita[13] = matriz_resultante[125:117];
    	matriz_escrita[14] = matriz_resultante[134:126];
    	matriz_escrita[15] = matriz_resultante[143:135];
    	matriz_escrita[16] = matriz_resultante[152:144];
    	matriz_escrita[17] = matriz_resultante[161:153];
    	matriz_escrita[18] = matriz_resultante[170:162];
    	matriz_escrita[19] = matriz_resultante[179:171];
    	matriz_escrita[20] = matriz_resultante[188:180];
    	matriz_escrita[21] = matriz_resultante[197:189];
    	matriz_escrita[22] = matriz_resultante[206:198];
    	matriz_escrita[23] = matriz_resultante[215:207];
    	matriz_escrita[24] = matriz_resultante[224:216];

	end

endmodule
