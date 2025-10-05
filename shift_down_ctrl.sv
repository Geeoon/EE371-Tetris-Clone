module shift_down_ctrl(clk, reset, start, cur_y_eq_19, cur_x_eq_9, init, plus, wren, load_empty, load_block, reset_x, incr_cur_x, incr_cur_y, done);
    input logic clk, reset, start, cur_y_eq_19, cur_x_eq_9;
    output logic init, plus, wren, load_empty, load_block, reset_x, incr_cur_x, incr_cur_y, done;
    
    enum logic [2:0] { s_idle, s_read, s_load, s_wait1, s_write, s_wait2, s_done } ps, ns;
    
    always_ff @(posedge clk) begin
        if (reset) ps <= s_idle;
        else ps <= ns;
    end  // always_ff
    
    always_comb begin
        init = 0;
        plus = 0;
        load_empty = 0;
        load_block = 0;
        reset_x = 0;
        incr_cur_x = 0;
        wren = 0;
        incr_cur_y = 0;
        done = 0;
        
        case (ps)
            s_idle: begin
                if (start) begin
                    init = 1;
                    plus = 1;
                    ns = s_read;
                end else ns = s_idle;
            end
            
            s_read: begin
                plus = 1;
                if (start)
                    if (cur_y_eq_19) begin
                        load_empty = 1;
                        ns = s_wait1;
                    end else ns = s_load;
                else ns = s_read;
            end
            
            s_load: begin
                plus = 1;
                load_block = 1;
                if (cur_x_eq_9) begin
                    reset_x = 1;
                    ns = s_wait1;
                end else begin
                    incr_cur_x = 1;
                    ns = s_read;
                end
            end
            
            s_wait1: begin
                if (start) ns = s_write;
                else ns = s_wait1;
            end
            
            s_write: begin
                wren = 1;
                if (cur_x_eq_9) begin
                    if (cur_y_eq_19) begin
                        ns = s_done;
                    end else begin
                        incr_cur_y = 1;
                        ns = s_wait2;
                    end
                end else begin
                    incr_cur_x = 1;
                    ns = s_wait1;
                end
            end
            
            s_wait2: begin
                plus = 1;
                reset_x = 1;
                ns = s_read;
            end
            
            s_done: begin
                done = 1;
                ns = s_done;
            end
        endcase
    end
endmodule  // shift_down_ctrl