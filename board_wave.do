onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /board_tb/clk
add wave -noupdate /board_tb/reset
add wave -noupdate /board_tb/wren
add wave -noupdate -radix unsigned /board_tb/read_x
add wave -noupdate -radix unsigned /board_tb/read_y
add wave -noupdate -radix unsigned /board_tb/write_x
add wave -noupdate -radix unsigned /board_tb/write_y
add wave -noupdate /board_tb/write_id
add wave -noupdate /board_tb/read_id
add wave -noupdate /board_tb/ready
add wave -noupdate -radix unsigned -childformat {{{/board_tb/dut/datapath/ram/q[29]} -radix binary} {{/board_tb/dut/datapath/ram/q[28]} -radix binary} {{/board_tb/dut/datapath/ram/q[27]} -radix binary} {{/board_tb/dut/datapath/ram/q[26]} -radix binary} {{/board_tb/dut/datapath/ram/q[25]} -radix binary} {{/board_tb/dut/datapath/ram/q[24]} -radix binary} {{/board_tb/dut/datapath/ram/q[23]} -radix binary} {{/board_tb/dut/datapath/ram/q[22]} -radix binary} {{/board_tb/dut/datapath/ram/q[21]} -radix binary} {{/board_tb/dut/datapath/ram/q[20]} -radix binary} {{/board_tb/dut/datapath/ram/q[19]} -radix binary} {{/board_tb/dut/datapath/ram/q[18]} -radix binary} {{/board_tb/dut/datapath/ram/q[17]} -radix binary} {{/board_tb/dut/datapath/ram/q[16]} -radix binary} {{/board_tb/dut/datapath/ram/q[15]} -radix binary} {{/board_tb/dut/datapath/ram/q[14]} -radix binary} {{/board_tb/dut/datapath/ram/q[13]} -radix binary} {{/board_tb/dut/datapath/ram/q[12]} -radix binary} {{/board_tb/dut/datapath/ram/q[11]} -radix binary} {{/board_tb/dut/datapath/ram/q[10]} -radix binary} {{/board_tb/dut/datapath/ram/q[9]} -radix binary} {{/board_tb/dut/datapath/ram/q[8]} -radix binary} {{/board_tb/dut/datapath/ram/q[7]} -radix binary} {{/board_tb/dut/datapath/ram/q[6]} -radix binary} {{/board_tb/dut/datapath/ram/q[5]} -radix binary} {{/board_tb/dut/datapath/ram/q[4]} -radix binary} {{/board_tb/dut/datapath/ram/q[3]} -radix binary} {{/board_tb/dut/datapath/ram/q[2]} -radix binary} {{/board_tb/dut/datapath/ram/q[1]} -radix binary} {{/board_tb/dut/datapath/ram/q[0]} -radix binary}} -subitemconfig {{/board_tb/dut/datapath/ram/q[29]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[28]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[27]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[26]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[25]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[24]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[23]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[22]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[21]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[20]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[19]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[18]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[17]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[16]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[15]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[14]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[13]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[12]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[11]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[10]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[9]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[8]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[7]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[6]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[5]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[4]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[3]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[2]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[1]} {-height 15 -radix binary} {/board_tb/dut/datapath/ram/q[0]} {-height 15 -radix binary}} /board_tb/dut/datapath/ram/q
add wave -noupdate -radix unsigned /board_tb/dut/datapath/x
add wave -noupdate -radix unsigned /board_tb/dut/datapath/ry
add wave -noupdate -radix unsigned /board_tb/dut/datapath/y
add wave -noupdate -radix unsigned /board_tb/dut/datapath/read_y
add wave -noupdate /board_tb/dut/controlpath/ps
add wave -noupdate /board_tb/dut/controlpath/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {167075 ps} 0}
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
WaveRestoreZoom {45338 ps} {187141 ps}
