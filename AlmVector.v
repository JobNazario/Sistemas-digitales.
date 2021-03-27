module AlmVector(
	input isenal,
	input iclk,
	output [7:0] oValor
	);
	
	//reg [7:0]memory[3:0];
	reg [7:0]result_Q = 8'd0;
	reg [7:0]result_D = 8'd0;
	
	reg [1:0]rCounter_D = 2'd0;
	reg [1:0]rCounter_Q;
	
	/*initial
	begin 
		$readmemh("memory1.mem.txt",memory);
	end*/
	
	assign oValor = result_Q;

	always @ (posedge iclk)
	begin
		result_Q <= result_D;
		rCounter_Q <= rCounter_D;
	end
	
	always @*
	begin
		if(rCounter_Q < 4'd8)
			begin
				result_D[rCounter_Q]=isenal;
				rCounter_D = rCounter_Q + 4'd1;
			end
		else
			begin
				rCounter_D = 4'd0;
			end
	end
endmodule 