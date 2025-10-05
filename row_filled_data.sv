module row_filled_data(x, y, initialize, clk, incr_x, x_end);
	input logic [4:0] y;
	input logic clk, initialize, incr_x;
	output logic x_end;
	output logic [4:0] x;
	
	always_ff @(posedge clk) begin
		if (initialize) begin
			x <= 4'b0;
		end 
		if (incr_x) begin
			x <= x + 5'b1;
		end
	end //always_ff
	
	assign x_end		= (x == 9);
endmodule //row_filled_data