module game_loop_ctrl(clk,
                      reset,
                      ground,
                      placed,
                      tetromino_ready,
                      place_or_no_place,
                      shift_controller_done,
                      tetromino_drawer_done,
                      board_drawer_done,
                      clear_rows_done,
                      tetromino_eraser_done,
                      collision_pos_x,  // board mux BELOW  
                      collision_pos_y,
                      shift_controller_out_x,
                      shift_controller_out_y,
                      tetromino_drawer_out_x,
                      tetromino_drawer_out_y,
                      tetromino_drawer_out_id,
                      tetromino_drawer_wren,
                      board_drawer_block_x,
                      board_drawer_block_y,
                      clear_rows_out_x,
                      clear_rows_out_y,
                      clear_rows_out_id,
                      clear_rows_wren,
                      tetromino_eraser_out_x,
                      tetromino_eraser_out_y,
                      tetromino_eraser_out_id,
                      tetromino_eraser_wren,
                      bm_wren_out,
                      bm_write_out,
                      bm_read_x,
                      bm_read_y,
                      bm_write_x,
                      bm_write_y,  // board mux ABOVE
                      reset_all,
                      reset_tetromino,
                      start_tetromino,
                      start_collision,
                      start_shift_controller,
                      store_tetromino,  // for datapath
                      start_tetromino_drawer,
                      start_board_drawer,
                      start_clear_rows,
                      start_tetromino_eraser,
                      reset_loop);
    input logic clk,
                reset,
                ground,
                placed,
                tetromino_ready,
                place_or_no_place,
                shift_controller_done,
                tetromino_drawer_done,
                board_drawer_done,
                clear_rows_done,
                tetromino_eraser_done;
    
    // board mux BELOW
    input logic [4:0] collision_pos_x,
                      collision_pos_y,
                      shift_controller_out_x,
                      shift_controller_out_y,
                      tetromino_drawer_out_x,
                      tetromino_drawer_out_y,
                      board_drawer_block_x,
                      board_drawer_block_y,
                      clear_rows_out_x,
                      clear_rows_out_y,
                      tetromino_eraser_out_x,
                      tetromino_eraser_out_y;
                      
    input logic [2:0] tetromino_drawer_out_id,
                      clear_rows_out_id,
                      tetromino_eraser_out_id;
                      
    input logic tetromino_drawer_wren, clear_rows_wren, tetromino_eraser_wren;
                      
    output logic bm_wren_out;  
    output logic [2:0] bm_write_out;
    output logic [4:0] bm_read_x, bm_read_y, bm_write_x, bm_write_y;
    // board mux ABOVE
                 
    output logic reset_all,
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
                 
    enum logic [2:0] { s_init, s_tetromino, s_collision, s_shift_controller, s_draw_tetromino, s_draw_board, s_clear_rows, s_eraser } ps, ns;
    
    always_ff @(posedge clk) begin
        if (reset) ps <= s_init;
        else ps <= ns;
    end  // always_ff
    
    always_comb begin
        reset_all = 0;
//        reset_tetromino = 0;
        start_tetromino = 0;
        start_collision = 0;
        start_shift_controller = 0;
        store_tetromino = 0;  // for datapath
        start_tetromino_drawer = 0;
        start_board_drawer = 0;
        start_clear_rows = 0;
        start_tetromino_eraser = 0;
        reset_loop = 0;
    
        case (ps)
            s_init: begin
                reset_all = 1;
                ns = s_tetromino;
            end
            
            s_tetromino: begin
                start_tetromino = 1;
                ns = s_collision;
            end
            
            s_collision: begin
                start_collision = 1;
                ns = place_or_no_place ? s_shift_controller : s_collision;
            end
            
            s_shift_controller: begin
                start_shift_controller = 1;
                if (shift_controller_done) begin
                    store_tetromino = 1;
                    ns = s_draw_tetromino;
                end else begin
                    ns = s_shift_controller;
                end
            end
            
            s_draw_tetromino: begin
                start_tetromino_drawer = 1;
                ns = tetromino_drawer_done ? s_draw_board : s_draw_tetromino;
            end
            
            s_draw_board: begin
                start_board_drawer = 1;
                if (board_drawer_done) begin
                    ns = placed ? s_clear_rows : s_eraser;
                end else begin
                    ns = s_draw_board;
                end
            end
            
            s_clear_rows: begin
                start_clear_rows = 1;
                // if (1) begin
                if (clear_rows_done) begin
                    reset_loop = 1;
                    ns = s_tetromino;
                end else begin
                    ns = s_clear_rows;
                end
            end
            
            s_eraser: begin
                start_tetromino_eraser = 1;
                if (tetromino_eraser_done) begin
                    reset_loop = 1;
                    ns = s_tetromino;
                end else begin
                    ns = s_eraser;
                end
            end
        endcase
        
        reset_tetromino = reset_loop & ground;
    end  // always_comb

    // FOR THE BOARD MUX
    always_comb begin
        case (ps)
            s_collision: begin
                bm_wren_out = 0;
                bm_write_out = 3'bxxx;
                bm_read_x = collision_pos_x;
                bm_read_y = collision_pos_y;
                bm_write_x = 5'bxxxxx;
                bm_write_y = 5'bxxxxx;
            end
            
            s_shift_controller: begin
                bm_wren_out = 0;
                bm_write_out = 3'bxxx;
                bm_read_x = shift_controller_out_x;
                bm_read_y = shift_controller_out_y;
                bm_write_x = 5'bxxxxx;
                bm_write_y = 5'bxxxxx;
            end
            
            s_draw_tetromino: begin
                bm_wren_out = tetromino_drawer_wren;
                bm_write_out = tetromino_drawer_out_id;
                bm_read_x = tetromino_drawer_out_x;
                bm_read_y = tetromino_drawer_out_y;
                bm_write_x = tetromino_drawer_out_x;
                bm_write_y = tetromino_drawer_out_y;
            end
            
            s_draw_board: begin
                bm_wren_out = 0;
                bm_write_out = 3'bxxx;
                bm_read_x = board_drawer_block_x;
                bm_read_y = board_drawer_block_y;
                bm_write_x = 5'bxxxxx;
                bm_write_y = 5'bxxxxx;
            end
            
            s_clear_rows: begin
                bm_wren_out = clear_rows_wren;
                bm_write_out = clear_rows_out_id;
                bm_read_x = clear_rows_out_x;
                bm_read_y = clear_rows_out_y;
                bm_write_x = clear_rows_out_x;
                bm_write_y = clear_rows_out_y;
            end
            
            s_eraser: begin
                bm_wren_out = tetromino_eraser_wren;
                bm_write_out = tetromino_eraser_out_id;
                bm_read_x = tetromino_eraser_out_x;
                bm_read_y = tetromino_eraser_out_y;
                bm_write_x = tetromino_eraser_out_x;
                bm_write_y = tetromino_eraser_out_y;
            end
            
            default: begin
                bm_wren_out = 0;
                bm_write_out = 3'b0;
                bm_read_x = 5'bxxxxx;
                bm_read_y = 5'bxxxxx;
                bm_write_x = 5'bxxxxx;
                bm_write_y = 5'bxxxxx;
            end
        endcase
    end  // always_comb
    
endmodule  // game_loop_ctrl
