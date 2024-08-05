// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 12:01:30 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fix_add_16_sim_netlist.v
// Design      : fix_add_16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_add_16,c_addsub_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_addsub_v12_0_13 U0
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
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_addsub_v12_0_13
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_addsub_v12_0_13_viv xst_addsub
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
BFk2XLx0gbeT1f4rzqY7uPOX
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
