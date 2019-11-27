module t_HW2_light();
	reg Clk;
	reg Right;
	reg Left;
	reg Haz;
	wire La, Lb, Lc, Ra, Rb, Rc;
	
	initial begin
	Clk = 1;
	Haz = 0;
        Left = 1;
  	Right = 0;
	#200 Left = 0; Right = 1;
	#100 Haz = 1;
	#98 Haz = 0;
	 
	end	
	
always begin
	#10 Clk = ~Clk;
	end

HW2_light h2 (Clk, Left, Right, Haz, La, Lb, Lc, Ra, Rb, Rc);
endmodule

