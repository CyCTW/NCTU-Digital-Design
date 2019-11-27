module t_HW2_Scoreboard();
	reg clk;
	reg rst;
	reg inc, dec;
	wire [6:0] seg7disp1;
	wire [6:0] seg7disp0;
	
	HW2_Scoreboard_modified w1(clk, rst, inc, dec, seg7disp1, seg7disp0);
	//HW2_E_Scoreboard w2(clk, rst, inc, dec, seg7disp1, seg7disp0);
	initial begin
		rst = 0;
		inc =1;dec = 0;
		clk = 1;
		#300 inc = 0;dec = 1;
		#100 inc = 1;dec = 1;rst = 1;
	end



	always begin
		#10 clk = ~clk;
	end
endmodule