onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /board_drawer_tb/clk
add wave -noupdate /board_drawer_tb/reset
add wave -noupdate /board_drawer_tb/ready
add wave -noupdate /board_drawer_tb/draw_done
add wave -noupdate /board_drawer_tb/done
add wave -noupdate /board_drawer_tb/draw
add wave -noupdate /board_drawer_tb/x
add wave -noupdate /board_drawer_tb/y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {254048 ps}
