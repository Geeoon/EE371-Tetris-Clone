// board_id is from the board
module shift_controller_ctrl(clk,
                             reset,
                             start,
                             x_eq_0,
                             x_eq_9,
                             board_id_eq_0,
                             temp_eq_lim,
                             out_right,
                             init,
                             lskip,
                             rskip,
                             noskip,
                             temp0,
                             incr_temp,
                             noleft,
                             noright,
                             l,
                             done);
    input logic clk, reset, start, x_eq_0, x_eq_9, board_id_eq_0, temp_eq_lim, out_right;
    output logic init, lskip, rskip, noskip, temp0, incr_temp, noleft, noright, l, done;
    
    enum logic [2:0] { s_idle, s_wait_l, s_check_l, s_wait_r, s_check_r, s_done } ps, ns;
    
    always_ff @(posedge clk) begin
        if (reset) ps <= s_idle;
        else ps <= ns;
    end  // always_ff
    
    always_comb begin
        init = 0;
        lskip = 0;
        rskip = 0;
        noskip = 0;
        temp0 = 0;
        incr_temp = 0;
        noleft = 0;
        noright = 0;
        done = 0;
        l = 0;
        
        case (ps)
            s_idle: begin
                if (start) begin
                    init = 1;
                    if (x_eq_0) begin
                        lskip = 1;
                        ns = s_wait_r;
                    end else begin
                        if (x_eq_9) begin
                            rskip = 1;
                        end else begin
                            noskip = 1;
                        end
                        l = 1;
                        ns = s_wait_l;
                    end
                end else ns = s_idle;
            end
            
            s_wait_l: begin
                l = 1;
                ns = s_check_l;
            end
            
            s_check_l: begin
                l = 1;
                if (board_id_eq_0) begin
                    if (temp_eq_lim) begin
                        if (out_right) begin
                            temp0 = 1;
                            ns = s_wait_r;
                        end else begin
                            ns = s_done;
                        end
                    end else begin
                        incr_temp = 1;
                        ns = s_wait_l;
                    end
                end else begin
                    noleft = 1;
                    if (out_right) begin
                        temp0 = 1;
                        ns = s_wait_r;
                    end else begin
                        ns = s_done;
                    end
                end
            end
            
            s_wait_r: ns = s_check_r;
            
            s_check_r: begin
                if (board_id_eq_0) begin
                    if (temp_eq_lim) begin
                        ns = s_done;
                    end else begin
                        incr_temp = 1;
                        ns = s_check_r;
                    end
                end else begin
                    noright = 1;
                    ns = s_done;
                end
            end
            
            s_done: begin
                done = 1;
                ns = s_done;
            end
        endcase
    end  // always_comb

endmodule  // shift_controller_ctrl
