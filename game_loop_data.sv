module game_loop_data(clk, store_tetromino, pos_x, pos_y, tetromino_id, stored_x, stored_y, stored_id);
    input logic clk, store_tetromino;
    input logic [4:0] pos_x, pos_y;
    input logic [2:0] tetromino_id;
    
    output logic [4:0] stored_x, stored_y;
    output logic [2:0] stored_id;
    
    always_ff @(posedge clk) begin
        if (store_tetromino) begin
            stored_x <= pos_x;
            stored_y <= pos_y;
            stored_id <= tetromino_id;
        end
    end

endmodule  // game_loop_data
