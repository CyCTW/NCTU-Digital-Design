module t_HW3_FPMUL_SP();
	reg Clk, St;
	reg [31:0] FPmcand;
	reg [31:0] FPmplier;
	wire Done, Ovf, Unf;
	wire [31:0] FPproduct;

	initial begin
		$dumpfile ("float.vcd");
		$dumpvars;
		#0
		Clk = 1;
		St = 1'b1;
		FPmplier = 32'b0_01110011_10101010101010101010101;
		FPmcand = 32'b1_10101010_00110011001100110011001;

		#50 St = 1'b0;
		#50
		St = 1'b1;
		FPmplier = 32'b1_10001111_10110011001100110011001;
		FPmcand  = 32'b1_11111001_01101000000000000000000;
		#50 St = 1'b0;
		#50		
		St = 1'b1;		 	   
		FPmplier = 32'b0_00000011_10111111111111111111101;
		FPmcand  = 32'b1_01001010_01000000000000000000010;
		#50 St = 1'b0;
		#50
		St = 1'b1;
		FPmplier = 32'b0_01110011_00000000000000000000001;
		FPmcand  = 32'b1_10101010_00000000000000000000001;
		#50 St = 1'b0;
		#50 $finish;
	end
	always #10 Clk <= ~Clk;
	HW3_FPMUL_SP h1(Clk, St, FPmplier, FPmcand, Done, Ovf, Unf, FPproduct);

endmodule