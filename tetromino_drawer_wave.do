onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tetromino_drawer_tb/clk
add wave -noupdate /tetromino_drawer_tb/reset
add wave -noupdate /tetromino_drawer_tb/start
add wave -noupdate -radix unsigned /tetromino_drawer_tb/in_x
add wave -noupdate -radix unsigned /tetromino_drawer_tb/in_y
add wave -noupdate -radix unsigned /tetromino_drawer_tb/t_id
add wave -noupdate -radix unsigned /tetromino_drawer_tb/x
add wave -noupdate -radix unsigned /tetromino_drawer_tb/y
add wave -noupdate -radix unsigned /tetromino_drawer_tb/out_id
add wave -noupdate /tetromino_drawer_tb/wren
add wave -noupdate /tetromino_drawer_tb/done
add wave -noupdate /tetromino_drawer_tb/dut/controller/ps
add wave -noupdate /tetromino_drawer_tb/dut/controller/ns
add wave -noupdate /tetromino_drawer_tb/dut/controller/x_eq_posxpwidth
add wave -noupdate /tetromino_drawer_tb/dut/controller/y_eq_posypwidth
add wave -noupdate -radix unsigned /tetromino_drawer_tb/dut/datapath/width
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {424 ps} 0}
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
WaveRestoreZoom {0 ps} {4778 ps}
