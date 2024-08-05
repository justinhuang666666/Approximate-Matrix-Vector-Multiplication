onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mask_v_1_opt

do {wave.do}

view wave
view structure
view signals

do {mask_v_1.udo}

run -all

quit -force
