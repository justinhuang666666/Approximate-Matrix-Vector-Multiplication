onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib s_tile_ram_opt

do {wave.do}

view wave
view structure
view signals

do {s_tile_ram.udo}

run -all

quit -force
