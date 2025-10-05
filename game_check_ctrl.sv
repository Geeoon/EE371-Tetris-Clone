module game_check_ctrl(clk, reset, start, present, shift_done, y_eq_19, x_eq_9, init, incr_x, reset_x, incr_y, clear, reset_shifter, done);
    input logic clk, reset, start, present, shift_done, y_eq_19, x_eq_9;
    output logic init, incr_x, reset_x, incr_y, clear, reset_shifter, done;

    enum logic [2:0] { s_init, s_wait, s_check, s_clear, s_done } ps, ns;

    always_ff @(posedge clk) begin
        if (reset) ps <= s_init;
        else ps <= ns;
    end  // always_ff

    always_comb begin
        init = 0;
        incr_x = 0;
        incr_y = 0;
        clear = 0;
        done = 0;
        reset_shifter = 0;
        reset_x = 0;
        case (ps)
            s_init: begin
                if (start) begin
                    init = 1;
                    ns = s_wait;
                end else ns = s_init;
            end

            s_wait: begin
                if (start) begin
                    ns = s_check;
                end else begin
                    ns = s_wait;
                end
            end
            
            s_check: begin
                if (present) begin
                    if (x_eq_9) begin
                        clear = 1;
                        ns = s_clear;
                    end else begin
                        incr_x = 1;
                        ns = s_wait;
                    end
                end else begin
                    if (y_eq_19) begin
                        ns = s_done;
                    end else begin
                        incr_y = 1;
                        reset_shifter = 1;
                        ns = s_wait;
                    end
                end
            end
            
            s_clear: begin
                clear = 1;
                if (shift_done) begin
                    if (y_eq_19) begin
                        ns = s_done;
                    end else begin
                        reset_shifter = 1;
                        reset_x = 1;
                        ns = s_wait;
                    end
                end else begin
                    ns = s_clear;
                end
            end

            s_done: begin
                done = 1;
                ns = s_done;
            end
        endcase
    end  // always_comb
endmodule  // game_check_ctrl
