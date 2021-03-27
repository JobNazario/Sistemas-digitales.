module stateM(	
	input iclk,
	input irst,
	input istop,
	input iback,
	output [2:0]ovalor
	);
	
	reg [1:0]rvalor_D;
	reg [1:0]rvalor_Q;
	
	reg [1:0]rEstado_D;
	reg [1:0]rEstado_Q;
	
	assign ovalor = rEstado_Q;
	
	always @(posedge iclk)
	begin 
		rvalor_Q <= rvalor_D;
		rEstado_Q <= rEstado_D;
	end
	
	always @ *
	begin
		case (rEstado_Q)
		2'd0: //case1
		begin 
			if (!irst && !istop)
			begin 
				rEstado_D = 2'd1;
			end
			else
			begin			
				rEstado_D = rEstado_Q;
			end
			rvalor_D = 2'd0;
		end
		2'd1: //case2
		begin 
			if (!irst && !istop)
			begin 
				rEstado_D = 2'd2;
			end
			else if(iback)
			begin
				rEstado_D = 2'd0;
			end
			else if(irst)
			begin
				rEstado_D = 2'd0;
			end
			else
			begin
				rEstado_D = rEstado_Q;
			end
			rvalor_D = 2'd1;
		end		
		2'd2: //case3
		begin 
			if (!irst && !istop)
			begin 
				rEstado_D = 2'd3;
			end
			else if(irst)
			begin
				rEstado_D = 2'd0;
			end
			else if(iback)
			begin
				rEstado_D = 2'd1;
			end
			else
			begin
				rEstado_D = rEstado_Q;
			end
		end
		
		2'd3:
		begin
			if (!irst && !istop)
			begin 
				rEstado_D = 2'd0;
			end
			else if(irst)
			begin
				rEstado_D = 2'd0;
			end
			else if(iback)
			begin
				rEstado_D = 2'd2;
			end
			else
			begin
				rEstado_D = rEstado_Q;
			end
		end
		
		default:
		begin
		rEstado_D = 2'd0;
		rvalor_D = 2'd0;
		end
		endcase
	end
	
endmodule
