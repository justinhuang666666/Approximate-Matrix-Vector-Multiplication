// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May 18 13:17:53 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/project_2/project_2.srcs/sources_1/ip/fix_mult_16/fix_mult_16_sim_netlist.v
// Design      : fix_mult_16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_mult_16,mult_gen_v12_0_15,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_15,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module fix_mult_16
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
  fix_mult_16_mult_gen_v12_0_15 U0
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
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynquplus" *) (* ORIG_REF_NAME = "mult_gen_v12_0_15" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module fix_mult_16_mult_gen_v12_0_15
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
  fix_mult_16_mult_gen_v12_0_15_viv i_mult
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
b98n2YvFFuSsL+zIacX62uw06YP0Y9JSUNp2wL9I9PHKLZVjQiqBVRogap1IxU5f7gy0eVOzom51
HzjRI1ytgGGZFTA5dm1mtQHpb0NJckIACs88YUcSF9MmUE80saRtV7zH1Ggc9mJD+P937iUSrMYy
9398SjTIET6SPf5cbGK1oViGDg/BoR6+z0AVZApcH57+lHUTR/+yxfxKsnuNaWTVZ1kr0DU8QnWm
259Yj9LG/pCp8VmHIYLtCsfQLrjD+2XoYAZ2EDgQv5kDMLTx9s69hcwDSO1Wo+eZxWcThRebkzW1
tjeNSiQJAcg4vplGQR0qXtND3MuZ9s+VJf4o3A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dMNGko89jaZeiHW3D4Zt7ysQMcKfRHFOAz3GcrBFcH6Js1Nk2zlpqKeIdbBvHACZUY1b1PrOhqEa
SYB0sxtQ68vEQY50FTSHhrFKukaTSzHESdrqWXnJIEmpxf8rfr3TIvV3C3dJEVMzrE3ouURCZicC
DSNcRn/+4P+fhfyXbdktvx6qsjhpN5O36xnNcgE2wmPJJFWP+PDE/lJZwS6ZrsYJonjzMZsLhUtk
MIvGD4QOMBHjZUcDKbwhSJgbh1T1NDtYk5Zy9JnHg0QAQf1yEOCG3GAe/fVmB7mYWjpjs1HulQto
rda+44kAeCZzEYjnz5elJ+aNBpsJSz6vKpuktQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27488)
`pragma protect data_block
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
He8Ir75Dhvvd9UohGrk=
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
