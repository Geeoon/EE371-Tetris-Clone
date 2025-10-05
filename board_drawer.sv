/**
 * @brief module to iterate through each block in the board
 * @param input     clk the clock driving the sequential logic
 * @param input     reset an active HIGH reset signal
 * @param input     ready the signal from the board to indicate to start
 * @param input     draw_done HIGH if the block drawer is done
 * @param output    done whether or not drawing is done
 * @param output    draw signal to the block drawer to draw a block
 * @param output    x the x-coordinate of the block
 * @param output    y the y-coordinate of the block
 */
module board_drawer(clk, reset, ready, draw_done, done, draw, x, y);
    input logic clk, reset, ready, draw_done;
    output logic done, draw;
    output logic [4:0] x, y;
    
    logic count_end, x_eq_9, init, incr_x, incr_y;
    
    board_drawer_ctrl controller(.clk, .reset, .ready, .count_end, .draw_done, .x_eq_9, .init, .incr_x, .incr_y, .draw, .done);
    board_drawer_data datapath(.clk, .init, .incr_y, .incr_x, .x_eq_9, .count_end, .x, .y);
endmodule  // board_drawer

module board_drawer_tb();
    logic clk, reset, ready, draw_done;
    logic done, draw;
    logic [4:0] x, y;
    
    board_drawer dut (.*);
    
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
        draw_done = 0;
        ready = 0;
        @(posedge clk);
        reset = 0;
        repeat(10) @(posedge clk);
        
        // start iteration
        ready = 1;
        repeat(10) @(posedge clk);
        while (~done) begin
            draw_done = 0;
            repeat(10) @(posedge clk);
            draw_done = 1;
            @(posedge draw or posedge done);
        end
        
        $stop;
    end  // initial
endmodule  // board_drawer_tb
