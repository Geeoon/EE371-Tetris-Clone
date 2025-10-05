/**
 * EE 371 Lab 6
 * @file DE1_SoC.sv
 * @author Geeoon Chung     (2264035)
 * @author Anna Petrbokova  (2263140)
 * @brief this file contains the module DE1_SoC which is the top level module
 *				for the Tetris game.
 */

/**
 * @brief this is the top-level module for this project.
 *		It implements the various memory modules for lab 2 on the DE1 SoC.
 * @param input     CLOCK_50 the 50MHz clock connected to be used to drive
 *                      the sequential logic
 * @param input     the on-board KEYs
 * @param output    HEX0 HEX display, on the far right
 * @param output    HEX1 HEX display, 2nd from the right
 * @param output    HEX2 HEX display, 3rd from the right
 * @param output    HEX3 HEX display, 4th from the right
 * @param output    HEX4 HEX display, 5th from the right
 * @param output    HEX5 HEX display, 6th from the right
 * @param output    VGA_R used for the VGA display
 * @param output    VGA_G used for the VGA display
 * @param output    VGA_B used for the VGA display
 * @param output    VGA_BLANK_N used for the VGA display
 * @param output    VGA_CLK used for the VGA display
 * @param output    VGA_HS used for the VGA display
 * @param output    VGA_SYNC_N used for the VGA display
 * @param output    VGA_VS used for the VGA display
 */
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY,
                VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	input logic CLOCK_50;
    input logic [3:0] KEY;
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
    
	// Default values, turns off the HEX displays
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
    
    logic [9:0] x;
	logic [8:0] y;
	logic [7:0] r, g, b;
    logic reset;
    logic [23:0] read_color;
    
    assign reset = ~KEY[0];
    assign r = read_color[23:16];
    assign g = read_color[15:8];
    assign b = read_color[7:0];
    
    logic left_input, right_input;
    input_airlock left_airlock(.clk(CLOCK_50),
                               .reset,
                               .in(~KEY[3]),
                               .out(left_input));
    input_airlock right_airlock(.clk(CLOCK_50),
                               .reset,
                               .in(~KEY[2]),
                               .out(right_input));
    
    
    // game
//    logic [4:0] block_x, block_y;
//    logic [2:0] block_id;
//    logic board_ready;
    
//    board brd (.clk(CLOCK_50),
//               .reset,
//               .read_x(block_x),
//               .read_y(block_y),
//               .write_x(),
//               .write_y(),
//               .write_id(),
//               .wren(1'b0),
//               .read_id(block_id),
//               .ready(board_ready));
    // video related
    
    logic wren;
    logic [9:0] out_x;
    logic [8:0] out_y;
    logic [23:0] out_color;
    
    game_loop game (.clk(CLOCK_50),
                    .reset,
                    .left_input,
                    .right_input,
                    .pixel_x(out_x),
                    .pixel_y(out_y),
                    .wren,
                    .color(out_color));
    
    
    
//    board_drawer_system drawer(.clk(CLOCK_50),
//                               .reset,
//                               .board_ready,
//                               .block_id,
//                               .block_x,
//                               .block_y,
//                               .out_x,
//                               .out_y,
//                               .out_color,
//                               .done(drawer_done));
    
    video_driver #(.WIDTH(640), .HEIGHT(480))
    v1 (.CLOCK_50, .reset, .x, .y, .r, .g, .b,
        .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
        .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
        
    screen_state screen(.clk(CLOCK_50), .reset, .read_x(x), .read_y(y), .write_x(out_x), .write_y(out_y), .wren, .read_color, .write_color(out_color));
endmodule  // DE1_SoC
