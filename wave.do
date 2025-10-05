onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /game_loop_tb/clk
add wave -noupdate /game_loop_tb/reset
add wave -noupdate /game_loop_tb/left_input
add wave -noupdate /game_loop_tb/right_input
add wave -noupdate -radix unsigned /game_loop_tb/dut/pos_x
add wave -noupdate -radix unsigned /game_loop_tb/dut/pos_y
add wave -noupdate /game_loop_tb/dut/controller/ps
add wave -noupdate /game_loop_tb/dut/controller/ns
add wave -noupdate /game_loop_tb/dut/bd/ready
add wave -noupdate -radix octal /game_loop_tb/dut/bd/datapath/mem_out
add wave -noupdate -radix unsigned /game_loop_tb/dut/bd/datapath/x
add wave -noupdate -radix unsigned /game_loop_tb/dut/bd/datapath/y
add wave -noupdate -radix unsigned /game_loop_tb/dut/bd/datapath/ry
add wave -noupdate -radix unsigned /game_loop_tb/dut/board_drawer_system_module/block_y
add wave -noupdate /game_loop_tb/dut/board_drawer_system_module/done
add wave -noupdate /game_loop_tb/dut/clear_rows_module/row_checker/fail
add wave -noupdate /game_loop_tb/dut/clear_rows_module/row_checker/full
add wave -noupdate -radix unsigned /game_loop_tb/dut/clear_rows_module/row_checker/x
add wave -noupdate -radix unsigned /game_loop_tb/dut/clear_rows_module/row_checker/y
add wave -noupdate /game_loop_tb/dut/clear_rows_module/row_checker/x_present
add wave -noupdate /game_loop_tb/dut/clear_rows_module/row_checker/controlpath/ps
add wave -noupdate /game_loop_tb/dut/clear_rows_module/row_checker/controlpath/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6549384 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 348
configure wave -valuecolwidth 78
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {6454796 ps} {6668206 ps}
