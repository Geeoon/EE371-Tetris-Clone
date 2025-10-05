/**
 * @brief defines the tetris game loop
 * @param input     clk the clock driving the sequential logic
 * @param input     reset an active HIGH reset
 * @param input     left_input if the user is pressing the left button
 * @param input     right_input if the user is pressing the right button
 * @param output    pixel_x the x coordinate of the pixel to draw
 * @param output    pixel_y the y coordinate of the pixel to draw
 * @param output    wren an active HIGH write enable signal for the pixel
 * @param output    color the color to draw to the pixel located at \p pixel_x and \p pixel_y
 */
module game_loop(clk, reset, left_input, right_input, pixel_x, pixel_y, wren, color);
    input logic clk, reset, left_input, right_input;
    output logic [9:0] pixel_x;
    output logic [8:0] pixel_y;
    output logic [23:0] color;
    output logic wren;
    
    // data path outputs
    logic [4:0] stored_x, stored_y;
    logic [2:0] stored_id;
    
    // control path inputs
    logic placed,
          tetromino_ready,
          place_or_no_place,
          shift_controller_done,
          tetromino_drawer_done,
          board_drawer_done,
          clear_rows_done,
          tetromino_eraser_done;
    
    logic bm_wren_out;  // board mux BELOW
    logic [4:0] bm_read_x, bm_read_y, bm_write_x, bm_write_y;
    logic [2:0] bm_write_out;  // board mux ABOVE

    // control path outputs
    logic reset_all,
          reset_tetromino,
          start_tetromino,
          start_collision,
          start_shift_controller,
          store_tetromino,  // for datapath
          start_tetromino_drawer,
          start_board_drawer,
          start_clear_rows,
          start_tetromino_eraser,
          reset_loop;
          
    // globals
    logic [2:0] tetromino_id;
              
    // board output signals
    logic [2:0] board_out;
    logic board_ready;
    
    // tetromino output signals
