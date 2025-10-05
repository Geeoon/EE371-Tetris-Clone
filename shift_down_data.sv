module shift_down_data(clk, in_y, init, plus, load_empty, load_block, reset_x, incr_cur_x, incr_cur_y, read_id, out_x, out_y, write_id, cur_y_eq_19, cur_x_eq_9);
    input logic clk, init, plus, load_empty, load_block, reset_x, incr_cur_x, incr_cur_y;
    input logic [2:0] read_id;
    input logic [4:0] in_y;
    output logic [4:0] out_x, out_y;
    output logic [2:0] write_id;
    output logic cur_y_eq_19, cur_x_eq_9;
    
    logic [4:0] cur_x, cur_y;
    
    logic [29:0] row;
    
    always_ff @(posedge clk) begin
        if (init) begin
            cur_x <= 0;
            cur_y <= in_y;
//            row <= 30'b0;   // uncomment to get rid of "don't cares"
        end
        
        if (load_empty) begin
            row <= 30'b0;
        end
        
        if (load_block) begin
            case (cur_x)  // concatonate based on block x value
                0: begin
                    row <= { row[29:3], read_id };
                end
                
                1: begin
                    row <= { row[29:6], read_id, row[2:0] };
                end
                
                2: begin
                    row <= { row[29:9], read_id, row[5:0] };
                end
                
                3: begin
                    row <= { row[29:12], read_id, row[8:0] };
                end
                
                4: begin
                    row <= { row[29:15], read_id, row[11:0] };
                end
                
                5: begin
                    row <= { row[29:18], read_id, row[14:0] };
                end
                
                6: begin
                    row <= { row[29:21], read_id, row[17:0] };
                end
                
                7: begin
                    row <= { row[29:24], read_id, row[20:0] };
                end
                
                8: begin
                    row <= { row[29:27], read_id, row[23:0] };
                end
                
                9: begin
                    row <= { read_id, row[26:0] };
                end
                
                default: begin
                    row <= 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
                end
            endcase
        end
        
        if (reset_x) begin
            cur_x <= 0;
        end
        
        if (incr_cur_x) begin
            cur_x <= cur_x + 5'b1;
        end
        
        if (incr_cur_y) begin
            cur_y <= cur_y + 5'b1;
        end
    end  // always_ff
    
    assign cur_y_eq_19 = cur_y == 19;
    assign cur_x_eq_9 = cur_x == 9;
    assign out_x = cur_x;
    assign out_y = plus ? cur_y + 5'b1 : cur_y;
    
    always_comb begin
        write_id[0] = row[3*cur_x];
        write_id[1] = row[3*cur_x+1];
        write_id[2] = row[3*cur_x+2];
    end  // always_comb
endmodule  // shift_down_data
