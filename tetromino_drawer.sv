/**
 * @brief draws a tetromino onto the board given its position and block id
 */

module tetromino_drawer(clk, reset, start, in_x, in_y, t_id, x, y, out_id, wren, done);
    input logic clk, reset, start;
    input logic [4:0] in_x, in_y;
    input logic [2:0] t_id;
    
    output logic [4:0] x, y;
    output logic [2:0] out_id;
    output logic wren, done;
    
    assign out_id = t_id;
    
    // control path outputs
    logic load_regs, incr_x, incr_y;
    // data path outputs
    logic x_eq_posxpwidth, y_eq_posypwidth;
    
    tetromino_drawer_ctrl controller(.clk, .reset, .start, .x_eq_posxpwidth, .y_eq_posypwidth, .load_regs, .incr_x, .incr_y, .wren, .done);
    tetromino_drawer_data datapath(.clk, .load_regs, .incr_x, .incr_y, .in_x, .in_y, .t_id, .x, .y, .x_eq_posxpwidth, .y_eq_posypwidth);
endmodule  // tetromino_drawer

module tetromino_drawer_tb();
    // inputs
    logic clk, reset, start;
    logic [4:0] in_x, in_y;
    logic [2:0] t_id;
    
    // outputs
    logic [4:0] x, y;
    logic [2:0] out_id;
    logic wren, done;
    
    parameter CLOCK_PERIOD = 100;
    initial begin
        clk <= 0;
        forever begin 
            #(CLOCK_PERIOD/2) clk <= ~clk;
        end  // forever
    end  // initial
    
    tetromino_drawer dut (.*);
    
    initial begin
        // reset
        reset = 1;
        start = 0;
        in_x = 0;
        in_y = 0;
        t_id = 1;
        @(posedge clk);
        reset = 0;
        start = 1;
        @(posedge done);
        
        reset = 1;
        start = 0;
        t_id = 3;
        @(posedge clk);
        reset = 0;
        start = 1;
        @(posedge done);
        
        $stop;
    end  // initial
    
    
endmodule  // tetromino_drawer_tb
