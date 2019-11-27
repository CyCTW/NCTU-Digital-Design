module t_HW2_divider();
	reg Clk, St;
	reg [15:0] Divisor;
	reg [15:0] Dividend;
	wire [15:0] Quotient;
	wire [15:0] Remainder;
	wire Overflow, Done;
	
	initial begin
		Dividend = 16'b1000_1010_1110_1010;
		Divisor = 16'b0000_0000_1011_1011;
		St = 1;
		Clk = 1'b1;
		#100 St = 0;
		#500 Dividend = 16'b0001_0101_0111_1111;Divisor = 16'b0001_0101_0100_0110;St = 1;
		#100 St = 0;
		#500 Dividend = 16'b0000_0101_1100_0011;  Divisor = 16'b1010_0100_0010_0000;St = 1;
		#100 St = 0;
		#500 Dividend = 16'b1001_0010_0100_1001; Divisor =16'b0000_0000_0000_0000;St = 1;
		#100 St = 0;
	end
	always begin
		#10 Clk <= ~Clk;
		end
	HW2_divider H2(Clk, St, Divisor, Dividend, Quotient, Remainder, Overflow, Done );
	
endmodule	
