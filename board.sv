/**
 * @file board.sv
 * @author Geeoon Chung     (2264035)
 * @author Anna Petrbokova  (2263140)
 */
 
/**
 * @brief a 10 x 20 tetris board
 * @note the memory is registered, so, when reading, the block id will update on the next clock cycle
 * @note id 0 means there is currently no block in that position
 * @param input     clk the clock driving the sequential logic
 * @param input     reset an active HIGH reset
 * @param input     read_x the x address to read the block id from
 * @param input     read_y the y address to read the block id from
 * @param input     write_x the x address to write a block id to
 * @param input     write_y the y address to write a block id to
 * @param input     write_id the id to write when \p wren is HIGH
 * @param input     wren an active HIGH write to the block located at \p write_x and \p write_y
 * @param output    read_id the id of the block being read at \p read_x and \p read_y
 * @param output    ready whether or not the board is ready to be read/written, when LOW, values in the read and write ports are undefined 
 */
module board(clk, reset, read_x, read_y, write_x, write_y, write_id, wren, read_id, ready);
    input logic clk, reset, wren;
    input logic [4:0] read_x, read_y, write_x, write_y;
    input logic [2:0] write_id;
    output logic [2:0] read_id;
    output logic ready;
    
    logic load_regs, load_val;
    
    board_data datapath(.clk, .ready, .write_x, .write_y, .read_x, .read_y, .write_id, .load_regs, .load_val, .read_id);
    board_ctrl controlpath(.clk, .reset, .wren, .ready, .load_regs, .load_val);
    
endmodule  // board

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module board_tb();
    logic clk, reset, wren;
    logic [4:0] read_x, read_y, write_x, write_y;
    logic [2:0] write_id;
    logic [2:0] read_id;
    logic ready;
    
    board dut (.*);
    
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
        read_y = 0;
        write_x = 0;
        write_y = 0;
        write_id = 0;
        @(posedge clk);
        reset = 0;
        
        // read contents
        for (int y = 0; y < 20; y++) begin
            read_y = y;
            for (int x = 0; x < 10; x++) begin
                read_x = x;
                repeat(3) @(posedge clk);
            end
        end
        
        // a different values to each block
        for (int y = 0; y < 20; y ++) begin
            for (int x = 0; x < 10; x++) begin
                wren = 1;
                write_x = x;
                write_y = y;
                write_id = x % 3'b111;
                @(posedge clk);
                wren = 0;
                @(posedge ready);
            end
        end
        
        // read contents
        for (int y = 0; y < 20; y++) begin
            read_y = y;
            for (int x = 0; x < 10; x++) begin
                read_x = x;
                repeat(3) @(posedge clk);
            end
        end

        // read every block
//         for (int x = 0; x < 10; x++) begin
//             for (int y = 0; y < 30; y++) begin
//                 read_x = x;
//                 read_y = y;
//                 @(posedge clk);
//                 @(posedge clk);
//             end
//         end
// //        
//         // write every block
//         @(posedge ready);
//         wren = 1;
//         for (int x = 0; x < 10; x++) begin
//             for (int y = 0; y < 30; y++) begin
//                 write_x = x;
//                 write_y = y;
//                 write_id = 7;
//                 @(posedge ready);
//             end
//         end
//         wren = 0;
        
//         // read every block
//         for (int x = 0; x < 10; x++) begin
//             for (int y = 0; y < 30; y++) begin
//                 read_x = x;
//                 read_y = y;
//                 repeat(2) @(posedge clk);
//             end
//         end
        
        $stop;
    end  // initial
endmodule  // board_tb
