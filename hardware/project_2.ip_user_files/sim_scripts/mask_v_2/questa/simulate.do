onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mask_v_2_opt

do {wave.do}

view wave
view structure
view signals

do {mask_v_2.udo}

run -all

quit -force
