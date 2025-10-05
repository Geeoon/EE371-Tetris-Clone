onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /block_drawer_tb/clk
add wave -noupdate /block_drawer_tb/reset
add wave -noupdate /block_drawer_tb/ready
add wave -noupdate /block_drawer_tb/done
add wave -noupdate -radix unsigned /block_drawer_tb/out_x
add wave -noupdate -radix unsigned /block_drawer_tb/out_y
add wave -noupdate /block_drawer_tb/dut/controller/ps
add wave -noupdate /block_drawer_tb/dut/controller/ns
add wave -noupdate -radix unsigned /block_drawer_tb/block_id
add wave -noupdate -radix hexadecimal /block_drawer_tb/out_color
add wave -noupdate -radix hexadecimal /block_drawer_tb/dut/color
add wave -noupdate -radix hexadecimal /block_drawer_tb/dut/base_color
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22217 ps} 0}
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
WaveRestoreZoom {0 ps} {52028 ps}
