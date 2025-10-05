module block_drawer_data(clk,
                         init_top,
                         incr_x,
                         decr_x,
                         reset_x,
                         incr_y,
                         decr_y,
                         init_bot,
                         set_xd,
                         incr_delta,
                         init_left,
                         set_yd,
                         init_right,
                         init_main,
                         zero_x,
                         zero_y,
                         grid_init,
                         grid_b_init,
                         grid_l_init,
                         grid_r_init,
                         grid_main_init,
                         incr_y_gm,
                         x_eq_19md,
                         y_eq_1,
                         y_eq_18,
                         y_eq_19md,
                         x_eq_1,
                         x_eq_18,
                         x,
                         y,
                         color);
    input logic clk, init_top, incr_x, decr_x, reset_x, incr_y, decr_y, init_bot, set_xd, incr_delta, init_left, set_yd, init_right, init_main, zero_x, zero_y, grid_init, grid_b_init, grid_l_init, grid_r_init, grid_main_init, incr_y_gm;
    output logic x_eq_19md, y_eq_1, y_eq_18, y_eq_19md, x_eq_1, x_eq_18;
    
    output logic [9:0] x;
    output logic [8:0] y;
    
    output logic signed [8:0] color;
    
    logic [1:0] delta;
    
    always_ff @(posedge clk) begin
        if (init_top) begin
            x <= 0;
            y <= 0;
            delta <= 0;
            color <= 9'h60;
        end
        
        if (incr_x) begin
            x <= x + 10'd1;
        end
        
        if (incr_y) begin
            y <= y + 9'd1;
        end
        
        if (set_xd) begin
            x <= x + delta + 10'd1;
        end
        
        if (incr_delta) begin
            delta <= delta + 2'd1;
        end
        
        if (init_bot) begin
            x <= 0;
            y <= 19;
            delta <= 0;
            color <= -9'h60;
        end
        
        if (decr_y) begin
            y <= y - 9'd1;
        end
        
        if (init_left) begin
            x <= 0;
            y <= 0;
            delta <= 0;
            color <= -9'h30;
        end
        
        if (set_yd) begin
            y <= y + delta + 9'd1;
        end
        
        if (init_right) begin
            x <= 19;
            y <= 0;
            delta <= 0;
        end
        
        
        if (decr_x) begin
            x <= x - 10'd1;
        end
        
        if (init_main) begin
            x <= 2;
            y <= 2;
            delta <= 2;
            color <= 9'h00;
        end
        
        if (reset_x) begin
            x <= delta;
        end
        
        if (zero_x) begin
            x <= 0;
        end
        
        if (zero_y) begin
            y <= 0;
        end
        
        if (grid_init) begin
            delta <= 0;
            color <= 0;
            x <= 0;
            y <= 0;
        end
        
        if (grid_b_init) begin
            x <= 0;
            y <= 19;
        end
        
        if (grid_l_init) begin
            x <= 0;
            y <= 0;
        end
        
        if (grid_r_init) begin
            x <= 19;
            y <= 0;
        end
        
        if (grid_main_init) begin
            x <= 1;
            y <= 1;
            delta <= 1;
            color <= -9'hFF;
        end
        
        if (incr_y_gm) begin
            x <= 1;
            y <= y + 9'b1;
        end
    end  // always_ff
    
    always_comb begin
        x_eq_19md   = x == (19 - delta);
        y_eq_1      = y == 1;
        y_eq_18     = y == 18;
        y_eq_19md   = y == (19 - delta);
        x_eq_1      = x == 1;
        x_eq_18     = x == 18;
    end  // always_comb
    
endmodule  // block_drawer_data