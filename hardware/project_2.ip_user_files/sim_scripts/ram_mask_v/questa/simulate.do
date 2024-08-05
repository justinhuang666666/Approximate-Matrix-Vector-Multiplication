onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram_mask_v_opt

do {wave.do}

view wave
view structure
view signals

do {ram_mask_v.udo}

run -all

quit -force
