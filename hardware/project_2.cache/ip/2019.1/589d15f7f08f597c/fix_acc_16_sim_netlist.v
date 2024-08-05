// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 12:37:44 2024
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
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [15:0]Q;

  wire [15:0]B;
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
  (* C_HAS_BYPASS = "0" *) 
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
(* C_B_TYPE = "0" *) (* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
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
  (* C_HAS_BYPASS = "0" *) 
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
qYkQSW72BWuf9hYjlbEK2lZB9TYU8jXUgG/IVAWxan4x8/CdApyVdZSZPRJrLeCcJwAFjtHOirWj
j9hgvPD/BWQmZZMpsLCR/F6dmVJJVqmMh1cIHx0Cjmbo5liUiBvov5CesVAthY6JPt/KDHp/yI+0
9tD5vKoii+G2bmm5Fxxh4QkzTD2VtYdJCJG68hImkvldSZEjj4zCjeEV67SubzDJG+kbBDzlHZyn
O0AW8z4NSNFMoYfl72E2SPQY1ZAf8Nd+MH6woh5K6gC1tzRC2C9qhEJk8yVhBT/kPaiOKGNYhtPa
m72O6oDLtZnMfw07FW0m6CrWspUQRWrrd89nvA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
5+ry1n1//8bHaivH/b0k9wPeuTwBP9uIRltD2QiGchsLRLW/LUtMNRp5sntATdEs2/uqv2oT4X/A
yZr2FTv+t6NRm7PU5AMFvLc16H20P9+Jz8I+OA1EMpGHC87/1dOiTxxITYxluQlJTfLEsu3nFx+o
K+mnjI5Ir4tFKZ+BsTHqKk7asXTm7tErQGffeRDfsNGyciifCn+IMffD1eHz6YzmM6AGYXlAhqAC
bBHVOB/z1wMGHvgsP3Gssxh8ud+ulRCEOvoRGIo2WGWRpeiFIdXnEdxJKrjQBdNfGCDQ5eT42kgP
YfFlgZ03PBS2KKAWbq4RjDGTgd7WzbBTotSFIw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11920)
`pragma protect data_block
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
pK5fbjwfXA==
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
