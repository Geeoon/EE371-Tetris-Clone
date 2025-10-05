module row_filled_ctr(Start, Reset, clk, x_end, x_present,
							Ready, initialize, incr_x, fail, full);
	input logic Start, Reset, clk;
	input logic x_end, x_present;
	
	output logic Ready, initialize, incr_x, fail, full;
	
	enum logic [2:0] {S_idle, S_wait, S_wait2, S_check, S_fail, S_full} ps, ns;
	
	always_ff @(posedge clk) begin
		if (Reset) begin
			ps <= S_idle;
		end else begin
			ps <= ns;
		end
	end //always_ff
	
	always_comb begin
		case (ps)
			S_idle: ns		= Start ? S_wait : S_idle;
			S_fail: ns 		= S_fail;
			S_full: ns		= S_full;
			S_wait: ns		= S_wait2;
			S_wait2: ns		= S_check;
			S_check: if ((x_end) & (x_present)) ns = S_full;
						else if ((~x_end) & (~x_present)) ns = S_fail;
						else if ((x_end) & (~x_present)) ns = S_fail;
						else ns = S_wait;
			default: ns = S_idle;
		endcase
	end // always_comb
	
	//output assignments
	assign Ready			= (ps == S_idle);
	assign initialize		= (ps == S_idle) & Start;
	assign incr_x			= (ps == S_check) & (~x_end) & x_present;
	assign fail				= (ps == S_fail);
	assign full				= (ps == S_full);
endmodule