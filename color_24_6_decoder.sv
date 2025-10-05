module color_24_6_decoder(in_color, out_color);
    input logic [5:0] in_color;
    output logic [23:0] out_color;
    
    logic [1:0] r_channel_in, g_channel_in, b_channel_in;
    logic [7:0] r_channel_out, g_channel_out, b_channel_out;
    
    assign r_channel_in = in_color[5:4];
    assign g_channel_in = in_color[3:2];
    assign b_channel_in = in_color[1:0];
    
    assign out_color[23:16] = { 4{r_channel_in} };
    assign out_color[15:8] = { 4{g_channel_in} };
    assign out_color[7:0] = { 4{b_channel_in} };
endmodule  // color_24_6_decoder
