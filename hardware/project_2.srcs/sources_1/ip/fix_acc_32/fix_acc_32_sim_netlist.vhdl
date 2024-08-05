-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat May 18 13:15:35 2024
-- Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top fix_acc_32 -prefix
--               fix_acc_32_ fix_acc_16_sim_netlist.vhdl
-- Design      : fix_acc_16
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xczu7ev-ffvc1156-2-e
-- --------------------------------------------------------------------------------
`protect begin_protected
`protect version = 1
`protect encrypt_agent = "XILINX"
`protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`protect key_block
mDIOS8PXcK1kR53SwDDegCaYI252Xt/PIM9qOoHzBCBlvrVEgTfwXdYnFtcyEPAXpOFIMhuhuTg3
sjA9gZ9Vcw==

`protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`protect key_block
kT/jNmiLcCvOm4mpYCI4eygVhjFrnC5AMm4j4uszeOK71Xgl/qVCrYxLPF4aDiq6Aw38Zd3EDkhF
WeY/0jcivGAjCONQZaHxaNOSv4VD4dsaZEspChn3rUxSKY8CAeCj57qCGOUg/jx/iZXNPzgXXAiw
EdFDmWu3pYcOmd5hOhA=

`protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
rJH2B3YYUuS8PnW6+HTozZ7g9Msv4UCDaK7jjFTdMhbEVUe1n1O3cYT0d94U8bJ/e8qgYiXca3GL
5BzZ5xAcnGzGdiRH4RCfIrrnkEJ+vyo6aJftc0LlV130qCl2WsHqeh7pvyy8tMhy+P4KhhI35zY8
2GgrLu4ViZiS7U8ifybQfI0WVFp23O+tFqZXf0UcisnL6f3G+Q0/XadW3Wj7a+D5yf+J6OuU8E0Y
OInAHRgJFR4mFZ0tkQY0NveQsYlIUEubV+zKv/35VjXOhTmNX3afzW/Z8Tf40vOkCE5MLNezo+37
xsC6cWHbe5pE8L3QQQwddl5SR3NSw39JJXdcNg==

`protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
XKLsO8R2L+p21gFpfS6RqZ/S+qwQZEYn7ET4lzv7ALj22WZjLj+T6sPGqeSo7jeqNmxGnae6P4CR
cLwbIbr1tyZRiz4SHfoXOoOR1aty4sliBFq0Gx+Xs8idPzzJrG79VClbilR4zmW0btnB2k8nMnjX
TxuoS6NKvxzNVz3oyQzntXhobenf0t+ximg9LIAfhbtgf1IR/EUVHUcl0i0TtXRVTdAQAMJO0N6h
NSu8KAMg0q0yIPD61otHRMUsDIQIoBmQkoOxWa4pKUy41SO2RAKYDHEC7t3OAoSvi8kGJtEyxxRq
41HPKlN1NcTyh3+ghtXW+46UZSbOauWYV9/FUw==

`protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
YBSdxLYu8i7Kfsn7jaZ0PXbcgVeMZ11qZ/BxILsQQ2rKc9jSxY2S4+7MC9GY/Bn20R9RXBpqQ5zS
NQQHA8UaJJbD8e5Se1k8ajJSHJORcrESnmeVvX+vRd0R02OV4TLOlQkqgg+wbQnFucszdCeYXGrw
MRZ/9fFI4bW8r19V/32eFIsxHm9J7+asY9fb3gk3V5y7zbKR7OiczF5ObPdO67evw8RRO8bxy1PK
SfRhfq2Lzchy3J8BTMeJ41PGhA/CqGO8aJ5PPQjACln6YEAcEvaKGfisSc1hSwHmMLuz7SUCQo8H
DqXqF1Orp2OqPummRTbSja6a84gVBxFIrjLbhg==

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`protect key_block
Iv6aKH1p+Zl+lBu2Jm9rauXPIgtYGRzAItQkUm4ImgGxvI96zhFJ1u+Fs2Qd5a7bWLqXL7gpjEmh
ecEPwGXx8SCe/5HvJ1JuD7W4LNSw6SKxzYVFIjaMajuVZkfi/QXZEHwyL1Vu2I6eReWlK4tzpWWw
9Vom1a2LQuS3niLiEMM=

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
KUKtpJlLjwg/TkSq/EVPQ3IHPY7bbmJUxOefnagc1ktTJZybwntUvupr9vmVg7KIwX41BupXsbLo
xT7CeSLx14bXAptml5AoDeAW3bXY1Vf7YMUyTtck9Pq769VUDFRLs+VsewBxZQm+a2LHlB0UPrVn
puZbhOqa3/KisEAv4IaljomjCrOr0N793QaLWKnL6b+pvYemk9SW4fYAFNDmEH4ZctSsVu3CgYyt
OArlPhNFvvaIi0mSCV2s73hHff9eONeqUxR1OKvFZPtbsj5TaKbHKqaDSVwnHffj5qUrmNVBT9MK
PA7eNEddw1lMA9StJu2sDqVdD07cietzt90Jqw==

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
gJnCrxLZwsIsrLD7isVFDxb9FVv40TEoPOgDNWdW6ZeclNI9IF6u0/Rd2zjHo17AiA+BjgShy1sv
3G2iw8p0KIaqHeOq+sIBzH3L4J5aElIfaUuKtQ9GOoQD/3QFtVtkaVNRc1DaGugMl4YPrm4mEco2
FKMuwmMrVOg+ZB8NBAroFjFYtUcfMXSQZZYWXE4piiO79s0RG/qZ0MUAW7P1iK+YJoVcjm6cQBjv
jrnX6jzBlMdqzMcOhVNTMUXv3ld+xLsroNDDWWnPuat5k6HGWlxA1w9YCgjwvx6UpErpCyiz7PBs
lqw3R4JFMJu/3XHEKlE7RNxm8Q2GoFe4MRJmVA==

`protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
OIiujmf7xrw/8bkwyRkBI/By96GCYCf0YVfgbfdpS/T21iUFdCiwP709ydnRoi+LtyM6yqL0O9ta
KFtQdr5d2vjr+a3G6oROkyRUOzqDd1o4H+rIaHwbWRuDBP1To2I4agEZ+XgYGnPv26z16TDxYFoU
ppgezHlAg4wCExfW1WAIcPJA8so+4nV3wc2tooyAr94ptOfcedYKH6om4CQ8indJqFRfosRVmPsV
lRWzimJPEB0DXREJS82urS6mq0FYiHxowSxRedzgMctH8pwTSmx77giR8rjKntKp9+JQnV3iFWes
L8F0a1M9MjiAfckXgH+Fim3C0/ITqthZitDkPw==

