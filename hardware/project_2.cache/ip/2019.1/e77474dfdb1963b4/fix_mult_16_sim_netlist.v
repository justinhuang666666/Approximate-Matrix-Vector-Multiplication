// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 13:35:12 2024
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
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [31:0]P;
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
  (* C_OUT_HIGH = "31" *) 
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
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "31" *) 
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
  output [31:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [15:0]A;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [31:0]P;
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
  (* C_OUT_HIGH = "31" *) 
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
CqTXnOjfKMFMr+RucJ0cgwQ8lUEfFjc+QgrtQhtjwJuy6R7lnxyYa2RYmK8fycyD7JpgCsgsdjkW
p8r6H3Z7LDrIODvSW5uAQQLuVLB6mBfuFNPHdrlVNqva/vwxHNe+ofAaNcC79TCj5xBNv+Lr+64P
3M93wobDLnlS72YPniG+jQ6Aw5fzL6iXUHd28Br74DVfn5DOr6eAo+tUVyxroE1klZ5WrJfgQO98
JuQXfat02DO/HIlvHF94yEd9WZF+JYeTGUi5kZu7o5ko8lfw4Ch86J33qbQb3Kp9gYgWili1HfdT
uKsWFFCJnwcIk7I7eHK7Zd9LXZy7fmwnBtI+fw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RJATQDEfoNSHR5G6wQyVk4fpx/ziFEBBvu37rZQnqVcDXhlPtGdufnwCmzkXOfDvchjikA0ZEnjr
FE2K7iaEDWbBk60zK4vvFvTR6qOQn8aPFMTuAuIE6GmgExmAb1CFpXb5EpYCbf+38IdlVSVutItk
UXQbVvqvUsfD3goIKHcjJVAJ07HxTWfIcj3ELKlkf9ILS42OHNVQHZh/7W5N8UHpF9e7cjFqTWpy
56kVK4onUdkuivJ/4gmjcift0X1Ei10ya3wy92NxHZJ2rWoKUiDloqc6PWMSCK7bogkhYmz1/4XT
KRzff7W14QpuxCOXZYjzFxn7IJlDM+KTt9XFvg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7664)
`pragma protect data_block
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
L7/2aj+WsAjxnGJV1AYAtFEmrVHZcgqbYLs=
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
