// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 18:47:52 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/project_2/project_2.srcs/sources_1/ip/fix_acc_16_sset/fix_acc_16_sset_sim_netlist.v
// Design      : fix_acc_16_sset
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_acc_16_sset,c_accum_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_accum_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module fix_acc_16_sset
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
  fix_acc_16_sset_c_accum_v12_0_13 U0
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
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynquplus" *) (* ORIG_REF_NAME = "c_accum_v12_0_13" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module fix_acc_16_sset_c_accum_v12_0_13
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
  fix_acc_16_sset_c_accum_v12_0_13_viv i_synth
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
UHQAJ9VtCImE8zF1eeB8sXyEthoHtdMYuEZqqnqCn0RjFwfhBzCk59I9MF7kd5chW6vVTLN+GlIG
Z2G4b9NZJhPoeKaRB1wgl6xXrXHtHXwa/kFnB9Bf8CTxKFiNx7u1pooeCLZeHSwEZ27mgcS9n3yv
eu0Jx3AgsckvWFfunZKKt5r0cf3N6vFxTsyuiWU/uWAGfUobheuaGHVBkoVJ7/CFT8jeg4sWUO6l
WztMO6kHNPGaCnWYWMU2EoyH+PU2OqXJNYZOPn9HhFGAf89o9T8zV5N9eA3vzgkzDEiB3Ol580L5
RdS8yNFKGaPCVx6XUQJ2+pl0Oh0RLt41THchsg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mjmjsKDX7+yTuSG3JEe+wtZy5dlvbFXEd0a4AM+vnzORoYcoIHHrr6TsL+Vnm6nxW1G3qSCk/JrE
7WUCopOG+UrUqq7csf9JmzjEzPdOSNspYZ2Q1dvFV8Vm4X7tPsO0jB4Wu2LXHkHoLanJDJoMc+eN
lv6gUTATYUDJr4a7Tvmu4eDS0jE/77Ns5t3F9toRJnkOvgvoC4ORE99QlC2ntw7zCPg7+UYm+WEL
Ne7XrELI6cRMe5HtGS+qb0GfsD/6pSFZcD8GvqOnjvzBAaQNGw2HkYWYj5hnCvLcpuSiDbHqF3B2
1/MH3WfCTMQ0eY1zLH89Y31WXETs2Jb2NZ7oWw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20928)
`pragma protect data_block
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
xqR5JawNVK6K
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
