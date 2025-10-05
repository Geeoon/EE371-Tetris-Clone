module board_data(clk, ready, write_x, write_y, read_x, read_y, write_id, load_regs, load_val, read_id);
    input logic clk, ready, load_regs, load_val;
    input logic [4:0] write_x, write_y, read_x, read_y;
    input logic [2:0] write_id;
    output logic [2:0] read_id;
    
    logic [4:0] x, y, ry;
    logic [2:0] id;
    
    logic [29:0] in, mem_out;

    logic wren;
    
    board_2PRAM ram (.clock(clk), .data(in), .rdaddress(ry), .wraddress(y), .wren, .q(mem_out));
    
    always_ff @(posedge clk) begin
        if (load_regs) begin
            id <= write_id;
            x <= write_x;
            y <= write_y;
        end
    end  // always_ff
    
    assign ry = ready ? read_y : y;
    
    always_comb begin
        wren = load_val;
        if (read_x <= 9) begin  // prevent overreads
            read_id[0] = mem_out[3*read_x];
            read_id[1] = mem_out[(3*read_x)+1];
            read_id[2] = mem_out[(3*read_x)+2];
        end else begin
            read_id = 3'b0;
        end
        
        
        case (x)  // concatonate based on block x value
            0: begin
                in = { mem_out[29:3], id };
            end
            
            1: begin
                in = { mem_out[29:6], id, mem_out[2:0] };
            end
            
            2: begin
                in = { mem_out[29:9], id, mem_out[5:0] };
            end
            
            3: begin
                in = { mem_out[29:12], id, mem_out[8:0] };
            end
            
            4: begin
                in = { mem_out[29:15], id, mem_out[11:0] };
            end
            
            5: begin
                in = { mem_out[29:18], id, mem_out[14:0] };
            end
            
            6: begin
                in = { mem_out[29:21], id, mem_out[17:0] };
            end
            
            7: begin
                in = { mem_out[29:24], id, mem_out[20:0] };
            end
            
            8: begin
                in = { mem_out[29:27], id, mem_out[23:0] };
            end
            
            9: begin
                in = { id, mem_out[26:0] };
            end
            
            default: begin  // prevent overwrites
                wren = 0;
                in = 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
            end
        endcase
//        in = {mem_out[0:3*x], write_id, mem_out[3*(x+1):29]};
    end  // always_comb
endmodule  // board_data
