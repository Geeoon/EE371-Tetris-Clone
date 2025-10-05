module shift_controller_data(clk,
                             in_x,
                             in_y,
                             tetromino_id,
                             board_id,
                             x_eq_0,
                             x_eq_9,
                             board_id_eq_0,
                             temp_eq_lim,
                             init,
                             lskip,
                             rskip,
                             noskip,
                             temp0,
                             incr_temp,
                             noleft,
                             noright,
                             l,
                             out_left,
                             out_right,
                             pos_x,
                             pos_y);
    input logic [2:0] tetromino_id, board_id;
    input logic [4:0] in_x, in_y;
    input logic clk, init, lskip, rskip, noskip, temp0, incr_temp, noleft, noright, l;
    output logic x_eq_0, x_eq_9, board_id_eq_0, temp_eq_lim, out_left, out_right;
    output logic [4:0] pos_x, pos_y;
    
    logic [4:0] temp_x, temp_y;
    logic [2:0] lim, temp;
    
    always_ff @(posedge clk) begin
        if (init) begin
            temp_x <= in_x;
            temp_y <= in_y;
            temp <= 0;
            lim <= tetromino_id - 3'b1;
        end
        
        if (lskip) begin
            out_left <= 0;
            out_right <= 1;
        end
        
        if (rskip) begin
            out_left <= 1;
            out_right <= 0;
        end
        
        if (noskip) begin
            out_left <= 1;
            out_right <= 1;
        end
        
        if (temp0) begin
            temp <= 0;
        end
        
        if (incr_temp) begin
            temp <= temp + 3'b1;
        end
        
        if (noleft) begin
            out_left <= 0;
        end
        
        if (noright) begin
            out_right <= 0;
        end
    end  // always_ff
    
    assign pos_x = l ? temp_x - 3'b1 : temp_x + lim + 3'b1;
    assign pos_y = temp_y + temp;
    assign x_eq_0 = in_x == 5'd0;
    assign x_eq_9 = in_x == (5'd9 - lim);
    assign board_id_eq_0 = board_id == 0;
    assign temp_eq_lim = temp == lim;
endmodule  // shift_controller_data
