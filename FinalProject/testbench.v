
module testbench();

	reg open_;

	reg clk, st_fileio, st_cashier;
	wire [31:0] sum;
	wire cdone, fdone;
	wire generate_receipt;
	wire open_cashier;

	
	initial begin
		clk=1'b0;st_cashier=1'b0;st_fileio=1'b0;open_=1'b0;
		
		#500 open_ =1'b1;st_cashier=1'b0;
		#100 open_ = 1'b0;
		#500 $finish;
		
		
	end
	always @(fdone) begin
		st_cashier = 1'b1;
	end
	
	fileio v1(fdone, sum);
	cashier c1(st_cashier, open_, clk, open_cashier, generate_receipt, cdone);
	always #20 clk <= ~clk;

endmodule