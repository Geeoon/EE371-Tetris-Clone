module tetromino_ctr (Start, clk, Reset, pos_y_eQ_ground, count_eQ_max, Ready,
							placed, incr_pos_y, incr_count, initialize, reset_count);
	input logic Start, Reset, clk;
	input logic pos_y_eQ_ground, count_eQ_max;
	
	output logic incr_count, incr_pos_y, reset_count, placed, initialize, Ready;
	
	enum logic [1:0] {S_idle, S_fall, S_done} ps, ns;
	
	always_ff @(posedge clk) begin
		if (Reset) begin
			ps <= S_idle;
		end else begin
			ps <= ns;
		end
	end //always_ff
	
	always_comb begin
		case (ps)
			S_idle: ns = Start ? S_fall : S_idle;
			S_fall: ns = pos_y_eQ_ground ? S_done : S_fall;
			S_done: ns = S_done;
		endcase
	end //always_comb
	
	//output assignments
	assign Ready			= (ps == S_idle);
	assign placed			= (ps == S_fall) & pos_y_eQ_ground;
	assign initialize		= (ps == S_idle) & Start;
	assign incr_pos_y		= (ps == S_fall) & count_eQ_max & Start;
	assign incr_count		= (ps == S_fall) & ~count_eQ_max;
	assign reset_count	    = incr_pos_y;
	
endmodule //tetromino_ctr