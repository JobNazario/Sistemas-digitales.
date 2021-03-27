module mux2_1
	#(parameter ancho = 4)
				 (input  [ancho-1:0] i0,i1,
				  input  s,
				  output [ancho-1:0] y);
				  
	assign y=s?i1:i0;
endmodule
