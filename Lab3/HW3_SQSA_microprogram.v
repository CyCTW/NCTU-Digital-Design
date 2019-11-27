module HW3_SQSA_microprogram(Clk, X1, X2, X3, Z1, Z2, Z3);
	output reg Z1, Z2, Z3;
	input Clk;
	input X1, X2, X3;

	reg[2:0] State;

	initial begin
		State = 0;

	end
	always @(posedge Clk)
	begin
		
		case(State)
			0:
				begin
					Z3 <= 1'b1;
					if(X1==1'b1)begin
						State <= 4;
					end
					else begin
						State <= State+1;
					end
				end
			1:
				begin
					if(X3==1'b1)begin
						State <= 6;
					end
					else begin
						State <= State+1;
					end
				end

			2:
				begin
					if(X2==1'b1)begin
						State <= 0;
					end
					else begin
						State <= State+1;
					end
				end

			3:
				begin
					State <= 0;
				end

			4:
				begin
					if(X2==1'b1)begin
						State <= 7;
					end
					else begin
						State <= State+1;
					end
				end

			5:
				begin
					State <= 3;
				end

			6:
				begin
					Z2 = 1'b1;
					State <= 3;
				end
			7:
				begin
					Z1 = 1'b1;
					State <= 2;
				end
			default:
				begin
					State <= 0;
				end
		endcase
	end


endmodule
