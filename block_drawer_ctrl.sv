module block_drawer_ctrl(clk,
                         reset,
                         ready,
                         x_eq_19md,
                         y_eq_1,
                         y_eq_18,
                         y_eq_19md,
                         x_eq_1,
                         x_eq_18,
                         nodraw,
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
                         done);
    input logic clk, reset, ready, x_eq_19md, y_eq_1, y_eq_18, y_eq_19md, x_eq_1, x_eq_18, nodraw;
    output logic init_top, incr_x, decr_x, reset_x, incr_y, decr_y, init_bot, set_xd, incr_delta, init_left, set_yd, init_right, init_main, zero_x, zero_y, grid_init, grid_b_init, grid_l_init, grid_r_init, grid_main_init, incr_y_gm, done;
    
    enum logic [3:0] { s_idle, s_top, s_bottom, s_left, s_right, s_main, s_done, s_grid_t, s_grid_b, s_grid_l, s_grid_r, s_grid_main } ps, ns;

    always_ff @(posedge clk) begin
        if (reset) ps <= s_idle;
        else ps <= ns;
    end  // always_ff
    
    always_comb begin
        init_top = 0;
        incr_x = 0;
        incr_y = 0;
        decr_y = 0;
        init_bot = 0;
        set_xd = 0;
        incr_delta = 0;
        init_left = 0;
        set_yd = 0;
        init_right = 0;
        decr_x = 0;
        reset_x = 0;
        init_main = 0;
        done = 0;
        zero_x = 0;
        zero_y = 0;
        
        grid_init = 0;
        grid_b_init = 0;
        grid_l_init = 0;
        grid_r_init = 0;
        grid_main_init = 0;
        incr_y_gm = 0;
        
        case (ps)
            s_idle: begin
                if (ready) begin
                    init_top = 1;
                    if (nodraw) begin
                        grid_init = 1;
                        ns = s_grid_t;
                    end else ns = s_top;
                end else ns = s_idle;
            end
            
            s_top: begin
                ns = s_top;
                if (x_eq_19md) begin
                    if (y_eq_1) begin
                        init_bot = 1;
                        ns = s_bottom;
                    end else begin
                        incr_y = 1;
                        zero_x = 1;
                        set_xd = 1;
                        incr_delta = 1;
                    end
                end else begin
                    incr_x = 1;
                end
            end
            
            s_bottom: begin
                ns = s_bottom;
                if (x_eq_19md) begin
                    if (y_eq_18) begin
                        init_left = 1;
                        ns = s_left;
                    end else begin
                        decr_y = 1;
                        zero_x = 1;
                        set_xd = 1;
                        incr_delta = 1;
                    end
                end else begin
                    incr_x = 1;
                end
            end
            
            s_left: begin
                ns = s_left;
                if (y_eq_19md) begin
                    if (x_eq_1) begin
                        init_right = 1;
                        ns = s_right;
                    end else begin
                        incr_x = 1;
                        zero_y = 1;
                        set_yd = 1;
                        incr_delta = 1;
                    end
                end else begin
                    incr_y = 1;
                end
            end
            
            s_right: begin
                ns = s_right;
                if (y_eq_19md) begin
                    if (x_eq_18) begin
                        init_main = 1;
                        ns = s_main;
                    end else begin
                        decr_x = 1;
                        zero_y = 1;
                        set_yd = 1;
                        incr_delta = 1;
                    end
                end else begin
                    incr_y = 1;
                end
            end
            
            s_main: begin
                ns = s_main;
                if (x_eq_19md) begin
                    if (y_eq_19md) begin
                        ns = s_done;
                    end else begin
                        incr_y = 1;
                        reset_x = 1;
                    end
                end else begin
                    incr_x = 1;
                end
            end
            
            s_done: begin
                done = 1;
                ns = s_done;
            end
            
            s_grid_t: begin
                if (x_eq_19md) begin
                    grid_b_init = 1;
                    ns = s_grid_b;
                end else begin
                    incr_x = 1;
                    ns = s_grid_t;
                end
            end
            
            s_grid_b: begin
                if (x_eq_19md) begin
                    grid_l_init = 1;
                    ns = s_grid_l;
                end else begin
                    incr_x = 1;
                    ns = s_grid_b;
                end
            end
            
            s_grid_l: begin
                if (y_eq_19md) begin
                    grid_r_init = 1;
                    ns = s_grid_r;
                end else begin
                    incr_y = 1;
                    ns = s_grid_l;
                end
            end
            
            s_grid_r: begin
                if (y_eq_19md) begin
                    grid_main_init = 1;
                    ns = s_grid_main;
                end else begin
                    incr_y = 1;
                    ns = s_grid_r;
                end
            end
            
            s_grid_main: begin
                if (x_eq_19md) begin
                    if (y_eq_19md) begin
                        ns = s_done;
                    end else begin
                        ns = s_grid_main;
                        incr_y_gm = 1;  // new
                    end
                end else begin
                    incr_x = 1;
                    ns = s_grid_main;
                end
            end
        endcase
    end  // always_comb
endmodule  // block_drawer_ctrl
