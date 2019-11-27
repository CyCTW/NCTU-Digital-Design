module cashier(st, open, clk, open_cashier, generate_receipt, cdone);

	input st, clk;
	input open;

	output reg open_cashier, generate_receipt;
	output reg cdone;
	reg [4:0] state, nextstate;
	reg [31:0] ram;

	initial begin
		
		state=0;
		nextstate=0;
		open_cashier = 0;
		generate_receipt = 0;

	end
	always@(state, open, st)begin
		case(state)
			0:begin
				generate_receipt=1'b0;
				open_cashier = 0;
				if(st==1'b1)				
					nextstate=1;
			end
			1:begin
				if(open==1'b1) begin
					open_cashier = 1'b1;
					nextstate = 2;					
				end
			end
			2:begin
				if(open==1'b0) begin
					open_cashier = 1'b0;
					nextstate = 3;
				end
			end
			3:begin
				generate_receipt = 1'b1;
				cdone = 1'b1;
				nextstate = 0;
			end
		endcase
	end
	always@(posedge clk) begin
		state<=nextstate;
	end


endmodule