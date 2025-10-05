module collision_tb();
	logic Start, Reset, clk;
	logic [4:0] y, x; //pos
	logic [2:0] id, in_id;
	
	logic [4:0] pos_y, pos_x, limit;
	logic Ready, noplace, place;
	
	collision dut(.*);
	
	//create simulated clock
		initial begin
			clk <= 0;
			forever #(20/2) clk <= ~clk; //20 was T
		end // clock initial
		
		//test input define
	initial begin
	//no block and not on ground
		Reset = 1;
		y = 19;
		x = 9;
		id = 1;
		in_id = 0;
		Start = 0;
		@(posedge clk);
		
		Reset = 0;
		@(posedge clk);
		Start = 1;
		@(posedge clk);
		@(posedge place or posedge noplace);
		@(posedge clk);
		
		Reset = 1;
		@(posedge clk);
		Reset = 0;
		repeat(3) @(posedge clk);
		@(posedge place or posedge noplace);
		@(posedge clk);
		
		//place since at ground
		Reset = 1;
		y = 0;
		x = 9;
		id = 1;
		in_id = 1;
		Start = 0;
		@(posedge clk);
		Reset = 0;
		@(posedge clk);
		Start = 1;
		@(posedge clk);
		@(posedge place or posedge noplace);
		@(posedge clk);
		
		//place
		Reset = 1;
		y = 1;
		x = 9;
		id = 1;
		in_id = 1;
		Start = 0;
		@(posedge clk);
		Reset = 0;
		@(posedge clk);
		Start = 1;
		@(posedge clk);
		@(posedge place or posedge noplace);
		@(posedge clk);
		
		//no place
		Reset = 1;
		y = 2;
		x = 9;
		id = 1;
		in_id = 0;
		Start = 0;
		@(posedge clk);
		Reset = 0;
		@(posedge clk);
		Start = 1;
		@(posedge clk);
		@(posedge place or posedge noplace);
		@(posedge clk);
		$stop;
	end
endmodule