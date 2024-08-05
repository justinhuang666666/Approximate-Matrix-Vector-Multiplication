// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 12:01:30 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top fix_add_16 -prefix
//               fix_add_16_ fix_add_16_sim_netlist.v
// Design      : fix_add_16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_add_16,c_addsub_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module fix_add_16
   (A,
    B,
    CLK,
    CE,
    SCLR,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF s_intf:c_out_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME s_intf, LAYERED_METADATA undef" *) output [15:0]S;

  wire [15:0]A;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [15:0]S;
  wire SCLR;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "0000000000000000" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "16" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fix_add_16_c_addsub_v12_0_13 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(CE),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_A_TYPE = "0" *) 
(* C_A_WIDTH = "16" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "0" *) (* C_B_VALUE = "0000000000000000" *) 
(* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) 
(* C_OUT_WIDTH = "16" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynquplus" *) (* downgradeipidentifiedwarnings = "yes" *) 
module fix_add_16_c_addsub_v12_0_13
   (A,
    B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    C_OUT,
    S);
  input [15:0]A;
  input [15:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [15:0]S;

  wire \<const0> ;
  wire [15:0]A;
  wire ADD;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [15:0]S;
  wire SCLR;
  wire NLW_xst_addsub_C_OUT_UNCONNECTED;

  assign C_OUT = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "0000000000000000" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "16" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fix_add_16_c_addsub_v12_0_13_viv xst_addsub
       (.A(A),
        .ADD(ADD),
        .B(B),
        .BYPASS(1'b0),
        .CE(CE),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_xst_addsub_C_OUT_UNCONNECTED),
        .S(S),
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
hkYW+OZm6k9gF5yAUfXGm/n8kfXYD6tjFQYha968Ws0SqrM/NNAjCrrtMG8kIqTbkipnmceefxNr
sB0PtSpUrw==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
NEPpD4CxNBVJLV3hg1agn83QnqiCz3YuR89MlVuNyQGERKVJ+uGolFDqHFzBKLQArFTiHBWivkzK
A2DQ42XdOxp30NKOgHjrjgmF+fZMjDs24rn3Ue1INLHwTS5RT84Kih7Jx/7R0dl03/COJq+33l9u
7l+ArdY7mLwqqI9iIjU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cfBwEwc95LpKuxDGqpON2gGac620iHNKrm/QNXYg3/OFA5ZQNdpdhRz4vCTQRVbOg7b1nIox6GR8
TD/cf0JW38RU0NuY+TR6CkFT19NCdy67gR6JTDdXifhr/zTKjOL5gvp0XjT9PSLwwPyDirNX4TMa
9y9X5pf4gEnt0dikHNgySZO+Qpr30MP7n6oAjuxowlf45cfmPqZthYPnIjBSCdQGBPfSF+kZ2F1N
XCDEja5xE4CQshPPodH5njadc6kj7/qp9C4PfKcyNtDug+qsws9UK25Z2IFc8vk6/15HlIkQHkXv
Wq0iHaPLidqh3035FinHyPD/FDnfGGa5Oa2qcg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QmjD3HAHcP+h0RsjR0iH8h2N6drNxei50nfQN9RC8HobMEaARq/6rKjZEhHXMSCStQeCMhyVKRmN
HM7ZrqMf3W0s/8U4QMqp3M1VuYXVjEe2PCIpvtRcMY3JngdSWOydG2dH6dDA16ehxinMKgIr0TjA
PXA+lfyX6yTs1FWrne/6ufrl6ZAPpNG7EDKQ2aHqSm8DEXT1BJYMblBfAjAajwaJmPEu1aDlQeNo
onryTiFJkKP92pcZLCCufZL8ZAJ5uMvZZxiZRsiLd0BnCfOe3rl9AON+q53U+iK11EvAkpIBT+Cc
VYb5NqVAVaqXbQrqo3+YHEW5ft3fM9kZnlFDew==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FkHW107swc8fPv4xOTlQJU6PWERObturlywl6rsGCswc/v367bmQ1Maze/8QdmUPjEYwhAcHKVMu
7U4o3CvYhmrDpYiUQdQQ0B7gAbMZbJ8MFY5jRxn7KYDk+Bi9Ov8092IdW1a51FPWEVPmF4Kn6z4E
DSqpQDL58qieEUnrU2Ltb4GLJc3NrWTLvnbvRtHUUuQWTMZTQ7WqX4iH2dZ/EICpbRjlAF50iMAS
YHuuFTRKXcIFQlKYRyeQV4nyaA5JGbb3RC3N/Q2IZjdSXqQ9EOpmdhttpxReCnsdJiD/pPCtf7ZN
d/TheLy1Va2FZR+p4MozZorVui5/FtcCwKy6aw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
NgZm/7Jvy0UZQRVxBVxeZ/odxMd59IlnRFHjM+6Bof6o6u4Qy4u9MOoQ3Sr2paPuGq+B+5EhdcD8
a5WGiurBrPW0qF+L2CoUJsDqz0WonRehZECQynibSUlmctvvMyr790pwb+C78gtW47p8uALYdUCJ
NhcDkV8fE3jFdDEYmfQ=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TxQNdd2WOThZCBZEYNgXxai4jK9AqWD/GRadYnarEfzmLUfcNDUoG7DxVWHCdTVuW8i2qZpouT1H
FUHt76rzZk8vI2tFLfUbKyTaRqik1aYwOCp1ZdqbgqQEDhBRWJjGxcJuxZbSQ2z8IUgiJ0eT148+
nf9UmzvYS1jrIsN/a7K4EjyRNMk0V917y85rxdk7itlisaUw4Cm72z9slByFtALj6/077uPjcK9U
mbWm7PbXk8PT44eQeaJl990wlWvD5/8BZS6AHqjg8520Xs+jftSeB6aNqTiYxfp21FJqmexwo7cG
G3BH/DRHhP7ZIsXHqSaJJFo20Nx9VgpLuF5t2g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FYS0LN2WETfvigtEzY/+ngPZEtd782C12BhC07ZINmuS8TMDn5sA4ugIKIpMI9ogjUMFpKkaPpJU
8tx3+D5G4lYJLlVF/VVmihHWvhjKpptiRZuf0Jb39FhdmmpC3oYlkv4jIoWFtwoCcSao0DR8NWda
dhBiGNQSlgdy3WQmqBX2xbS5MsDGxmtPAed3Sy4+vRgPGPgonJdgTBxfaQk/zQb6rjWMFepv8umC
gTNkGOEUFJ0U8B8MmZl/EWsT/q5wWimu+UNYQfGjEKZeOCuB0QpFgaHoM6BT8tf5XchKkhkyvFI0
CrUVUKPoFkGITdHYvV1M44qNtoN8fy6uXJG32g==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
WK7H7xIdAqf8W8jmhJ/JRCNTdnyXI/oXBRhVfIgCE8cDORO1h+MTlLkDDhP7MkgWVyl/iXjZQpC3
Sen9t/cGmA1k5fEVLzLhbPH5dShp88PmWR3lAXNS5P4V1fJZOMtLeyz98I+aoyV9kYrTnXxzdH4N
tAlwmcX8O/fmTQ+DwgCV/BuglQI1S+H0tyqHFaYzWELSG3qPqgdO10+oA7GbLp4BRbiNM72PD0Cd
d++OHIDzfgW1KIvrR2k0h53A5GihnGIBExZxUZmEMKFGfgCV9uYuItEmXL6lYw4Ic0p612iDln4Y
q2RfjGkXWP3cJi3GEQSC7AyjiRQEiHgyliPriw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 13584)
`pragma protect data_block
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
nCnc/yiZTsw=
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
