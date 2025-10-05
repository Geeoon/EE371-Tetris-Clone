module tetromino_drawer_data(clk, load_regs, incr_x, incr_y, in_x, in_y, t_id, x, y, x_eq_posxpwidth, y_eq_posypwidth);
    input logic clk, load_regs, incr_x, incr_y;
    input logic [2:0] t_id;
    input logic [4:0] in_x, in_y;
    output logic x_eq_posxpwidth, y_eq_posypwidth;
    
    output logic [4:0] x, y;
    
    logic [4:0] pos_x, pos_y;
    logic [2:0] width;
    always_ff @(posedge clk) begin
        if (load_regs) begin
            pos_x <= in_x;
            pos_y <= in_y;
            width <= t_id - 3'b1;
            x <= in_x;
            y <= in_y;
        end
        
        if (incr_x) begin
            x <= x + 5'b1;
        end
        
        if (incr_y) begin
            x <= pos_x;
            y <= y + 5'b1;
        end
    end  // always_ff
    
    assign x_eq_posxpwidth = x == (pos_x + width);
    assign y_eq_posypwidth = y == (pos_y + width);
endmodule  // tetromino_drawer_data
