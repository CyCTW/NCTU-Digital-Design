module t_HW3_SQSA_microprogram();
	reg Clk, X1, X2, X3;
	wire Z1, Z2, Z3;

	initial
		begin
			$dumpfile ("micro.vcd");
			$dumpvars;
			Clk=0;
			X1 = 1'b1; X2 = 1'b1; X3 = 1'b0;
			#11 X1 = 1'b0; X2 = 1'b1; X3 = 1'b1;
			#20 X1 = 1'b0; X2 = 1'b0; X3 = 1'b1;
			#20 X1 = 1'b1; X2 = 1'b0; X3 = 1'b1;
			#20 X1 = 1'b0; X2 = 1'b0; X3 = 1'b0;
			#20 X1 = 1'b0; X2 = 1'b0; X3 = 1'b0;
			#20 X1 = 1'b0; X2 = 1'b0; X3 = 1'b0;
			#20 X1 = 1'b1; X2 = 1'b0; X3 = 1'b0;
			#20 X1 = 1'b1; X2 = 1'b0; X3 = 1'b0;
			#100 $finish;
		end
	always #10 Clk <=~Clk;
	HW3_SQSA_microprogram h1(Clk, X1, X2, X3, Z1, Z2, Z3);


endmodule