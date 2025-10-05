/**
 * @file block_drawer_system.sv
 * @author Geeoon Chung     (2264035)
 * @author Anna Petrbokova  (2263140)
 */

/**
 * @param input     clk the clock drivng the sequential logic
 * @param input     reset an active HIGH reset signal
 * @param input     board_ready whether or not the board is ready to be read
 * @param input     block_id the block_id from the board
 * @param output    block_x the x cooridnate of the block to draw
 * @param output    block_y the y coordinate of the block to draw
 * @param output    out_x the x coordinate of the pixel to draw
 * @param output    out_y the y coordinate of the pixel to draw
 * @param output    out_color the color to draw for the pixel
 * @param output    done HIGH when this frame is done
 */
module board_drawer_system(clk, reset, board_ready, block_id, block_x, block_y, out_x, out_y, out_color, done);
    input logic clk, reset, board_ready;
    input logic [2:0] block_id;
    output logic [4:0] block_x, block_y;
    output logic [9:0] out_x;
    output logic [8:0] out_y;
    output logic [23:0] out_color;
    output logic done;
    
    logic block_done, draw_block;

    logic [9:0] block_out_x;
    logic [8:0] block_out_y;
    
    assign out_x = 9'd50 + (block_x * 5'd20) + block_out_x;
    assign out_y = 8'd50 + (block_y * 5'd20) + block_out_y;
    
    board_drawer board_drawing_module(.clk, .reset, .ready(board_ready), .draw_done(block_done), .done, .draw(draw_block), .x(block_x), .y(block_y));
    block_drawer block_drawing_module(.clk, .reset(draw_block), .ready(board_ready), .block_id, .out_x(block_out_x), .out_y(block_out_y), .out_color, .done(block_done));
    
endmodule  // board_drawer_system

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module board_drawer_system_tb();
    logic clk, reset, board_ready;
    logic [2:0] block_id;
    logic [4:0] block_x, block_y;
    logic [9:0] out_x;
    logic [8:0] out_y;
    logic [23:0] out_color;
    logic done;
    
    board bd (.clk, .reset, .read_x(block_x), .read_y(block_y), .write_x(), .write_y(), .write_id(), .wren(1'b0), .read_id(block_id), .ready(board_ready));
    board_drawer_system dut (.*);
    
    parameter CLOCK_PERIOD = 100;
    initial begin
        clk <= 0;
        forever begin 
            #(CLOCK_PERIOD/2) clk <= ~clk;
        end  // forever
    end  // initial
    
    initial begin
        // reset
        reset = 1;
        @(posedge clk);
        
        // draw
        reset = 0;
        @(posedge done);
        
        $stop;
    end  // initial
endmodule  // board_drawer_system_tb
