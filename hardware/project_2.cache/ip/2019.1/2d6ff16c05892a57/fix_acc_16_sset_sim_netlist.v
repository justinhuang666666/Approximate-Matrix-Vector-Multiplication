// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 18:47:51 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fix_acc_16_sset_sim_netlist.v
// Design      : fix_acc_16_sset
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_acc_16_sset,c_accum_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_accum_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (B,
    CLK,
    CE,
    SCLR,
    SSET,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 sset_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME sset_intf, LAYERED_METADATA undef" *) input SSET;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [15:0]Q;

  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [15:0]Q;
  wire SCLR;
  wire SSET;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "1" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* c_add_mode = "0" *) 
  (* c_b_type = "0" *) 
  (* c_b_width = "16" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "0" *) 
  (* c_latency = "1" *) 
  (* c_out_width = "16" *) 
  (* c_scale = "0" *) 
  (* c_verbosity = "0" *) 
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
        .SSET(SSET));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_TYPE = "0" *) (* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "1" *) 
(* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "1" *) (* C_OUT_WIDTH = "16" *) 
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
  wire SSET;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "1" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* c_add_mode = "0" *) 
  (* c_b_type = "0" *) 
  (* c_b_width = "16" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "0" *) 
  (* c_latency = "1" *) 
  (* c_out_width = "16" *) 
  (* c_scale = "0" *) 
  (* c_verbosity = "0" *) 
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
        .SSET(SSET));
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
ksk5GVvmNhGDyFC9Ge3BtqTJlI64GeMRX7sygHF6pQ9+XkMjd6Qz7JG/R752RktAupKJYtgIeqPR
Xe0BqeRmd6wekc4HfV9JIm+yuWGV7rRscYmMqR9N1tO5j6JlmHUALKTakJHfixHJ5VpxbtEDPJP3
iQMO75VnH6ryvnMi3eI3ERchnt6MMZdnqpIppsG29351BCBA5OdjX9S7J401+hC/SUia24S4KGbp
KKqD02ZZB+642ZUgkTuGowkZYYonn3yxmOGuK02osIKFlcva+uvzZ774hSIYOZ56msM4t/Fz/og4
evhHQ+H+3Ao5vqQKXS4KZ2XBZGjmy02BIiyPQw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
EdzttZJwNil5n4wGKnRQubBQrGBEuye1Of+eCbEu0QCAnZMICXcB9Fkf8+oNA7oAZM+jhRC4506R
Cga37cGLwxEvcSOjWRK9cJQ2GADcrZupb9qYXPjYF5p5WIeiEeM70hMQC0/MIJAcJ04s+NguCz6Q
abbjhO6jiO7MB7IJdKXyeGs117/FgB17+LDG5TwIdMXazEqrXlzjW90FBwy660U49SooVlTnsdQg
kuLsenXvm7HIglkLZG68lRvbH4y40fnzTICRaRuvpgEs4hgm3u40leh+s1mmeUuk32SXs3f5BzaW
oV1sXtObUcNPZIheftdTj6y7dea+D0wG5PESCA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20912)
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
