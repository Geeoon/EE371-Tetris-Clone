/**
 * @brief this module checks a board and clears any rows that it can
 * @param input     clk the clock driving the sequential logic
 * @param input     reset an active HIGH reset
 * @param input     start should be connected to the board's ready signal
 * @param input     read_x the x coordinate to read from the board
 * @param input     read_y the y coordinate to read from the board
 * @param input     write_x the x coordinate to write to the board
 * @param input     write_y the y coordinate to write to the board
 * @param inpu
 */
module clear_rows(clk, reset, start, read_id, read_x, read_y, write_x, write_y, write_id, wren, Done);
    input logic clk, reset, start;
    input logic [2:0] read_id;
    output logic [4:0] read_x, read_y, write_x, write_y;
    output logic [2:0] write_id;
    
    output logic wren, Done;
    
    logic fail, full, start_check;
    
    logic [4:0] checker_x, clearer_x, row, clearer_y;
    
    row_filled row_checker(.clk,
                           .Start(start),
                           .Reset(~start_check),
                           .y(row),
                           .x_present(~(read_id == 0)),
                           .x(checker_x),
                           .Ready(),
                           .fail,
                           .full);
                           
    clear_row row_clearer(.clk,
                          .read_id,
                          .fail_or_full(fail | full),
                          .full,
                          .Start(start),
                          .Reset(reset),
                          .row,
                          .Ready(),
                          .clearrow(),
                          .noclear(),
                          .read_x(clearer_x),
                          .read_y(clearer_y),
                          .write_x(),
                          .write_y(),
                          .write_id,
                          .wren,
                          .start_check,
                          .Done);
    assign write_x = (start_check | fail | full) ? checker_x : clearer_x;
    assign write_y = (start_check | fail | full) ? row : clearer_y;
    assign read_x = write_x;
    assign read_y = write_y;
    
endmodule  // clear_rows

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module clear_rows_tb();
    logic clk, reset, start;
    logic [2:0] read_id;
    logic [4:0] read_x, read_y, write_x, write_y, w_x, w_y, temp_x, temp_y, read_x_c, read_y_c;
    logic [2:0] write_id, w_id, temp_id;
    logic wren, Done, reading, start_clear, writing;
    
    board bd (.clk, .reset, .read_x, .read_y, .write_x(w_x), .write_y(w_y), .write_id(w_id), .wren(wren | writing), .read_id, .ready(start));

    clear_rows dut (.clk, .reset(reset | ~start_clear), .start, .read_id, .read_x(read_x_c), .read_y(read_y_c), .write_x, .write_y, .write_id, .wren, .Done);
    
    assign read_x = reading ? temp_x : read_x_c;
    assign read_y = reading ? temp_y : read_y_c;
    assign w_id = writing ? temp_id : write_id;
    assign w_x = writing ? temp_x : write_x;
    assign w_y = writing ? temp_y : write_y;
    
    //create simulated clock
    initial begin
        clk <= 0;
        forever #(20/2) clk <= ~clk; //20 was T
    end // clock initial
    
    initial begin
        // reset
        reset = 1;
        reading = 0;
        writing = 0;
        start_clear = 0;
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
        // 1s to every row
        for (int y = 0; y < 20; y += 1) begin
            for (int x = 9; x < 10; x++) begin
                writing = 1;
                temp_x = x;
                temp_y = y;
                temp_id = 3'b111;
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
        reading = 0;
        
        start_clear = 1;
        @(posedge Done);
        
        reading = 1;
        // read contents
        for (int y = 0; y < 20; y++) begin
            temp_y = y;
            repeat(3) @(posedge clk);
        end
        reading = 0;
        
//        reset = 1;
//        start = 0;
//        read_id = 0;
//        repeat(5) @(posedge clk);
//        reset = 0;
//        repeat(5) @(posedge clk);
//        start = 1;
//        read_id = 0;
//        repeat(50) @(posedge clk);
//        read_id = 1;
////        repeat(1000) @(posedge clk);
//        @(posedge Done);
        $stop;
    end  // initial
endmodule  // clear_rows_tb
