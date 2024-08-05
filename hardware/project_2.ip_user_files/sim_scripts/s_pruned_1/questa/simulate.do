onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib s_pruned_1_opt

do {wave.do}

view wave
view structure
view signals

do {s_pruned_1.udo}

run -all

quit -force
