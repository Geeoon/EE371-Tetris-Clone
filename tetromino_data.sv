module tetromino_data (clk, initialize, incr_pos_y, incr_count, shift_left,
								pos_x, pos_y, shift_right, reset_count, ground, pos_y_eQ_ground, count_eQ_max);
	input logic initialize, incr_pos_y, incr_count, reset_count, shift_left, shift_right, clk, ground;
	output logic [4:0] pos_x, pos_y;
	output logic pos_y_eQ_ground, count_eQ_max;
	//internal datapath signal
	logic [31:0] count;
	
	always_ff @(posedge clk) begin
		if (initialize) begin
			count <= 0;
			pos_x <= 4;
			pos_y <= 19;  // 19
		end else begin
			if (incr_count) begin
				count <= count + 5'b1;
			end
			
			if (incr_pos_y) begin
				pos_y <= pos_y - 5'b1;
			end 
			
			if (reset_count) begin
				count <= 0;
			end
			if (shift_left) pos_x <= pos_x - 5'b1;
			if (shift_right) pos_x <= pos_x + 5'b1;
		end
	end //always_ff
	
	
	
	assign pos_y_eQ_ground	= (ground);
	// assign count_eQ_max		= (count == 25000000);  // for uploading
   assign count_eQ_max		= (count == 5);  // for testbench

endmodule //tetromino_data