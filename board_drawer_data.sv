module board_drawer_data(clk, init, incr_y, incr_x, x_eq_9, count_end, x, y);
    input logic clk, init, incr_y, incr_x;
    output logic x_eq_9, count_end;
    output logic [4:0] x, y;
    
    always_ff @(posedge clk) begin
        if (init) begin
            x <= 0;
            y <= 0;
        end
        
        if (incr_y) begin
            x <= 0;
            y <= y + 5'b00001;
        end
        
        if (incr_x) begin
            x <= x + 5'b00001;
        end
    end  // always_ff
    
    assign x_eq_9 = x == 9;
    assign count_end = x_eq_9 & (y == 19);
endmodule  // board_drawer_data
