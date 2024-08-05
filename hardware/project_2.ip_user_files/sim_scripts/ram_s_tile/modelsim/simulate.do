onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L blk_mem_gen_v8_4_3 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.ram_s_tile xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {ram_s_tile.udo}

run -all

quit -force
