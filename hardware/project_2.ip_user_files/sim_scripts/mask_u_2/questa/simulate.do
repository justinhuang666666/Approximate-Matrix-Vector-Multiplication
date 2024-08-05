onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mask_u_2_opt

do {wave.do}

view wave
view structure
view signals

do {mask_u_2.udo}

run -all

quit -force
