/**
 * @brief given the current position and rotation of a tetromino, determines whether or not it can shift left or right
 * @param input     clk the clock driving the sequential logic
 * @param input     reset an active HIGH reset signal
 * @param input     tetromino_pos_x the position of the tetromino (bottom left)
 * @param input     tetromino_pos_y the position of the tetromino (bottom left)
 * @param input     tetromino_block_id the block_id of the tetromino
 * @param output    board_block_id the block_id of the position we're checking
 * @param output    out_x the x position to check (for the board)
 * @param output    out_y the y position to check (for the board)
 * @param output    out_left the output of whether we can or cannot move left
 * @param output    out_right the output of whether we can (HIGH) or cannot (LOW) move left
 * @param output    whether or not we're done the shift detection
 */
module shift_controller(clk,
                        reset,
                        start,
                        tetromino_pos_x,
                        tetromino_pos_y,
                        tetromino_block_id,
                        board_block_id,
                        out_x,
                        out_y,
                        out_left,
                        out_right,
                        done);
    input logic clk, reset, start;
    input logic [4:0] tetromino_pos_x, tetromino_pos_y;
    input logic [2:0] tetromino_block_id, board_block_id;
    
    output logic [4:0] out_x, out_y;
    output logic out_left, out_right, done;
    
    // controlpath outputs
    logic init, lskip, rskip, noskip, temp0, incr_temp, noleft, noright, l;
    // datapath outputs
    logic x_eq_0, x_eq_9, board_id_eq_0, temp_eq_lim;
    
    shift_controller_ctrl controller(.clk,
                                     .reset,
                                     .start,
                                     .x_eq_0,
                                     .x_eq_9,
                                     .board_id_eq_0,
                                     .temp_eq_lim,
                                     .out_right,
                                     .init,
                                     .lskip,
                                     .rskip,
                                     .noskip,
                                     .temp0,
                                     .incr_temp,
                                     .noleft,
                                     .noright,
                                     .l,
                                     .done);
                                     
    shift_controller_data datapath(.clk,
                                   .in_x(tetromino_pos_x),
                                   .in_y(tetromino_pos_y),
                                   .tetromino_id(tetromino_block_id),
                                   .board_id(board_block_id),
                                   .x_eq_0,
                                   .x_eq_9,
                                   .board_id_eq_0,
                                   .temp_eq_lim,
                                   .init,
                                   .lskip,
                                   .rskip,
                                   .noskip,
                                   .temp0,
                                   .incr_temp,
                                   .noleft,
                                   .noright,
                                   .l,
                                   .out_left,
                                   .out_right,
                                   .pos_x(out_x),
                                   .pos_y(out_y));
endmodule  // shift_controller

module shift_controller_tb();
    logic clk,
          reset,
          start,
          out_left,
          out_right,
          done;
          
    logic [4:0] tetromino_pos_x,
                tetromino_pos_y,
                out_x,
                out_y;
    
    logic [2:0] board_block_id, tetromino_block_id;
          
    shift_controller dut (.*);
    
    parameter CLOCK_PERIOD = 100;
    initial begin
        clk <= 0;
        forever begin 
            #(CLOCK_PERIOD/2) clk <= ~clk;
        end  // forever
    end  // initial
    
    initial begin
        reset = 1;
        start = 0;
        tetromino_pos_x = 0;
        tetromino_pos_y = 10;
        tetromino_block_id = 2;
        
        board_block_id = 1;  // used for collision detection
        @(posedge clk);
        
        // left
        reset = 0;
        @(posedge clk);
        start = 1;
        @(posedge done);
        @(posedge clk);
        
        // right
        reset = 1;
        tetromino_pos_y = 5;
        tetromino_pos_x = 9;
        @(posedge clk);
        reset = 0;
        @(posedge clk);
        start = 1;
        @(posedge done);
        @(posedge clk);
        
        // middle
        reset = 1;
        tetromino_pos_x = 5;
        tetromino_pos_y = 15;
        @(posedge clk);
        reset = 0;
        @(posedge clk);
        start = 1;
        @(posedge done);
        @(posedge clk);
        $stop;
    end  // initial
endmodule  // shift_controller_tb
