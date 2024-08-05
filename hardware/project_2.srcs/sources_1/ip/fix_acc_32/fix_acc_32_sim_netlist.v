// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May 18 13:15:35 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top fix_acc_32 -prefix
//               fix_acc_32_ fix_acc_16_sim_netlist.v
// Design      : fix_acc_16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_acc_16,c_accum_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_accum_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module fix_acc_32
   (B,
    CLK,
    CE,
    SCLR,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [31:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [31:0]Q;

  wire [31:0]B;
  wire CE;
  wire CLK;
  wire [31:0]Q;
  wire SCLR;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "32" *) 
  (* C_SCALE = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fix_acc_32_c_accum_v12_0_13 U0
       (.ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(CE),
        .CLK(CLK),
        .C_IN(1'b0),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_TYPE = "0" *) (* C_B_WIDTH = "32" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) 
(* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) (* C_OUT_WIDTH = "32" *) 
(* C_SCALE = "0" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynquplus" *) (* downgradeipidentifiedwarnings = "yes" *) 
module fix_acc_32_c_accum_v12_0_13
   (B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [31:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output [31:0]Q;

  wire [31:0]B;
  wire CE;
  wire CLK;
  wire [31:0]Q;
  wire SCLR;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "32" *) 
  (* C_SCALE = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fix_acc_32_c_accum_v12_0_13_viv i_synth
       (.ADD(1'b0),
        .B(B),
        .BYPASS(1'b0),
        .CE(CE),
        .CLK(CLK),
        .C_IN(1'b0),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
dSeZRmSWebtpOR1O9c+IDTdlMH9/1hro8PqDVDl27v005C5MqyZKeYNm9mMQ4XxWPZxFv87c3Z4n
5Uz6xaUmaA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
C1X6j2CN/BrcCWflKLlsg+cM+rksMcYf4EY7flfh0J07Kd6Yz1U8b4CQa6qGoE2Y/wXsD6+gLu1B
2quOLx5FDsX7IQ01fo4Wy5qqUx/igSc9hpspjPHf2g+aIJkObQiq+MmJ+KTB+Mr045wlFkkQImp+
nDfZhNfvYWVtC9yy0Mg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HjLqlbAvfCfrXjMuBZHqAXPJS1vFnuk4uVIm/P79GrZZ9F4hFvwWw6h/Zebc7LHBZ8aDoz2nqBGS
agpUUi5a/7KL6U7zc4JR+FiGSOstAhOnchiAjnOL/ldhpQkZIkSQSTy9sflsdb5yUdL0uPtUDYKm
JiJ+7sIur9MpneraAAsadcSxH8JIj82UxvxsEWic+lRUQBGZFYyW0a0weg1TJA3+efxfenYDiODb
8jzwBuRuSugqAtIDl3yWQJ9IcNkG+CU+BGRm90QOw588wfIZH03ujkyY04caLofICJJNQUmw+DM1
VDUxFyWr5tAkQVtSuA6xeiwuyy2I65doiiKY6w==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jBvJHqZCB59aFpCz1IePy4RYqbdYJK8+fPkLRFZsA/PaDkJTn3Hl79AMa4nnyc/JiDyDTouUur+B
wq9KbIkwWHA+V1GYoCQNsRGcXLp203F8xGa0WwDCMkQ61DI8d+vX/vCNY6WtVir5NydV3RPPeiNF
noQc9J8fdyNdBk8Dxycu9m0M6hA7pKxhqzaHGTgDfbTL5nSSisEctrk7xIKxRZfDEOjb/HgQrPu8
PxKjuK+PWdRbd2TYDPTYnN2aSVMTc6FECz/tkuEDTDbHOolKjwwgmUiTQnpnNMkoUeVX0sUgETZ0
PKLh1yOIslZFd3mse8z6tXWAOjf/rOzL2t0EsQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Wfi1Xoi9/LK5icaWPECZ2+1JTGzZYnEl3d+vB8OHM+D4/fOHr3MHHVZ0qGciPepgRoPPmPsVwn9B
ArC5SHMlmrWWF5Z9WanD8/2Yrj5Bi3kpeZ37ays2Rv60e/FbcLgpzFehbdd70uh20kKd41JucKIG
Pqqwd9WOovku5RQDI9cmBTOzshupNa5+d+mxjOcVuX6Z0iiYgrqSoYVsnRBBn5gTC/QcQpo+5G9C
ns/bzHveQR1VYA6IFM4GmlqKjaDc2w1jfg/FWtasz5yKFmkAp373q/uDiliz3SkRfXw+ciWt0WEu
xoNuMpdlbRqGAogaFMBPgBhHYDT6o1aa76AXTQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
DMUDPZjwKoonOS0VVbYtITWEUX/2WEHTClm1HjCk/vPm2O3Uvu+dFPKkbyVwsC4FU4hlJRDwWfgC
oaXUKoljsM4sDKmfg7+qAjFuZJq5zk0fZyjAT8T/ZLfQ6BlQ5ARAZJrb6mZr1VppAca86m3l0Qdv
ngH/g/XldqQKrARLx4Y=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
C7PFVsZigY1uTEEQM+/f4IwFmUMcqTrhsXoxQyu0ggdL9ucOj1dbj+YWrUORvE5egEx49rO56kTw
tDIj4NUh+zIDEY+ZVj9luOJ0+6xsEPBCJrz7XamiG0StFGzjnZF/DhB6wjRraeouE/H3ANL9I7r8
dOj5uvd06ApE35mLiFBo6gsfno83mSOasT0ZH4dVuOH4l0Y2v8BrhyMvhYbUsCZQK3X0uembZyhz
VjqiMeFRF3MGpFD3QZHvnui8DK0HgE0ax9Y0wqriLLm6qBX91UKKcgItKLtWuQF3rEV5jxZJjv9j
jJUEjk4e+X6nMNcMTB0QaLYW6kr5oAuebhwiyw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GtlktBcAZKaK90vbHOJul5P29zXD7NOtvUGhqulS9EqKAX1Wql7PvQDHiuAuJeGCiLv9TYcNjl7J
lNK4nM0YluUYGdLtD2XGBEnqjqVPgBxn/F8w9qatFV7qQVGhhr+YSDNs7NL5aJqNMUZu9e4Fwj6x
nVACPL5aGXnUHJtnjGd5YadoBldZ1dXWFxrqO5iQ4hHyXHAWOb9SKB9yRZVL/wyRgjFs2LQHkNVq
HCFF0lt4ymMBVcXQpooyarc4vyeJDQEZmv+EKDQBr/vPuZxYCeUKPq57VrcCorDj0rhTehzNgOY8
6KeZLyxW+0e0DvfQI2AodCMZcs/9LHoRSSH3Yw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
5L6QCdTfZOcAXiAUB3gQ6lEZsz3/OVeZZ3LE73cgyXi1MzU1BTmskbvG83htKq49MPzUh5OmkcFy
v4Lo171xvfhDKL5YSTsxdKqCbtu4kD3ERRv+L5LipIqNroG1hcqUYEZkppNGH/lWrziXp+eI94Lv
sJDKn2sOJt13UEsDkkQr0V2qeYp6RgM1oRlNGr0HMV9AgaslOe9r2AjBZPuo7iqqQKkf6t9ws2kx
UbXpdyN06JSdHYrwv5cDVQcvWQP0NkXh/rOzFF2SBoaKu+ZY8O821JIvQOhrRJtxxEtFuQPq3Gag
rMRj2t9PoFjYe0H/mrq/d+8pDdA2cpVJGpW9yQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11152)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
