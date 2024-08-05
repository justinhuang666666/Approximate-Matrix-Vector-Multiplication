onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xbip_utils_v3_0_10 -L xbip_pipe_v3_0_6 -L xbip_bram18k_v3_0_6 -L mult_gen_v12_0_15 -L xil_defaultlib -L secureip -lib xil_defaultlib xil_defaultlib.fix_mult_32

do {wave.do}

view wave
view structure
view signals

do {fix_mult_32.udo}

run -all

quit -force
