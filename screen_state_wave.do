onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /screen_state_tb/clk
add wave -noupdate /screen_state_tb/reset
add wave -noupdate /screen_state_tb/wren
add wave -noupdate -radix unsigned /screen_state_tb/read_x
add wave -noupdate -radix unsigned /screen_state_tb/write_x
add wave -noupdate -radix unsigned /screen_state_tb/read_y
add wave -noupdate -radix unsigned /screen_state_tb/write_y
add wave -noupdate -radix hexadecimal /screen_state_tb/write_color
add wave -noupdate -radix hexadecimal /screen_state_tb/read_color
add wave -noupdate /screen_state_tb/dut/collision
add wave -noupdate -radix hexadecimal /screen_state_tb/dut/rdaddress
add wave -noupdate -radix hexadecimal /screen_state_tb/dut/wraddress
add wave -noupdate -radix hexadecimal /screen_state_tb/dut/ram_out
add wave -noupdate -radix hexadecimal /screen_state_tb/dut/RAM/data
add wave -noupdate -radix hexadecimal /screen_state_tb/dut/RAM/rdaddress
add wave -noupdate -radix hexadecimal /screen_state_tb/dut/RAM/wraddress
add wave -noupdate /screen_state_tb/dut/RAM/wren
add wave -noupdate -radix hexadecimal /screen_state_tb/dut/RAM/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {84215662 ps} 0}
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
WaveRestoreZoom {0 ps} {193536264 ps}
