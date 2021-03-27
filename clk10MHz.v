module clk10MHz(
	 input  clk,
	 output reg clk10
    );
	 
	 reg [24:0] cont;	 
	 initial
	 begin	 
		cont = 0;
		clk10 = 0;		
	end
			 
	always @(posedge clk)
		if(cont < 25'd2500000)
		
			cont <= cont + 1;			
		else
		begin		
			cont <= 0;
			clk10 <= ~clk10;			
		end
endmodule
