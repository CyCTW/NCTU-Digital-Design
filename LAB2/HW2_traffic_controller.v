module HW2_traffic_controller(clk, Sa, Sb, Ra, Rb, Ga, Gb, Ya, Yb);
	input  clk, Sa, Sb;
	output reg Ra, Rb, Ga, Gb, Ya, Yb;
	
	reg [3:0] state, nextstate;
	initial begin
		state = 0;
	end 
	
	always@(state or Sa or Sb)
	begin
		Ra = 0;
		Rb = 0;
		Ga = 0;
		Gb = 0;
		Ya = 0;
		Yb = 0;
		nextstate = 0;
		case(state)
			0, 1, 2, 3, 4:
				begin
				Ga = 1;
				Rb = 1;
				nextstate =state+1;
				end
			5:
				begin		
				Ga = 1;Rb = 1;
				if(~Sb)
					nextstate = state;
				else
					nextstate = 6;
				end
			6:begin
				Ya = 1;
				Rb = 1;	
				nextstate = 7;
				end
			7, 8, 9, 10:begin
				Ra = 1;
				Gb = 1;
				nextstate = state+1;end
			11:begin
				Ra = 1;
				Gb = 1;
				if(Sa | ~Sb)
					nextstate = 12;
				else if(~Sa & Sb)
					nextstate = state;end
			12:begin
				Ra = 1;
				Yb = 1;
				nextstate = 0;end
			endcase
		end
	always@(posedge clk)
		begin
			state<=nextstate;
		end
endmodule


