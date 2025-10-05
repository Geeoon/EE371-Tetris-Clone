module game_check_data(clk, init, incr_x, reset_x, incr_y, y_eq_19, x_eq_9, x, y);
    input logic clk, init, incr_x, reset_x, incr_y;
    output logic y_eq_19, x_eq_9;

    output logic [4:0] x, y;

    always_ff @(posedge clk) begin
        if (init) begin
            x <= 0;
            y <= 0;
        end

        if (incr_x) begin
            x <= x + 1;
        end

        if (incr_y) begin
            x <= 0;
            y <= y + 1;
        end

        if (reset_x) begin
            x <= 0;
        end
    end  // always_ff

    assign y_eq_19 = y == 19;
    assign x_eq_9 = x == 9;
endmodule  // game_check_data
