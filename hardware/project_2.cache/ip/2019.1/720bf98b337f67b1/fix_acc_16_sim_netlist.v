// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 12:19:02 2024
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
    BYPASS,
    SCLR,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 bypass_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME bypass_intf, LAYERED_METADATA undef" *) input BYPASS;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [15:0]Q;

  wire [15:0]B;
  wire BYPASS;
  wire CE;
  wire CLK;
  wire [15:0]Q;
  wire SCLR;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "1" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "16" *) 
  (* C_SCALE = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_accum_v12_0_13 U0
       (.ADD(1'b1),
        .B(B),
        .BYPASS(BYPASS),
        .CE(CE),
        .CLK(CLK),
        .C_IN(1'b0),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_TYPE = "0" *) (* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "1" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) 
(* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) (* C_OUT_WIDTH = "16" *) 
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
  input [15:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output [15:0]Q;

  wire [15:0]B;
  wire BYPASS;
  wire CE;
  wire CLK;
  wire [15:0]Q;
  wire SCLR;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "1" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "16" *) 
  (* C_SCALE = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_accum_v12_0_13_viv i_synth
       (.ADD(1'b0),
        .B(B),
        .BYPASS(BYPASS),
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
Mx82j7LVD5/VcIxRGJQMc3phjfM9zkqy9QEVVPuwJnZLeIJmd9AIrX8tA38CrI8YTP1aXQzkRyTY
yIPmuhr1U2OkCLnmuDBtE2GWUTZW7xRv75d8pZk+YgyEyWEtPD1l5bgULbo4ZqQmbY5EY7r2CnlE
fMXh78c/vPUdsvA/QBRf8t+Lhda9JUj3MY2DJ7mWSgLHe9s7xM/8gNwpC2+ocIWB5IgDDFEZzD3t
vic28vP3v552fpK1VVxA4Act0dXWdtfak7D4piQjGxKOpgGprvmw1DMIYi4Wv2u01Gkkj/PoaPRQ
5fsup0aCldKSW0RMbCm7oZqRGc4eJqX4hZCbTg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
tipwxqI9swh4TCXxN58vZx4tt6vv8uYx+1WkwqJYOEqe9fqbKW8HeuCVy1dIsmjluBXK4Hoxks1+
PRoR3SyI8yzzOP9FD+bZ/wsbopH0tMQYsAXmQAZY42MncDveim91svLecT2EX+zPUCw74d/ZWKa8
T0uU6X9nf8YF3mALI7U22QVz7i08iFywpn+4Xgg14LN3qfhH/aKqrM8TWxSaAZY9VRc3Q6RxCiDd
fOmwu5+ux4IxfHVXCtyJS5iPH6a8xfCUZKIxN9gCOt0hySyELPEEen+ij2uxUN/IjNbavk+Gnj2C
A4foEMPeQwaFvj0sOOmAZa5jQfi0ALm1jZg77Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 12320)
`pragma protect data_block
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
W0biSBy8rIo=
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
