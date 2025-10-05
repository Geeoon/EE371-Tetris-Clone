/**
 * @brief deletes a row and shifts all rows above it down one, leaving the top row clear
 * @param input     reset an active HIGH reset signal
 * @param input     start an acitve HIGH signal that should be connected to the board
 * @param input     y the row to delete
 * @param input     read_id the block_id that is being read from the board
 * @param output    read_x the x coordinate to read from the board
 * @param output    read_y the y coordinate to read from the board
 * @param output    write_x the x coordinate to write to the board
 * @param output    write_y the y coordinate to write to the board
 * @param output    write_id the block id to write to \p write_x and \p write_y
 * @param output    wren the write enable signal, should be connected to the board
 * @param output    done a done signal when the shifting is finished
 */
module shift_down(clk, reset, start, y, read_id, read_x, read_y, write_x, write_y, write_id, wren, done);
    input logic clk, reset, start;
    input logic [4:0] y;
    input logic [2:0] read_id;
    
    output logic [4:0] read_x, read_y, write_x, write_y;
    output logic [2:0] write_id;
    output logic wren, done;
    
    // control path outputs
    logic init, plus, load_empty, load_block, reset_x, incr_cur_x, incr_cur_y;
    
    // data path outputs
    logic cur_y_eq_19, cur_x_eq_9;
    
    shift_down_ctrl controller(.clk,
                               .reset,
                               .start,
                               .cur_y_eq_19,
                               .cur_x_eq_9,
                               .init,
                               .plus,
                               .wren,
                               .load_empty,
                               .load_block,
                               .reset_x,
                               .incr_cur_x,
                               .incr_cur_y,
                               .done);
                               
    shift_down_data datapath(.clk,
                             .in_y(y),
                             .init,
                             .plus,
                             .load_empty,
                             .load_block,
                             .reset_x,
                             .incr_cur_x,
                             .incr_cur_y,
                             .read_id,
                             .out_x(write_x),
                             .out_y(write_y),
                             .write_id,
                             .cur_y_eq_19,
                             .cur_x_eq_9);
    
    assign read_x = write_x;
    assign read_y = write_y;
    
endmodule  // shift_done

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module shift_down_tb();
    logic clk, reset, start, reading, writing;
    logic [4:0] y;
    logic [2:0] read_id;
    
    logic [4:0] read_x, read_y, read_x_s, read_y_s, write_x, write_y, temp_x, temp_y, w_x, w_y;
    logic [2:0] write_id, w_id, temp_id;
    logic wren, done;
    
    board bd (.clk, .reset, .read_x, .read_y, .write_x(w_x), .write_y(w_y), .write_id(w_id), .wren(wren | writing), .read_id, .ready(start));
    
    logic start_shift;
    shift_down dut (.clk, .reset, .start(start & start_shift), .y, .read_id, .read_x(read_x_s), .read_y(read_y_s), .write_x, .write_y, .write_id, .wren, .done);
    
    assign read_x = read_x_s;
    assign read_y = reading ? temp_y : read_y_s;
    assign w_id = writing ? temp_id : write_id;
    assign w_x = writing ? temp_x : write_x;
    assign w_y = writing ? temp_y : write_y;
    
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
        reading = 0;
        writing = 0;
        start_shift = 0;
        y = 0;
        @(posedge clk);
        reset = 0;
        @(posedge start);
        
        reading = 1;
        // read contents
        for (int y = 0; y < 20; y++) begin
            temp_y = y;
            repeat(3) @(posedge clk);
        end
        
        reading = 0;
        // 1s to every other row
        for (int y = 0; y < 20; y += 2) begin
            for (int x = 0; x < 10; x++) begin
                writing = 1;
                temp_x = x;
                temp_y = y;
                temp_id = (x + 1) % 3'b111;
                @(posedge clk);
                writing = 0;
                @(posedge start);
            end
        end
        
        reading = 1;
        // read contents
        for (int y = 0; y < 20; y++) begin
            temp_y = y;
            repeat(3) @(posedge clk);
        end
        
        // shift
        reading = 0;
        start_shift = 1;
        @(posedge done);
        
        reading = 1;
        start_shift = 0;
        // read contents
        for (int y = 0; y < 20; y++) begin
            temp_y = y;
            repeat(3) @(posedge clk);
        end
        reading = 0;
        
        $stop;
    end  // initial
endmodule  // shift_down_tb
