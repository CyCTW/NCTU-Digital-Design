module HW2_Scoreboard_modified(clk, rst, inc, dec, seg7disp1, seg7disp0);
	input clk;
	input rst;
	input inc;
	input dec;
	output [6:0] seg7disp1;
	output [6:0] seg7disp0;
	reg state; //only 2 states, 1 bit sufficient
	reg [3:0] BCD1;
	reg [3:0] BCD0;
	reg [2:0] rstcnt;
	reg [6:0] seg7Rom [0:9];
	initial begin
	BCD1 = 4'b0000;
	BCD0 = 4'b0000;
	rstcnt = 0;
	state = 0;
	seg7Rom[0] = 7'b0111111;
	seg7Rom[1] = 7'b0000110;
	seg7Rom[2] = 7'b1011011;
	seg7Rom[3] = 7'b1001111;
	seg7Rom[4] = 7'b1100110;
	seg7Rom[5] = 7'b1101101;
	seg7Rom[6] = 7'b1111100;
	seg7Rom[7] = 7'b0000111;
	seg7Rom[8] = 7'b1111111;
	seg7Rom[9] = 7'b1100111;
	end
	always @(posedge clk)
	begin
	case (state)
	0:
	begin
		BCD1 <= 4'b0000;
		BCD0 <= 4'b0000;
		rstcnt <= 0;
		state <= 1;
	end
	1:
	begin
	if(rst == 1'b1)
	begin
	if(rstcnt == 4)
		begin
			state <=0;
		end
	else
		begin
		rstcnt <= rstcnt + 1;
		end
	end
	else if (inc == 1'b1 && dec == 1'b0) // rst = 0
		begin
		rstcnt <= 0;
		if (BCD0 < 4'b1001)
			begin
			BCD0 <= BCD0 + 1;
			end
		else if (BCD1 < 4'b1001) // BCD0 = 9
			begin
			BCD1 <= BCD1 + 1;
			BCD0 <= 4'b0000;
			end
		end
	else if (dec == 1'b1 && inc == 1'b0) // rst = 0
		begin
		rstcnt <= 0;
		if (BCD0 > 4'b0000)
			begin
			BCD0 <= BCD0 - 1;
			end
		else if (BCD1 > 4'b0000) // BCD = 0
			begin
			BCD1 <= BCD1 - 1;
			BCD0 <= 4'b1001;
			end
		end
	else if (dec == 1'b1 && inc == 1'b1) // rst = 0
		begin
		rstcnt <= 0;
		end
	end
	endcase
	end
assign seg7disp0 = seg7Rom[BCD0];
assign seg7disp1 = seg7Rom[BCD1];

endmodule