`protect data_method = "AES128-CBC"
`protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19296)
`protect data_block
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
`protect end_protected
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fix_acc_32_c_accum_v12_0_13 is
  port (
    B : in STD_LOGIC_VECTOR ( 31 downto 0 );
    CLK : in STD_LOGIC;
    ADD : in STD_LOGIC;
    C_IN : in STD_LOGIC;
    CE : in STD_LOGIC;
    BYPASS : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    SSET : in STD_LOGIC;
    SINIT : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute C_ADD_MODE : integer;
  attribute C_ADD_MODE of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of fix_acc_32_c_accum_v12_0_13 : entity is "0";
  attribute C_BYPASS_LOW : integer;
  attribute C_BYPASS_LOW of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_B_TYPE : integer;
  attribute C_B_TYPE of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of fix_acc_32_c_accum_v12_0_13 : entity is 32;
  attribute C_CE_OVERRIDES_SCLR : integer;
  attribute C_CE_OVERRIDES_SCLR of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_HAS_BYPASS : integer;
  attribute C_HAS_BYPASS of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of fix_acc_32_c_accum_v12_0_13 : entity is 1;
  attribute C_HAS_C_IN : integer;
  attribute C_HAS_C_IN of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of fix_acc_32_c_accum_v12_0_13 : entity is 1;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_IMPLEMENTATION : integer;
  attribute C_IMPLEMENTATION of fix_acc_32_c_accum_v12_0_13 : entity is 1;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of fix_acc_32_c_accum_v12_0_13 : entity is 1;
  attribute C_OUT_WIDTH : integer;
  attribute C_OUT_WIDTH of fix_acc_32_c_accum_v12_0_13 : entity is 32;
  attribute C_SCALE : integer;
  attribute C_SCALE of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_SCLR_OVERRIDES_SSET : integer;
  attribute C_SCLR_OVERRIDES_SSET of fix_acc_32_c_accum_v12_0_13 : entity is 1;
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of fix_acc_32_c_accum_v12_0_13 : entity is "0";
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of fix_acc_32_c_accum_v12_0_13 : entity is 0;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of fix_acc_32_c_accum_v12_0_13 : entity is "zynquplus";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of fix_acc_32_c_accum_v12_0_13 : entity is "yes";
end fix_acc_32_c_accum_v12_0_13;

architecture STRUCTURE of fix_acc_32_c_accum_v12_0_13 is
  attribute C_ADD_MODE of i_synth : label is 0;
  attribute C_AINIT_VAL of i_synth : label is "0";
  attribute C_BYPASS_LOW of i_synth : label is 0;
  attribute C_B_TYPE of i_synth : label is 0;
  attribute C_B_WIDTH of i_synth : label is 32;
  attribute C_CE_OVERRIDES_SCLR of i_synth : label is 0;
  attribute C_HAS_BYPASS of i_synth : label is 0;
  attribute C_HAS_CE of i_synth : label is 1;
  attribute C_HAS_C_IN of i_synth : label is 0;
  attribute C_HAS_SCLR of i_synth : label is 1;
  attribute C_HAS_SINIT of i_synth : label is 0;
  attribute C_HAS_SSET of i_synth : label is 0;
  attribute C_IMPLEMENTATION of i_synth : label is 1;
  attribute C_LATENCY of i_synth : label is 1;
  attribute C_OUT_WIDTH of i_synth : label is 32;
  attribute C_SCALE of i_synth : label is 0;
  attribute C_SCLR_OVERRIDES_SSET of i_synth : label is 1;
  attribute C_SINIT_VAL of i_synth : label is "0";
  attribute C_VERBOSITY of i_synth : label is 0;
  attribute C_XDEVICEFAMILY of i_synth : label is "zynquplus";
  attribute downgradeipidentifiedwarnings of i_synth : label is "yes";
begin
i_synth: entity work.fix_acc_32_c_accum_v12_0_13_viv
     port map (
      ADD => '0',
      B(31 downto 0) => B(31 downto 0),
      BYPASS => '0',
      CE => CE,
      CLK => CLK,
      C_IN => '0',
      Q(31 downto 0) => Q(31 downto 0),
      SCLR => SCLR,
      SINIT => '0',
      SSET => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fix_acc_32 is
  port (
    B : in STD_LOGIC_VECTOR ( 31 downto 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of fix_acc_32 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of fix_acc_32 : entity is "fix_acc_16,c_accum_v12_0_13,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of fix_acc_32 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of fix_acc_32 : entity is "c_accum_v12_0_13,Vivado 2019.1";
end fix_acc_32;

architecture STRUCTURE of fix_acc_32 is
  attribute C_ADD_MODE : integer;
  attribute C_ADD_MODE of U0 : label is 0;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of U0 : label is "0";
  attribute C_BYPASS_LOW : integer;
  attribute C_BYPASS_LOW of U0 : label is 0;
  attribute C_B_TYPE : integer;
  attribute C_B_TYPE of U0 : label is 0;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of U0 : label is 32;
  attribute C_CE_OVERRIDES_SCLR : integer;
  attribute C_CE_OVERRIDES_SCLR of U0 : label is 0;
  attribute C_HAS_BYPASS : integer;
  attribute C_HAS_BYPASS of U0 : label is 0;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of U0 : label is 1;
  attribute C_HAS_C_IN : integer;
  attribute C_HAS_C_IN of U0 : label is 0;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of U0 : label is 1;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of U0 : label is 0;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of U0 : label is 0;
  attribute C_IMPLEMENTATION : integer;
  attribute C_IMPLEMENTATION of U0 : label is 1;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of U0 : label is 1;
  attribute C_OUT_WIDTH : integer;
  attribute C_OUT_WIDTH of U0 : label is 32;
  attribute C_SCALE : integer;
  attribute C_SCALE of U0 : label is 0;
  attribute C_SCLR_OVERRIDES_SSET : integer;
  attribute C_SCLR_OVERRIDES_SSET of U0 : label is 1;
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of U0 : label is "0";
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of U0 : label is 0;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of U0 : label is "zynquplus";
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
  attribute x_interface_info : string;
  attribute x_interface_info of CE : signal is "xilinx.com:signal:clockenable:1.0 ce_intf CE";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of CE : signal is "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW";
  attribute x_interface_info of CLK : signal is "xilinx.com:signal:clock:1.0 clk_intf CLK";
  attribute x_interface_parameter of CLK : signal is "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0";
  attribute x_interface_info of SCLR : signal is "xilinx.com:signal:reset:1.0 sclr_intf RST";
  attribute x_interface_parameter of SCLR : signal is "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0";
  attribute x_interface_info of B : signal is "xilinx.com:signal:data:1.0 b_intf DATA";
  attribute x_interface_parameter of B : signal is "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef";
  attribute x_interface_info of Q : signal is "xilinx.com:signal:data:1.0 q_intf DATA";
  attribute x_interface_parameter of Q : signal is "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef";
begin
U0: entity work.fix_acc_32_c_accum_v12_0_13
     port map (
      ADD => '1',
      B(31 downto 0) => B(31 downto 0),
      BYPASS => '0',
      CE => CE,
      CLK => CLK,
      C_IN => '0',
      Q(31 downto 0) => Q(31 downto 0),
      SCLR => SCLR,
      SINIT => '0',
      SSET => '0'
    );
end STRUCTURE;
