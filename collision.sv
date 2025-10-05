module collision(Start, Reset, clk, y, x, id, in_id, pos_y, pos_x, limit, Ready, noplace, place);
	input logic Start, Reset, clk;
	input logic [4:0] y, x; //pos
	input logic [2:0] id, in_id;
	
	output logic [4:0] pos_y, pos_x, limit;
	output logic Ready, noplace, place;
		
	logic y_eQ_zero, in_id_eQ_zero, pos_x_eQ_limit, init_regs, incr_x;
	
	collision_data datapath(.x, .y, .clk, .init_regs, .incr_x, .id, .in_id, .y_eQ_zero,
							.in_id_eQ_zero, .pos_x_eQ_limit, .pos_y, .pos_x, .limit);
	collision_ctr controlpath(.Start, .Reset, .Ready, .clk, .y_eQ_zero, .pos_x_eQ_limit, 
									.in_id_eQ_zero, .init_regs, .incr_x, .noplace, .place);

endmodule