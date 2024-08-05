// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 12:37:44 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top fix_acc_16 -prefix
//               fix_acc_16_ fix_acc_16_sim_netlist.v
// Design      : fix_acc_16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fix_acc_16,c_accum_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_accum_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module fix_acc_16
   (B,
    CLK,
    CE,
    SCLR,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [15:0]Q;

  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [15:0]Q;
  wire SCLR;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "16" *) 
  (* C_SCALE = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fix_acc_16_c_accum_v12_0_13 U0
       (.ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(CE),
        .CLK(CLK),
        .C_IN(1'b0),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_TYPE = "0" *) (* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) 
(* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) (* C_OUT_WIDTH = "16" *) 
(* C_SCALE = "0" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynquplus" *) (* downgradeipidentifiedwarnings = "yes" *) 
module fix_acc_16_c_accum_v12_0_13
   (B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [15:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output [15:0]Q;

  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [15:0]Q;
  wire SCLR;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "16" *) 
  (* C_SCALE = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fix_acc_16_c_accum_v12_0_13_viv i_synth
       (.ADD(1'b0),
        .B(B),
        .BYPASS(1'b0),
        .CE(CE),
        .CLK(CLK),
        .C_IN(1'b0),
        .Q(Q),
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
dSeZRmSWebtpOR1O9c+IDTdlMH9/1hro8PqDVDl27v005C5MqyZKeYNm9mMQ4XxWPZxFv87c3Z4n
5Uz6xaUmaA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
C1X6j2CN/BrcCWflKLlsg+cM+rksMcYf4EY7flfh0J07Kd6Yz1U8b4CQa6qGoE2Y/wXsD6+gLu1B
2quOLx5FDsX7IQ01fo4Wy5qqUx/igSc9hpspjPHf2g+aIJkObQiq+MmJ+KTB+Mr045wlFkkQImp+
nDfZhNfvYWVtC9yy0Mg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HjLqlbAvfCfrXjMuBZHqAXPJS1vFnuk4uVIm/P79GrZZ9F4hFvwWw6h/Zebc7LHBZ8aDoz2nqBGS
agpUUi5a/7KL6U7zc4JR+FiGSOstAhOnchiAjnOL/ldhpQkZIkSQSTy9sflsdb5yUdL0uPtUDYKm
JiJ+7sIur9MpneraAAsadcSxH8JIj82UxvxsEWic+lRUQBGZFYyW0a0weg1TJA3+efxfenYDiODb
8jzwBuRuSugqAtIDl3yWQJ9IcNkG+CU+BGRm90QOw588wfIZH03ujkyY04caLofICJJNQUmw+DM1
VDUxFyWr5tAkQVtSuA6xeiwuyy2I65doiiKY6w==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jBvJHqZCB59aFpCz1IePy4RYqbdYJK8+fPkLRFZsA/PaDkJTn3Hl79AMa4nnyc/JiDyDTouUur+B
wq9KbIkwWHA+V1GYoCQNsRGcXLp203F8xGa0WwDCMkQ61DI8d+vX/vCNY6WtVir5NydV3RPPeiNF
noQc9J8fdyNdBk8Dxycu9m0M6hA7pKxhqzaHGTgDfbTL5nSSisEctrk7xIKxRZfDEOjb/HgQrPu8
PxKjuK+PWdRbd2TYDPTYnN2aSVMTc6FECz/tkuEDTDbHOolKjwwgmUiTQnpnNMkoUeVX0sUgETZ0
PKLh1yOIslZFd3mse8z6tXWAOjf/rOzL2t0EsQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Wfi1Xoi9/LK5icaWPECZ2+1JTGzZYnEl3d+vB8OHM+D4/fOHr3MHHVZ0qGciPepgRoPPmPsVwn9B
ArC5SHMlmrWWF5Z9WanD8/2Yrj5Bi3kpeZ37ays2Rv60e/FbcLgpzFehbdd70uh20kKd41JucKIG
Pqqwd9WOovku5RQDI9cmBTOzshupNa5+d+mxjOcVuX6Z0iiYgrqSoYVsnRBBn5gTC/QcQpo+5G9C
ns/bzHveQR1VYA6IFM4GmlqKjaDc2w1jfg/FWtasz5yKFmkAp373q/uDiliz3SkRfXw+ciWt0WEu
xoNuMpdlbRqGAogaFMBPgBhHYDT6o1aa76AXTQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
DMUDPZjwKoonOS0VVbYtITWEUX/2WEHTClm1HjCk/vPm2O3Uvu+dFPKkbyVwsC4FU4hlJRDwWfgC
oaXUKoljsM4sDKmfg7+qAjFuZJq5zk0fZyjAT8T/ZLfQ6BlQ5ARAZJrb6mZr1VppAca86m3l0Qdv
ngH/g/XldqQKrARLx4Y=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
C7PFVsZigY1uTEEQM+/f4IwFmUMcqTrhsXoxQyu0ggdL9ucOj1dbj+YWrUORvE5egEx49rO56kTw
tDIj4NUh+zIDEY+ZVj9luOJ0+6xsEPBCJrz7XamiG0StFGzjnZF/DhB6wjRraeouE/H3ANL9I7r8
dOj5uvd06ApE35mLiFBo6gsfno83mSOasT0ZH4dVuOH4l0Y2v8BrhyMvhYbUsCZQK3X0uembZyhz
VjqiMeFRF3MGpFD3QZHvnui8DK0HgE0ax9Y0wqriLLm6qBX91UKKcgItKLtWuQF3rEV5jxZJjv9j
jJUEjk4e+X6nMNcMTB0QaLYW6kr5oAuebhwiyw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qYkQSW72BWuf9hYjlbEK2lZB9TYU8jXUgG/IVAWxan4x8/CdApyVdZSZPRJrLeCcJwAFjtHOirWj
j9hgvPD/BWQmZZMpsLCR/F6dmVJJVqmMh1cIHx0Cjmbo5liUiBvov5CesVAthY6JPt/KDHp/yI+0
9tD5vKoii+G2bmm5Fxxh4QkzTD2VtYdJCJG68hImkvldSZEjj4zCjeEV67SubzDJG+kbBDzlHZyn
O0AW8z4NSNFMoYfl72E2SPQY1ZAf8Nd+MH6woh5K6gC1tzRC2C9qhEJk8yVhBT/kPaiOKGNYhtPa
m72O6oDLtZnMfw07FW0m6CrWspUQRWrrd89nvA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
5+ry1n1//8bHaivH/b0k9wPeuTwBP9uIRltD2QiGchsLRLW/LUtMNRp5sntATdEs2/uqv2oT4X/A
yZr2FTv+t6NRm7PU5AMFvLc16H20P9+Jz8I+OA1EMpGHC87/1dOiTxxITYxluQlJTfLEsu3nFx+o
K+mnjI5Ir4tFKZ+BsTHqKk7asXTm7tErQGffeRDfsNGyciifCn+IMffD1eHz6YzmM6AGYXlAhqAC
bBHVOB/z1wMGHvgsP3Gssxh8ud+ulRCEOvoRGIo2WGWRpeiFIdXnEdxJKrjQBdNfGCDQ5eT42kgP
YfFlgZ03PBS2KKAWbq4RjDGTgd7WzbBTotSFIw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11920)
`pragma protect data_block
qqBSHdzQqZj90a4RhfbbnwUdB3Qd0DCunekzD2UWGO5P9CkERNs4Lgco1TeX8Iq/UL7gk6PAchgx
CLwaJuEApQrzmWOde7ISj1DSiC7imeSaruNkIKURVtycw5TvP5ZeqYstGnAK3Fskzy/2dY7SWWRw
NuZu3qJKKMT5zUmB2edvfKM8CfabXCbaRADcOuYI7ZKJ+GrKTHSvqdQgbQ3xR0d35ODmYfgJJebo
XY5UfmYPrYSMCNjoMJ6OCvFE0k6pMjYLmq2tRhiUR6I1hyU6T//K6zyhnyke4naxrBgHvn6SbBAm
R4Cno4xwX35/U5suhcGRx+eIYgW7B43KY0zbMiCDdoe+ORMzoQapv27R/8oWMXljlGjRgLBZdBoB
jtLgorn5fBIytDu9/d37jOoSoERsQf1ilsLxKh4LVnTby5A9cwYHEzt34ntdUSFgyjgEbrswu10Z
O6vFLyRnMYrsiKQt0Ogj5Opj+Fjyq9Rw5KW/drVCkHs9ON8BLY429T64I97RwLFujEMfnkkgZCoz
/SBzzJrKgz7Mu8fUmccVWW+qtxhayRcqnnff8y3SJsHYkggs6XxSutSokkO8hEfM2Qx3sP3k0CrA
9uv86RX4Ck4Wgq8DLASwi5sSnAPrBPSvO8fTRryxIejahIbwl4nzHVXBSoNaV8/NISphuiZaqWHd
MZClNxiVrS4X5dvAZpSvJZV3kwHKAx9aM65watNdYkV6ZCzwQQIXv3k9ktQ61O6yU4l/iJTmgHE/
KvjmM+09hjLjo+sObzbQXgpHWO/xlN+lhAaZNlDqWUMZ31S6jvjyCsuZz32I/GYclXKpH9wr3+FI
oP7GmuCu4jseqHvMlqtlRbQq9I9IDBtSAiLPf3MTGQqBcvkcMNnK+IV8I8O5v20afWjcMB3U73bg
YL8m5srxiaZg+gnvPYvYYCHybhwlJ6wIsmYWS+2LtNk4nLOy2niT3IoRV4JrfX5YPj3Gxr77QHf/
7kUFPX1IaHB0VN8M7DDeiRG7eUgM8r+/a4iDYuKnZ7K70KfCueFRZFi2MnLbOWeEKqvFmS6fopzp
+hz+4Fim4fAnLlc9yACD9jUMBL6RVE8QpwQoPU/0YobRJU+Nx4Amsub/aOFUVUOFsJo6foT0ifK2
+dbziE2yYQNAZLM5hS43Q3c8KweK3hV8PsWaEo6RR1A4/8cw41Egh05l1MGKvP1kyqAEe2DgGkMY
ef7ALQQtkPSr1Xb/qzfXoAYegd50b1FZW2rVA3d8CiGMzUFodkRVUtkt0FazD73FpwdM8o4pnVhy
eagmKkYdtmWJl2Lel1kjBwKZMX7VhkBdQ9ZqTJEDwdPn/SdWmx3nUh+cAIzFACgUiGL/bNOhlrQE
F+mro9TQZr/G/Oliu8MVWqwCJzMEVX9wnPF4IijO6pngp3/Ub1ih8GE206kCvAtOkRSjBOA8MUjZ
812QmO1TOQaqJnTOhAxgdR/tvHcRUstkukp+V1gY4FNzKKBBfMjkpi9NEtdIYpfGIAY2pIHZW6n9
dyT3pq48FDO27dOHCakyPseHlZ/ieQEYJirQ/mD3Nxw4m54f4WxHfKBZrjwV7X5yY6xOafZ5P/gF
6NNW3otLR1bv9TouQSzTfUVx2rv3+l61z0AaxQ+h3Zwu3GjmcBxCVclXTz3KkoNDAdGeHEIJOU5M
5Jz9hK7gBKv/cviXwGweD3xc47uHzrfs4OEsUPQyZL4Dqq5LNxUdABafZ+OoxRQNZMOtvRf9pXbF
PMVmMoVCAD799v4PNRMOZvaZx27W1WX2D8i+iwXqpbNHNGwXwRhUZt42yCUHSCGOH8actCBGJWMM
MNdgMxlwwubdekqjrl3iMHLJNW/TIwosaZ5pwYSeduN9kwth/S2iD7DZmWu6AsQmY+yyVE5lH5Bz
UJ3Omg9I1wg2RkLLIpanjk2uRbX+hca0T6s9Vz1L6F7F3PAIYp9L05ncxs9pYV22+1XkIbEvW3Pv
R2H2i3T/pDFQhkQgO32cQCbPqO1SLHc7O6MyRoilPTbChfs7PUMfFjuhvKsmghAvCplX4dhU+AGC
LwQe4/7HGOtD5aLQRE8DYXzCO4VJytIO/v8APAt2mwcJV2dUbQ4wcdTXh1kP7dSKqSM0EAVbaQGq
/VL/zxLJ0hjtouy8bFu0/vSFHpp9n5ZQDbS7FfBacQKgR2YaIHcCSiC0HvzqCebX2eKI5nOTEBkW
YgSqBrYE3etW1w4gs7u8rs11P1MdQSD7pm5pVABczOR2Ibb1PdpGPs1YJ/6tM7+Epi6FsJ6+hZHl
2JcngL1D21aCWhW06dqBFp93zxRWhnWoMDyJhCwy4jzPU8Zv4YTmgwnpySsqIuy/YIS/g3ZejVzD
uUVASpuyf9a2iYqMfO2MUZgoD/MkUazpF8sWN3ANBtNawQ14yzw1Hy86C3PUOaLrmJbTNXi2htvw
++MS4A2nWYrfvauj27vSAtlacEygwOIWSijBLjA9iMjn/pcugostOooibQTAKYLu2GExoMlhIaHw
3CElekM0SclVag+uFrCs4LK4Q/rRZNEineu6BniQpsGeUGzRA9TcXX3lS6jzAwDq+WB9DQzgoXLt
tuLaJVaKqqPI0JboxRrzZ7F5h68IDr2zoEu7LyiIbjMW7LaxcSA4D1lCoWSVRmGx/JkzoGxkV1kF
iaWWkPrmvlFAPxqkhkTzNqidGsKT1QnFQP6CSMSZwwRUnrCa5i0+NHoZvP6fMJqkQgrnDKasP4lb
KeuCcE4idY7UjqcwCoZEtm1b7cHyxWHIeSjxQSHa3bYCaIr+9lg39tMak2v4e/dYUk4CCkOV2+PK
JU8kTaGuacfFNPXQtYI74yVbZBfXtUJy7EKIkxNUDHHzFpyi6YwMasCU35DJ9iMQaZlGhenct2vz
nXQdSC+4hyD1Kb2iiJUyVKiZ1oeSeC1488If2WXT4UPs40V4VFWoO2lY3anEak0pSNUQAhQv4Mmq
J3UUiJ6uuf/OahwlY6fGO2WUJAF9ZKYqQUUS7eQrzIY/Rjee/f/r/fpscVqlQUoZGR45u74MpP6f
MtiFVxuAoQ23L8sQSrE9+8T5PhRewFpzmWaGM7E/nYWuWl3AWe4350sUKZhrWHUe28Ctj3ZwGHvb
IDawdmKx4XLMqjMltggr1duQE2gZGhlBLd61QjXk1sI4pjPyv5bCRTKonMj7lkcPOrDBrZX9fRia
a+jcoRpkA4X4sXuZABIpktUdHPy/+kavdZkTkLpEa7qWFELQHtqxnv7RI5dCdvjU3lfHLMKA/Eyg
cdhR5dhnaiixicRgCfOYJgPRUzXVzo3jrw05b43zkbthfMmtI6ZQ8lijW5F7tFtsu7OixrsDMIyO
FkNZ8+cXmdssZ1Oei/jaen3ui+b6yTkaoNxhi9C229a8HXbjb6YAXTr/mRv57GXV6nwpZ5AWD8V8
RLarQpdHZpsbNkqHwgaeEhiq0waJterb07U/YmGKLo+zsRkWPkW/nXxYxmA2MAsMjrijEOvgjUjy
Kc8eE9uTVEkDNM7R5C5fY+F+TU4OlaRv2dqDYQlYH3fLA+R0YPbjcIksYNlYxNTAYADloYn/EOGa
Q4I3wIz9yZiZNJ5QARPJmN5iq+yIrLMLUKXh1hdhbTjrxKyS9hsvWkvZgjLwKEYA6a1Luhh4Kmm0
ZS56r6+biJwCrtW1cM8u+KsFQMTs/wZJ+qeVquH9Jp+vJ4ORrgPT5UP87cDYQI5Oz8jeMsOEniaZ
IANXZoOm3WkPjyVa8KZnMGsuWLIQLJX7XGa5hjLqAPEJn1VxXABOMiUWt4I4PE9jnmJKpo2ER0MX
nGo/a/533Fjy0fe4Cuj2gEiwzHjD95FV7xi7l6Nt8jruuD1OvYSN0C2MWhPXL0LmLE5CpF5FgCkP
voAjgeGWF7CXOSMC4nKeMDX+yo3C2VDmRGZfiiTSy0xaNWgujHvfsp/UeCM5+aY/Ljk6a5uf6qXX
6sgYiLiun5pynfCMKP5i48Go14ncuVcIeSyk3Q/9HosqV77kaooobiT6cUB/MOkzPdsQSZxmEk04
CrH+2qjap1jVqLmG3rk+tXgR3UofeqEJVXdtseA1egpgEZnGWR+APH4hpbmysGLCRmBq1BajPXBt
vAWYYS8qCtG3QP3+FAzqPXPSTeW+Qqei1mwGDFuHqsBWz4QAegFEFitqOPCn5EVWo8EQUmXrC7TK
vunhUlcH2TNZem/xhMP1BwUnwgiAbDzI0Fccj9gYifmBbNVv5SxDCzNreeF5jXTa8ToxYN0hLvcG
EIWlGQvwbNtc1bEhI4LqCfSQok1IB1rLFY8PPknwNSFS5hA2MoZ9h3LMIYk4xJhiy9v9BBbUaTpl
JfXSyrJ5TjjGNUheTbuqlQt+8bd2Cn9EIrm4TZqRt34uS8/Au2OQS9Zd8N13o3VsjU+aEvJA9bQD
e1580+prQDicAnQZdlO5SJhWVVEpmNwSmZaxkKUr5wPLBqwjaG6BhLn/zwmAc4FfkXwWLGEpd0qZ
wq75jooOi6IUnkmbzLhJITO7M5VbzZjLnHts+PzO1qMDPk90Su4RooD6lZjUrcRAJkK6VrI8tEg9
lLPUNYWbcE1ClakU7Qro8JzgBlJ5nS4AUURMTaSrqH1u1KTnvNbisJIdAc9j7Ym6cgT0h6EDo1v1
y3DWVRlvTPNqQIjzn32Fry6aEivv6VG4wiZYmLJxvjAScaRDqW9OdnAMHyAbSKu3DJH7rsq7UuHy
RmxUASqNg/kHEZZjqMv0fwZ4NaC/ArVCo2ldeQD2F4bKTWwhqvoFZRf5fUolGA59OqZmu2jnoNII
C99oExvf0eJzhWRLQhe1MOpeaM1sZpgTfVBclyyZmFRfynXMtc2CunbLM/KYv0mOA96TKXLCOBKg
qvF4JkgSenh4+EiVVFbfP1ek1s2xmL73WxTfJZLwIrmRzoeIfBxeCBBpSEYXBxXerVM6KRPipHqd
btQHIfDQiMroz94wNpGQzvgoLDtMFmJyHY3r8pq19grsCNHbZJ+6ZBGODNQfUT04YHF1WOUQ1Coy
kPCkGiRvNQFn8b3ccG/Wjz0oajJdEzBCIzaievyCOgBpXNJkSeHhrZSZvi1kca2IYrz1k+TJRYnj
nQU+5N9aPiP+ADCxwMR90UzWqRPFuULZ1sLA6b7bzoMRmOo24D744U0bBZMb8C/wpSSrgoAX3ard
w7Md0vwTgtahkDPkaNIoAHgaiia8XjwHAbOwsA3gw2b31kTUC8eC2gTneEt9x5gbaby3fjKeGGLX
uwypCDkvzGAa4kex88SoUO0ZmHaT56TIwyjZzdasEtNu9XxA2IFvhYJ68+6lp5tDYppyVh2GWV5A
HBDW8X0548DBbYDbPxC74Bad4RBMLAQLkfUdUSnHIp9oYtbku8hW2pqjAz0jkpgkyNdYTk9Pwj01
0zfXM1fsJYL7RyK9Pa3rWiUD4g4dzM7RsjYqGx8YQULOFAIrk1eBbFiM6ckeDC27v0ZBTLORFsq1
UAMys869F/NQTkidJuQbqGC7LyIIxkNAhXH65k7H6fAQmf8sxR6dVXKJ4iieX/EsAyVYL5FuxL7F
y0qWSMSvoppXWsuQM0Xb5uBSfJq10DKsj0ZuGvbvphwC6bBFaM0N+HmpSNx5kl1zn6G/SUhO2nVE
JmXlh4NLoDUpSN8PdCAk664yEs9kw50n9m4sv6DCAJKgFk1jA0fK6ocULh0hf6Z0diJmRgP4xVvD
HvUYYJIu8v2VfcgavCFbZyFg7cNFCYpkEBKZUOb51L8Vyf72P3+Dw+SyfxDUILvp/TK7yerq9fcW
JNIborXw7CZXXi/SnUCaCnZe/KB9ypYG0eWmjrWeAL5Qe+8m32sN7DSlWTXKoOSrIw59E+L3PLOY
s3kHF1Lvf54TjMoCQrCdGqtKSNyOD/JWhbzWqMPyMCDfLkhXb+raeMVXPZinzggw6JL7oxIAKBiz
ZRdPdWwQ0HXClsIk19eROuPqaTsxveXCRqAkA11qMPkdsT/QMc7vpD5A886HpL3pOhjgANPX4b2I
bpBMOiypM9aUrjsSQVh5tuXGhucDn0Q/OL0WG7U+kwGvPM1JgW8Wsq6lFqI9emGn0hql0NSh9+Ow
GJfNUz+JpkP3/qJf2knFd2uvg0utdxFowjHkVuQ/jcJcM9m11zDbPVLMQ6oB3G+dER1z+nQM78yE
BxVNxzs4VQcJ7sK1O2uMBG41mJindg45oyV+EkGAxvwv8xJF5Uo4r4yqUFbSppdIrgZrD+utPrEX
VQf4vG+eRTlHY4Dh4nFNUNV1JDUm9sKD1ZHTfYCNd9mYTGLs8Mr00Nd3ROJ2ROei/Z0KrhCqWFMn
Z1QEwvGYzByr9sKejpuFPnqY2MWV4BFPzwmhoMcQzHEEynGn5ZX+levCGHbI3/O96unpp4m8F9Mj
k5EMfYAa9kdhQLV9nlR+5ALVuYT9zP9bFyqcEXFrf8nKKeydpPVkuUsFIvnOPFjxKupTCuvJCRZ2
ieLpUxuC/M9gmDWpC57X8klICBVwIPCNrW1X3rjuvN1U0BRBwQWVTFrsYaceeHnzdSE0+PIHJJbr
tpe1vnraSBmrMMtxtiGQLjxfkZMYgOes/Rz0GMaTUQtnNzunoP8EX6Iusbl5oRaDGY1yP0RKcnbG
9RhjmTPmjTO9j0066hM+f8Mo0BTPgprhgOP/DYiet8Oqn/vpgKnX0Wpror0e83tG3/4bvwPK56vZ
7ay+79C85xMU/G1RRQYHyefV9bBkDpok0rFfKcBCG6PtOCQ/ih0OghnMh6RsiYgJDnhLyzA1Eq2z
iMpScpCowrggqXZhesyKBP3EB2tmKXrkhVjHlmRF9PNfiD+A6TYJ/UKpwqeAyu8Ic00AI3DoYZCw
AsTNHf8DX+jTQ+m/c+2HKLrkgqTh+0+BSP2xbVL2DBQSYzVzZJSpqPHmYmmXVkRp3Ll3l3+Tt6C9
N3bKcCkdC28PRgSsAFPJjVPs7bho2wa30DmcUzAG8Fg8MZSw5Pww1mfcs+IuVoDv8mdbx+LBPDna
772bAXOK94c5bYzt9bBOwSXUGJkaRoCWaleyidZi47X4rSlwHT+7aWAcozHVngu4DMzO1CLjLf42
Qx4Usmwa5YHh8AJS+CplUpE8I4oSwX2rARJi+vIMPxz8zm1Bm5VYtKY0uTLafOVgkvJuEiL8Hr0U
dnt6VsgNlPQzn0SVWXyyHtDJcSjjz34lt89UMebWmdL1rzXX8ksEQzumV+MruFMgSQ3h9g9qBIVX
C9ZkPqt4wEJu9W0FAkakNvBDacpAPq81O9vXdqR9Tn0M8iQsySkYXHHieWIEGeL8am4JSGRCDvfC
T1YeKGJn5w/illFz+52DOiZnWQHiduAM0GNPPqgioPS5SMrwV/djWGhPnbazV42UBE0tDRgG32h0
jXYI9GgOfkCvCzv+8V0dCM2E845UwNaSS5otKL2LIZkEZUuZjXp4E1EQBzE3JdTkX5nBmaQ2Xebb
EAbUfgAtvi/PyxIeFD+JdY+l2guxK0mUoJpUS7l4w2h5vWtoyU7n0MKx9GdALtQsV2jKxORNmHGH
aeXiwJTBcx8SmDPU5ty6Qp13D4iJjzSG5OVc781gAGXiIe+0opCGTY0Gc23rCBvE17gD1d02sNQ6
oT7R08vBTaZau6uyLM2VrJua0xgoBZTsJq8QzimYZ1A5/Ke/zEFrqy+mkrfBc/mcyEvIafNKY6Pq
Ao+ExoJ3mtQ+5DBUsIUYKRM0Zt7LR1uvw6BeXwNgdzgikCjJjoy67ydFTyvhazmX84QSgGcnXzCP
uDZZTh/tznh6TiyercVnO89KDMNXgi5r+bXsAzqedB/kHHVRCegRuupf8dhhbR2ET/rBLUtstajB
I9BbQ7Cdey7RGL1nKAuUjn+B+MEDAdvRfHfe23amC4HlGks0DbVzJt78m+24fPVIgggftGYaaGL3
7Im40eMQTftTJ9306W4ao6jvpi6ReJXjTfz7+KOiqYWnavuWrPTqWFN0xvwpJO8JkPAXbB8Sjses
tBNI1mJh9ofXxjbWOhFjtC1cbQZcD5bNBDcq2PwfT3DX0lxT3i6nDmtn2YgiZwfff9PDJQMM1r4D
FyZFolvB9jSMsDArDww+BY2b90Y5p9jaRxJv8Fg2tCqMoLbb/BlxM+GQafTsYGsYAgluqS1vUjvh
8PUT0I7lGR9A3/DfjEokRlSwRUnOwOz0r9vATb7gP2oxCC6E21wsufyy9P3AgNbFNA70Idrvw+Rv
vZE3pKl0dHcn3qd75udxOr+0x3c/bl1ynP4vjM7McWyNQGQ8lWqk9ldDAnz9gnstUnlV84oZBOpB
NIXdwjYdK8XbqD1N7F6bIkrVlhga5/u/KhwQx9SFxPcmIOfkzMElHnXyc6vHX+cq9cXt6F0Wf2Fj
QUXBNd11lmezeHQrcQEo2OoDd9VCqgrowRL0L1Zl2ul8MSR7ppKsIxUEzCkllBQFb0O//mr2XAm0
A5xFaYCm4kuy9VOb4IkjI5RLUDBGoi5WltJbQ0xUToKhMNGcVUG8lqJeHF9HGvSWrIWbWGwSS/rP
iw6TB994phPjIUtlBxPVsqwy4BMMphYoqcrrMBsfkv5HLYx2m5T/DO3ljiNwws+YR1nqn0HHTav5
ZNDWEYm1pKcqlpP3gk3qBD1naVjmPwQDriIV+CVuBxKJFnutdika3VNDCoFOvQVkz3SxKTpNaB+k
eb8iXBfmB1AZHBlcLj66AUqQYJel3wRT2YW/GTMdfi3Q0MxCNO39IAmRFofN9cyOW6fKgrG6l6pM
mI+ixKTctgDGX8yPF0YsHc37OTXIVDZnZlOrME+uy8lk7r4j03JTJyTMkgTP0l/sEfcAp/0A6Ex/
96HU2gAuvDj7S9wv0pVialCAsZcVcQhvutrnxP1atBlRCOWyw5FedlB8EHhYyhQysRGx2OXv52Eb
7a3aFW6+zwfS6ueGUlkXbhGx662UC9w4ObX/heB8+0JwSTJTn3oRm68/O5d9tXiVV+tYTjbBu350
NLflpmJqjFYpVKmXLhZzxTLFWeFTI7a837UnDbABhxgBhEPFeCUZVslKsgbJGFTnASikfjREuJA4
PMwHuHRxASz9Y5zGaLqm1BRpCKkWadh1585PLhz53eeumFaCmR4mb1J/yiRIqnuuqFKo0B3u0y19
ZiV+U7V5AY1to4avV8FheZUccdNKf7sFK6r5Y8DkX7jYrQ2X4c4JNbKGXCATJzGDQtUsiEz4vcmP
iUVpFfwcfXoRksaQ/BTbWCTOL6ohxn90qP3YPmOWszZjBo6a3YHswf5X8r9K4PhZTfSr0jbC6mID
qWIypmmW8MAhqVjFMLxfdP91ncrtOKZLceatBcdFA2eoIk5JbZeipXhVakanO6I8QUDZKG4ZgdkU
9+s3PpUPYmDuQuoWVM1GNybIEPR1yBnrC7GCrQOTSGW9wVIjiGWRwM/EYUPBl6jDOZTZ21YMUfsV
oxRr34wGqmdzSvoCp2BlUUo1tPMQXU03eFUyraPBXcDrYddPlGZtDsK4v5wqoloT7IyX0HiR/Dmg
OrToP1t/9AhGgX//l6um10LHjVKtIwpUNl6h5jjc9GkielH+CiW5ltpVNm7eKZeG+emQ/+w2Tua7
at12Mn+J6WCNy6O/0hAwoSPwkldgE5eu7iGdRGnv2Vv31xXaEyUJ+09wYRR8uyFSwwS/sX9deKnz
QvbcznpXoUr0Qjo9yR4jygs90G3PvC47e1WDefPWcc57k30EvfQ8knUsZUpXHZGqaFUpRADrl9gI
Tno4tctFLQrz/Q79aJepQEr7/08nR8BZ98fHjldJuiWndc5GIC7+xbiV5bUjv5B+ehh9q6PIhwkf
/UDNoW4I1Bl61/HaNNsVa7piBSWo7N+4oVLNIBuE3DSXFxEWuo7IvGtcC9YtgcSPcTBMGR11Hgsl
upP3Q7NF3W3sda/Dt5pZ0LOd9un7EGbYhl8+T6+jIfPzcEKGbt8TOsS2QF5zl2G4mh2slLx0LLIB
83alftRjDtNo/QCscLDZnqv10HFZX73KeaLcuRdoUUcmHLDTbJ2CXn9Kbu+dOLFoE0ge/9aWiQwC
Z3W9U1rBKsoUFrW3Mu7PdfH1DCdMWT3VZIDu5FS92XavYe/h42s/Sdw9dIXMd21odHyrmw4VUUg0
icenkvxVVSP7YdMTknuzn7Z7v8HL+D/j0zV7u1EOu+VMRD+YYkwNb2jZItyram+9LD+k2+eVL9cG
fANHgPr6zHr7J+0CLO0zQ/FkhYI2qQ/i7I4Oc/XL4+S/z/nilXd3C5hKfgm+7EoKsCniPtb/R5TI
TBu7gdteuIj9ZMvv8rpfi2rnZlxzc4/44yNfptvXngT0t0jpAqUtQf0t9danZjaFG7z9mFJSl8yg
DnwaY+u5kBgq7R7uQFjCqRG6ujQ83dEYCN4wtgZKMPoJZRN6aUG3ovHX7PNPntlUXUrQeyVsAA63
AKcVN3dWX+8dileDUnNmmzslp8VBT4vcflArYqt+Cki/xQwJE3kNt9FMCJ+RdQrjI/3bu/XPVMXb
NTd/XutHfAVgzpblkaRdyIVNedQc8wR844UiilJ9feT86hk44K7RIiY3eVsWmuNLmgh3KnitUr0Z
DAKQiFww7vFvbQVOnWUYiZFW8JDguzOhTwjKTeD0WsfVtIfGhBn6gL7LN7+vkB5tyIHTb9WZYV8Q
TamyAXLkjpMEpPE0+lfo74gkNJxYprlu/j/3gGyjKtazKw9ajWtVeuUZJhKDbl0Um1AgraPU1ldb
My72rHaoQ/DTAihMpczXnnUSpYL9EPOi/XXB4YVLgvB+dwn1tMss7NbKJfAD8F0EIN2h+gK41kMj
2B3Hl6/Y+nj+fY9eROfY8+wR30ZZLnroQ1yIcQM/tH1U6EzlYcEyda35i7Vnv3bKllF46l/umjj7
ihysqXlXQtUCMB+K4RUgsH4/8Qyj8Nvp809ywLUKa6+UghEG/d2Mv8vCwvfgG6OX48fiHYdS+/Mv
dvDrbgjJq73Xzcgd2RQ/T90AKZAEhsvXzaOyt/q0MuDO6d4GPKC/bMZcPRNxmnU6ncWKVfqHHzyz
/kxf+fQQSwu310CKMKH01ijjgZ++VokT/P5gCM/sANT9tsD/4KosJwvQffg9H9sOLgMZp3eJcDnz
RP5mnYZdp3Z8a1B0EJhRPdAzgoPlsGQsy2pWkFwTlh3TfhoGCFvoMZJUJBUKKw9uu3wsukLRF3w9
NHDtOxpwvdERYELFlFWLRfg+wJD3jxWrep6Vq98UsTiEWxE6kxuqmj99a1L3cjBy9fzrxdG/fMIR
rtmh+gz+14AcP0G1s9TS+1ul7/5OSSssavo38/SpTxjy7fMzhiZqp2WnIH9RSJgHzLAvVkToIkDy
+UJsLVA2Ei+anTkTPdiSNP1isQOxHNl/6sVIVuCmlxXr9twrxuD436iGD4CSJcddN8febTytBVIk
f0e+64kCHG99Qw3Us3duq46Na4S/gcXcFFX3laHkk4MI6jIq2fIRGbi0cijtC7f13Lf2C8X83NaA
ehMlaAx4b47QUecefVcv9yPI5d8r3TBr795WYWLeNbjsbcscDihF7FWSat7I8sXISNwIZVeRykJv
QJ07DxbiCIajIpjKknnrkTRymzISLTYlvDY1kSvbH8352DohanWDi1rqxbvtz08hiuD+1JZdl3xt
RghDgpBOYM9UQKKVKw2+aeRQ6PTdzlAFpNn2CBMVK7ZDfMzwD6r9PJCjfSLFpMQvE5edFko+Iyyu
yW0wBRJonAMzhzyDROGxJgJ+Qf3bOvJqTAVpdy57KqCqUUaOiqWW7cX0Tn6aUsP7Mq0KIvHIf/zp
9PSbCOswwNr6Dmj6tuGBXTNYR8jZemJRUC5beOgzYLQbFxBnhcVmvC0A3EJbi6tGG5v0+pi9n40w
hEqtQCTr0zTWOADFFS9a4Yaw3s6KLS31rsP1mD6VFN/wNVVoljaQBIrDd0MB4dsRczr2Z2Lp/3qi
CMXyrodqvTJ8Bfbf0kgH6+XjGT9j6y7Ttla8WR3XuOuipYah2Ur3BEz0bJuxq1biPnh1m7x35xuB
ROAOS3vfa6MizVPQ1bZxhKaj0PgZfLymfPdIgxguopQIEu5cO2daOXqioCLOSu8uVAwGd0tTIg58
lxTgcL/jCouJ1N4N626gCu7ARqor4/n8m56tP+G6frqebnl+iVfK27ihyDBZmfsrhrrOFaOUrxwP
B207Aspgr1dDp4VNKs/th/wai8GFxWYjgPenVXyxxUejsJfLJGF+j0Aar8FpCK5ladRa27Y31FSh
8hr7Wnyaa/rywjQUlSQYXo+fdOzA6oygthAxmDeCj+ww9hIZqgNIoMa3cFZWlpl9+i9Q8SRBvdgM
YnoGJ3a8D2byJpkN70C5hUUIk3vVmGUOnOXLcLok8ur002uIpr2W7dsTgIlqCVcFwctPeyDQRtvI
M+DB+5osGxFsdF4Dhid9vCzU9y8OWULcvSURqFAVqm9nX/hal8MZ/6RhetIp+0wmuwadZ8+2w8yb
enI18VX8c+zmkRprph1wWF7KQJxbRM5K7Zd2PdJg0lGPLFKkXnnUq11vGViOLKUnz90oqmcFqIHI
4Im3X9LUwDLb4Hz1K4utwTH/zdjHLX5tDcQ2Lo2ZN1LWIQO49QEEdp7kiwsGHoR70gBbJHzLsc/j
cy2XfvNXv3sLAYcyvTgWn6lvsZxVQYvJ83uuuMUqW2FxjIobhMz3aL5Ox6pm6yFT4t3Zy0yCx97j
ejmk8SdHbrRQ4Nz79y/EsCcbr7r2HrGVC+mvAgT7cn+O1MgN9W50Bem6ZVH+j9++9GDNZcj1zFIh
reiHhn6xEv+CGJ5eYzIcAaXpswfdGbu9k0LE+RlAWFiVTlrKX36CiRj/99NgBlDOkS+z6JUMFJUc
YVzaROJ3XnLX+6gx8xWWetcg2CcY6w0X12rzsVpbcV2jy2RTL6kN87Q7CNRVUPf54Ce8KuSwIYOV
ehNnYIqYwyLWlPh9btByPnfo6XlRkDNkrwPd+QNgbJnucys76Gu8uNJJCkw85HljwqPBILxmQEs1
EawPUEwkP3OJjOmuWgrSADzZtppn29CP8RIBTUhOyiH4Rt7xrQIjPhgYWG/8NSX05yyPQHKVT/ub
XVViiDzFmMM8cAz7gxb1pNq2w+8xHwXc1oFWXz+R50aRleGayVT7q0abW3Zj3lsuqLBT/zdcgxPQ
Qu9oWZeMAuteXQ0sJiruQLq/ur7hhGNhoBbvH6Fn8y/EEu9ZLyZOnfN9AjnzjnqN091lfxc8I3fH
nBH/GOPmd8sUy3pan0VUYKmDTQbxNVItUGHYZnKTKDxLVB+1sdT0B1Oil4eMlEDzYUU5L6f5tKbY
8Rnac75O+r6QRdnEpXF422Fg27yZITlje8eWuBkXhzq5HwomJlA/F2qmmTST8luRR+dYf2FfEKUX
6Ug7ykJu0OtBRF6DBLoqNU0YtWFUujxir9FqWkUKdNxlUKoiyWGt9nxF6/+5KWenVXIIizp/nBXM
sGcAYEjUewWdREl6OhpRSvq4ZafoFfO33pphn/eq8HF1sbuWn7mT0/MBAKGlUkhVapjO2bPkuj+N
fN+96Iibcv5VY2lCXuZy0NdFhXyjUiKNDJNuydaqJBgRaAYLj5d5FsGEWLv67tw32rEPDe+7aa7M
CWaxhZJWg4TBm9PTi2XBVq9leukIVkHQTRnPvliqxdMNtyF0QSN6oOYj8B3slNo0PqH8a09dSn2Y
uR0PaHjfys5sKVrzcPvDlZ/FrIFdaWEAldz7VttYcZvWBiT8CYe6MyYoGkJt8F5IvRbZLetcGYhb
JRzUd5zIVIZFTSr/dbp98QLID2qyZ7caKRHaIA182/iCig8xGj7TL6DroQVRtC04tvp+amIsvUMN
GPtlBvoBZxx6EFd3cHn6X2RfVmNvHl6xnt+6M4iBZNJ/eckewN6H4rekjkFLtiF1E53FNyggBJTm
4mvFEBtiajbfVVmRyLxC6CPvRFCzadFH1HFoSGvCtMwU5CndvR/uiTCJGxfhg9eIHnb8+oMu3eKe
+3cRT4OYdcZAf7PvKoObPTHqeXkjI0YfzB+n/DO+MM7UGRz9JgVVLdNnOfphWAqf/8gsn93x5HkK
mKr6vRUzK+OhvA4pxuiEe6EEZFWiTvk/fVEXQw4B1Pt/M1miilXa5xgGEBOQgwExbHTcOT2dFLi1
OZ2ZoPvl+c57RKPW2nnCXB7ee259Bw63g2UbVjIpSnaTRX8d1SovZanU/LvY46tH5WXN30TFeTkW
Ppan7s0lXQLnvXtcCh0NUgA2ffqA+EK49N/OuC1EDyJ2bNkWSEAkc5xwZoaPxLuC/uNzxl3nPc4h
+B5eQpQtU+wZ/6qTuvMviCZc5S98YVXYY6DSyfy6l5AOyFI19+KcMwTQ3rVY4Zx1KE/umVKoQ1BV
O5E3aqD956S7Zo7ke5PMoJPKChHNbkelDwI1XK0NciS/xnPZtYMVjF9I4gJgTfwMSqjcTGHLDGZp
LWjuS1OH87XgzNDsJweEt3HcbAR0iTgVOS54avqDeVsV7Z9JCmJ5/e3JQjf2uv686fUzyv085ghN
rayHqYkdw106ncZj4YPqqmUzdZcnfANdANBb0sa4nooAefYuUAr6R2I/Etl1mcAu0UY/gbcWIMeT
M2N1/bDSmIYmLo761eFQ33ptaR0kViqPq/A2Y17m1kT64BxT8FP3N4HQ26HH76gG+2Bu6T0G1lvh
Im5N97X+XJJjRkBmAsX2ngoeO204gvdaLQV7eKnstoxvIjQyrkZ3wMCbS3qsCxXSrOnZreLGY74r
SUXwKtNIBjECSMEmGvoGrlODyFNIkUSpTGzC51QGy9SCdbM68Gcuj+mfWK5t8HMfYsTC30K5x++5
hSPSQRAUoRyXPj7/azTjLf6SAS9DIDwuJza8GYMcyy/zR04qqpXAryHi4ZhUlnZhG+209zXruhOg
vdSFNmTxUKFN/xdGIdYs/hWR1IOKJP/ZTvJy32r9iPrEncdxuTEiNKJZgOgRtFEfbO1ZFOLm6emD
yZHcolJlOmuyeRSh30rEy2jcKfnq9ZAP9KmBsTJgqYG7UTTl54VI+QYCKMzSITZbkLxe7mds8DKH
effvGio1GKOg2NjZ/PgvRlbtx1wVioSpBuH6Q0euMwyhR9lArjfQivO2A6iSqHgPYM8mfcJwCmjm
xAc8GghWlmlTf4Jw9FlccWj4oAfxBm1Svs6HEnFPv4NVR87C/b0NvnrayvWlib96KrZYnSzl26MK
Xo4AuDGHj3vo//u1EbeoV4I2UzA2fFmPW2elbVot2w8HfdkojRsP+/1YR0AdMr/ANaySbc1t/+CU
1btfDjlDoOhaC/yoceZaX6WhzM4u30ek7gnLmyo/n0KKr++fB45Vcn/4vvvEEkobI/gOJs52rIIJ
XqFR2RVgsa3arp7xyyHs6h+rxbhp+nB/2BG0KVPZgBh3w9YLHVkQL6LE6fwo0+RAGqUWV/1qsbF0
90Ec14B9BmAQ64X+iTHaLvlIKKsUWnVbiJM3rC3B7HyQ5wAPDYLMkNDA64wMBUd4TYTq3nfOIzhx
3wOyGQ==
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
