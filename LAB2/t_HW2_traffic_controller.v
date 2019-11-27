module t_HW2_traffic_controller();

	reg clk, Sa, Sb;
	wire Ra, Rb, Ga, Gb, Ya, Yb;

	HW2_traffic_controller h1(clk, Sa, Sb, Ra, Rb, Ga, Gb, Ya, Yb);
	
	initial begin
		clk = 1;
		#2 Sa = 1;Sb = 1;

	end


always  begin
	#10 clk  <= ~clk;
end


endmodule