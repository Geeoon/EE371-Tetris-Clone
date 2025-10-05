/**
 * @brief ensures that a button press is only HIGH for one clock cycle and prevents metastability
 * @param input     clk the clock driving the sequential logic
 * @param input     reset an active HIGH reset signal
 * @param input     in the signal to sanitize
 * @param output    out the sanitized signal
 */
module input_airlock(clk, reset, in, out);
    input logic clk, reset, in;
    output logic out;
    
    logic on;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            on <= 0;
            out <= 0;
        end else begin
            on <= in;
            out <= in ? ~on : 1'b0;
        end
    end  // always_ff
endmodule  // input_airlock

module input_airlock_tb();
    logic clk, reset, in, out;
    
    initial begin
        reset = 1;
        in = 0;
        @(posedge clk);
        reset = 0;
        in = 1;
        repeat(20);
        $stop;
    end  // initial
endmodule  // input_airlock_tb
