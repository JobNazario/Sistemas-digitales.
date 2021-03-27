module Debouncer  //codigo cuyo objetivo es evitar el rebote de la señal. 
	(input sen_in,
	 output reg sen_out
    );

reg [3:0] cont = 0;	
initial	
	sen_out = 0;

always @(posedge sen_in)	
	if(cont<8)		
		cont = cont + 1;			
	else		
		cont = 0;
		
always @(*)	
	if(cont == 8)	
		sen_out = ~sen_out;
endmodule