// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May 18 13:16:32 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top fix_add_32 -prefix
//               fix_add_32_ fix_add_16_sim_netlist.v
// Design      : fix_add_16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_add_16,c_addsub_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module fix_add_32
   (A,
    B,
    CLK,
    CE,
    SCLR,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [31:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF s_intf:c_out_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME s_intf, LAYERED_METADATA undef" *) output [31:0]S;

  wire [31:0]A;
  wire [31:0]B;
  wire CE;
  wire CLK;
  wire [31:0]S;
  wire SCLR;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "00000000000000000000000000000000" *) 
  (* C_B_WIDTH = "32" *) 
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
  (* C_OUT_WIDTH = "32" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fix_add_32_c_addsub_v12_0_13 U0
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
(* C_A_WIDTH = "32" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "0" *) (* C_B_VALUE = "00000000000000000000000000000000" *) 
(* C_B_WIDTH = "32" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) 
(* C_OUT_WIDTH = "32" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynquplus" *) (* downgradeipidentifiedwarnings = "yes" *) 
module fix_add_32_c_addsub_v12_0_13
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
  input [31:0]A;
  input [31:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [31:0]S;

  wire \<const0> ;
  wire [31:0]A;
  wire ADD;
  wire [31:0]B;
  wire CE;
  wire CLK;
  wire [31:0]S;
  wire SCLR;
  wire NLW_xst_addsub_C_OUT_UNCONNECTED;

  assign C_OUT = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "00000000000000000000000000000000" *) 
  (* C_B_WIDTH = "32" *) 
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
  (* C_OUT_WIDTH = "32" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fix_add_32_c_addsub_v12_0_13_viv xst_addsub
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
hSzjseD0RL+/JdtCPIWEnQWszz9Wq+6OdMQQX2ldzRfS4AkbmO3ORaQWAJ565f1Wufg1KplT0n5I
6pNwP2HQeaNnrFgUeYo/CdGl3EtZ8ars7NmRa2T01UultB87Bp+yMxNDE3Dpwpwj/cSVQb0JFAXn
XCPZen+plz3N0+eHz9RO9zKA/XUV/PO6/hRoKw6dN+iTX4+z59XBew7o6uDwKx/z79nabZf4SsXQ
Cue8szHR7SxCbd3xGeUYUVAcB93CNF/J3Q6rl0FLL+ywIPv4XiRFIeKKzBRsV9S4/ziQeZ1WWtjR
MIDmuDbVFlUi/gbf8a6H6L+TMrzb3fESw+DCzA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vCzLvEwdaijLKnKugqGI3M3fUJKUIMYrUqRHOXvw+vfUBB6gE2+Fq39htbCybEs+k+ZJ/dt/QbES
Wu+gmu30EhKH5L3nri8hfjJMkY/e23ydqP9eGWr5mINtgX2aVibNDOXOZ4/GqEb75R2l82eoI2/M
qmML/vIbSlpPEUg5HIDn2/5eA3mBAEVbDH0dFr3sdx5D3mQTq+HVWljMzmgPSXEF8As4J3/7l1cM
XkOkCByloLQY1dPogTdKvGwm3827IM7RRPP5DepgPv3PqijW+kiGKqSCh+3EV+BM8n2LA+uDge4a
WHKmxj/wFKOw3oLcJs1fmW2DgktBdfbV4Rs9Dw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 12736)
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
