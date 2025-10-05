onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /clear_row_tb/clk
add wave -noupdate /clear_row_tb/fail_or_full
add wave -noupdate /clear_row_tb/full
add wave -noupdate /clear_row_tb/Start
add wave -noupdate /clear_row_tb/Reset
add wave -noupdate -radix unsigned /clear_row_tb/row
add wave -noupdate /clear_row_tb/Ready
add wave -noupdate /clear_row_tb/clearrow
add wave -noupdate /clear_row_tb/noclear
add wave -noupdate /clear_row_tb/Done
add wave -noupdate -radix unsigned /clear_row_tb/read_id
add wave -noupdate -radix unsigned /clear_row_tb/write_id
add wave -noupdate -radix unsigned /clear_row_tb/read_x
add wave -noupdate -radix unsigned /clear_row_tb/read_y
add wave -noupdate -radix unsigned /clear_row_tb/write_x
add wave -noupdate -radix unsigned /clear_row_tb/write_y
add wave -noupdate /clear_row_tb/wren
add wave -noupdate /clear_row_tb/dut/shift/done
add wave -noupdate /clear_row_tb/dut/controlpath/ns
add wave -noupdate /clear_row_tb/dut/controlpath/ps
add wave -noupdate /clear_row_tb/dut/shift/controller/ps
add wave -noupdate /clear_row_tb/dut/shift/controller/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29590 ps} 0}
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
WaveRestoreZoom {0 ps} {174395 ps}
