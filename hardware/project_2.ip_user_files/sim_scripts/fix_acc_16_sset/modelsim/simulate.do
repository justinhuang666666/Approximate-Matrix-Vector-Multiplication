onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xbip_utils_v3_0_10 -L c_reg_fd_v12_0_6 -L xbip_dsp48_wrapper_v3_0_4 -L xbip_pipe_v3_0_6 -L xbip_dsp48_addsub_v3_0_6 -L xbip_addsub_v3_0_6 -L c_addsub_v12_0_13 -L xbip_dsp48_acc_v3_0_6 -L xbip_accum_v3_0_6 -L c_accum_v12_0_13 -L xil_defaultlib -L secureip -lib xil_defaultlib xil_defaultlib.fix_acc_16_sset

do {wave.do}

view wave
view structure
view signals

do {fix_acc_16_sset.udo}

run -all

quit -force
