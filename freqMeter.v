module freqMeter (
  input clk,                       							    //Reloj FPGA a 50MHz
  input signal,                     							
  // input [3:0] vSw;
  output [6:0] voSevenseg
  );

  assign voSevenseg = vSevenseg;
  reg [6:0] vSevenseg;
  //reg [7:0] vSw;      
  
  reg [13:0]counter = 1'd0;             						 // contador posEdge
  reg [13:0]counted = 14'd10000;         						 //Últimos posEdges contados

  reg [15:0] period = 16'd1000;          						 //Periodo calculaden microsegundos
  reg isLowPeriod   = 0;             							 //Verdadero si el período <1000

  reg [7:0] x;                       							 //BCD
  reg [7:0] y;															 // recalculacion de la frecuencia
  reg [5:0]signalPast = 6'b010101;  							 //señaliza los últimos 6 valores

  //assign vSw = 1/x;											    //freceuncia 
  
  // cuaerpo del codigo 
  always @(posedge clk) 
  begin

    // counter logico
    if (signalPast == 6'b000000 && signal == 1)
	 begin     															 //if input signal is at posEdge
      counted = counter;                                  //save counter value
      counter <= 0;                                       //reset counter
    end 
	 else 
	 begin                                      
      counter <= counter + 1;                             //count
    end
    
    //Almacenamiento de los últimos 6 valores de la señal
    signalPast = signalPast << 1;
    signalPast[0] = signal;
    
  end

  
  //Period Compu
  always @(counted) begin
    period = counted / 10;
    isLowPeriod = period < 1000;
  
  end
  
  
  //BCD Compu
  always @(period) begin
  
    if (isLowPeriod) begin
                                                    
      x[7:4] <= (period - period % 100)/100;
      x[3:0] <= (period % 100 - period % 10 )/10 ;
    end 
	/* else if 
	 begin
		x[7:4] <= (period - period % 10)/10; 
      x[3:0] <= (period % 10 - period % 1 )/1 ;
	 end*/
	 else begin
                                                    
      x[7:4] <= (period - period % 1000)/1000;
      x[3:0] <= (period % 1000 - period % 100 )/100 ;
    end
	 y=1/x;
	end
	
	always @*
	begin
		case (y)
		4'h0: vSevenseg = 7'b1000000;
		4'h1: vSevenseg = 7'b1111001;
		4'h2: vSevenseg = 7'b0100100;
		4'h3: vSevenseg = 7'b0110000;
		4'h4: vSevenseg = 7'b0011001;
		4'h5: vSevenseg = 7'b0010010;
		4'h6: vSevenseg = 7'b0000010;
		4'h7: vSevenseg = 7'b1111000;
		4'h8: vSevenseg = 7'b0000000;
		4'h9: vSevenseg = 7'b0010000;
		4'hA: vSevenseg = 7'b0001000;
		4'hB: vSevenseg = 7'b0000011;
		4'hC: vSevenseg = 7'b1000110;
		4'hD: vSevenseg = 7'b0100001;
		4'hE: vSevenseg = 7'b0000110;
		4'hF: vSevenseg = 7'b0001110;

		endcase
  end

endmodule