//    logic ground;
    logic [4:0] pos_x, pos_y;
    
    // collision output signals
    logic [4:0] collision_pos_x, collision_pos_y;
    logic notplaced;
    
    // shift controller output signals
    logic [4:0] shift_controller_out_x, shift_controller_out_y;
    logic out_left, out_right;
    
    // tetromino drawer output signals
    logic [4:0] tetromino_drawer_out_x, tetromino_drawer_out_y;
    logic [2:0] tetromino_drawer_out_id;
    logic tetromino_drawer_wren;
    
    // board drawer system output signals
    logic [4:0] board_drawer_block_x, board_drawer_block_y;
    logic [9:0] board_drawer_pixel_x;
    logic [8:0] board_drawer_pixel_y;
    logic [23:0] board_drawer_color;
    assign pixel_x = board_drawer_pixel_x;
    assign pixel_y = board_drawer_pixel_y;
    assign color = board_drawer_color;
    assign wren = ~board_drawer_done;
    
    // clear rows output signals
    logic [4:0] clear_rows_out_x, clear_rows_out_y;
    logic [2:0] clear_rows_out_id;
    logic clear_rows_wren;
    
    // tetromino eraser output signals
    logic [4:0] tetromino_eraser_out_x, tetromino_eraser_out_y;
    logic [2:0] tetromino_eraser_out_id;
    logic tetromino_eraser_wren;
    
    rng random_number_generator (.clk,
                                 .next(reset_tetromino | reset_all),
                                 .out(tetromino_id));
    
    board bd (.clk,
              .reset(reset_all),
              .read_x(bm_read_x),
              .read_y(bm_read_y),
              .write_x(bm_write_x),
              .write_y(bm_write_y),
              .write_id(bm_write_out),
              .wren(bm_wren_out),
              .read_id(board_out),
              .ready(board_ready));
    
    tetromino game_piece (.clk,
                          .shift_left(left_input & out_left),
                          .shift_right(right_input & out_right),
                          .Start(start_tetromino),
                          .Reset(reset_all | reset_tetromino),
                          .placed(),
                          .ground(placed),
                          .pos_x,
                          .pos_y,
                          .Ready(tetromino_ready));
                          
    collision collision_module (.Start(board_ready & start_collision),
                                .Reset(reset_all | reset_loop),
                                .clk,
                                .y(pos_y),
                                .x(pos_x),
                                .id(tetromino_id),
                                .in_id(board_out),  // from the board I assume?
                                .pos_y(collision_pos_y),
                                .pos_x(collision_pos_x),
                                .limit(),  // not needed?
                                .Ready(),  // not needed?
                                .noplace(notplaced),
                                .place(placed));
                             
    shift_controller shift_controller_module (.clk,
                                              .reset(reset_all | reset_loop),
                                              .start(board_ready & start_shift_controller),
                                              .tetromino_pos_x(pos_x),
                                              .tetromino_pos_y(pos_y),
                                              .tetromino_block_id(tetromino_id),
                                              .board_block_id(board_out),
                                              .out_x(shift_controller_out_x),
                                              .out_y(shift_controller_out_y),
                                              .out_left,
                                              .out_right,
                                              .done(shift_controller_done));
    
    tetromino_drawer tetromino_drawer_module (.clk,
                                              .reset(reset_all | reset_loop),
                                              .start(board_ready & start_tetromino_drawer),
                                              .in_x(stored_x),
                                              .in_y(stored_y),
                                              .t_id(stored_id),
                                              .x(tetromino_drawer_out_x),
                                              .y(tetromino_drawer_out_y),
                                              .out_id(tetromino_drawer_out_id),
                                              .wren(tetromino_drawer_wren),
                                              .done(tetromino_drawer_done));

    board_drawer_system board_drawer_system_module (.clk,
                                                    .reset(reset_all | reset_loop),
                                                    .board_ready(board_ready & start_board_drawer),
                                                    .block_id(board_out),
                                                    .block_x(board_drawer_block_x),
                                                    .block_y(board_drawer_block_y),
                                                    .out_x(board_drawer_pixel_x),
                                                    .out_y(board_drawer_pixel_y),
                                                    .out_color(board_drawer_color),
                                                    .done(board_drawer_done));
                                                    
    // clear_rows clear_rows_module (.clk,
    //                               .reset(reset_all | reset_loop),
    //                               .start(board_ready & start_clear_rows),
    //                               .read_id(board_out),
    //                               .read_x(clear_rows_out_x),
    //                               .read_y(clear_rows_out_y),
    //                               .write_x(),  // not needed
    //                               .write_y(),  // not needed
    //                               .write_id(clear_rows_out_id),
    //                               .wren(clear_rows_wren),
    //                               .Done(clear_rows_done));

    game_check clear_rows_module (.clk,  // similar in function to the clear_rows module
                                  .reset(reset_all | reset_loop),
                                  .start(board_ready & start_clear_rows),
                                  .in_id(board_out),
                                  .out_x(clear_rows_out_x),
                                  .out_y(clear_rows_out_y),
                                  .out_id(clear_rows_out_id),
                                  .wren(clear_rows_wren),
                                  .done(clear_rows_done));
                                  
    tetromino_eraser tetromino_eraser_module (.clk,
                                              .reset(reset_all | reset_loop),
                                              .start(board_ready & start_tetromino_eraser),
                                              .in_x(stored_x),
                                              .in_y(stored_y),
                                              .t_id(stored_id),
                                              .x(tetromino_eraser_out_x),
                                              .y(tetromino_eraser_out_y),
                                              .out_id(tetromino_eraser_out_id),
                                              .wren(tetromino_eraser_wren),
                                              .done(tetromino_eraser_done));
    
    game_loop_ctrl controller (.clk,
                               .reset,
                               .ground(placed),
                               .placed,
                               .tetromino_ready,
                               .place_or_no_place(placed | notplaced),
                               .shift_controller_done,
                               .tetromino_drawer_done,
                               .board_drawer_done,
                               .clear_rows_done,
                               .tetromino_eraser_done,
                               .collision_pos_x,  // board mux BELOW
                               .collision_pos_y,
                               .shift_controller_out_x,
                               .shift_controller_out_y,
                               .tetromino_drawer_out_x,
                               .tetromino_drawer_out_y,
                               .tetromino_drawer_out_id,
                               .tetromino_drawer_wren,
                               .board_drawer_block_x,
                               .board_drawer_block_y,
                               .clear_rows_out_x,
                               .clear_rows_out_y,
                               .clear_rows_out_id,
                               .clear_rows_wren,
                               .tetromino_eraser_out_x,
                               .tetromino_eraser_out_y,
                               .tetromino_eraser_out_id,
                               .tetromino_eraser_wren,
                               .bm_wren_out,
                               .bm_write_out,
                               .bm_read_x,
                               .bm_read_y,
                               .bm_write_x,
                               .bm_write_y,  // board mux ABOVE
                               .reset_all,
                               .reset_tetromino,
                               .start_tetromino,
                               .start_collision,
                               .start_shift_controller,
                               .store_tetromino,  // for datapath
                               .start_tetromino_drawer,
                               .start_board_drawer,
                               .start_clear_rows,
                               .start_tetromino_eraser,
                               .reset_loop);
    
    game_loop_data datapath (.clk,
                             .store_tetromino,
                             .pos_x,
                             .pos_y,
                             .tetromino_id,
                             .stored_x,
                             .stored_y,
                             .stored_id);
    
endmodule  // game_loop

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module game_loop_tb();
    // inputs
    logic clk, reset, left_input, right_input;
    
    // outputs
    logic wren;
    logic [9:0] pixel_x;
    logic [8:0] pixel_y;
    logic [23:0] color;
    
    parameter CLOCK_PERIOD = 100;
    initial begin
        clk <= 0;
        forever begin 
            #(CLOCK_PERIOD/2) clk <= ~clk;
        end  // forever
    end  // initial
    
    logic left, right;
    
    input_airlock left_airlock(.clk,
                               .reset,
                               .in(left),
                               .out(left_input));
    input_airlock right_airlock(.clk,
                               .reset,
                               .in(right),
                               .out(right_input));
    
    game_loop dut (.*);
    
    initial begin
        reset = 1;
        left = 0;
        right = 0;
        @(posedge clk);
        reset = 0;
        // repeat(300000) @(posedge clk);
        // place one on the leftmost side
        // shift left
        repeat(5) begin
            left = 1;
            repeat(20) @(posedge clk);
            left = 0;
            repeat(300000) @(posedge clk);
        end

        repeat(3000000) @(posedge clk);
        $stop;
    end  // initial
endmodule  // game_loop_tb
