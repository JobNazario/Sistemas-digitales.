module antirebote( 
	input reset, clk, senout,
	output reg sen
	);

   parameter delay = 10000;

   reg [20:0] count;
   reg kk;

   always @(posedge clk)
     if (reset) begin 
	  kk <= senout; 
	  sen <= senout; 
	  count <= 0;
	  end
     else if (senout != kk) begin
	  kk <= senout;
	  count <= 0;
	  end
     else if (count == delay) sen <= kk;
     else count <= count+1;

endmodule