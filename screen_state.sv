/**
 * @file screen_state.sv
 * @author Geeoon Chung     (2264035)
 * @author Anna Petrbokova  (2263140)
 */

/**
 * @brief module that stores the screen's pixels
 * @note this module has a registered input AND output, so outputs update on the second clock cycle after changes
 * @note colors are formatted as 8 bits of each, from low to high: red green blue
 * @param input     clk the clock driving the sequential logic
 * @param input     read_x the x-coordinate to read
 * @param input     read_y the y-coordinate to read
 * @param input     write_x the x-coordinate to write to
 * @param input     write_y the y-coordinate to write to
 * @param input     wren an active HIGH write enable
 * @param input     write_color the color to write to at \p write_x and \p write_y
 * @param output    read_color the color at \p read_x and \p read_y
 */
module screen_state(clk, reset, read_x, read_y, write_x, write_y, wren, read_color, write_color);
    input logic clk, reset, wren;
    input logic [9:0] read_x, write_x;
    input logic [8:0] read_y, write_y;
    input logic [23:0] write_color;
    output logic [23:0] read_color;
    
    logic [1:0] collision;
    
    logic [18:0] rdaddress, wraddress;
    logic [5:0] ram_out, ram_in;
    logic [23:0] decoded_color;
    
    // this memory has a registered input and output
    screen_state_2PRAM RAM (.clock(clk), .data(ram_in), .rdaddress, .wraddress, .wren, .q(ram_out));
    color_24_6_encoder color_encoder(.in_color(write_color), .out_color(ram_in));
    color_24_6_decoder color_decoder(.in_color(ram_out), .out_color(decoded_color));
    
    // register the collision detection to make sure it is pipelined alongside with the RAM
    always_ff @(posedge clk) begin
        if (reset) collision <= 0;
        else begin
            collision[1] <= wren & (read_x == write_y) & (read_y == write_y);
            collision[1] <= collision[0];
        end
    end  // always_ff
    
    always_comb begin
        rdaddress = { read_x, read_y };  // concatonate x and y to get address
        wraddress = { write_x, write_y };
        if (collision[0]) read_color = write_color;  // might need to take into account the change in color depth of stored memory vs collision return
        else read_color = decoded_color;
    end  // always_comb
endmodule  // screen_state

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module screen_state_tb();
    logic clk, reset, wren;
    logic [9:0] read_x, write_x;
    logic [8:0] read_y, write_y;
    logic [23:0] write_color;
    logic [23:0] read_color;
    
    screen_state dut (.*);
    
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
        wren = 0;
        read_x = 0;
        write_x = 0;
        read_y = 0;
        write_y = 0;
        write_color = 0;
        @(posedge clk);
        reset = 0;
        @(posedge clk);
        
        // read all pixels
        for (int x = 0; x < 640; x++) begin
            for (int y = 0; y < 480; y++) begin
                read_x = x;
                read_y = y;
                repeat(2) @(posedge clk);
                #1; assert(read_color == 0);
            end
        end
        
        // write white to all pixels
        write_color = '1;
        wren = 1;
        for (int x = 0; x < 640; x++) begin
            for (int y = 0; y < 480; y++) begin
                write_x = x;
                write_y = y;
                repeat(2) @(posedge clk);
            end
        end
        wren = 0;
        @(posedge clk);
        
        // read all pixels
        for (int x = 0; x < 640; x++) begin
            for (int y = 0; y < 480; y++) begin
                read_x = x;
                read_y = y;
                repeat(2) @(posedge clk);
                #1; assert(read_color == '1);
            end
        end
        $stop;
    end  // initial
endmodule  // screen_state_tb
