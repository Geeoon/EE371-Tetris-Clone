onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /clear_rows_tb/clk
add wave -noupdate /clear_rows_tb/reset
add wave -noupdate /clear_rows_tb/start
add wave -noupdate -radix octal /clear_rows_tb/read_id
add wave -noupdate -radix unsigned /clear_rows_tb/read_x
add wave -noupdate -radix unsigned /clear_rows_tb/read_y
add wave -noupdate -radix unsigned /clear_rows_tb/write_x
add wave -noupdate -radix unsigned /clear_rows_tb/write_y
add wave -noupdate -radix unsigned /clear_rows_tb/w_x
add wave -noupdate -radix unsigned /clear_rows_tb/w_y
add wave -noupdate -radix unsigned /clear_rows_tb/temp_x
add wave -noupdate -radix unsigned /clear_rows_tb/temp_y
add wave -noupdate -radix unsigned /clear_rows_tb/read_x_c
add wave -noupdate -radix unsigned /clear_rows_tb/read_y_c
add wave -noupdate -radix octal /clear_rows_tb/write_id
add wave -noupdate -radix octal /clear_rows_tb/w_id
add wave -noupdate -radix octal /clear_rows_tb/temp_id
add wave -noupdate /clear_rows_tb/wren
add wave -noupdate /clear_rows_tb/Done
add wave -noupdate /clear_rows_tb/reading
add wave -noupdate /clear_rows_tb/start_clear
add wave -noupdate /clear_rows_tb/writing
add wave -noupdate -radix unsigned /clear_rows_tb/bd/datapath/x
add wave -noupdate -radix unsigned /clear_rows_tb/bd/datapath/y
add wave -noupdate -radix octal /clear_rows_tb/bd/datapath/mem_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {33998 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {8012 ps}
