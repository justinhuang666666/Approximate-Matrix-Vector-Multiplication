onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fix_acc_16_opt

do {wave.do}

view wave
view structure
view signals

do {fix_acc_16.udo}

run -all

quit -force
