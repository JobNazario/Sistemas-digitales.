module Simult7segs(
	input clk,
	input  [3:0] A,B,C,D,
	output [6:0] display
	);
						 
wire [3:0] num;
reg  [1:0] S;
wire clk1;

initial

	S = 0;

	mux4_1 mux0(A,B,C,D,S,num);
	mux4_1 mux1(4'b0111,4'b1011,4'b1101,4'b1110,S);

	Siete_segs dis(num,display);

	clk_div clkdiv(clk,clk1);


always @(posedge clk1)

	S = S+1;

endmodule
