module board_ctrl(clk, reset, wren, ready, load_regs, load_val);
    input logic clk, reset, wren;
    output logic ready, load_regs, load_val;
    
    enum logic [1:0] { s_idle, s_load, s_write, s_wait } ps, ns;
    
    always_ff @(posedge clk) begin
        if (reset) ps <= s_idle;
        else ps <= ns;
    end  // always_ff
    
    always_comb begin
        ready = 0;
        load_regs = 0;
        load_val = 0;
        case (ps)
            s_idle: begin
                ready = 1;
                if (wren) begin
                    load_regs = 1;
                    ns = s_load;
                end else begin
                    ns = s_idle;
                end
            end
            
            s_load: ns = s_write;
            
            s_write: begin
                load_val = 1;
                ns = s_wait;
            end
            
            s_wait: ns = s_idle;
        endcase
    end  // always_comb
    
endmodule  // board_ctrl
