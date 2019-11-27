module HW2_multiplier(Clk, St, Mplier, Mcand, Product, Done);
	input Clk, St;
	input [7:0] Mplier;
	input [7:0] Mcand;
	output [15:0] Product;
	output reg Done;
	
	reg [4:0] K;
	reg [2:0] State;
	reg [8:0] A;
	reg [8:0] B;
 	reg [7:0] C;
	reg [8:0] addout;
	initial begin
		State = 0;
		K=0;
		
	end
	
	always@(posedge Clk)
	begin
		case(State)
			0: begin
				if(St==1'b1)
				begin
					A<=9'b000000000;
					B<={Mplier, 1'b0};
					C<=Mcand;
					State<=1;
					K<=0;
					Done<=0;
				end
			  end
			1:begin
				if(K<7 && ~(B[1]^B[0]) )
					begin
					K<=K+1;
					A<={A[8], A[8:1]};
					B<={A[0], B[8:1]};
					State<=1;
					end
				else if(B[1] && (~B[0]))
					begin
					
					addout = A + {~C[7],~C} +1'b1;
					A<={addout[8:0]};
					
					State<=2;
					end
				else if((~B[1]) && B[0])
					begin
					addout = A +{C[7], C} ;
					A<={addout[8:0]};
					
					State<=2;
					end
				else if(K==7 && ~(B[1]^B[0]))
					begin
					A<={A[8], A[8:1]};
					B<={A[0], B[8:1]};
					State<=0;
					Done<=1;
					end
				end
			2:begin
				if(K==7)
				begin
					A<={A[8], A[8:1]};
					B<={A[0], B[8:1]};
					State<=0;
					Done<=1;
				end
				else
					A<={A[8], A[8:1]};
					B<={A[0], B[8:1]};
					State<=1;
					K<=K+1;
			end

			default:
			begin
				State<=0;
			end
		endcase
	end

	assign Product = {A[7:0], B[8:1]};
endmodule
				
								
						
				


