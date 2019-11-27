module HW3_FPMUL_SP(Clk, St, FPmplier, FPmcand, Done, Ovf, Unf, FPproduct);
	input Clk, St;
	input [31:0] FPmcand;
	input [31:0] FPmplier;
	output reg Done, Ovf, Unf;
	output reg [31:0] FPproduct;

	reg Smcand, Smplier;
	reg [9:0] Emcand ;
	reg [9:0] Emplier;
	reg [9:0] Etotal;
	reg [23:0] Fmcand, Fmplier;
	reg [47:0] Fproduct;
	reg Load;
	reg [2:0] State, Nextstate;
	parameter Exponent = 9'b110000001;
	parameter E = 7'b1111111;
	wire [9:0] Ecomp;
	assign Ecomp = (~Etotal)+1'b1;

	initial begin
		State = 0;
		Nextstate = 0;
		Emcand = 0;
		Emplier = 0;
		Ovf = 0;
		Unf = 0;
		FPproduct = 0;
		Fproduct = 0;
	end

	always @(posedge Clk) begin
		case(State)
			0:begin
				if(St==1'b1)begin
					Done<=0;
					FPproduct <= 0;
					Emcand <= {2'b00, FPmcand[30:23]}+Exponent;
					Emplier <= {2'b00, FPmplier[30:23]}+Exponent;
					Fmcand <= {1'b1, FPmcand[22:0]};
					Fmplier<= {1'b1, FPmplier[22:0]};
					Fproduct<=0;Etotal<=0;
					Load <= 1'b1;
					Ovf <=0;Unf <=0;
					State <= 1;
				end
			end
			1:begin
				Fproduct = Fmcand*Fmplier;
				Etotal = Emcand + Emplier;
				State <= 2;
			end
			2:begin
				//detect float overflow
				if(Fproduct[47]==1'b1) begin
					Fproduct>>=1;
					Etotal+=1;
				end

				State <= 3;				
				
			end
			3:begin
				//detect exponent overflow
				if(Etotal[9]==1'b0)begin
					if(Etotal>E)begin
						Ovf = 1'b1;
					end

				end
				//detect exponent underflow
				else if(Etotal[9]==1'b1)begin
					if(Ecomp>126)begin
						Unf = 1'b1;
					end	
				end
				Done<=1'b1;

				State<=4;


			end
			4:begin
				FPproduct[31] <= FPmplier[31]^FPmcand[31];
				FPproduct[30:23] <= Etotal+127;
				
				FPproduct[22:0] <= Fproduct[45:23];
				
				State<=0;
			end
			default:
				State <= 0;


		endcase
	end

endmodule
