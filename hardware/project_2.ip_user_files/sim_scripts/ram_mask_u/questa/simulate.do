onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram_mask_u_opt

do {wave.do}

view wave
view structure
view signals

do {ram_mask_u.udo}

run -all

quit -force
