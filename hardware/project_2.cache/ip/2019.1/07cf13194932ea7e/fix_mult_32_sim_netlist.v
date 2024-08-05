// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu May 30 15:19:27 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fix_mult_32_sim_netlist.v
// Design      : fix_mult_32
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_mult_32,mult_gen_v12_0_15,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_15,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    A,
    B,
    CE,
    SCLR,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [31:0]B;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

  wire [31:0]A;
  wire [31:0]B;
  wire CE;
  wire CLK;
  wire [31:0]P;
  wire SCLR;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "59" *) 
  (* C_OUT_LOW = "28" *) 
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

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "32" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "3" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "59" *) 
(* C_OUT_LOW = "28" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
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
  input [31:0]A;
  input [31:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [31:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [31:0]A;
  wire [31:0]B;
  wire CE;
  wire CLK;
  wire [31:0]P;
  wire [47:0]PCASC;
  wire SCLR;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "59" *) 
  (* C_OUT_LOW = "28" *) 
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
        .PCASC(PCASC),
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
UryaTKqZ3iikbhQobxhtmafOCFrgNlCwmlUlzi6sTQXcTkn/95xccp+rNmSbOEWqaPl6ChFJdmmV
4NzEnOGGaUhbAfcPV/DsDMSup7OhgazO1uFTd9oR7IBCHpm4jP9jCrwr9zymYzknviBFycG2aGxu
Z/XVoj87wpeHc+5mb5h6ozNFz3oU53Kvc5xyAuTfg7BPrC0a2/gFENygf+8yFlMaWYD8ip5YeqIp
EI07w4nPjO7ACIjrANMulSbgRPAbXgcZ0Hyb2EmMn35RD0ieMCpO/0NMQrCNk0l4MnJCQl9gZFYx
wPKwEassiElR2VdY/Y09TNRj5vNRYDtI+H6U/g==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
z5lrjq1l7uPmRWO7VYEVUHG0ofymr3cZVXoQM2ejJvXB2+xZOS4lokh2XJ9Xzm1W/90nQSInEKg+
/Xvg/6MHgHZihqrcQfptO0xZsrWByrUNmKvhraDfEPCYEMqkaaK0XtdS1WMbYCWnymI+/Ai3UQzS
HiYMfrpqHdeU9a3QrktoVLczXVJFcK+Gw6ZWjH9RKiluo/WjiJT5X8wrfcpqU3yR/hLkASRnWeEN
IiL+mxuN0Sm+LyVy7SraZoWbKMXNXDHlBXbvB6wGLUKyzI8XEuiTrp4Zlhz3WyRHtTBi+vX6hjh7
cO612Ia6gXjMV2hZDp0XqQbzqCc7Zi7tNOuLGw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 24576)
`pragma protect data_block
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
6PlEf0s2jnyi
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
