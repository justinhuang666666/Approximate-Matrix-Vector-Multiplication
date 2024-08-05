onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram_v_tile_opt

do {wave.do}

view wave
view structure
view signals

do {ram_v_tile.udo}

run -all

quit -force
