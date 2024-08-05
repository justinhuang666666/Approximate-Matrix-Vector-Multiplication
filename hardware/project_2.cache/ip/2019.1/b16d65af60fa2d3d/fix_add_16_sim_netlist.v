// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May 18 13:16:32 2024
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
(* C_A_WIDTH = "32" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "0" *) (* C_B_VALUE = "00000000000000000000000000000000" *) 
(* C_B_WIDTH = "32" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) 
(* C_OUT_WIDTH = "32" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
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
pyh6iRMddlb7g4XYDz8sy4ee2LFFLi3EWg==
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
