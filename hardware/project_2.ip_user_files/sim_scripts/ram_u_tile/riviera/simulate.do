onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ram_u_tile -L blk_mem_gen_v8_4_3 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ram_u_tile xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ram_u_tile.udo}

run -all

endsim

quit -force
