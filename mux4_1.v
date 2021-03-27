module mux4_1
	#(parameter ancho = 4)
				 (input  [ancho-1:0] i0,i1,i2,i3,
				  input  [1:0] s,
				  output [ancho-1:0]		y);
				  
	wire [ancho-1:0] alto, bajo;
	
	mux2_1 #(ancho) mux_alto(i2,i3,s[0],alto);
	mux2_1 #(ancho) mux_bajo(i0,i1,s[0],bajo);
	mux2_1 #(ancho) mux_final(bajo,alto,s[1],y);
endmodule
