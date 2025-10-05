onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /shift_down_tb/clk
add wave -noupdate /shift_down_tb/reset
add wave -noupdate /shift_down_tb/start
add wave -noupdate -radix unsigned /shift_down_tb/y
add wave -noupdate -radix unsigned /shift_down_tb/read_id
add wave -noupdate -radix unsigned /shift_down_tb/write_y
add wave -noupdate -radix unsigned /shift_down_tb/write_id
add wave -noupdate /shift_down_tb/wren
add wave -noupdate /shift_down_tb/dut/datapath/cur_y_eq_19
add wave -noupdate /shift_down_tb/reading
add wave -noupdate /shift_down_tb/writing
add wave -noupdate /shift_down_tb/start_shift
add wave -noupdate /shift_down_tb/bd/controlpath/ps
add wave -noupdate /shift_down_tb/bd/controlpath/ns
add wave -noupdate -radix octal -childformat {{{/shift_down_tb/bd/datapath/mem_out[29]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[28]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[27]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[26]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[25]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[24]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[23]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[22]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[21]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[20]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[19]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[18]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[17]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[16]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[15]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[14]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[13]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[12]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[11]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[10]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[9]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[8]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[7]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[6]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[5]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[4]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[3]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[2]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[1]} -radix octal} {{/shift_down_tb/bd/datapath/mem_out[0]} -radix octal}} -subitemconfig {{/shift_down_tb/bd/datapath/mem_out[29]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[28]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[27]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[26]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[25]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[24]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[23]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[22]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[21]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[20]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[19]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[18]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[17]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[16]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[15]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[14]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[13]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[12]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[11]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[10]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[9]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[8]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[7]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[6]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[5]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[4]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[3]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[2]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[1]} {-height 15 -radix octal} {/shift_down_tb/bd/datapath/mem_out[0]} {-height 15 -radix octal}} /shift_down_tb/bd/datapath/mem_out
add wave -noupdate -radix unsigned /shift_down_tb/w_x
add wave -noupdate -radix unsigned /shift_down_tb/w_y
add wave -noupdate -radix unsigned /shift_down_tb/read_y
add wave -noupdate -radix unsigned /shift_down_tb/dut/datapath/cur_x
add wave -noupdate -radix octal /shift_down_tb/dut/datapath/row
add wave -noupdate -radix octal /shift_down_tb/read_id
add wave -noupdate -radix unsigned /shift_down_tb/read_x
add wave -noupdate -radix unsigned /shift_down_tb/write_x
add wave -noupdate /shift_down_tb/dut/controller/ps
add wave -noupdate /shift_down_tb/dut/controller/ns
add wave -noupdate -radix unsigned /shift_down_tb/dut/datapath/out_x
add wave -noupdate -radix unsigned /shift_down_tb/dut/datapath/out_y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {59200 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {57938 ps} {61094 ps}
