
# set_property PACKAGE_PIN W5 [get_ports clk]
# set_property IOSTANDARD LVCMOS33 [get_ports clk]

# set_property PACKAGE_PIN U16 [get_ports rst]
# set_property IOSTANDARD LVCMOS33 [get_ports rst]

create_clock -period 5.000 -name clk -waveform {0.000 2.500} -add [get_ports clk]
# set_input_delay -max 5.000 -clock clk [get_ports rst]


# set_property PULLUP true [get_ports rst]

# set_property PACKAGE_PIN F23      [get_ports "clk"] ;# Bank  28 VCCO - VCC1V8   - IO_L13P_T2L_N0_GC_QBC_28
# set_property IOSTANDARD  LVDS     [get_ports "clk"] ;# Bank  28 VCCO - VCC1V8   - IO_L13P_T2L_N0_GC_QBC_28


