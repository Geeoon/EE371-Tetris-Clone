module collision_ctr(Start, Reset, Ready, clk, y_eQ_zero, pos_x_eQ_limit, 
							in_id_eQ_zero, init_regs, incr_x, noplace, place);
		input logic Start, Reset, clk;
		input logic y_eQ_zero, pos_x_eQ_limit, in_id_eQ_zero;
		
		output logic Ready, init_regs, incr_x, noplace, place;
		
		enum logic [2:0] {S_idle, S_wait, S_check, S_place, S_noplace} ns, ps;
		
		always_ff @(posedge clk) begin
			if (Reset) begin
				ps <= S_idle;
			end else begin
				ps <= ns;
			end
		end //always_ff
		
		always_comb begin
			case (ps)
				S_idle: if (Start & (~y_eQ_zero)) ns = S_wait;
						  else if (Start & y_eQ_zero) ns = S_place;
						  else ns = S_idle;
				S_wait: ns		= S_check;
				S_noplace: ns	= S_noplace;
				S_place: ns		= S_place;
				S_check: if (~in_id_eQ_zero) ns = S_place;
							else if (in_id_eQ_zero & pos_x_eQ_limit) ns = S_noplace;
							else if (in_id_eQ_zero & (~pos_x_eQ_limit)) ns = S_wait;
							else ns = S_check;
			endcase
		end //always_comb
	//output assignments
	assign Ready			= (ps == S_idle);
	assign init_regs		= (ps == S_idle) & Start & (~y_eQ_zero);
	assign incr_x 			= (ps == S_check) & in_id_eQ_zero & (~pos_x_eQ_limit);
	assign noplace 		= (ps == S_noplace);
	assign place			= (ps == S_place);

endmodule