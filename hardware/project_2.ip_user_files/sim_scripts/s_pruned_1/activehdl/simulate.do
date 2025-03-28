onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+s_pruned_1 -L blk_mem_gen_v8_4_3 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.s_pruned_1 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {s_pruned_1.udo}

run -all

endsim

quit -force
