module modulo_transpor (
    input wire [224:0] matrix_in,  // Matriz 5x5 com elementos de 9 bits (225 bits no total)
    output [224:0] matrix_out  // Matriz 5x5 com elementos de 9 bits (225 bits no total)
);
	assign matrix_out[8:0]     = matrix_in[8:0];      // Transposição do elemento (0,0)
	assign matrix_out[17:9]    = matrix_in[53:45];    // Transposição do elemento (0,1)
	assign matrix_out[26:18]   = matrix_in[98:90];    // Transposição do elemento (0,2)
	assign matrix_out[35:27]   = matrix_in[143:135];    // Transposição do elemento (0,3)
	assign matrix_out[44:36]   = matrix_in[188:180];    // Transposição do elemento (0,4)

	assign matrix_out[53:45]   = matrix_in[17:9];      // Transposição do elemento (1,0)
	assign matrix_out[62:54]   = matrix_in[62:54];    // Transposição do elemento (1,1)
	assign matrix_out[71:63]   = matrix_in[107:99];    // Transposição do elemento (1,2)
	assign matrix_out[80:72]   = matrix_in[152:144];    // Transposição do elemento (1,3)
	assign matrix_out[89:81]   = matrix_in[197:189];    // Transposição do elemento (1,4)

	assign matrix_out[98:90]   = matrix_in[26:18];    // Transposição do elemento (2,0)
	assign matrix_out[107:99]  = matrix_in[71:63];    // Transposição do elemento (2,1)
	assign matrix_out[116:108] = matrix_in[116:108];    // Transposição do elemento (2,2)
	assign matrix_out[125:117] = matrix_in[161:153];    // Transposição do elemento (2,3)
	assign matrix_out[134:126] = matrix_in[206:198];    // Transposição do elemento (2,4)

	assign matrix_out[143:135] = matrix_in[35:27];    // Transposição do elemento (3,0)
	assign matrix_out[152:144] = matrix_in[80:72];    // Transposição do elemento (3,1)
	assign matrix_out[161:153] = matrix_in[125:117];    // Transposição do elemento (3,2)
	assign matrix_out[170:162] = matrix_in[170:162];    // Transposição do elemento (3,3)
	assign matrix_out[179:171] = matrix_in[215:207];    // Transposição do elemento (3,4)

	assign matrix_out[188:180] = matrix_in[44:36];    // Transposição do elemento (4,0)
	assign matrix_out[197:189] = matrix_in[89:81];    // Transposição do elemento (4,1)
	assign matrix_out[206:198] = matrix_in[134:126];    // Transposição do elemento (4,2)
	assign matrix_out[215:207] = matrix_in[179:171];    // Transposição do elemento (4,3)
	assign matrix_out[224:216] = matrix_in[224:216];    // Transposição do elemento (4,4)
	
	  
endmodule
