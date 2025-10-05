module clear_row_ctr(Start, Reset, clk, shift_done, fail_or_full, full,
                     Ready, init_regs, clearrow, noclear,
                     incr_row, final_row, start_check, Done);
    input logic Start, Reset, clk, shift_done;
    input logic fail_or_full, full, final_row;
    
    output logic Ready, init_regs, clearrow, incr_row, noclear, start_check, Done;
    
    enum logic [2:0] {S_idle, S_wait, S_check, S_noclear, S_shift_wait, S_done} ns, ps;
    
    always_ff @(posedge clk) begin
        if (Reset) begin
            ps <= S_idle;
        end else begin
            ps <= ns;
        end
    end //always_ff
    
    always_comb begin
        case (ps)
            S_idle: ns      = Start ? S_wait : S_idle;
            S_wait: ns      = fail_or_full ? S_check : S_wait;
            S_check: ns     = full ? S_shift_wait : S_noclear;
            S_shift_wait:   if (shift_done) begin
                                if (final_row) begin
                                    ns = S_done;
                                end else ns = S_wait;
                            end else ns = S_shift_wait;
            S_noclear: ns = final_row ? S_done : S_wait;
            S_done:    ns = S_done;
        endcase
    end //always_comb
    
    //output assignments
    assign Ready            = (ps == S_idle);
    assign init_regs        = (ps == S_idle) & Start;
    assign clearrow         = (ps == S_check) & full;
    assign incr_row         = (ps == S_noclear) | ((ps == S_shift_wait) & shift_done & ~final_row);
    assign noclear          = (ps == S_noclear);
    assign Done             = (ps == S_done);
    assign start_check      = (ps == S_wait) | (ps == S_check);
endmodule  // clear_row_ctr
