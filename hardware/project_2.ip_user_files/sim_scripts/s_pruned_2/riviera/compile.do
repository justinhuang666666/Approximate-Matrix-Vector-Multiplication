vlib work
vlib riviera

vlib riviera/blk_mem_gen_v8_4_3
vlib riviera/xil_defaultlib

vmap blk_mem_gen_v8_4_3 riviera/blk_mem_gen_v8_4_3
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work blk_mem_gen_v8_4_3  -v2k5 \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../project_2.srcs/sources_1/ip/s_pruned_2/sim/s_pruned_2.v" \


vlog -work xil_defaultlib \
"glbl.v"

