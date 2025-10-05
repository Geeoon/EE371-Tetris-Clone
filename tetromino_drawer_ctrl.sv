module tetromino_drawer_ctrl(clk, reset, start, x_eq_posxpwidth, y_eq_posypwidth, load_regs, incr_x, incr_y, wren, done);
    input logic clk, reset, start, x_eq_posxpwidth, y_eq_posypwidth;
    output logic load_regs, incr_x, incr_y, wren, done;
    
    enum logic [1:0] { s_idle, s_loop, s_write, s_done } ps, ns;
    
    always_ff @(posedge clk) begin
        if (reset) ps <= s_idle;
        else ps <= ns;
    end  // always_ff
    
    always_comb begin
        load_regs = 0;
        wren = 0;
        incr_x = 0;
        incr_y = 0;
        done = 0;
        
        case (ps)
            s_idle: begin
                if (start) begin
                    load_regs = 1;
                    ns = s_loop;
                end else ns = s_idle;
            end
            
            s_loop: begin
                if (start) ns = s_write;
                else ns = s_loop;
            end
            
            s_write: begin
                wren = 1;
                if (x_eq_posxpwidth) begin
                    if (y_eq_posypwidth) ns = s_done;
                    else begin
                        incr_y = 1;
                        ns = s_loop;
                    end
                end else begin
                    incr_x = 1;
                    ns = s_loop;
                end
            end
            
            s_done: begin
                done = 1;
                ns = s_done;
            end
        endcase
    end  // always_comb
endmodule  // tetromino_drawer_ctrl
