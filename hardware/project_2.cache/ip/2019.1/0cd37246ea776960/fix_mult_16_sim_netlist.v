// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 12:52:09 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fix_mult_16_sim_netlist.v
// Design      : fix_mult_16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_mult_16,mult_gen_v12_0_15,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_15,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    A,
    B,
    CE,
    SCLR,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [16:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [16:0]P;
  wire SCLR;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "16" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_15 U0
       (.A(A),
        .B(B),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(SCLR),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "16" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "16" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "3" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "16" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynquplus" *) (* downgradeipidentifiedwarnings = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_15
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [15:0]A;
  input [15:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [16:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [15:0]A;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [16:0]P;
  wire SCLR;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "16" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_15_viv i_mult
       (.A(A),
        .B(B),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(SCLR),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
KGg++J83s0yJ7o2/XMVLkRRTRjS0oC9h86tQjl1+xE1m53Uwmm0+K41skiYHo3Urr6lMQ4q2jL5Y
R/1NOu1WGg==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jCBx8aLaNWpgdwu0tsffQfmLNKET4Uy44Upxw9AlkO9Ma9Y+tqZHrHroYhGJUxa/dyJZ7Z0HDJ1t
hUhVV6SjuhVMs1NLM1MVw9F3MTSW7MB/qx7j0WAj62FJgoxsCtt6g392p1JAAosX8yACeLKiQ0KF
mnMpugzqSRDI445k7So=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
zdO8kU0uCj5Mggk0oLUcYcllNQJVD7vxIj25evesPPwBvXuv6EUsbKmUaCAlFUyG0YQ0mxWxXmzV
V/dRqKxqZ1ZI8+mX4IFaTJSCcYctMZsCl+2EWvQQHakV4QzWuCyca1phNacrRJfur8Ssc/Mhbez3
GLQCRrSfyBYyi3u9J+SAJRcJapyB1syXXhclDtup6m1z2C5S+NX/ql6kVXkcd9P+C5ordunfutgU
6uco8UymF/9QFYiBCWlTkHAgd7DH3dCI1E72N2H/KpX0/0xFBk++NCVuNucOwd9h4/hAyr4L+SI0
6Dzmn6kaBO4lnMAj5P58GIeWO/EtqrPeWg4UJw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FdbUT4bIXyyFULrG0eEn0kqX6tjVoWssNb1FURO5jvyN5IkvkkDKCSLsd4J+2RE35ttJ20+4IZm2
p3H/UGCxkuCYtlZzovVpVf93DlhFUM2iSGd/L3evdLLL8VYETZTScGFdFXqiqe4ggXPHQCSEPD+e
PmMIJTGQka0DD3H+w+9t5Po/+M8b4r1y70l3Py7aYMeCEsZ/yHRmk8szsOjUbwvFEJk8SPXrEERg
EYMIrbryPHXq5E2fCL7hTgHa+bzIdFQOc2/8wn8YMVTmIJCZLBZDXvGSSm16cifWzXKHbPSly8js
RAoD2yYva4rr9cUy8jEyEpUcPGnaJXBDnB7lsQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
eGYl/A3vBqVYodgklvBXVlduDkQKDOe941//b/7D71XaDbW1Cqv7m5eqy+I7bUTyBfnKRV6WeTtg
K2eZlSMADPLNGmIEawb1T81kHA95L4SgxCaMDbzt0t5pO+IQTca0KxjvPFPjj860AZ/Y4IJCgD9Z
vZNfcSeez7bqGB9kVNzxh40hdeBm7XY8a+5R/yPufF2S8KSSaiPSvYwD8yXOBzVoRhqA9q5PWKTd
u6qoeWMnQ1r/hIDsge5oDE06b6+zC7odC460K8KIOtKzeCrfWezkynmD7wBR1fdIwh9FGe2Uq4lO
ZbT2QFx8Ga5NQIwIIZZci/uL4Tw/7+CPKEoddw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
k1GN+kT7KgRIHJs5Cw+hQb7EZrReCsvXgXeCjz4o0RyqpPm8XlxoPCNX4kR8BSaVxBTPm8qGrOj8
IkQcLP4XpLGNjMzOE8knGvgjraCBhhY/bboSihIYbJYXuKW0k/ErxcqbMup3dsmp8N5M+ZYpiEuF
88HraBjchDshDh5xlcY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jzBUDUoUQBD0tzi9B/VXNwpoyjUIKBzxkVyikkxc/QHKpaIlgud+eCQD6psG9RUWZouQN8CQmJEY
0K5qgvfm7GxXMbjLUwnVBRg4Uzfc4OTySfJMu1k9/qGISvYwf4r0rzMMp9aPgp+ElEwTGx3z9N0A
vWNdEjCI2mqdxmP3Q9AYUPTudILppELRMP4SJijczuRIhtAKpxFjTP2gL8zQE0aq1kkWRZfaHW1t
wV7tZ/jCUxkX8uj8DL6Bei6oBC1nTm/FjPhi+htKla8XNUEftaqUre2/0Sxhsxl/FTAzaex9fCj4
AMt2l6o0FpW5JlLhGnTYhWm/bgsyGCPBg6lSjQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ApY6Auf8hvLJqij81TpNNkHmtNBWVdFqOKG52S2Voa6djk+zrly49tuc5gVwhWYzaSWbCV21tYXH
j32g0gN3PWMjhUapRGwrXa6jJxPeJQDiTfz8CeK+iz+RSWiTUhMRvda4iNAjvmq2vjJHr7G7VQzv
zAADUJ8MFo5nHQsHXzEOlZWNwzAbH0ClO977CygNAnNK6491pHkTZsPzOM7EkKFfPD7e0yU26zDI
8JeGD9vZZ9mNtSWFMQScpe3nwPoQ/CDKGGOmVuGMDeALdKmd15vd/84KXGvINM4G7/N8/9KH2c7i
UDYR4j1z3iWVC1iyIeVqEswDf16j8xHOot4X3w==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
q3nr6hW9j1hzIxQ/hOQk/wyFmWoA4WopJSCLtRiq/vWEwtFmt8NUHV8CqIXqMo/kWnLTd0C9SwRR
pUTCkUL9RA7idh7IFx69TCDXPXdh5pJ56mZHRluH3WsPZ4oukuWtn2J62xqTpH6P+Y3Q+L5y0uKW
sLhXXddbaj9kcbwOHKeDgh7h4xe70+LP1vtXuVMRYlDlI0AjXcEXUkzCpTVxdze8mVbTgq9z00jM
NnMgx4butkgmSQPGCCafBcfvJum/rBosWpc7RbLHgDAKgIAYJJitJoXlIgZ1pDB4MRtqEYxYmIZa
ZvG8U+jQixe+rNoiAkqxkZQmrlxyb7C5ugvEjQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7664)
`pragma protect data_block
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
cqG4bvSB7ijHH2poV6a8ckhBgyYthZkbTU8=
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
