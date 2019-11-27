
module HW2_divider(Clk, St, Divisor, Dividend, Quotient, Remainder, Overflow, Done );
	input Clk, St;
	input [15:0] Divisor;
	input [15:0] Dividend;
	output [15:0] Quotient;
	output [15:0] Remainder;
	output  Overflow;
	output reg Done;
	parameter Z = 0;
	reg [15:0] divisor;
	reg [15:0] dividend;
	reg [2:0] State;
	reg [3:0] count;
	reg [15:0] ACC;
	wire B;
	wire [15:0] Sum;
	wire K;
	wire o;
	assign K = (count==15)?1:0;
	assign Sum = ACC+~Divisor+1'b1;
	assign B = Sum[15];

	assign Overflow = (Divisor == Z) ? 1'b1 : 1'b0;
	assign Quotient = dividend;
	assign Remainder = ACC;
	initial begin
		State=0;
		Done=0;
		count = 0;
	end	
	always @(posedge Clk)
	begin
		case(State)
			0:
				begin
					if(St==1'b1)	
						begin
							dividend<=Dividend;
							divisor<=Divisor;
							ACC<=0;
							State<=1;
							Done<=0;
						end
				end
			1:
				begin
					if(Overflow)
						State<=0;
					else
					begin
						State<=2;
						ACC<={ACC[14:0], dividend[15]};
						dividend<={dividend[14:0], 1'b0};
						count<=count+1;
					end
				end
			2:
				begin
					if(B && ~K)
						begin
							ACC<={ACC[14:0], dividend[15]};
							dividend<={dividend[14:0], 1'b0};
							count<=count+1;
							State<=2;
						end
					else if(~B)
						begin			
							ACC<=Sum;
							dividend[0] = 1'b1;
							State<=2;
						end
					else if(K && B)
						begin
							ACC<={ACC[14:0], dividend[15]};
							dividend<={dividend[14:0], 1'b0};
							count<=count+1;
							State<=3;
						end
				end
			3:
				begin
					if(~B)
						begin			
							ACC<=Sum;
							dividend[0] = 1'b1;
							State<=3;
						end
					else
						begin
							Done<=1;
							State<=0;
						end
				end
		endcase
	end
endmodule
							
