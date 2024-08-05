// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May 18 13:15:35 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fix_acc_16_sim_netlist.v
// Design      : fix_acc_16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_acc_16,c_accum_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_accum_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_accum_v12_0_13 U0
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
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_accum_v12_0_13
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_accum_v12_0_13_viv i_synth
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
