// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 13:39:51 2024
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
  (* C_OUT_HIGH = "28" *) 
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

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "16" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "16" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "3" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "28" *) 
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
  (* C_OUT_HIGH = "28" *) 
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
D94zk1hW8hUnoNWGSZWchawIziDZjDdsRVWlaLg/3fjK6OmHFvYUNaNd/6xD7zRrpk3uqDJz21m/
58aMFmfF5CGQkYkagyxPMSoDUtHM1c91NXuHRK5fZXottvc2gYuR4KUOHAwYfYWTRNLGvrWnP9Jc
N0sD8Clp2oEXdqZVa/qnoUytoXtmYaOeTJxuqW3yhUIC/Ny5BLbKwGCvSSqsDL6SyopEC3qaqcmQ
fePnU0RJo5SSFv+VLvITENGqX37Xqnkq1lSlyUSbCgys2sukJ+IGTmVW60lZOfN8CyzaUTAOVzJ2
Tng9aG61fSvWLWs7m7X4FBZTroSkWXpLYvMb9w==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
IyYp/oaEThtY1aRxJAgX1JhaYuWK1mgxJpqxelBmekDRWJjvO6BVE1wYNaJzjJBKWAI3C/aKGX6P
rVrCFeewyMS5NNNzVySBiTgcn2a6pE+iRI/SM5wxgV8XcG6goODGyymQkc/YK8RvFIEk2R91f1qH
HybTPjx4GHw/5uvCHSSnv9Xeqva0Nn8PsU14i9O3RpOFCoyLFQMJRJuscpbzpeXK9OfaIeECou4d
Wb1GyVP7X6qqY2ZW55Pox6iLLvjPm+2o4INsh8jQ9ef60l1EnaK91+XRShL1isSn52X9vhL72iuU
9+x7pnyASu6JWv/CpiOky8b3xqZuUjsuYJIL3A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 8832)
`pragma protect data_block
0VJqq7oovoPKlps7Kp8/yhFlnVwmFCPncBp6zHTbZ6sKr6dBZk89yBESUiU4YYZdmzsGl+LY/7r8
zSEs2kFjfYHjTjTZhleBMEe3TWN9EHt5TLVTijE+EBX4nEsimkF9WCkq0ukeofXluJQPzDnzmE1c
oSEevhjE2YVfwHzvd91XAVXGizTQZNaSJ3KY5KrMZk82+MBarwwry1pLgDXJlGaIeUAxHvj+T3jT
vYCrj3yhkk4VSGxA836K1ScT+tGBDSlWEsuHgWoaB+N5ZAHprKaPrVnPMDyRB2grCTVgFIAYlqB+
CLZLbL+I8XTN0NWxfqBb77kMLoWqJ/qvcp/j3rc5i5cVGTDK1HbNnjDVikOenHkgnZ6yXJcORE7q
S2pTI3kOwYEpDGddfrqgzveQvovKe8IKm/OUSF7ZrdnHLSuVLtRC7aRsxciyGwUfxaJAtLqaDaZl
TMbYs8s/HdaCuUjUmbGxbXAgKhAx+x2GW7TkvvqtkUtcxkHkB8STyOS8nidhy0zgEdeXtsJHxsvm
RicH9I2vcik9v9nlOj/KlBljPQfKeMZ8/DF0e/UgZM8+9yfg/xhqvkI+m3v+EaXCj7PIg3T42zNJ
YPACBLyMVvLnbhU1zfFAkITyFfEZ1TLhLtGES/qTpchAt1iX2rRlcLUIrCqNnD4bUsAsziMpi65/
M4Lhgf3OXRjPuhC2O2XK8bw3xNATk7Rt7q6COWZ9BVgtx4PBPTSNVSqfjRQNEZwORjzwfObjJDpB
pCLPS7cHRzkw0b5eNQeOvz4nvl1En3UYOw55qhOJuQb46kzdwE7tvw20hmp+EYXPfV6fsrbu5eef
tj/9CwNtxSnjKhrVsonI314uAg5TwH6IidxNUgqW9elyN/txYHfPE+kuP5D1ZlKBjHnTHyTuWRG4
FYctUKFhc5cmNTZl4cUhGa1nY3pU02/j6y2H2uJDfP8PuvH6AGAq5UUDwaD9WP/1zWNH0Su9LNXs
BoteUeSffSVtV63vZ90gx9pDb+h7kuA5TCYS3K63DqfywerP+G1RuD1lRT/+LNbBrxcI9WkQ+Ii8
zASH/kXDPYKDVDlmBL3nUgMWyVVaMO2iNWKCfL2AzMZ+eNPKzeu67d3Ei6bk/lnnJ+vbQBPWjaG2
UKRjVQbxF/9Q4wX2Bf4OTS2TJD2eeG0wWPwgLzpGTZYUgyTmmPgJBpAEVk1Ims44FMAgnUiLcIxC
WDfVMvAqo+aIU1239iJuFtmE75pwiSFHv3XDzdJTAVfE18UpWcpt4KzzuC9CvYKyBYLrz4lCfJsT
igU9JvJCGdIFg9s9bC8E3XJi0ZczFSYQeC30d4sjDmcBI6TwzHs54d/u4nOc+eAW4dyjB0OCKmxZ
b3yEvGzO755F+E4MvsSmY7A+jhaq7C0VO0Eg9SvVDZB8kFp/T0FBixGc7YUvcFBG/VJZy+IE1IIs
RDm2WCab9G33rtIUHAJ0CT1DaDnMnbq4MCB1q1Jd4PoovZDEqu96HlAnazNRMoTgFCjiqzWxf9y2
U6aDufgWDm64U61zjgkge6w6EOegfF3xeznBWIbRUkZDyYt+sGz65sgUzy4g8WDgshbGFAKKCQCw
UQ/fRWTUVc9j3FK46DZXUT+VV1J79uYcR1MszfHT4tZtUdta+EBB6HxAQraRJmfTTOJwZ16bqX5f
g9D82nT/0DkgRUjzz1ElOVxh9zb6BgUCGemuqha8IELvLK6x0uV+nnAD3MR5crCyd+P/R/hUq2vD
IpdoJ1fa7iik4bCAmLbXaAxgIC9LwO7Ftkpc4b5Ji/qdi1C6yMzPyDNUgsoPlCTZvcLOdf6+Qg8p
I9bToAuvHWT/XJvOuySX+3uDEg2MUouUbuLNPaAAS/eLDkEHHnpPS+WtpeG3BhvuO9+J3It9VkJZ
uOBi68vWZ6cjyI9qdpJbZh2wW2xc5o3yp4g5MzP+AoLWbFzGLQWVM+NOOaHgvJMNPZh5n8GWAimK
7z8hPkxqtYTC5pPVGr7Mg/Du5WZEU9Vs6quMaCMMMw0lk8PX77gBkJjygDEObV3hvly2PW/PEizO
YDvkLYPiQs5xUhBXlNlQYMQnw/39uVmNujtZ+Tqgn/gZZdTYtEJ6oRHAZQOPAnZaT4wGedTH8p+N
+RvoqDHz2cxU0YRK2LFJKgnLbfLDoKv6xLL4Kt6KfmttKio56274337W2fqO5r/IZAp+i4iXa+f9
kor44pLw3pDAmFGTezBR/25JT8EjjUIgznguaOzx8kxUtAcJksVaAiBOAVJEUgb6DUAhGsZXZFxv
KH8VT5oEB01BbkkJLBDTbyJaMaf6h1huJqD5BsNZxmZnFAXsMCCNVQ/vI5itNSxvT/rRhH8vyhQR
0n/MFzHSzByOmwG0xk1LcdYKWRan9MPAHmQqbYAkVfP4rPWJ9v3nmC2AOtXvzx2E3bZFDWAIM7rW
51fU/KVCW+2y1reWr8ktaNAKCadehraoQAT0zVECI/t6/nXWapgED4xoStM7druUSCzfI69+jNio
gBBs0gUZ7GgzyWn1QtbWYmynaxzAHwm7/i+EtqbBytEfb+h9cNLpWvRha858KXvYLfp4LZJbPo0s
7dCHckG55EKlunduKtZxlwaR+8d5tpGyUkcGTe6XEWV1+6X2XN4uux+lSrhRg83RWRmvMkk6MuN3
lo2A3lxz1AH+7IkhlL8t5d5SFjJqaTzTVk5gYuNJp/cPJFNQipjzPX9XK9fkeD0WRuM5Ytu5Skx1
Q8/gVrjEp4FHRxw4d4rKW8AIfjCk38ur7/vC2m1mrIO9YT3J29aw5FF8LHAQhdNWORENBu3EqfYD
wVKxVM1SIFUXdA/bqGlzktIKpkw/06i8ZaX/i/7T+loUD7QtVB8AmIKRY33gnUPToNn9zik6mUbq
8595C+1fxPcqQjFAaFKIzHeKdHb7avOmONT8egfVMHruwra7ssN3QcDAwJx2xzOQU1gZzWlg6LCg
fzFywgR1aXs3abeZPvgGV2U/SK16F4Jyb8KGzOsG2VAKA56xYGrcH9Cl80h6VoiCVYDh4MKOhuCD
KAYnu87CjlwpAXDi5mrhXCjSUzPFt5UxiDTBeOIp0OMZKM7rIgHNno6faw9S0yUBqXcW8bwvMt1f
WwXdR3ltBjV/CFhA2R+ICXqUbABj36BwGV+mj9Cng3XmaqKxdr4lZD+/comPIki+kik+DhcHn9Ol
G6eUhIuz5orjbdJQkWbJczh+wlYsudUVK7XcqhR7J+cDRFuWwTJt3Ei49EoI1d5dcste0pOnnsbj
9m447lhMGz5YF70gslJ/JvgZCk3PItveMtflFO392C5D3tYTPeYVdmPKtKWYfyCcLGJBpImwRsSK
Gb+2K+WUOk8EdD2dwhgxy8hEb0qknNG7Z28X9GpxiqVNPL+2PO6PXvNYUjOY0bct6ke6ZyIW0/Gv
huFh5PLz/3Kf9VuKqNHfAXU1LOHG6Xac+3uPtuwPwqKHfVSwXUv5MiHCf80rjLpmDiRnqMIWV7IY
+JuA1vXtyPNmxEnn686dW9JAHvNxLjNp8a9y/vQ1rftxndHU7iOG0Dj6v6j/zBZ85iE4OxDUY4Jr
Q0Q7t7OJRGCqvJTQdH7fY6Bd7mtkq7NpN37UlE6Npf71sHW9QZ0Vf/n5MPpzUJAmjCW6ZP99OO5F
+zmarxBJ4MV+Af8G708GEK5oCtHAJ2Ni3b6gWBSZbtfltuSikFZ7tH8ttD9h68ZgANH3rIhr8x8G
fcI6+2JactrvH5NypGys0BQYaowIhDb0PqLkoPgc/8J9RRf7UaSfWsorLWFBPazhAhHbvnSUzLWD
uQr8eElsSS7s10JynVO5fFGtD9RJhsaQ8a93469IueDR+cyRTTn6QoynTTbl7Lfp7GRmFEBqUhsv
Yses+x5m2qMSX9ViAqSAmfBy5i/MTom+14ytGmbwnrvxEeO88TDTAbA3kbOJ4WKZio0FjLY14EcE
ltsEgWKf31bQxsCYZsZ7ObQnWSXcdPhT3J+1J4wmy9qS3as2u+uFSRWso0Ta3QgXGP9STv6cNmDI
87FXXPduO1gWxgKABQIGNcw9c2tfG9Sg0a6R/EoOC8dCd+bZ821IFIn0CYSVvQPVeRpXFD3wvffD
m6Sskpirp5JHh1HxRI3Mtw6sst/q4VLVvLQ/iA26lYEWbUnQsHGfH0rs1BftruNfWq+VU/ENxtMg
EQJFadpA6YctXn4o0TwllkEx7v4/QeDUBqhCxben9GwAZDMd/FquhHpVHaZOFZS0H2Ok+TQnST0M
L3i+eKYK2VCn31J58wWGSV01U5y29IIgHloRRkHWJnXnDmdNN9liJXUqM0uqcHkIGofWSBvyrBMw
FnW6aus0QK+donSOn+QeEwZUp+02v3unBp2EsDH/XmeQO9wtClOnSMcxxrbEvpRxN2uADzl1yYZD
vun/FkCTG0eQnhlpX73KSWcarhx9mSlTKatWSG7/HazKGpUxlajqqagtH0ucIfXH/5FNNTSdejHk
d68jt33LBp3R+W7vEG0K3DtY36LwpLzafuf35Xs4ZMr32zGsa1lHKU/IXU4q2z3n2S/DwBEYim4s
R3ERVn55FFG0tPs2J0+AZFjN4Qn938bVhc2AV2GlK0igoeOYuwAJYOp9wESLT9D9rPbqAv1RoorD
aoXpovjQdWPWcr7Iis3jg4/REU34IKptQJYS4FrlMR/EkZiW92F02HBmm+4KSc7Wy6jkmwSlOfu+
Xlc9bY/YWg1DW2Y2e753gX8uDdvaRqyajuN89gK7VslT7unwbBoy6SJDTiFeAQEbYfQtX5o3eeak
5x5aREspTuyTUBHs/FwOUnOLedyucMWzF7A98dr2ilTPqJeaOYEzWR+2x4/udXjY6/Se3iiTb8GF
0/nzKxjiG4VEQwUuAQ+QZwRcZ8Y2XSIjrIsjnr3/wS6Quhl1DhqOaiG60nzujh0SZB8QXd/RY4iZ
QxvVz+wl8Ky8pTFMBibXIvLCLogjlYA9W2K4c6587I/T8GO1TzfY4GDOLN8AKwq/F2L03XmGbwMj
D5guHHkCGHahmmhUiZKkGx6MgUK8nGXlTMJOY6G+MutycTzLkWBDR0RjBoZ7WJBML92/WZ/c7zkw
JKjdtbgOEdpia3DuQY7zrvhizaa9KasX1b7zLHREqnEe9gqPUfCjQ4Hlf8hwaKaf9qKBGHG5g/XM
wqi8LBp1hrkmEkhYZIy6nCmcyi465NuQDgS/8YEwJjFil1OoTpkZQ7INR5K26LHBQ6bb42FVJQ9h
Txr4WTRmkmyZ/gFU1qqTjMjJrqFJ+J8JvCv+AcZd6cHoExIsqAI9pSPQGOURC0cDoJTyPt/e/zAp
bRoUDEtw58HSUzLt1jyr+aKUMMVWfMJbSyR9KW3gMl+DcpMVfBqSswgyOw9dQWM7vrbSoSuQrItU
8hLVhPrVMKmc6XvZjOWIhXwA8wXOTXEbcUlFbZs6aqECtda1uJEuyejVBySmKonTJcbHLCpArqN7
d63c5lJsaojQrBM+3DLSeW4PPw2rrtxagqW6fjnrGSwpMjLcL3BMNnL6tvtIjuF2lNxgwn3tVkO2
unThahNmySRMxDEJ771mjQ/sIhxkDWfSoeXz34sSJ/rQyeEGT3bq1QqFVgqBZc+7XILYA/NK1IfA
ayTBkK3TtWHUU2HQ34EwU9uO9J2THvcTJaW/K6h/01Ad+NLyAApJBXCQdDg/d2/wxaTiBjjVRcEV
PAnkPedq2vgUCud7nKa8+pWwX2AztHXRN0HQjJL3JjYvSEbWWag7lZSOV9/MP/7i4A0U7xyDcXy5
qZsFMCScOh0uRcGl7ouZkOyUxcfQkl8mhZBfuU6exAUUKsxBJf47i+5ja9+eFoVxdicS3lVApop6
teXIPtLh4uNuvFDObuIPmnuPZY6SWlgEMk04kf7PkgsIVG1ZhqdY1KnCzsdkVt2ZLjxv3xVQ7ZAe
QI69qJnlrqwToxiJqPkOLYIY0MKVBxPS+QjYQxtVBRlxda2QvzS2HmSSW+EyQby29lYGA4NJ8rZn
RfmYd0cCU9mFZxu+/WkqpFr52K/x9+9utI3nGObb86pGHJTV8wko7NyULlVBnBAuFmcfn56sRWjE
kesr1/NcN4psTi/bLH5iaxOq/sgG9AuIxajKF8LRn3IgXTia/RSjS2UxrLJfCTCRgU3d4x9hETRF
HQz3QJjCvPwJSDtKYOLhj72DBWdEX288fwI6/eqWUzSz5yxKDPEP0wd7wE/7N+jTGj5IeHKcU5QQ
5qE00gt+h3C53uL3pEIvsOoUPE+XtTwGU/RX2quIAwPHJIe3XMnJhC3rzfXEt2XoOZfgF7t8ZSJs
SJTLqgyoOmv/v/IDcpxm3c7a8s5LrUsmKQRtFrLt9viqEztq8rDm3gPNNRowZwnB+gxBLQ8zc6ul
FWSlwwpBKXumjPs6RtdxuRX38aDrGJYQX69V+2/OpHnQNkWH4pgNxj9oSbzAeHfARt0757BGwhu6
OWDRJUs6DDrSvfa2tL6SguOjxsZUWX4KzE/xEjqpfAA/nauwMCjT10t9eLXkbmEzjWUmXsomojzT
1BgmfxUQXFaL37enDtri+QWq/R2PLT4yzh7UYNUE7j8J7r8CEYQDgjHTu8LzVQuqMHkbTPACqMfB
ZhSNsu4YgE6tUcbu+9Tjm/3kdqn14TNs28R7GwKRww7JY62CZsWG6Lqv9xkBFRZvKF5h/1p25LWn
t/jeeus70h+T7jrCFP/jsBefknGUuaV5GIeosLBPhuVBa9Um2d4coYw8sPG5Pp8dTKjWEQtgtlxB
UEJ+JMYnN1TCHID1DXbGJmMqRgpo30zBpP++SDI3JbFKs9qqtshyu17ZlKi+jBo1lwXs6VLe65+i
a1D1WQP+MCsPEn/oBXIXIuXILHzEi87AcarFXueJ5gvuUJ+pvj62W+muFaiZHyQfnrowJeRDZ1kH
GVp0R/y053G+R2RBdbU9h9EiuebVKu6CeL5QUX5y8x903ODF9y5/yZv6Sb2DvNlED8Y3xU0BquHT
zu8wPoypTLL/U4uz1Gb1Ygf/jMnDuB+wIq5a4+GQqzAQ4BlCz00JNCKCI5EZd2kcqJuXMX3Ymwnm
78oWPXug9Bv1OUsSzyMfpN5X1MvkwVEv05JcmGKX1KlDibx98gPAyPU3huGjk6oEnfB4YM61vpGP
ghBoOhnXvAsCqJLyeblHD/Q8nbbdNK7Ih6VHo78xTHy/XPwX1YJdjkf/82R76u9pyxKw9ySqOLlK
6I5VeLMQEYp94WuftWGp7khUX/BUFwGCOO9pGxYqHytiBtNZ4ghiK7ULvg/ve1eCz10oOdo+eGSQ
GOKaZ2JUHU1j3bLWnYcrQQrH3WWiaSsRODSeoeLPox9VrKWHYGvNhzjd6IsWrhL0agcjKkY1OybV
h3uB92RwPhO3b5DTvFqi/AiTTonpYHtNthBgwQcKoH6LUIquM4Ioad9ZMzxeKHxO/DXe44L+rym3
iIRF+H5+E/wTh+hS/GVPUYkMC/wIaOvC+2X58/Z6ssFd1w//xsdS1TFP6OG49IOyPGsMqiTMwRy8
x1IRT8ZkEreKtTt/ER+vMZA+4UBsF9N84kNhWC2nTT5guiFrI6zldURVi9ESoUag+8owMqalRcW8
DZK8A/6VHOJyx0cruVYss4wnmuTt+o9RydlFuJ/p4Euy337mvlM8WDyJdufkv1agVTNOlsdWZnry
TGQzaaGRXxGE0XGCWaAx9e+rzyZvJk3lPHWvWKN7uz+s7stv/axXbo66rpknMaN5fJpHWVFRyBYa
vd9KsysgIpCGoWtvKZ6xdIE1mgsh4Fjr8Rb3T1UvIartaaAn1ndEdFQMyWXQTLlCbfBQX5xqc6O8
YOYdX8nO3Qpvcjf3KfnPd1pWYCrFUjwOQYgVt9fnn5dVnplszioDoKAKgGximq0u0q9XH9/QJl49
H82z99RoQtor5obKDu+QTx3uaZa0pchNHgnx113cIt/wJeBDNZFz/fxxnkENoy5bU6sqtsbVvX8R
qV7UYHrs/ZqoXJo+tuLL2NIvyMr3ft8VdQR3njx+V9mH9gIgLI/C40CWLo5gV3/3uW12Ve3pAbGn
5t4CcXEQfrEYy7d/e/AD6U+Z+Fb2kJ8+XqAYBTrIQkG89L16MrNdWkElEVQcVT+51j22PQRe/iHh
b2P+KbxZraqWbKuT1GyyG+Mdd+IegiFRzfIpPqOAAyoZqFS4bobX/u/svpAlbotZr/PAZv64sQFe
E1U6RBB3whDOcB/id+mIfD5CmQt6Cu4ZF/hx7U2Y4zCQH9iW8F1VFhX9kaQaaGMZSd0gws+Erjm5
plWpIfjLvs4oE5bk1gAk830lt/Bm5cw0ygy1nb0HGJpk0fhrZluggLsboTOHaPHAPMlElSxgt65u
F2clD2M7UYL3SUaD9wYXjplsefOXmcyPhwqb+OpQuFpSlwb3Zc5hpN3LVClLs2zpWVKpqGKYt0TG
1sCAxmrFBtWV0tp7WU4eewwUYoYNftQvdOsOOyRBAxvnwDCR45qvdAxHRUkqcqo+V+rJhANbnn5U
F4q7uSF5Yvx4ENFi4iQQuL5KiHRzD2mdNo0qgMpvKMXfzl5zBeQ6PIbOxKEvjlsL02xQTb5HakxW
KUpdUMQp4sF44Kpl357WAjB0urjFCiszVdjYgCHtKPoYlk6HZ74RlIIXkEqDeAhICRbh4HhQBwsz
GwufNYa7LPIDoFv4Gy5BdOy7riQyetcCF78rSBFdIw32++9OopFw0y4XhVvMW0WwTv770V7/QgBC
khpAiiMfLik9XBh8uwk4ZLE6vTWFCZPnOfg0qJyHZhPxqfGOJajwGBO0O3FO0pPojUZsL1nThhkE
ftgsMCOuF9JMzAqmfo6byFtiI9Cwajqc/kKE29EUxoP/oVuNH3o+nFnBlBWGDGUZgOArzfIDE57L
ER7pxFQ45i8UDaz2ocJl5iXQ5fah0dz7t5Rk7hr+X8PU094iHu1mZkiDSNiHkPS5vH1tXPYfbYIw
c279YTJnpCYbIX1jhiy8crj6lE0cHf1vHcaCraGjxtkPhKinG4t6EJv2oAYyVA1IlHyool4oiysT
u7kOQMwljOl7gWkKkO7wDlYi7yxXqfVtAJN0tieu7uCuEqPPVLd5epV7fw5nHsn8un3KpGuGDEsf
ttgFIp1FDB89PLw02u4neYC9bRdkHBUj5IqqpJvycQka+r2b3IvrT3f9aztm0jXdJt8CJup3qpLP
qLuStg1TJP1EtCXi44StTE6HWCNLvFPhOlGqWjzOdzOeuaexOlWCGlFfg2cuy1ppFwftIaae/2Rc
MTs4FCHIpo1TTcHRMNbHvNPhCyhik2XifhSRmbtOR30nql9zEP4DE2GuLv9+AO9zRSl6PZec/IpH
8KIg0uQecm0zuPOUQ8YEbzik68nACbzXf+m2IcTz06+yfszbUxspPKe7NAYxnnQg6cYemzbNhg7f
sAjldjOcsGuhPBY+MdsNXBQ322Oz9EyEiZbb+iuRuCbqCeg+OdC03eXJzPjvB3vjdNcZ9Lo0SMay
MSKRMQ93q7ZPot25klctgIxbQ6GgO2mTCP0n/uzRk9ZxWBrXWF72wFmif0X+u36IvOZoyG1kqbnM
BX7sxe8/k25pYakJIzQisag5jwcdnRtZkW9gngfKlb0/YEUvZYxvPvpqgdgn1Cf0GKm5lgHXU10d
idynT9fKJynm8ej45r3xoCvPUSMxB6bojIA8L+enqQFI4LP07cQY04rcmZ7A2kPs0ZPJqUAwQJa/
/DJRy1KZOQmsMsILj0e1FkWbKqJqneF8yUxYxgByYEiP7P0QlZFbW2lDEh1LweOh30bGyr2/Y6hy
BW3/huteJt86kPplZjelWnX0B/mRYHi81IyEVmlRRYScn2SsLwCY4q5+ALWue2gfhCVzTN78Ah58
aGZtu+XL21nqEEO2vdh46HIwqcm8uTL7hAAbsvRQI9gbGGzVHe6S1YVJajGbujxO7Jb9YyZbVZz/
aJWYjv9+RlGQHRJgFAg18hM082TEXLFR624hfSzQdixs7O0dBnrJ6Fst6yGcCu7HQ0KfnTmSl/zB
4/CaiaPYF+HbVO9QPwcIP9DqHlLsiigIPhiapm5VGFzmw9q1BUd3yk0yeg16TKURpL88E3ufmWyo
ZWzBFsdHytDiTcjRNsaDb+5/TTFINvFC4P6uzaIJDS/SSL5O+ofJEPq/fmjf5pz7vkUjjO2GbS5y
+nmtuXaUgH5A9QMa1vBdUKJZ7Dc+p5r+m2R8VA3+K2af+3miItHMWERjM9Ce+DtjkYRb20P0IpUd
4lLngMM3bzKHhwYjIoddQjsVNHj2n5c6KkKGj3OSenJVca4i3+74N3nptU4RsrtwY1tw734RW3p/
iP4MYKc+EtUiN+PjLL0F8Y++499RHgDEoQjPhN9JRTKbMEaFa1e8FuovzP+/DTauhE1NXz8Auubs
qu6rCf7vIOSETizurMfhg1H1f3vVfbDW6z9pC406wwGVEMwRgqW50cZSQi2I8BTKaBUOFf8wzmZ+
xOC1tboT0Z+aD6jq2a8Sf6p6U5fM+dGmVbIfSiY1v0KW82Dk8rgcdhdOLzPw0urhBOlkpTDQ+k3C
qNPobL0d78fiMtGapCYKBqEvZAlAoo86+sMItXIRF1VzvA1d1BsYqrQtRvMzGHxBaRrOebDKqFoM
E1bfAjNJwfpDu1/2bbeO+ubKMGChVFbIBMthVoEKGRDaCX+rQVwID0zOJwswT1N4U4R3TUYVNS+Z
Z8ozs/ZAEintoqeH0v+z/TgkraSEFdZMhkPd1b0fK6/Lf6T4RfVfY75RlWEwsRAPneNCYlVk3UqO
Hx8fKX2TNKMXHlJRln/RhykCoS6fbIlG78iV3OYniztwU6PS4WfrfeNtJZ+tPPIrR1Ot+2OPGjxP
6jc+278wh0kZkZfC8rpzXXQ8gVdnSIEyZ2xhSVxLPM5XWaHT87S2eceUMI4LYUpwOjpMwu8LtpOY
ayn29gv+9D9kP2GSc/Cm1+hbsJYrvmF3wmDGvGCqlVNZsZSq+AT9HeLIX8MxRzS9v754j1nh3QzI
w/X2AGjXQDsfxjECJCCdftvv6sDQ+omkfoLA2dgQE4BELjr9xfI8kJx7DuO0ZlMdF88EUWQMP8rK
JemIQRyIcVoh1y+ddOWHBuKChah1M130h9QJvY8XuLwYG626CG/gEKfWTDNyv5WNuBaUGNvaBcyt
4Gs/emWJEi3cE3nMTYXHnAc5KCb4LJp/yW7lNJicOjpy4YB0UtpwWlLMpsDBNhb9Upe7phxOxPj3
dsfESIjZPAJmtsUq1HIXZCDHi6ywJ25xxkw3JWbCPbfp9WWNhOIqVlkWWp3teYhQTSWUyShhOl52
CSNP0CQfa2U1cuZNXZjqoVBIpz+KY8hU69ZUgYxWI4SUDrkclFnLvnDHMyqKp/J+QLg2ot6i0g3G
HubADxN9/877vzAdK/ztKFliip+sWw00ErP5+XZ//XUjvMH5oI33drdRroQkkghDHrTFHj9Jc4iT
JEXQiqTZuzpq/0ZTtCpSrr8oTx8HXAWMAFzMX1WZGDBvFksKZcrR2qiInfKfULen4U03qmM1y+Ku
8wiV2pDJJHlZSXWOx6++Qt8aaKrWqYbMk8NM7elrsYCAfrMuB+EA701Mqed4LloAV9H27U9aDGW6
7T/ZlcEyPaO7dXwDQFgg2Q1oGhLLMaAznMSMoCJtL5UL2X6TPdfUKEjuDWKYCnMeMTZpFHf0eYOh
BTpVzNzS4lshBIGJtU/cI+/HrfU9asq/YufA17fAUm+fObCmytLQBQUpk5p5VLSGyXjPs0ET
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
