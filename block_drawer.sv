/**
 * @file block_drawer.sv
 * @author Geeoon Chung     (2264035)
 * @author Anna Petrbokova  (2263140)
 */

/**
 * @brief module to draw a single block on the screen
 * @param input     the clock driving the sequential logic
 * @param input     reset an active HIGH reset
 * @param input     ready whether or not the board is ready to be read
 * @param input     block_id the id of the block to draw
 * @param output    out_x the x coordinate of the pixel to draw
 * @param output    out_y the y coordinate of the pixel to draw
 * @param output    out_color the color of the pixel to draw
 * @param output    done HIGH when the block is done being drawn
 */
module block_drawer(clk, reset, ready, block_id, out_x, out_y, out_color, done);
    input logic clk, reset, ready;
    input logic [2:0] block_id;
    output logic [9:0] out_x;
    output logic [8:0] out_y;
    output logic [23:0] out_color;
    output logic done;
    
    logic init_top,
          incr_x,
          decr_x,
          reset_x,
          incr_y,
          decr_y,
          init_bot,
          set_xd,
          incr_delta,
          init_left,
          set_yd,
          init_right,
          init_main,
          zero_x,
          zero_y,
          grid_init,
          grid_b_init,
          grid_l_init,
          grid_r_init,
          grid_main_init,
          incr_y_gm,
          x_eq_19md,
          y_eq_1,
          y_eq_18,
          y_eq_19md,
          x_eq_1,
          x_eq_18;
          
    logic signed [8:0] color;
    logic [23:0] base_color;
    
    block_drawer_ctrl controller(.clk,
                                 .reset,
                                 .ready,
                                 .x_eq_19md,
                                 .y_eq_1,
                                 .y_eq_18,
                                 .y_eq_19md,
                                 .x_eq_1,
                                 .x_eq_18,
                                 .nodraw(block_id == 0),
                                 .init_top,
                                 .incr_x,
                                 .decr_x,
                                 .reset_x,
                                 .incr_y,
                                 .decr_y,
                                 .init_bot,
                                 .set_xd,
                                 .incr_delta,
                                 .init_left,
                                 .set_yd,
                                 .init_right,
                                 .init_main,
                                 .zero_x,
                                 .zero_y,
                                 .grid_init,
                                 .grid_b_init,
                                 .grid_l_init,
                                 .grid_r_init,
                                 .grid_main_init,
                                 .incr_y_gm,
                                 .done);
                                 
    block_drawer_data datapath(.clk,
                               .init_top,
                               .incr_x,
                               .decr_x,
                               .reset_x,
                               .incr_y,
                               .decr_y,
                               .init_bot,
                               .set_xd,
                               .incr_delta,
                               .init_left,
                               .set_yd,
                               .init_right,
                               .init_main,
                               .zero_x,
                               .zero_y,
                               .grid_init,
                               .grid_b_init,
                               .grid_l_init,
                               .grid_r_init,
                               .grid_main_init,
                               .incr_y_gm,
                               .x_eq_19md,
                               .y_eq_1,
                               .y_eq_18,
                               .y_eq_19md,
                               .x_eq_1,
                               .x_eq_18, 
                               .x(out_x),
                               .y(out_y),
                               .color);
                               
    always_comb begin
        case (block_id)
            0: begin
                base_color = 24'hFBFBFB;
            end
            
            1: begin
                base_color = 24'hFFFF00;
            end
            
            2: begin
                base_color = 24'hFF0000;
            end
            
            3: begin
                base_color = 24'h00FF00;
            end
            
            default: begin
                base_color = 24'hFFFFFF;
            end
        endcase
    end  // always_comb
    
    always_comb begin
        // if color is negative
        if (color[8]) begin
            if (base_color[23:16] >= ~color[7:0]) begin  // no underflow
                out_color[23:16] = base_color[23:16] - (~color[7:0]);
            end else begin
                out_color[23:16] = 0;
            end
            
            if (base_color[15:8] >= ~color[7:0]) begin  // no underflow
                out_color[15:8] = base_color[15:8] - (~color[7:0]);
            end else begin
                out_color[15:8] = 0;
            end
            
            if (base_color[7:0] >= ~color[7:0]) begin  // no underflow
                out_color[7:0] = base_color[7:0] - (~color[7:0]);
            end else begin
                out_color[7:0] = 0;
            end
        end else begin  // color is positive here
            if (base_color[23:16] <= 8'hff - color[7:0]) begin  // no overflow
                out_color[23:16] = base_color[23:16] + color[7:0];
            end else begin
                out_color[23:16] = 8'hff;
            end
            
            if (base_color[15:8] <= 8'hff - color[7:0]) begin  // no overflow
                out_color[15:8] = base_color[15:8] + color[7:0];
            end else begin
                out_color[15:8] = 8'hff;
            end
            
            if (base_color[7:0] <= 8'hff - color[7:0]) begin  // no overflow
                out_color[7:0] = base_color[7:0] + color[7:0];
            end else begin
                out_color[7:0] = 8'hff;
            end
        end
    end
endmodule  // block_drawer

module block_drawer_tb();
    logic clk, reset, ready, done;
    logic [2:0] block_id;
    logic [23:0] out_color;
    
    logic [9:0] out_x;
    logic [8:0] out_y;
    
    block_drawer dut (.*);
    
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
        ready = 1;
        block_id = 1;
        @(posedge clk);
        
        // draw a normal block
        reset = 0;
        @(posedge done);
        
        // draw an empty block
        // reset
        reset = 1;
        ready = 1;
        block_id = 0;
        @(posedge clk);
        
        reset = 0;
        @(posedge done);
        $stop;
    end  // initial
endmodule  // block_drawer_tb
