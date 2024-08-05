onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+db_u_tile_ram -L xil_defaultlib -L xpm -L blk_mem_gen_v8_4_3 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.db_u_tile_ram xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {db_u_tile_ram.udo}

run -all

endsim

quit -force
