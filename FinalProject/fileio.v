
module fileio(fdone, tsum);
		
	output reg fdone;
	output reg [31:0] tsum;
	reg [31:0] sum;

	integer file, ret;
	parameter Password = 63;
	reg [15:0] char;
	reg [8*2:0] multichar;
	reg [4*3:0] m1, m2;

	reg init = 0;
	reg [6:0] password_tmp;
	reg [8*20:0] commodity;
	reg [8*10:0] payway;

	reg enable = 1'b1;
	reg custo = 1'b1;
	reg [31:0] ram;
	integer customer;

	initial begin: fileio
		sum=0;
		file = $fopen("data.txt", "r");
		
		// $monitor("%d%d\n", m1, m2);
		ret = $fscanf(file, "%b", password_tmp);
		if(password_tmp != Password)begin
			$display("Wrong Password. Please try again.");

			$finish;
		end
		else begin
			$display("Welcome back! You can start to operate the machine!\nHave a nice day!\n");
			$display("This is what you input and the totoal sum:");
		end	

		
		while(!$feof(file)) begin:fscan
			if (custo==1'b1) begin
				ret = $fscanf(file, "%d\n", customer);
				$display("\n\nCustomer number: %0d\n", customer);
				enable=1'b1;
				custo=1'b0;
				init=0;
			end

			if(enable) begin
				enable=1'b1;
				ret = $fscanf(file, "%d %s %d %s\n", m1, multichar, m2, commodity);
				$display("price: %0d amount: %0d name: %0s\n", m1, m2, commodity);
				
				if(init==1'b0) begin
					sum=sum+(m1*m2);
				end

				else begin
					if(char=="+")begin
						sum= sum +(m1*m2);					
					end
				end
				$display("Current sum= %0d$\n", sum);
				ret = $fscanf(file, "%s\n", char);
				

				if(char=="f") begin
					enable = 1'b0;
					$display("Total Sum: %0d$\n", sum);
					tsum=sum;
					sum=0;
				end
				else if(char=="c") begin
					$display("Clear all previous input! Sum return 0.\n");
					sum=0;
					init=1'b0;
					disable fscan;
				end
				else if(char=="--") begin
					sum=sum+(m1*m2);
					$display("Delete previous one. Current Sum: %0d$\n", sum);

					ret = $fscanf(file, "%s\n", char);		

				end
				else if(char!="+") begin
					$display("Input error. Please type '+'.\n");
					ret = $fscanf(file, "%s\n", char);		
					
				end

				init=1'b1;

			end
			else begin
				ret=$fscanf(file, "%s\n", payway);
				$display("Pay by %0s!", payway);
				
				ram = $random(customer);

				#100 $display("Your receipt number: %d", ram);
				
				custo=1'b1;
				
			end
		end
	$display("\nThere are no data in input! Finish!\nThank you for your use.\n");
	$fclose(file);
	tsum=0;
	fdone=1'b1;

	end
endmodule
