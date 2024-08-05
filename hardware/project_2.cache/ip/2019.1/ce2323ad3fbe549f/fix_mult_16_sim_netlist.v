// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May 18 13:17:52 2024
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
  (* C_OUT_HIGH = "44" *) 
  (* C_OUT_LOW = "13" *) 
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
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "44" *) 
(* C_OUT_LOW = "13" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
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
  (* C_OUT_HIGH = "44" *) 
  (* C_OUT_LOW = "13" *) 
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
C5qHoEPFln3i+ANTrQo7UxLDvTkPGekSQcAU14uzGwagsWT2/7NGeMACqAbGuMhy5qr9IgQm6+wD
NpB+cNY2uKeb6jkzrFSWC3EgG5/oemi+DZ906qJ0qTudeTC8Y/4B08dbD9roFgO1S8/i3hRXFEHm
M9HaAvhEoPvIkDJepA9jz9bWlQrzafn6HEVED+Bui3TD0ybbAuNgl5cwRmOL0Xaa4MNeTA95d4Nq
OEM4iXmWqJ1ZEIdZ+DItnMSQU2uV2HTVWW+UonHXCNxQ1H8bMJn9KF5GShJpphhxl0VVFIimGVlE
JjOWMHT0go+nr9pLN476ofm9cq5HOoTAC7MNMQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
gHGB0UF1OirQZSnYBp1xk311giC/y8YEun+kCnlSkbw/gjZG4ej1xQxDkftUDnWyJ5NIPzIfhHN2
oJ5kxDx/+rH8aFMBiEwgkSBJeWNCk/L2WJlGwhF+gyLH7AvlEXthyBQgYwGl85u3+NRpBlj5FPhZ
ZDwDeHJMVmf/hC6ZwwYNKYSz2EF6kAEFV02Xv1SfUohg6BqTm9+73CMPC4SmqOSwKH2yONg46/Dc
1dyE3CQzErO7wYonTE3yjPtQZ7QWj83cgJbHgCEPAVwtySnCgNgOc4cuDnjh+9fN9XRUolEynxIL
ClTMbQDNblipeh+jo0VvcPQMYHlYP/o7cYrjWg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27616)
`pragma protect data_block
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
0QxjMlA6LQit4kQ3go8NJYcFKf/03BtBJKrOWg==
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
