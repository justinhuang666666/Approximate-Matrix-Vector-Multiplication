vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/xbip_utils_v3_0_10
vlib activehdl/c_reg_fd_v12_0_6
vlib activehdl/xbip_dsp48_wrapper_v3_0_4
vlib activehdl/xbip_pipe_v3_0_6
vlib activehdl/xbip_dsp48_addsub_v3_0_6
vlib activehdl/xbip_addsub_v3_0_6
vlib activehdl/c_addsub_v12_0_13
vlib activehdl/xbip_dsp48_acc_v3_0_6
vlib activehdl/xbip_accum_v3_0_6
vlib activehdl/c_accum_v12_0_13

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap xbip_utils_v3_0_10 activehdl/xbip_utils_v3_0_10
vmap c_reg_fd_v12_0_6 activehdl/c_reg_fd_v12_0_6
vmap xbip_dsp48_wrapper_v3_0_4 activehdl/xbip_dsp48_wrapper_v3_0_4
vmap xbip_pipe_v3_0_6 activehdl/xbip_pipe_v3_0_6
vmap xbip_dsp48_addsub_v3_0_6 activehdl/xbip_dsp48_addsub_v3_0_6
vmap xbip_addsub_v3_0_6 activehdl/xbip_addsub_v3_0_6
vmap c_addsub_v12_0_13 activehdl/c_addsub_v12_0_13
vmap xbip_dsp48_acc_v3_0_6 activehdl/xbip_dsp48_acc_v3_0_6
vmap xbip_accum_v3_0_6 activehdl/xbip_accum_v3_0_6
vmap c_accum_v12_0_13 activehdl/c_accum_v12_0_13

vlog -work xil_defaultlib  -sv2k12 \
"C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_10 -93 \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work c_reg_fd_v12_0_6 -93 \
"../../../ipstatic/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_wrapper_v3_0_4 -93 \
"../../../ipstatic/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_6 -93 \
"../../../ipstatic/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_addsub_v3_0_6 -93 \
"../../../ipstatic/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \

vcom -work xbip_addsub_v3_0_6 -93 \
"../../../ipstatic/hdl/xbip_addsub_v3_0_vh_rfs.vhd" \

vcom -work c_addsub_v12_0_13 -93 \
"../../../ipstatic/hdl/c_addsub_v12_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_acc_v3_0_6 -93 \
"../../../ipstatic/hdl/xbip_dsp48_acc_v3_0_vh_rfs.vhd" \

vcom -work xbip_accum_v3_0_6 -93 \
"../../../ipstatic/hdl/xbip_accum_v3_0_vh_rfs.vhd" \

vcom -work c_accum_v12_0_13 -93 \
"../../../ipstatic/hdl/c_accum_v12_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../project_2.srcs/sources_1/ip/fix_acc_16/sim/fix_acc_16.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

