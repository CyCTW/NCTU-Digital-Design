module HW2_light(Clk, Left, Right, Haz, La, Lb, Lc, Ra, Rb, Rc);
	input Clk;
	input Left;
	input Right;
	input Haz;
	output reg La, Lb, Lc, Ra, Rb, Rc;
	reg [2:0] State;
	reg [2:0] Nextstate;
	initial begin
		State=0;
		Nextstate = 0;
	end
	
	always @(Left, Right, Haz, State)
	begin
	
		case(State)
			0:begin
				La = 0;Lb = 0;Lc = 0;Ra = 0;Rb = 0;Rc = 0;
				if(Haz)
					Nextstate<=7;	
				else if(Left&(~Right))
					Nextstate<=1;
				else if((~Left) & Right)
					Nextstate<=4;
			   	
			end
			1:begin
				if(Haz)
					Nextstate<=7;				
				else if(Left) begin
					Nextstate<=2;
					La = 1;
				end
				else	
					State<=0;
				
			  end
			2:begin
				if(Haz)
					Nextstate<=7;						
				else if(Left) begin
					Nextstate<=3;
					Lb = 1; La = 1;
					end
				else
					State<=0;
			end
			3:begin
				if(Haz)
					Nextstate<=7;		
				else if(Left) begin
					Lc = 1;Lb = 1;La = 1;
					Nextstate<=0;
					end
				else
					State<=0;
			end
			4:begin
				if(Haz)
					Nextstate<=7;						
				else if(Right)begin
					Nextstate<=5;
					Ra = 1;
					end
				else
					State<=0;
				end
			5:begin
				if(Haz)
					Nextstate<=7;						
				else if(Right) begin
					Nextstate<=6;
					Rb = 1;Ra = 1;
					end		
				else
					State<=0;			
			end
			6:begin
				if(Haz)
					Nextstate<=7;		
				else if(Right) begin
					Rc = 1;Rb = 1;Ra = 1;
					Nextstate<=0;
					end
				else
					State<=0;
			end
			7:begin
				La = 1;Lb = 1;Lc = 1;Ra = 1;Rb = 1;Rc = 1;
				Nextstate<=0;
			end
	endcase
	end
	
	always @(posedge Clk)
	begin
		State<=Nextstate;
	end
endmodule
