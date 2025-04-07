module unidade_logica(
	input clk,
	input start,
	input [2:0] operacao,
	input [224:0] matriz_A,
	input [224:0] matriz_B,
	output reg [224:0] matriz_resultado,
	output reg done
);

	reg done_det;
	
	initial begin
		done_det = 1;
	end
	
	
	wire [224:0] matriz_soma, matriz_sub, matriz_oposta, matriz_multi, matriz_transp, matriz_int, matriz_det;
	
	always @(posedge clk) begin
        if (start) begin
            // Resetar done antes de começar.
            done <= 0;
	
				case (operacao)
					 3'b000: matriz_resultado = matriz_soma;       // Soma
					 3'b001: matriz_resultado = matriz_sub;        // Subtração
					 3'b010: matriz_resultado = matriz_oposta;     // Oposta
					 3'b011: matriz_resultado = matriz_multi;      // Multiplicação
					 3'b100: matriz_resultado = matriz_transp;     // Transposição
					 3'b101: matriz_resultado = matriz_det;        // Determinante
					 3'b110: matriz_resultado = matriz_int;        // Multiplicação por inteiro
					 default: matriz_resultado = 225'b0;           // Default
				endcase
				
				if(done_det == 1) begin
						done <= 1;
				end
		end
	end
		
		
	// Soma
	modulo_somador_subtrator inst1(
    .a(matriz_A[7:0]), 
    .b(matriz_B[7:0]),
    .op(0),
    .resultado(matriz_soma[8:0])
	);

	modulo_somador_subtrator inst2(
    .a(matriz_A[16:9]), 
    .b(matriz_B[16:9]),
    .op(0),
    .resultado(matriz_soma[17:9])
	);

	modulo_somador_subtrator inst3(
    .a(matriz_A[25:18]), 
    .b(matriz_B[25:18]),
    .op(0),
    .resultado(matriz_soma[26:18])
	);

	modulo_somador_subtrator inst4(
    .a(matriz_A[34:27]), 
    .b(matriz_B[34:27]),
    .op(0),
    .resultado(matriz_soma[35:27])
	);

	modulo_somador_subtrator inst5(
    .a(matriz_A[43:36]), 
    .b(matriz_B[43:36]),
    .op(0),
    .resultado(matriz_soma[44:36])
	);

	modulo_somador_subtrator inst6(
    .a(matriz_A[52:45]), 
    .b(matriz_B[52:45]),
    .op(0),
    .resultado(matriz_soma[53:45])
	);

	modulo_somador_subtrator inst7(
    .a(matriz_A[61:54]), 
    .b(matriz_B[61:54]),
    .op(0),
    .resultado(matriz_soma[62:54])
	);

	modulo_somador_subtrator inst8(
    .a(matriz_A[70:63]), 
    .b(matriz_B[70:63]),
    .op(0),
    .resultado(matriz_soma[71:63])
	);

	modulo_somador_subtrator inst9(
    .a(matriz_A[79:72]), 
    .b(matriz_B[79:72]),
    .op(0),
    .resultado(matriz_soma[80:72])
	);

	modulo_somador_subtrator inst10(
    .a(matriz_A[88:81]), 
    .b(matriz_B[88:81]),
    .op(0),
    .resultado(matriz_soma[89:81])
	);

	modulo_somador_subtrator inst11(
    .a(matriz_A[97:90]), 
    .b(matriz_B[97:90]),
    .op(0),
    .resultado(matriz_soma[98:90])
	);

	modulo_somador_subtrator inst12(
    .a(matriz_A[106:99]), 
    .b(matriz_B[106:99]),
    .op(0),
    .resultado(matriz_soma[107:99])
	);

	modulo_somador_subtrator inst13(
    .a(matriz_A[115:108]), 
    .b(matriz_B[115:108]),
    .op(0),
    .resultado(matriz_soma[116:108])
	);

	modulo_somador_subtrator inst14(
    .a(matriz_A[124:117]), 
    .b(matriz_B[124:117]),
    .op(0),
    .resultado(matriz_soma[125:117])
	);

	modulo_somador_subtrator inst15(
    .a(matriz_A[133:126]), 
    .b(matriz_B[133:126]),
    .op(0),
    .resultado(matriz_soma[134:126])
	);

	modulo_somador_subtrator inst16(
    .a(matriz_A[142:135]), 
    .b(matriz_B[142:135]),
    .op(0),
    .resultado(matriz_soma[143:135])
	);

	modulo_somador_subtrator inst17(
    .a(matriz_A[151:144]), 
    .b(matriz_B[151:144]),
    .op(0),
    .resultado(matriz_soma[152:144])
	);

	modulo_somador_subtrator inst18(
    .a(matriz_A[160:153]), 
    .b(matriz_B[160:153]),
    .op(0),
    .resultado(matriz_soma[161:153])
	);

	modulo_somador_subtrator inst19(
    .a(matriz_A[169:162]), 
    .b(matriz_B[169:162]),
    .op(0),
    .resultado(matriz_soma[170:162])
	);

	modulo_somador_subtrator inst20(
    .a(matriz_A[178:171]), 
    .b(matriz_B[178:171]),
    .op(0),
    .resultado(matriz_soma[179:171])
	);

	modulo_somador_subtrator inst21(
    .a(matriz_A[187:180]), 
    .b(matriz_B[187:180]),
    .op(0),
    .resultado(matriz_soma[188:180])
	);

	modulo_somador_subtrator inst22(
    .a(matriz_A[196:189]), 
    .b(matriz_B[196:189]),
    .op(0),
    .resultado(matriz_soma[197:189])
	);

	modulo_somador_subtrator inst23(
    .a(matriz_A[205:198]), 
    .b(matriz_B[205:198]),
    .op(0),
    .resultado(matriz_soma[206:198])
	);

	modulo_somador_subtrator inst24(
    .a(matriz_A[214:207]), 
    .b(matriz_B[214:207]),
    .op(0),
    .resultado(matriz_soma[215:207])
	);

	modulo_somador_subtrator inst25(
    .a(matriz_A[223:216]), 
    .b(matriz_B[223:216]),
    .op(0),
    .resultado(matriz_soma[224:216])
	);
	
	
	// Subtração
	modulo_somador_subtrator inst_sub1(
		 .a(matriz_A[7:0]), 
		 .b(matriz_B[7:0]),
		 .op(1),
		 .resultado(matriz_sub[8:0])
	);

	modulo_somador_subtrator inst_sub2(
		 .a(matriz_A[16:9]), 
		 .b(matriz_B[16:9]),
		 .op(1),
		 .resultado(matriz_sub[17:9])
	);

	modulo_somador_subtrator inst_sub3(
		 .a(matriz_A[25:18]), 
		 .b(matriz_B[25:18]),
		 .op(1),
		 .resultado(matriz_sub[26:18])
	);

	modulo_somador_subtrator inst_sub4(
		 .a(matriz_A[34:27]), 
		 .b(matriz_B[34:27]),
		 .op(1),
		 .resultado(matriz_sub[35:27])
	);

	modulo_somador_subtrator inst_sub5(
		 .a(matriz_A[43:36]), 
		 .b(matriz_B[43:36]),
		 .op(1),
		 .resultado(matriz_sub[44:36])
	);

	modulo_somador_subtrator inst_sub6(
		 .a(matriz_A[52:45]), 
		 .b(matriz_B[52:45]),
		 .op(1),
		 .resultado(matriz_sub[53:45])
	);

	modulo_somador_subtrator inst_sub7(
		 .a(matriz_A[61:54]), 
		 .b(matriz_B[61:54]),
		 .op(1),
		 .resultado(matriz_sub[62:54])
	);

	modulo_somador_subtrator inst_sub8(
		 .a(matriz_A[70:63]), 
		 .b(matriz_B[70:63]),
		 .op(1),
		 .resultado(matriz_sub[71:63])
	);

	modulo_somador_subtrator inst_sub9(
		 .a(matriz_A[79:72]), 
		 .b(matriz_B[79:72]),
		 .op(1),
		 .resultado(matriz_sub[80:72])
	);

	modulo_somador_subtrator inst_sub10(
		 .a(matriz_A[88:81]), 
		 .b(matriz_B[88:81]),
		 .op(1),
		 .resultado(matriz_sub[89:81])
	);

	modulo_somador_subtrator inst_sub11(
		 .a(matriz_A[97:90]), 
		 .b(matriz_B[97:90]),
		 .op(1),
		 .resultado(matriz_sub[98:90])
	);

	modulo_somador_subtrator inst_sub12(
		 .a(matriz_A[106:99]), 
		 .b(matriz_B[106:99]),
		 .op(1),
		 .resultado(matriz_sub[107:99])
	);

	modulo_somador_subtrator inst_sub13(
		 .a(matriz_A[115:108]), 
		 .b(matriz_B[115:108]),
		 .op(1),
		 .resultado(matriz_sub[116:108])
	);

	modulo_somador_subtrator inst_sub14(
		 .a(matriz_A[124:117]), 
		 .b(matriz_B[124:117]),
		 .op(1),
		 .resultado(matriz_sub[125:117])
	);

	modulo_somador_subtrator inst_sub15(
		 .a(matriz_A[133:126]), 
		 .b(matriz_B[133:126]),
		 .op(1),
		 .resultado(matriz_sub[134:126])
	);

	modulo_somador_subtrator inst_sub16(
		 .a(matriz_A[142:135]), 
		 .b(matriz_B[142:135]),
		 .op(1),
		 .resultado(matriz_sub[143:135])
	);

	modulo_somador_subtrator inst_sub17(
		 .a(matriz_A[151:144]), 
		 .b(matriz_B[151:144]),
		 .op(1),
		 .resultado(matriz_sub[152:144])
	);

	modulo_somador_subtrator inst_sub18(
		 .a(matriz_A[160:153]), 
		 .b(matriz_B[160:153]),
		 .op(1),
		 .resultado(matriz_sub[161:153])
	);

	modulo_somador_subtrator inst_sub19(
		 .a(matriz_A[169:162]), 
		 .b(matriz_B[169:162]),
		 .op(1),
		 .resultado(matriz_sub[170:162])
	);

	modulo_somador_subtrator inst_sub20(
		 .a(matriz_A[178:171]), 
		 .b(matriz_B[178:171]),
		 .op(1),
		 .resultado(matriz_sub[179:171])
	);

	modulo_somador_subtrator inst_sub21(
		 .a(matriz_A[187:180]), 
		 .b(matriz_B[187:180]),
		 .op(1),
		 .resultado(matriz_sub[188:180])
	);

	modulo_somador_subtrator inst_sub22(
		 .a(matriz_A[196:189]), 
		 .b(matriz_B[196:189]),
		 .op(1),
		 .resultado(matriz_sub[197:189])
	);

	modulo_somador_subtrator inst_sub23(
		 .a(matriz_A[205:198]), 
		 .b(matriz_B[205:198]),
		 .op(1),
		 .resultado(matriz_sub[206:198])
	);

	modulo_somador_subtrator inst_sub24(
		 .a(matriz_A[214:207]), 
		 .b(matriz_B[214:207]),
		 .op(1),
		 .resultado(matriz_sub[215:207])
	);

	modulo_somador_subtrator inst_sub25(
		 .a(matriz_A[223:216]), 
		 .b(matriz_B[223:216]),
		 .op(1),
		 .resultado(matriz_sub[224:216])
	);

	
	// Oposta
	
   modulo_oposto inst_oposta1(
     .entrada(matriz_A[7:0]),
     .saida(matriz_oposta[8:0])
   );

   modulo_oposto inst_oposta2(
     .entrada(matriz_A[16:9]),
     .saida(matriz_oposta[17:9])
   );

   modulo_oposto inst_oposta3(
     .entrada(matriz_A[25:18]),
     .saida(matriz_oposta[26:18])
   );

   modulo_oposto inst_oposta4(
     .entrada(matriz_A[34:27]),
     .saida(matriz_oposta[35:27])
   );

   modulo_oposto inst_oposta5(
     .entrada(matriz_A[43:36]),
     .saida(matriz_oposta[44:36])
   );

   modulo_oposto inst_oposta6(
     .entrada(matriz_A[52:45]),
     .saida(matriz_oposta[53:45])
   );

   modulo_oposto inst_oposta7(
     .entrada(matriz_A[61:54]),
     .saida(matriz_oposta[62:54])
   );

   modulo_oposto inst_oposta8(
     .entrada(matriz_A[70:63]),
     .saida(matriz_oposta[71:63])
   );

   modulo_oposto inst_oposta9(
     .entrada(matriz_A[79:72]),
     .saida(matriz_oposta[80:72])
   );

   modulo_oposto inst_oposta10(
     .entrada(matriz_A[88:81]),
     .saida(matriz_oposta[89:81])
   );

   modulo_oposto inst_oposta11(
     .entrada(matriz_A[97:90]),
     .saida(matriz_oposta[98:90])
   );

   modulo_oposto inst_oposta12(
     .entrada(matriz_A[106:99]),
     .saida(matriz_oposta[107:99])
   );

   modulo_oposto inst_oposta13(
     .entrada(matriz_A[115:108]),
     .saida(matriz_oposta[116:108])
   );

   modulo_oposto inst_oposta14(
     .entrada(matriz_A[124:117]),
     .saida(matriz_oposta[125:117])
   );

   modulo_oposto inst_oposta15(
     .entrada(matriz_A[133:126]),
     .saida(matriz_oposta[134:126])
   );

   modulo_oposto inst_oposta16(
     .entrada(matriz_A[142:135]),
     .saida(matriz_oposta[143:135])
   );

   modulo_oposto inst_oposta17(
     .entrada(matriz_A[151:144]),
     .saida(matriz_oposta[152:144])
   );

   modulo_oposto inst_oposta18(
     .entrada(matriz_A[160:153]),
     .saida(matriz_oposta[161:153])
   );

   modulo_oposto inst_oposta19(
     .entrada(matriz_A[169:162]),
     .saida(matriz_oposta[170:162])
   );

   modulo_oposto inst_oposta20(
     .entrada(matriz_A[178:171]),
     .saida(matriz_oposta[179:171])
   );

   modulo_oposto inst_oposta21(
     .entrada(matriz_A[187:180]),
     .saida(matriz_oposta[188:180])
   );

   modulo_oposto inst_oposta22(
     .entrada(matriz_A[196:189]),
     .saida(matriz_oposta[197:189])
   );

   modulo_oposto inst_oposta23(
     .entrada(matriz_A[205:198]),
     .saida(matriz_oposta[206:198])
   );

   modulo_oposto inst_oposta24(
     .entrada(matriz_A[214:207]),
     .saida(matriz_oposta[215:207])
   );

   modulo_oposto inst_oposta25(
     .entrada(matriz_A[223:216]),
     .saida(matriz_oposta[224:216])
   );

	
	// Multiplicação
	modulo_multiplicador inst_multi1(
     .a(matriz_A[7:0]),
     .b(matriz_B[7:0]),
     .resultado(matriz_multi[8:0])
	);

	modulo_multiplicador inst_multi2(
     .a(matriz_A[16:9]),
     .b(matriz_B[16:9]),
     .resultado(matriz_multi[17:9])
	);

	modulo_multiplicador inst_multi3(
     .a(matriz_A[25:18]),
     .b(matriz_B[25:18]),
     .resultado(matriz_multi[26:18])
	);

	modulo_multiplicador inst_multi4(
     .a(matriz_A[34:27]),
     .b(matriz_B[34:27]),
     .resultado(matriz_multi[35:27])
	);

	modulo_multiplicador inst_multi5(
     .a(matriz_A[43:36]),
     .b(matriz_B[43:36]),
     .resultado(matriz_multi[44:36])
	);

	modulo_multiplicador inst_multi6(
     .a(matriz_A[52:45]),
     .b(matriz_B[52:45]),
     .resultado(matriz_multi[53:45])
	);

	modulo_multiplicador inst_multi7(
     .a(matriz_A[61:54]),
     .b(matriz_B[61:54]),
     .resultado(matriz_multi[62:54])
	);

	modulo_multiplicador inst_multi8(
     .a(matriz_A[70:63]),
     .b(matriz_B[70:63]),
     .resultado(matriz_multi[71:63])
	);

	modulo_multiplicador inst_multi9(
     .a(matriz_A[79:72]),
     .b(matriz_B[79:72]),
     .resultado(matriz_multi[80:72])
	);

	modulo_multiplicador inst_multi10(
     .a(matriz_A[88:81]),
     .b(matriz_B[88:81]),
     .resultado(matriz_multi[89:81])
	);

	modulo_multiplicador inst_multi11(
     .a(matriz_A[97:90]),
     .b(matriz_B[97:90]),
     .resultado(matriz_multi[98:90])
	);

	modulo_multiplicador inst_multi12(
     .a(matriz_A[106:99]),
     .b(matriz_B[106:99]),
     .resultado(matriz_multi[107:99])
	);

	modulo_multiplicador inst_multi13(
     .a(matriz_A[115:108]),
     .b(matriz_B[115:108]),
     .resultado(matriz_multi[116:108])
	);

	modulo_multiplicador inst_multi14(
     .a(matriz_A[124:117]),
     .b(matriz_B[124:117]),
     .resultado(matriz_multi[125:117])
	);

	modulo_multiplicador inst_multi15(
     .a(matriz_A[133:126]),
     .b(matriz_B[133:126]),
     .resultado(matriz_multi[134:126])
	);

	modulo_multiplicador inst_multi16(
     .a(matriz_A[142:135]),
     .b(matriz_B[142:135]),
     .resultado(matriz_multi[143:135])
	);

	modulo_multiplicador inst_multi17(
     .a(matriz_A[151:144]),
     .b(matriz_B[151:144]),
     .resultado(matriz_multi[152:144])
	);

	modulo_multiplicador inst_multi18(
     .a(matriz_A[160:153]),
     .b(matriz_B[160:153]),
     .resultado(matriz_multi[161:153])
	);

	modulo_multiplicador inst_multi19(
     .a(matriz_A[169:162]),
     .b(matriz_B[169:162]),
     .resultado(matriz_multi[170:162])
	);

	modulo_multiplicador inst_multi20(
     .a(matriz_A[178:171]),
     .b(matriz_B[178:171]),
     .resultado(matriz_multi[179:171])
	);

	modulo_multiplicador inst_multi21(
     .a(matriz_A[187:180]),
     .b(matriz_B[187:180]),
     .resultado(matriz_multi[188:180])
	);

	modulo_multiplicador inst_multi22(
     .a(matriz_A[196:189]),
     .b(matriz_B[196:189]),
     .resultado(matriz_multi[197:189])
	);
	
	modulo_multiplicador inst_multi23(
     .a(matriz_A[205:198]),
     .b(matriz_B[205:198]),
     .resultado(matriz_multi[206:198])
	);

	modulo_multiplicador inst_multi24(
     .a(matriz_A[214:207]),
     .b(matriz_B[214:207]),
     .resultado(matriz_multi[215:207])
	);

	modulo_multiplicador inst_multi25(
     .a(matriz_A[223:216]),
     .b(matriz_B[223:216]),
     .resultado(matriz_multi[224:216])
	);


	
	
endmodule