onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram_input_vector_opt

do {wave.do}

view wave
view structure
view signals

do {ram_input_vector.udo}

run -all

quit -force
