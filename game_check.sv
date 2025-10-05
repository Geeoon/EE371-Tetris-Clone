module game_check(clk, reset, start, in_id, out_x, out_y, out_id, wren, done);
    input logic clk, reset, start;
    input logic [2:0] in_id;

    output logic [4:0] out_x, out_y;
    output logic [2:0] out_id;
    output logic wren, done;

    logic shift_done, y_eq_19, x_eq_9, init, incr_x, reset_x, incr_y, clear, reset_shifter;
    logic [4:0] x, y, write_x, write_y;

    shift_down shifter(.clk,
                       .reset(reset | reset_shifter),
                       .start(start & clear),
                       .y,
                       .read_id(in_id),
                       .read_x(),  // same as writes
                       .read_y(),
                       .write_x,
                       .write_y,
                       .write_id(out_id),
                       .wren,
                       .done(shift_done));

    game_check_ctrl controller(.clk,
                               .reset,
                               .start,
                               .present(~(in_id == 0)),
                               .shift_done,
                               .y_eq_19,
                               .x_eq_9,
                               .init,
                               .incr_x,
                               .reset_x,
                               .incr_y,
                               .clear,
                               .reset_shifter,
                               .done);

    game_check_data datapath(.clk,
                             .init,
                             .incr_x,
                             .reset_x,
                             .incr_y,
                             .y_eq_19,
                             .x_eq_9,
                             .x,
                             .y);

    // might be some errors in the transition with write value being undefined
    assign out_x = clear ? write_x : x;
    assign out_y = clear ? write_y : y;

endmodule  // game_check
