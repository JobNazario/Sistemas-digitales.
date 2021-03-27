module clk_div(
	input clk,
	output clkd
	);
						 
	reg [16:0] count;
	initial count = 0;	
	assign clkd = count[16];	
	always @(posedge clk)
	
		count = count + 1;
endmodule
