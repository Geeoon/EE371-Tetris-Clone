// random numbers generated using an LFSR
// always generating random numbers, but only output when next is called

module rng(clk, next, out);
    input logic clk, next;
    output logic [2:0] out;
    
    logic [9:0] registers = 0;
    logic [2:0] next_out;
    
    always_ff @(posedge clk) begin
        if (next) begin
            out <= next_out;
        end
        
        registers[0] <= ~(registers[9] ^ registers[6]);
		registers[1] <= registers[0];
		registers[2] <= registers[1];
		registers[3] <= registers[2];
		registers[4] <= registers[3];
		registers[5] <= registers[4];
		registers[6] <= registers[5];
		registers[7] <= registers[6];
		registers[8] <= registers[7];
		registers[9] <= registers[8];
    end  // always_ff
    
    always_comb begin
        next_out = { 1'b0, registers[1:0] };
        if (next_out == 0) begin
            next_out = 2'b10;
        end
    end  // always_comb
endmodule  // rng

module rng_tb();
    logic clk, next;
    logic [2:0] out;
    
    parameter CLOCK_PERIOD = 100;
    initial begin
        clk <= 0;
        forever begin 
            #(CLOCK_PERIOD/2) clk <= ~clk;
        end  // forever
    end  // initial
    
    rng dut (.*);
    
    initial begin
        @(posedge clk);
        repeat(100) begin
            next = 1;
            @(posedge clk);
            next = 0;
            repeat(2) @(posedge clk);
        end
        $stop;
    end  // initial
endmodule  // rng_tb
