// the ready in this is for when the board is ready
// draw_done is for when the outside block drawing algorithm itself is done
module board_drawer_ctrl(clk, reset, ready, count_end, draw_done, x_eq_9, init, incr_x, incr_y, draw, done);
    input logic clk, reset, ready, count_end, x_eq_9, draw_done;
    output logic init, incr_x, incr_y, draw, done;
    
    enum logic [2:0] { s_load, s_loop, s_draw, s_wait, s_done} ps, ns;
    
    always_ff @(posedge clk) begin
        if (reset) ps <= s_load;
        else ps <= ns;
    end  // always_ff
    
    always_comb begin
        init = 0;
        incr_x = 0;
        incr_y = 0;
        draw = 0;
        done = 0;
        case (ps)
            s_load: begin
                if (ready) begin
                    init = 1;
                    ns = s_loop;
                end else ns = s_load;
            end
            
            s_loop: begin
                ns = s_draw;
            end
            
            s_draw: begin
                draw = 1;
                ns = s_wait;
            end
            
            s_wait: begin
                if (draw_done) begin
                    if (count_end) ns = s_done;
                    else begin
                        if (x_eq_9) incr_y = 1;
                        else incr_x = 1;
                        ns = s_loop;
                    end
                end else ns = s_wait;
            end
            
            s_done: begin
                done = 1;
                ns = s_done;
            end
        endcase
    end  // always_comb
endmodule  // board_drawer_ctrl
