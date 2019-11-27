module t_HW2_multiplier();
	reg [7:0] Mcandtmp[1:2];
	reg [7:0] Mpliertmp[1:2];
	reg Clk;
	reg St;
	reg[7:0] Mplier;
	reg[7:0] Mcand;
	wire[15:0] Product;
	wire Done;
	integer i;

	initial begin
	St <=1 ;
	Clk = 1'b1;
	Mcand<=8'b11110111;
	Mplier<=8'b11110011;
	#100 St<=0;
	
	#500 Mcand<=8'b01100110;
		   Mplier<=8'b00110011;
		   St<=1;
	#100 St<=0;
	#500 Mcand<=8'b10100110;
		   Mplier<=8'b01100110;
		   St<=1;
	#100 St<=0;
	
	end

	

	always 
	begin 
		#10 Clk<=~Clk;
	end

	
	
HW2_multiplier H1(Clk, St, Mplier, Mcand, Product, Done);
	
endmodule

		