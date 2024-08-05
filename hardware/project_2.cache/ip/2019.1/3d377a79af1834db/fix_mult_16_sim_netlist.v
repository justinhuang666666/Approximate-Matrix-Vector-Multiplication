// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 13:30:38 2024
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
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [15:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [15:0]P;
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
  (* C_OUT_HIGH = "15" *) 
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
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "15" *) 
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
  output [15:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [15:0]A;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [15:0]P;
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
  (* C_OUT_HIGH = "15" *) 
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
PS4l9v5wG39uGt1jwvWYGyNhkwQIkx3KYS/OXJ3oOoLE60Ns4jdklNNNtoGllIL67RYmFhFVUwI7
WIdQaJP7h8vYLfjJ2CzzUsNmDqyFn1ud47RCpbWj7u2yOg5wOtqk1/zif7mbF2wDlfolABorX5nk
cV0YqdXHpvS+W1Tw1nnmqJLAlMUFoFlFIckz2A/zlhHm+Wesc6S4VMCtWz9sdh2EGjxLULj9LDIn
YEJk/hmcm1x6+U6+pdx8agw+HUwLo6ApsZp/GE0OJAy6TBDpPOhgRU6nB0ipXcBIyNVbGN5Qiguz
UKxzLF3h5kCv4qhUdLKGWt424RvywEN8oXgf8A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vA68tk4SU4l2vyO2YgjRZ2YEQlKtAX9P8Ex5DWPlLJdvBJv6esJVznAd0KZcq/WAtuPPdXP5LIGQ
QANnmjG+flscn0M6M9fikpbfaixDqRjRqEOOoLldQwdO+o76UA2R3O12z06mzSPEW842Ub4r3YLf
GWfSfbUwKFVOMV1eXZfv2uZBeb54auqvRSXZOtLQIl5Z7G5ztYfRYdqxpLqPJX6D+uW/7r/yH/wc
yKDFhpGkhhG9BdsZH/ODFWUHNcA6y+lnV5BETi2uZFKGpCuI+z9VoefvtAQZepE+pRrl/J1w91dc
jpIH8+Kck3UE1qOAvENI+ozH2CcalLwDt+EB1A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7664)
`pragma protect data_block
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
A+YeWjvdmkaLnLUZCQqXGebwxVWegyT8NFE=
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
