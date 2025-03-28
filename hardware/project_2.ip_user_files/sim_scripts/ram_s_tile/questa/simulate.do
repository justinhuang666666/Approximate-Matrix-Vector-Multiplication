onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram_s_tile_opt

do {wave.do}

view wave
view structure
view signals

do {ram_s_tile.udo}

run -all

quit -force
