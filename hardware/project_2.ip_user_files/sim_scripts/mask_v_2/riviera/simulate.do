onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+mask_v_2 -L blk_mem_gen_v8_4_3 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.mask_v_2 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {mask_v_2.udo}

run -all

endsim

quit -force
