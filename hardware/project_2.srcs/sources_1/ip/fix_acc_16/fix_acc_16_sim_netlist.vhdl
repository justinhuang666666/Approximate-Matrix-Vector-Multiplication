-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat May  4 12:37:44 2024
-- Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top fix_acc_16 -prefix
--               fix_acc_16_ fix_acc_16_sim_netlist.vhdl
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
WqJCul4+tXeEdWLkT/8/wFg9MmvxAzKnoRS50KEihikm5pgASiaZ+7QPXMtIEFm2/LSnScOdv6B5
o+g5n744ahppcwkUeskMVbfcZE1/FcqLwYiKftPOmC+7qB6I7kK3xyt9aPeE6Wom4F+b4u697vhX
IeI6iFOMUrxR3HoTVoxmJAls/ZPC0tUaMyA1sjzWP+Ftz8Ur0X8mc/fWp9S51k72rkBChgTMwJtG
O7zp9Y0fRSvjKURkHlvHyiTYbTmiCwS+sWH8BAK2cpb2BXmXETBYzvEmQSClYa0khOuGGwgwna6e
BqwEmSbJJrswQAgE+TM5pCqTOez6T6Xd9JP7lA==

`protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
W61lgvCrt9+oztncrA+fI7emHGlkaJtGjwTmmKX1OFf01y889ZM0MfOHYbIL9axQ7KmJlfZvOblm
OKi67izR8aUx516vGjldaSo4gHS+K3p+DOZzMheynHnLYxshxIB4MEOoAZYE2P0B/rvOvGhBXIbg
2EmNW8xr/thZhchd+Ln5yvgsvzJVDKUcs30EmP+H+OCXgCT+Bfp6Z8QrC5HPxrD+Mp5okRILm4GG
2omHdSYut3mWJ0OfXiQZHrURVYRwtDxWN+Jt0F3Z06mIBf1P1DPT6v17aSjvqeZYpgvGaFrRROWh
iu8N6Bho1H253xe+oBlusJKMaqrKfDqxjtmdSA==

`protect data_method = "AES128-CBC"
`protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20800)
`protect data_block
2XbpC17pdOvztQproQ1gS4UJ3G4V1T8dPougXKwTT/2pw4Gft2pFuXVLqduZmPlozXWpfZ/BgC32
1yalkpXf9aP1I7AfpF2aWPGYjBkRQj09pZGo+r8n3ftJrhAR0ns3JYfIm7YZiGH6hrEleE3rIWKr
H+teDkN9FsSmk84zkFxLhdLC9JRzwkGN7EjTRKiBjiSbB3cfZG5ScCHcmOHwUV2t4/Y+HS8VAjrF
rDHhMQREGoYRwrMcm0RS4dU6M80eIuVC+2OstOjlpfdS8ml/qoytz/QYmtfrnnPIgVwMDUlmlYXD
UEmrjG2LvNoYu4Af+UByuB4COLGOs6IsakA+rsVCZshPzSiIYOHGbSAYVU9Omx3uGSEU02VNHFis
fBqQZ7L/Yf18mBlFQsmf0QD6thpOW0gpAdtG08qUWo1fFrBaGwM9pLGAtITcVg1VP6JlZdpS9Vq7
h6ynjuQJI8R57TaTozKlbbb6JdeHwYND32hGWZEhrI0dmIDgrSpKeJ9GxyIad49BZ83/nMVRxpBk
WRpsOiQ2erKdWboNugwGAv8xKnWRl8kEqeqCSU2g9fCYMh7iY5DtNYX/DF8K6Hakz37M7Pr6WII6
hZWF6aiRIK7M+FuiRu42ZFo/R4Cag5nCMaLDAezWx5wC0AEKLVycEj+M93TJQlzaSMmBk4SieVq3
p7xBN83NhMnDOHAi28NrEv0UV9aUiE0muw1UydeZGwT6odr59lZe2DHWMbqYevJzRbmGgyf+iIwf
bNPZ2yHV8HIdin5FVe8dCQ8Gyp5Oo4zGf/njp5Yrr7qPTtRJJx6zxx+J2jl+qmkh9Ql0ljDGQFx+
VqJZ/w4IuuENfgOOLkb1PQjOtM4mgdpJ4a34XH6jwqqOG1eHuo78+IAIOCgmuO6+Q/e6zBk5bBZe
Nrpv6iN3aI2gcaCsv8u5EfqxWF0MMDaPefHwIjPtexBC7me/3r2U80JffbbgrmmjL6+QCSvffYlE
YFWBdYeIfK4HLrCYywRrTKwhZopSnEx4vqqBx8Vka3zMHJxjfV/oduI9PnoYjWDxzxo6c/Yfrg3U
j9O3dtQEPRSAngd6BVwU/Lolb2CbV5rpwKL0hdkJGPNYtTB3y8Xe5ELzZajpgGFNKtYrscs5GoAo
UQis6N3zvPaFEesi4+NRiDeFc6pKEthAOC0/eY6juznIyQe/TDvGj4V9cb397bqmy01MdpC5B8Gz
xi4ChaAPrrACSAg7o5zs6P/rVYL6KkttTaumZWYfzo72t0kpuBSzMuacCtsv4U7aeU/EkC+xpZtb
BcQmyyBSi08CHwRWYZKhGGSfTg5PPIs3LK2RnzglSY1U+OaNVexgMOHe5YBNNlZkOP+wh+A6eIga
z5hnXg9ldJnoByyWjxv9MaXq6xagOM0vXDE+AI45871aKEP1n7ihC8WNnmqZGzkazMv0HRx97Kq7
7MwhQT1H3EUnnN0YI+V7YjmCk3gVBdsQkqokQHlS2Ju5ioiu/x8S6B1oiONekZxgomhmPRALN1xW
tnS0T4hzl5523M7hY1nDpxbVAxGqJZC6tukRqL4mQSk23GUwnZYTZ8p0LmGvEsWAwbxt5nsDzfJ0
Q4iAcMszgGMYotrHyFUtrcr6yUZr0M4JZtTFn+W9Hg/nhZytdXtIoeTMq+y07OfQkZ8LwUmZCdbZ
LHlg1cuCGywaHI0mvvCUCB4NblYepX0SE4hl7RN+FKw2Z4hE4yUgAGrimzROJCgZ21RToqKtgUGN
Drpdl9Q8VfgGmF1Jz7d/brHnG9oJx3r/i9eDe9FzuYA1kSLhjwwmDUUphXk0n0H77pVRp0LgW9H7
woeS2ivsze0YY2au5s0bQlZKZVVlAnCdKHHTZqI68cveMfi8kaplwgbRKodMk2KpASu+2lhVx6Vl
hmaZY+Tnm90lQk0nrccnCOQ6vzlpm4umMhOySHRCyROx3/xrFQtML4zzrPdbw9KKVLK6oviS+uPp
JXTylnbfqcIAMwdMSyqUccRHazt4HG2ty4ja1WxX6h87fIr0V0qhJBJlba/Ox0PlCVzuxCHcFgHi
0N7GEi9MlCTcQbAdwM+QOdiaYcfIhZdVIXmnQtb0ir+8mr/JFs4hoVKdNMyvjP5VA6JvUZ52AnjX
recs2L8IglFb9cS+I85oUFfVpIt+K+h6XBBhhB/i39udClwF4DBjFSR/ItYeRUcKF7aiULePLPoI
Zh+NgQyM4PQ54PH5SyJIHRAKprvOx85wzEMEstAKhlaUvSB514WqTRGoimTKcF+OvjyTum6zpxFG
HYRWKx8qO2vF2+KR88cv29PmBPAtxxnCAsiw0dXX+9ezfApvpxWaIEE9w9cey+5GHR3uc3VeXKbO
wC0rqrnLe2RxaWOFHlkKPgqUbmpNlEx3lKQKIvdC/EO4wsAQu2LDo55b6pdzfgNXZUFrhaHQLZyB
H5F4pXnkckbzYmbbAbSxInzjEbxBNvU4yTV9wbvkzqkWFp7YB6OFusVOX3QvMgufTK7H8SRHAX0t
fxCekssueEDKp9dXDWF2Io+mfumm9k6C3ZRoVqC9n+ZezmM/o6q9GJKKnO1JVrZE8IgPpuuPs/Yk
ebXZGZaCGLpbEs7WZKB+BaGQCkQVEncLlKtKs2SfIfUPolRMR5m9x/hZ7f7gg/rEoby2emF7jAtq
JVMf4VH+vVdteluGsTMTrZBqSL/Ufd9bxtTRz7MLcWGwRfdPRPdqWo9VGKx+Lspz1tu8UQLXajh5
AdF869IrelmJfYBriJC5SCkoxxFA+F36gKhcu0Rq8EZKtZzuO28cr3J3rJSNcCulsZOrfPKNlFeo
Fw0NOuPRqvGf1OlDpcA//KeAn5LvKuwOAJ+kk3HtC8y0RXGgEFHzagZKJcIMqeamQYDopUpMCUU6
J0s01T3AZKCrD33xI7df8A8tdeXiGXLX+CEeoveyPCbjT/8SKHPli8ahBrn8qBOHv8Dd/hlAGrGf
rL8PkFES7iYESYh+esJBHqAVLyVXcgwmECmMaRYEmVJbEJPJZEtm4LH5VNm4NBGFqyNmJs8EWsXE
fIoPU7RwfjbQhQ+cnPQn8j6RZa4H9mAU1eWpUXjtagNfcC33xm69E5qX/Kmms2KINqdLdrVlhsp1
O7XpIeSwJX0258GUcpUbg3RLBx/i+NMpHf7VitNLBO/6q9qQzFjs2k83vH7cjbTsoTwwlP1BOEaN
e9JMLZDUDDx46RO689ZSvlyWrXVniljCna46hrHVZvgAx0T4/bGTpnHkeLcDmeTj5Kz4EgoS2bYu
Bf3Ewk4GARuUvaaeLTOfOTYj/jf/xC9R3t0cke9rWqaNGPgmj9YkNodPr39UIjnpJBw386hgm3Z5
WWsZPMqcqn/XlgBsfaAJMMexXJ7nnGBdwFARG+rda7gCcaENULIDWnqGq+pVtT0OtWZqnQ1bSkSG
3IYJNIuJ3ApbWESrkPs/Q3BnmH2NipjScHUqOFsrwMHskoPhbhQnuoCKtN7IaJdQfQHnRzLNwMMP
taSP3bhIwCodIzIg9Fhshg+KqZyxmqe4tBQmxAObP1l6eVMvZo4f39i312wgNAnapHbmZL7qSYvD
pYYuTPXIBIwlVVM3MqpMttS+DuCEC9pdcnWSLstquzKzyuDyZWXYgSJuqZLt12BnUA9e97LMTsC3
MIkjRC/a+cfSUUYKf2cZqye7W0T9e6jTJMBa11bEO9Jqu1DmbR1V7XIwo7rwfCytEDPnONtwRaTY
b3kOFEpCrhLFi3W2O2kDTLICnh0nRgtbypf4PU3uoRUyZUCgl77cl1vtSTPs8e3glXWXSn1JxduB
NgdA5D8ex6vmZAWNXDqpRAx+4SnW03PvZVMi6vQfdkELJFbXjsJQ/WZtX2zsnvNYGj5Ze8LFcy1V
CIDEukslEyMDiMO9o3YivV0TZS/FqySSGIv/n2jt34pOsqDs4g7jeAdHgZ5HJjRQ4Tk7nq6VptaC
KEP7bDWVuRfTfhu7L2Ca011uElX/q2wzhHvfeCZQnQ8pcjiTti96SVRC8qEiMSyKGG6pzCUSld1X
zD+FLI/lRK6oFWCj6zteApmJ6GSIJ8Dv/NJR5bRW4Ql1pC0c78zXKqYV4ISjEeIcaoRrn4wqyAbT
1xY6lv4vr/+WV5tHtYkj+dU9+TbSSW3rjuEu/JTiRmUa/yScWf4bdnNhqNvz+glEnol+S7u6kpNs
tFIjJ3Lp5FKurNPy+fzo+KuzE+HEnGpHNXL8vuTVW/qG2r50A/1tjF4bLgF7zWu0IIsivQxPvt+G
SQ8OlAKLJG23l4PR21Th8Kv64G/e8xaA0KngcKkMJd/BEEXcpWXv3r7H985ubDXdoYODPds6n02y
WLH/gfSJwFnJ6SXJ1yS/yE3tfcgCsWXi/hP/Jf5oo/QTIkT5cIUMTb9IVMmJNkVFX62P5uFGiFpp
G8qmliXy5cuIB7PqR+AEScCOql5aqcu4YEt69U71+qxRuQBPy+D1sqygcy3iqYxDtea+FiF2h16d
SnJyVdBoNst9OPWWCgsDUSOYN0KdLVrFbBCORTgzqSF742pptoDjouQf2ytLyT+0Tg4FtnC+Mj2W
ugWrNWH5jCi+WwOgY/A/2PEVF6UIfLVTs2eFlUY4u2X72GUgY+pU2F38dgFQp3nWQP1SKO7bqJAp
zGmbSHBBh8haj3ptQUxuIcX9+M5kVe6NSnEXPstQBsBIz/AtXN4H63vl3Wquf+dn4TioEYoHkL03
VaqoGzQIRLsHS2lfHW7FLu4wfn0RWFAVA+xRngYiwceeEua+tJ6VbrWWEWnc2u183BTZSOBqp5cs
zk1sxi+8/aKln2tB9dWrYkfxOEsOY/dRgdBZZrhOGb0Dz3v5MO0mvLFbBgk67av3yx/+QA/7E2bT
tmaFtceMBsCaWxcselfGbboC3NMqsFQzWALQguwciQokNVhdz8FFnHcI8fuwTaj5ci9C4xBba32C
ylSjGHMxgo5A3K7hQCjOuXqbU7g71YZ++EGdFp1xst3sSrdXoa3W2suhtZCZbxOHBOKOuQ/3/PwP
MBGBQVi4IjpiO9XDuRtuAOkxlqq1Zp9ePuEaG6SdA5u32epcLqtyAroyRVnPjXqRgjnIW+Jd++yR
1hIzFc10+MneLrIYSFK4Q4ebwO+eqE40dcxtXqbjbGxLEdczd5U6M++ITFewTb47VTb5h9MTha10
XSxv93bzL37VERUssfavLTEfGi6yMpRQaHVfpKJoO8MWmjA2iOSmRumfr1ECkbTx1h6X33Pl+ZS/
8zw0fBazjlY0Uo1X5uN4ifJgeApogrYhb2aMC9Ag1Hkpq1d79J3Uq/BL0SW16dlxjg09C2GHkdp6
4JNtXeD2nb1ZBJ3AvNYoaj4fzoWApHIX2jIrUTYz2M91nSg42Z0DmZ3pSSluhC9+pey9o4jqNSca
KE64nondmHAw8qTsamTvoKEL2SDiQenOHTASfV9vefG1ztFr/JA/rP2KzUoZ/AqU5MLJAvswTaT6
Jth0ooICyjuEfFCEL8rpAgmGoqNJaq+WYGGJtEBQvzZ6R2DNm9b5+O9Tx8wWQCE1sK0gdNHzBxmV
6uX4buTS3XvD0++eZDVZDQrGO5PDkZWkjyAHNxQD0bjoe4WN1t7Phsddaiaas3LZegQC1NIxOBdp
4Z/PIOs85UC4PE6ga/Df3cVE/+DNPiB9cw581UAJVqHlQyuJqKRpxil7KoBH40jvNNXNLAcGhDzU
ODnWejNJdO6zBVD72hdn2a4eTExIl1BC1e4uqXa7EDARKjJ2rPJrqltzVc16DEHQ9Rr9i/mLnljH
qKpHI97JHODK1IeGWJV8xM7xCYlEE4Xphfjuj37IpDwVsROP0yGSG5eys0NOSyLPvT4LI2aNToOp
If3dbF+JimsuMTw1HlDorhUfoMZWAJzAnePOqgPkdNTeJpwVK8joDg+Gn01LMKB96iB5sKDdYXgj
5CZYRuxmwU+VPEXgYBWrIpeRqcrXH+UXLIvfDSVrnaavsV3wdnqMeMaq/4TJkQYp6D8UastZokQw
uO4+WtTBhMUkYh/4JDjTS9/3fDAYaxZ51V5gX7XWYMny3T2eAGyJ59SxG5kUNHtfs1Z1Nh7uTHj7
rjUUEtXN/hWmPe7kZK0FxK6i6kFys/x4NQ4YCGnuYCPu0Rvy7YPm5TPI+P9LJOEN7xJRJTU+PVlW
pUo1WcfhmAvRCBjOEZaoqBVgKoPk+cRuwKa0znsuAVcxkuwXqKisTh1aCNQUebcfAX67+jUUFkSs
Si2eesxfE+FfqJGYrIr+B/kK3fDzZQvocyxwYUZ/uQRD9TkXnhHj0EHrAkUreslP6fd+CR1cUpnU
/WJ4IiCWoXbEknvwfYAfElENKgiiSzbdbZoVhJflaShx+zTtrJEJDBzUbfLyak6DRn4egYTJcELd
hBxdCmICdgSClQY37BtFHRjzmMA/DQugQZCXfc/ONq+cNDKZD6LIuqutmbKW91I+YJMBwlccxcgE
5Vl2MFXuCtR8+H/6KfW4D0rw8J9OJmVVT/pWFx9rBUHNgq8TiEJLBcqRkVmXZbRy+qmVQHsgU9yB
1UD8aC0K4fNpvWpYHx5ZMxjfUdRtMd2lWVPU4wyhYa96Kj7rPeKi+wzAhl6lpt1mOTuKO4OuzmIS
Ruh284mfGg/wuRWF8CemNcMKCaDwmuXxNeshQEITGDzDiTluJY6EcIBLhrzhqPfZtu5Dwt+5jWRl
i7OrZ63LlORb0tH0gpkWHPUFEBrHtxTj8z8pR4M5cWVVJaEuvtUXYiTBXeK4YyVz/PkaRtO/GK52
ZQYttyXBi4dSUi6ON8hlCC9HJr6I3h1n+3B3wF5MX+lZciJbpR4/doNxGuoIol6NwbwSl9S701h1
2skY/6Qu/DleHPMbfBYGXAeNyZnwKSAdd7eNkOPjb8zcCfGAu2NT+lC+pcE1Kc7kQtN/wSz1BrIq
SY2KGeyEUymYXptSagLP4v7wjzg167HqV/lfciFEsBUnsiDAhz93Ph3uRTAAn1wHx6c5q7xG5ohI
qIOxbLSBaGdi1n/1pdp0t3fAnr9VcSW3re32fE9qAL7DQ6aVJ7+y8quq9yshmf9juRiFnlYut+E9
Lsg0SPWs4RXeEMDeO6tsM7WETV+aTIZl/l0Jp48jx8I1nHAMJyalrkX/jnVob4+X8c+dTFefu6Ik
rYgFLyLEaLEfztX9sBbSvcfTt5P6/euB9ziU0gswrwbbrlILd2EG3TmFrCtuP8v6mMlGhS/2bgaU
D3UoVdDqSFnDnExB0o2uoWguUJz5S6lG8ONUOOXQfJBlAeuu0Ci8bRDNotwL2Fo8fEF2QFwj6s6X
nk5nT5nkR51mh02bruILx/vWwbqnp6xblC/NdYcdiARbn7WwZCBU1TPojsX1/5XsKYmkurfjcMep
1k6a6QsqJNSQQZvDtLYNm9QSDi/jdEGPji4wMa09a6wxR7km9jX4161IbT1bO0O5B5ddV11tfKsN
Azyb33Hgey5KcnhP6YRMetSptHzn6rO4excTXdivaRudmbBveRSL63JFh936SZM1J8ZS8o3EXvLG
5aRKDcLFJngDfMTBDYioL1YTvqLf8k3F96WcXAHPTxI62DUF+l4pD7MNSOh2e83XCMhQamBf/nyS
iGzz4f8lvU5G4S+4TbEKMfJuWGRN+h0JqoFEdI6l0VdZ5m4QGfK0hLFP9me2zNFjAt6xrpZIMxLM
SFWb09HI+SkLw8B3ISwtEq+L5oHfKOXV+F88tQcj3Tr11uXBMjeWj2iE0t4imKsxWN/PbAVQMj+t
fcSJV7zUb4SX5iCvb7z3aIOrelJZChdT/HtI5K4QoKX2pIgaP8HwH1INeZTZcqPzfPXeq68J8Y/y
QNd4OwhJpjmzeK3T1547QnX8Ylq+RAJxXsGIrYZOcXvGfwrdZwKS4EirZVVXrW05B/YMw1hL5TNZ
IWz/xQPxbXOSuRfVlyXM+gBlsAcJpeoe8drO/Rs8AirxOFuqwf/LqfOkUXuqySvdV/uKRvWWt6LX
y+9y6s9Ha1w7vx5qBt0ScO/wW2lKjsHhHuimix25mEdOEJN81aRd1B1n9jH+1TsWQ44st9ooc7+D
+jFyqk6wdhIHXKjCliWH/EaOsS9YBY1GdMCxUeR9A2qMQ5RiKzHdtiAh/S5xc7eeX5L/hB/sb0i8
TOW6oS3vySxwJaq3WoIqDTRlMxa4mqYXuh/UDCzVTq9NYJCNgfzvaBMoLV07QQFAtQade8ttRdBa
v0T+D8mKaMjntwTfpjybMZ0R5rlK5gNTW+VieHTko0TaQG2ZYVMnwLrVTpPadc9hyBu/eECkN7T0
BHJQPTZjd149EgpD7aZXn4j9xWrbwlJB7wtp9MTPbLKg/a0pklUUNoCib19juf4y4ihhwm061F33
Q1ARKz7UJBQ44hzvulmWF9NlThTTo1hmY513LjY/INq1TToBzft1hMvdjj4Em4BfvmD71/D8lnYH
XpsdkQXKi3G6MicoElFdO6KG6sQBGvqhtcnOZVlKkf1AnlP9xjXQaGOaSEwJnxpRiGGS3zhoxApt
qx2v15Xn46627GXMHaSqqmQq5+zEYUP7Y08HGgwCdMvWybS75elcyzdp/vVzxlLxc0jiMQkc+8Se
RKXgbmaoWSCo2P6MSfAfWGhDulBOXmrBeHYmsYgYfYhkQYAzGwyUaJRBbjVOCEH863+FFST+s9RF
uh3JbP7YBVpEEBPlfed+V0rs72xjtFlOtBE0O87axLzfD+Kfxik14Ibo8RKFGd04d3gjO3vVghhd
8ZhebClI8WOvT9B1JMDShqlwlCRpydGkTqpO/F53bWl6zseSd4UDY33i0EthDdKmB/o4s+iZVQzh
2yObPE2VKyHYQ3Q6GHnW9h/ot5rN4qoMHL1D1cAg2n05Fvnvfk/oYg2wXRufW/lfLgHKkYujbwrt
ay5uUsmK9LiNKryW8UnZiSeIu3TlXsHouMwF0iDwWBZvGVSI1ON9twykeLDPQuhMDqZL+IdsrPhm
AuZyP2+4SJrurbDQmSFerYUYH00XaRtLrIJkDCKJocdl0q6BywfbGjcUrkXqnpjo3uVycfhZG0EC
QwRyDzMn72mLLjcvJ31d8yo7Aaiz2UXPs+wGveTWNDcJtICSyNyQOxUeiMegt4dY5DDF11ZqeYun
GybAV9duPvyueIq6yTLgRhb4e9TI3WRk9tCg3zFQZILAfgRMPKZ77wAdmjnV3R3kCblw4VTCxbad
u8FXUC7B7tHrM3vLIRGVPhDH9NCs1XO3L4E+K2hGMZ5ylUHZLZGsWcIs7hC83SX2XQjSkh3gVBo9
dNJpwFCL6R8r27YQHDz6jBMPB8bFCaNq1yC/bqDn4qTeO5uK9v1pIUCp9Vd0fAUD8n8rvuRfM5d+
PYcG1GUIuN7tu1nysPSAN5E2MwyzvGQPhX6WxGarTtmrBDbCN6de7adcvrrwnMcN+NTZLc+OkY3M
IuipGGV47AKk7rr5Ou63PnwwH5kubnemtmt7lwbEnxCo+liY+jvCKr+sDj0o8H2oHpel00GQlXjO
APEJC8LYz+VYIOXYe5HFPHaH2Pkayd6Cpu/yq1cLIP4ShxUy3omWIN//Ng6W3Ri1PQfnOLt6uUf6
5cLrEdETbPbfHf9kdEvLPeAK27ef7TwIEIJ3MzDkfQWAEmDZ0hDyfW0sN46+W7zRRRSdlRJ/94tF
jQJ/wgZ1+WQK5qSp/yt4YIWOQ3EeH5HBwvMxAbF/S3xcCdR9L+o6dUSbE/0QW73mUF7Cbt4fut3f
JN+kRYamXVFZCY8a5+zUmveUBPiDCN+/iJZafXLHBWOyqJMxNIXzBhQKy4U/oPqc5jDid0T/EHW1
3ODdnwkjqAYijkTOUEt0M3ZNdtxswl4T6N3gXLhANdXKl8Jy12x+CxFHrgxi99L4uQMOsuA3LbLp
+iZaC0/7l/GWQ8AgSSkpGeVdzamevl4wK2vLDyT72hDOIVkKkcdLWcmJJSLA5vlY1aqe6Z2SBCU8
fqcBG7i2qGPxdpECLYlETcomz3MA7PXne6TxAi8e2tH8lf9nERzTXKanaHFmABks6a5JmtSjyrGC
auVwVDrL+7hEvJI0TJdcu1ucJG+6YdKW58Z+SZ9/MY+oKoNu08K+898i9/rxrDVka6mighuiG8b4
hPzmBIKHtBLku6+rwDx4XtJCKWWHYlHxiwRnigq5c2oGqLoI2nGPVXBlHBj6TlM04rU66LzeDdTU
gT/aXLbBRU+I/6cRvA6GZWtiKMOMPVXI6sC+ns7mp4iOOHwIxc4omJBNW5MAS2IZkGABZX9eGgYy
2kYSUdcSIAZKGnfRv2v7U0W1lWkUN6R3phnKJ5gS7zGqlHGuPw+smTDgIwOubH40CFXFXMc4Hvmp
aUYSqdRkD2e1wQRtUwiVDH+jCU7Xw2iLtfG1S0LW5BsIwZfaJ7W3tmAxIUcrvr8jsACWwaQcHQwH
nH93bu8Pn2VFpadA/8fjMQXp8Im7yB+NDWxr6qUwrliI4P/hrFMWJwvxTPcV4KmNnxaJ94bDlqtu
CX1eb1KFi7m5tSl5uw0qeTY2Y4PgOwVYxu825OF6PUkaxmhBaPT9dabThjP4UI45qPRV+X5kcpuA
/3Fg3VOOjxOh3tQqaPYYitCor1GB4Qbw1M2r+w8iP+5e14Uf7yOcTLWspyczuX8gIVPvI4QDqxm3
cm8tHrui/YcnLK/WPjOIlx5JMr776m9YhLzCAoDGBTow/SBh3Cj+7B0bs6eS58j1EHOL1eX53xLf
3vPh8XKkpO69Cb3+K7mtsh5HcBwGTfH/rdPlHrWxvLeHmUu3MHf+LWNvLB0b1+qq/PPXTDEr7trB
YqpxG1sAEK3dgkrWsPpcOjSHVEoIj9RjDBkskYLP3baM6eg7L8xcPyP1PLKYiWQmfNY1SxkAqA/E
pqMvg1GeAq7mOViThd87kdSGppiNkDPUtb5hx+6gWcrXg+pvWIJ/x3SR0GGGJtJtkltIhQVTQjRz
fqNtDrLPcuI3JE4X7fasgxMnU5PJY8ttcweOFf+KHwIGDUOi9C+raBfMyxiZiIlNNjeYOmDgXjpe
WHbAQUzmI4hPgXgeEL2UdkNmArV+KUd1OBfGv4oY90eb/knlow9Ms5EqWL0gjkp+DeHEyjblco7G
2EAKX/N1iOToTnLT9CRk90nvE1oNiG6DIsLOSRSs7f32oA2YanqvezqLz8i4NoYbWuy5xys9+8z6
NZJSAwxep62hzda4yV3P7CpE885PbNTFl1wmWCk3ZIGBHY7AlAHcn7wjVpsgC9GvvEsAq9Lfm8ET
gMGlQ/Sf+/fHL/FEOBeL1Bp5AfxWo761Zn0Ewz/qLWOca4jSIjM5eI20maXCw0kqqJahSz76Xubl
Rm9Bnnep3Jh0Ro+tpgP8vxKoEy7DJ4yeOs52huX4gtwznzF5822i74XQIgcd4u34+LUQpyvLrYk/
hDV3HT32lhusbQ8seFyER0RQz2Q1uDW43pVbitr4NIyk1gGmZITi39iYoxgdd06XST/Z3a0dVkcl
4czL4i6mXcd9OXfstD40EGI75h0iuTYKdjaA5DFajTkeXw/671P5bHLGiLtTXYbVq8kAa8rwWWRA
j93fu7cxwvkRyeRhTRFktrUK6IkK2eHHZ3zNYCEceAjHiwz3I2kS4mGq3EVIJscq0DOnbVSTElpj
EkrkxIp2181tkQRLaEx898zTgwvREGchi/R1s1pq8xqt0KIKwCqpL4zD0Rwz32or7gTyIDuoOwv9
vCgQ6YnoRwcXx8ZZqnpRugiBL5lxsSMYMiteP+AdHaGN84WK/LBUxrEr8owf+pdLc4/NP+HYmjHo
KB7BTiXDwA+xxA0C9ihRY9UQAW78i16PEaN4eQ2Spgm2MUq0HDYzowmOatUjEc9psZiHQ+Gsfq7h
7e3urPDd+nD8QX6wt9vv5ocxGPCHwT05D/QnJpIFg9JkZKAXHVKlofEpT0ViJnOZnaCguh15gvfj
jabNxtJ4kMcr4bfFOu5hTTutaS2YzzjqWdUn7LB7KHS2hcC1auNYEdmqk+UROopqFwuI5+aQEF7Z
/ufMxKYuu40Kw0ZRO71n2pY8Rxs0gO+flxNFBANXX2TaaBmXvm1DmLS1XXq+Jo8/34AI5xkieQBl
wLizjvfsRpCdU/MsN4LccRZtmrTC9/1u4KYBs9eeNcxBL4if3HOnYOXDH5VNXxs8I0VlPFvYWXNR
I/2PqOK7Czhh+2mpifPrSTXahGWTvAqej2Vvx+9s4/z1ejuBWW9R1OeJn8/1TlXB8+wrC9gYdf9V
fdic+4p2QuP52n4yIRSvUFlCzFULj68ceJyQFLv6ThkNuE9+Gf02Kvva660oWABOY+96DvLXrTKR
aZSFxmoQL9If/2cLsM3Jy1DAsMs/30x7YJHj/WZxAHda+undEDMEiXdymyNNJZBJXhEoeiVQWMfo
up1PUQCO1daHIfcxus+eawudzAzE8TFENCKZ5PN+Ok2cp0T06Dayv8/IH7J4j2v/I6Gv6i5Gjap0
e0xg7IHoMe8IUZmR1fNPZp/ITqA6JLFm3MUYUiAVUpl07fli1mS5ilIdlNOZlbuyqrv8LXL8EvkR
rXtQD5AzvqvlluQ7Xkd2dYmOF8gIDfWqFDw7kKbQqQ2kWp7s2oZ1uvS4D/Cw9Iht7OKpKEsFerZa
6G8Mo9AF4jmiapBgQY3O33GRQ5yedof7dp+8DM3dp+SmcKWRQyIqG6v6V/Jz6r/HMlNcfnNEPOBL
unsWr4MooBIHHPLjhAZuznJ9heEHYlB/ANo1t0/mCHCXtjswqa1jpr0LOiDne0f85GOIngGxl3sE
//WluU0YwJFF2oPJdzpcgI1W1LzcAwccYtOx+3cy58e+u5bKHczBkoBiIkqzT3SYDlFPtP6+hWbp
N1061ad4qWx7IctEEZz9Dg0DS2afWyKU1GTEOQ19xul+uYGLAOBcR/+kmxz0rz37B/9VzdTzFgDa
u8e7Y6+BPohTUQ+XYQIYzo7zAOrlK11mpcEwPNlAGdiRlcaitbq/11RXO2OIs/Ra3ZMTg0vxSBbF
Y8XDN67y4PnONjXgF8itv0VzuKktjVv/otKjfhIrh1Bbg4MsgJIlQiQIHJ4qkmav10t1iSHWFSgE
71pvG6dNG2FJpZ0DhLaNZh/P63lW/i9pwyKJJwyHezDDWpJLdCrNH2NJt72ULOqqnK5rFt5S5CX7
NOKrvmLU14v44zKUwuGH9V06CNH0vOPx3QtvCJpMdWWyWcRRB6t6kfhgmxds0wMdpLzUYn4H+CTw
DlrNbg+FdwXxVxW8HISRp2v2WzrMbTNpEozMSLRJgLryZ4feWAxAwFSqsSsZutjFR5R/eJWX5i9p
xdRlPpbsM4cyRJTOiLeTojEQESrePKL26AvOu8D3X56QQd6NI/loDQKmMU7nyrZnmOfHBMJVK5aG
otUVaez2eA0WUgov2/nb93EJ3GytcRE9+724ziHosfaDpmkZbwLfVUder0Tl3N2p3Hpyi3ghr62a
CTMclRSM5leIpctJpe9SIq7qmwm6AAkKT1m5j71rH0Eo2tJjaiGkzxnpOXAAOlkpIxbhXaJdouiT
BYGXzD2fAdWEBBUbcUY9xnX+wrnx+PFfqdT6/BWn0yU0mJcIguz5cs5m6vtSgT84y3zBEU94vUdt
AlxG+fIORTwKVsI6uiMBZ8jpIBnPnH6hHOhTFUGxlaWt9bBfpA7V/YyUuBIhofPbJ6l/so+PITfg
d55ZTSXvL1WO1UMMKtNw9xLIfY35afE1iVCgsz3nh9T4aYufKdWYMwMLoO9l5AuIGq/Welx/pG5T
ZlVH7VxyDZTFt0GYVo0Qj6WEfnKKhnCGok2Pw1pQEwoxQVoqDgoMNfQKoTPZH1oOLRqTdl53ZSvo
B6n1SjQGbwIV66CMR0ego+QOpKbgApQNTFolrQP0YAXNKZRB19OXeeO4MOOyeokKLfl722aPoaxa
B0l//JXdSAsnX+o+ou27AX03uk/NhL1bhrq/qNGefFhgPoiIhbFy12oplbwEX9dIjiViYxkVp145
z/ywjPCp9a091BKSzlFoIRmt+VCzyJXqqsFQQ/uQE/5MvrfKFXADxm8G31OE244pbZE2Em/kupRn
0erGZTr9zOuY6qTRAEpL9xLsix/eFTjX7svAdD3KI7g81kMMQmghqlArPo9afMHuUsq4zwmhBBAn
l51r6Iot1hlKnsLbUWTvHoiuW12v8tYLo6zF0rgFmIE2vQbMs/AEj6kg4hJx35/1nqvfEtUdEISP
9Os3Nonc95dlxq/FcmdSuAfKzhxcAw2Ztvdecwb/Ba6Wbn192IUFZosS8OPABLwPyrl/8bH3PBng
+Au0vgF4h6n5dTPLeqJbJvBqIU4zZCqAb2Ano8dOBpSb3HN80Qm9TyvHOT/G8eqTMppZ//DAkBFy
dyE+tM+cD4ETCLtmj7GN8Aw/taxj+VT+gqLaJE87WcymW3HkBd7tbCTCIbjjoP4jVFZTw5AcPCwG
4h+VKh+wmCMMJUALy9vyEdsjGXieobphHBKzF2fVHb3GDfHcuQI0L2pSzpNwhBSF2w2gjRXDizoD
vufVK3643WUipk0ULTN48rP7zVCTHuDVHHbss6vMMe9YP9zPVGSMBvN6OM0hKW1JSzWc1jwSksSh
vfUmZTO8LNG4s1+3GfVFYb9rw5y69yAtRlD3vhFv8mxaHOybvXrZKrc3OyLUwrZGvKuyu1/YznLs
b5T9ViwLl7L+Eb+ALi/d9r+8zOK9r8zxM6aJP/41zQsx5cdy6rGkX4DydADjEx2rJqujFyYLQO1B
4A4YC+hKYlF+mRChDGl169s83dfFmWg08G58TyhjRXRp7oFhZrE/6bDYD3JkqtQG3/z59nTBq+lG
gGhIu1hj+8WTvWqZkzspLSk92NdsiGqoJqQgG8KW5zbyT5w0hXWzMeuwOHbmmztnYLtyd4IpNc1s
K6f79AeEHGVLG3SkEXNd3QbIdT/lIp+IX3NH5IVS5OkGakVFSnSYAXxoVV9jNM/ufXE6N8YNBhuD
55KXm4zyo4d/ZullkiLcjIN5ZzN0JfbUXF6nxuynurm0cbDgLrQTAQO/UWEqCzzctAYOuMjapxGZ
UbALYKXluka97/wuDUNvYODEs6Rau9s6IZB07NDSMmp40Rd7Ll7Sp09wxeAEgupPYYarB07ymqlz
7UjEzLlZWkmadtRDTr3lGXDEiyLn7yQGZqMgGfsjKYCMygxqEoJQ/bM5MW+qr95jypbW+pV/LwXK
zOBxGAcIqvFKKs3kFlPIThdLY3AoWJSngY614lPHOuFfag7PAf9qsmSaJa80kJl5RKKEbm+LV9or
edyp+YexhhR17LC2dnlIrfFGse92SrTWBM+EfqlIjIvgd8My6ki3JWdLkB+tuBB+stl8I92HpIun
HwJB4q4hiW57jyRz9BWbNDjeIIbzwX1Ac+KrUClACpqOB4Mf3mEcOm2NEqR0CusIMgjcJpGk8HDm
uFk7oK+YGpbp9yTdlufidJYjCyxaj12CodNHSlixnuPNpYAgBDOkscnrhHu8pz7y5Jglm97SLYFw
meZgsEVFHQjO4V/Wi1TxkD6I4SNHMPwXffQnzFoP8AzkULjgKTkkncVaHjNYm+J7Zx4uMvMb7gPM
1UJehdl5kc8FoxjjcKS23IUMVLVY3oVYbi26bA4ZPTbajXzGnWHsOiObq/yIMA46t/zPF2B4xrsQ
2GKo+tUtm+GVImco/ypcPGRnyBda3la1Sppmodo6nRtljQIMp7UTkTO8LTSZ4VpJcPHFaee8KQUv
6nTyP4nK3AFPpL07shdBq/2zeuQoUnOQnZ25zJZDRxBLMJk64sNYeqHxUCxKz0m/gXDVTWeAFkj3
F/6e1ZryyBkv3h8TBZ7PRrEIaUBauCvgUjLau++FQrA231mCpUIAKNR+2SGhroPgmRPWn5pM+CF4
TFjNsum6B0/WRYV2+f2WckTYISRsUnbzmpOYLUYjBQbYxAAXyPZpnkcMQOzMxY/vWYOCdf6/sn4Z
08sgoPYBrRhTjfBMdJJip42y4hRUWgzk6aifE6869uHrCEkdOC3f5nvPdwloF3MJGWYaLAB6klh5
ybocQ2GrZhMZnNmVeJoaGBXS5xXGgpgGYFeGP2TsWAqJESfiPjqDx3hBXvrZiuyOWvqXHdT5Mk6+
v+v2aRmJVU2Zl7sf70E2xq7Ht4nbjnLEj4JtBp6sCbODlk6NVrqjt2YWDxzROEX+tl/znRQQ99Hr
lh0FBAy+AsTPahcLrLAGnIWusb/YbA9Q64+wcyM4VskGLI5+MipMaNizeRGDZDsxdz13OOp/65Sl
PEhd1SFGklvA8+5dh3uLZ+yu2IwKvnEXfMVQ5XfzPX4kR4mWclHsCbMJInP159/RU/05LPow5BT5
a6bYfloj3gyule+g3a0ULUY/3wyL7Ru6j55QQNVbUMmdSGGFPMegZ1mmTh27y1042zlz0lUSlClu
z5H1UG2dxxQXNNhVOUo40uQzLX3VaI2Zof0bEgjlCZWWjiEEFvZEOpIAIt/fR2gL+5nuLiuc3Tk2
HePrBP/LUteoFYrHrbJT6557g2uKMDq7sqE/US5rX41g071GdGK/jv5RWumhL4GEdVn9OUqz2ujy
1R1s3ymixkqz8Hy11fnehaasSd0dmTOGp4o2j40GfYnkxDeP2CnnAXrENeza0VHC6KJc7lOPQduQ
rKBa48maoB/v8F1oatUyRq0g2AWe8jANH+wnKPhh0Eet/Nz3Zwi2FWhhBfMe9zxltuV6U5GS7rUn
sMuLp57Q0kReerNhytzH/tjsbo1Ej6pWqBCU+c2+TET3rEOzXFkDRQCUHOvYU6LO+F8gGkepV32L
1VDV1LwedxVEqZoaho+OGy80dL9lI4sOXTiKrP16azg9JYW8bCrWxJXn8RTTi6E5F4wnGKFVgR+L
h666pMkrgG1Mjle4ISV7ZBGbo9M3ncy9JKLbyeJOFiez9Bs0ihI+HHVY2crCFq2M7v7Zw1cEefCS
wKLd+RwUsghUeQQ2oIfvhHNE4y3EawwvQJm78wLk27AbYzcc+5XteC7ya4aEYfPsUmcmDzZT61hV
gbB+RLaMJdEadNRRhMNprppiW/Di1G4WxhcdRNZLSM3ireSBmLqImOUVHgevoS/bmlwL1EqT9jYL
fsE8QILNP5GpOO//LWBisPU3fx9VVXdMLyRN04zzC4wfNpdcezB8kQwN9KHal8/BlNoa1Tcig5HG
jp70/mD7UNCGMtVln/EHiyYvWsm/wXG316QXUF4oN/KNBV5b8IzxcQyQf6zc6U7ULBlPgfVUgwEV
90yaiZgJrNPBGqvSIYWBCOQQCK12WvgevQt4gFr/1xefDn9ldsEGJSxz9r4ug3ohgb5pVyN59bhr
anK18/Unk+HDU0VwE6Q2oha5D/EF/vKgz62oEJ3Gz/sXVpLPecviBSunyChKWK559qgBDiVu4qC0
yxhCXhhtQn+UEZfRQfg6O4sfrag68d7+rXdbI6HA+VX/vqgjo6XEZMHdPuKXBUtDWMtlpTDfe/OH
fbFJsUHz+UyY65EzMlOUGltLsVagrzjfpeJkpmHZhofVlCYek3XgwKfSvtLGVY03J1tWGbJTyQsn
h17AT7FKjdl+t7ezSnva+Hp2yXzY81wH9iFOJbizXAcJob+O0KpGmK6o8S+0fz8N8OHKiLs1BEJF
L0Y/mZRjNh0waNw4x8k3mxdXyqrfSTiDjMkcIlJ9k0puByJal6U3AT4Rwk60clKtB5bHjRNfE7nu
ve0F1p/doIk1w36ySoY4XlAV2WGpIJO5bX33Zv4FG9klIvB/fXXUhUAC+OIX2wP2gM8faNXHLXc3
pImXCGfiCz+FxLqo8X8GaJoNT1qVApA63pwTydf9AQypxuxg0IOvRX+XPG0kWQ1tgfmPkqkGe4+B
p85McCJTIRnzcvvyh87QrDsAufAoYboQqk4K5/9k4iQAvdAos1+cDW3U74hAnPj99Emqk2fmSiYh
H+4s1aXhJiks/l99qkNx8L8RHio9Pokn1wMdaiyZwUdK9dK6sjMls6iRxtyMTmHwn7A5uAG0rgxo
8E5n+G4jluvHsqa72TaMn2rAkLbVR/Uu4tsw3zpSL7UQ5pq+9k1p/YUM8odB/aPxeYvZlmNKMAGT
d3vZA6P0ChR2VStdAuDMK8MOzsJQmAwcoY1MBbn79By/MTHx8xM65JnSaifsq/27k06u7Nx9Iojw
gc7SMe6CkyQPwkul02ZZPOAUlRdBGSAapbL6na3N6gcv6IM0zmebGHyce1IavBFKz1fsqRVMJ0p8
+DrEWW7zQiUz0qjaepR08rPXrI1a874F0tfQ/lNqSc/6y69uk8lXwzy7uLuo4J8H/P9zN4O/V5BS
S7foCfWazdqQ1SJbNZ5loaIAmytzaWGNxSKPcg6Mb0NuiUBjt4H3opNIeGHpWlSeU30FnXp9dSIt
na/FXWh2nvVtfQhK1pmP0DGZuWLC1KNff8OgIIZJVUiM7SOGxQ4ZRh2ruRzyQe9qH51UfmpaDbBK
qdDm2uOiUo7186Ujkr3vaa3I9XU+tIolGFgSIHFJhkVxFkjABWK+n5q4hlE21u2loeA95oKxjBWJ
Vg7C7omhA4397Hpnj/FEHlkRot08BXw9Cjkz23uVl5ksiHDCQYXvChjDr8RsxAvZC0vqSbUIGMa3
DDRs5phFFPKDIAsGWYiRwa2xBCULqpQ436oFlpE7Z/Ic89pT9L4BDM9mQZu8f33mUzw6k3Uypnie
L/GvJ1MMxd8gAXm/M7Leq1VinqJG/bebtNx21E4Hn8LEIrlETRfskVLPGc7LsA1MfIdPUoKvPkte
4z040MVV1Oj8Gw3CjiYOLYgKbkATO6P5bRKIohQxCrMBQj+sNgt+t4YIJchLmIzMqkBCV0hsHwgL
emZuibFgn5xC0o/cFs2bXoinArqNz4N56a3EsnA9lujn+xnG8Z+pkLA2fs6HAtnJDgcKy1qUTWw5
uwVkGfAaCmrzVJgcHlOUwPYLsbmMjPAqyUDZsAvknCfigamBgiB+UCtZa4f0DnB8cY8G15mr7N9P
nCQw9AcxzlOPKlNFNxSYZUrp1LlU673coJH6kYrjpGSqpVEVdPGxjApCdHsKw1Mejmlp+TtBiK3D
H8uJmBXI18BSvnWHg2w24pwCNlZC/hp2pAl6NK8enmAkvAt1Aa7RvyfPGifZrirUUZ8b814OTNKm
eLt8l1qHYSDQCITJpRk4af6G2a1JxlAOeEOJPXTGn9qdOJXOrJJHHJn+0aG3JGgOcuwj2Mj7jstT
5AowumRyXqCq3vW6KfrxcZiE/4smzgLX5Pupxi88rixI9gGkNBZQak5MJa1sgyttv+GYBgJJtpLr
SsTNG5xf/hhmEuilfOFq0Rx6hqCjlp0+XeMN/yMKfzCF/XgjLq8MILmGY617j7X1uxnDXYqu0szD
VsLhLukZGfyxVr15AwphXZ/Eialyi/WDPkYCCujKIjEZd5jY8ky2iT+SWZKOfj2kDrwUmYby/g6r
sFJVo1ktJUGfCsL2a5QZ4+S97dpiHZuu+VnHpDB9IQQaxU3ndvI8Z61BSCwl6PLwuZE8EyHsDCdH
KIXJrVcizURjBqIidr9JTtEPfl5N/rpxCplLkn80navYpvjhh0zYn5JU6tzfz6KV0DCvWk2hAQaK
RR6EJkHQULbHUQzi1u8dBN0wvmNNIyZSK0SLvWH83vo6VZ1YqQDpapQVcAFoVrNCAFOkASSkgpIx
dr72dkgawbUgEmDJD/eU76iZf8CJ5Jf7V5VfAfj5VptnebOdE5/PcIYp4gPnSm9Ev6+1qFeLHsTc
YYqZnTe7bHV8Hqtt0WXiBsa/ycSfT7GL7EPz3zOsx0ERms8be4FdJo0+9cUu+bceDpW6fQPNR/W5
JcaWXSdxaNlgy2EXqMFcnLnbDwlBfcFOis/0qN7L82Y2S8PrHpgczr76SDqLhoCccWw126oN35rB
ZIo/w3ZgAhqYOdBs6yiRpGsF/55wZDagEpgJGf3cPrExfKuzPnE7gvjfLVSQqkG3pI4fqN1XxQmK
VjVeM/y643tqVAuqpHXzUtoLOBkB8k5e/yiFClxu8z/2uWDqG7/i5upxiDHcd1ov/KJSMGZVZkDC
C6w9xlVy4qYG5IZ95wuO65q+byg2Mr5mJRI3osn67jmiDKgkNx3g3XZJWeCMDOWNNFgWcvy+hqh6
/LX6f67v+kc/3haCycT3tTgotN6l7FAWXKQAdr1qKwvhX5hQqEg4KiBDf72/cRAPs3FU2h+tuqJU
Dk+5ua/Q/rLnmFa+glmsc95JMYAnI+FxnLhgF5r6f1oU7NugNkNh8dGy8s0HF7RbYHF1DzsVK4sW
sOiDKS7O4dXksa81sTUhmdR3tSOhnriYXPxJMtXeh6jcV/NVMjBW7Y5ejbsAhX7Uw1rz13OTDQ5f
p5mZODu9gc92SAfiutr0HOjsou0IJ7FlHdSQEuc7RskMRc98PHececGCmj+h34R2r+/xqhMlbayy
0kuCY1NZ5f9ofmjlyqF4Wx9OXfTDEJzLyBN8WxRe9UuPg0j1d5W+PhQBXU/Jxat+VAq+NiDtjNc/
uyEq5zkILF6h42yK2nESY8dKMAK4snePLBnSVYiMBuygdBMncpogQaxiNX7fao2ilFNUU4H15uy0
IEyFdR0Fu9nO+km8ix4rAIgadmwx8JJrkN7HPvgKqdyVjmTIV8vGJ6rFk2VKP3vgZ3IBLJmHUcpO
oulDRq+erIAR5J7RvTeQQo9yqCSV579Ql5fOoK1k4L+Co+Lvah2Eh1812BeYt3lmW+OUwQ5niwya
Xmt2xxN1fpKGCZbFfzqA63VWKvTJyPy87HwN//pvQL6tgjMaxtpeLT4ebdnBG8aQa8LXCZD/65Kb
AOCGASTQS8l19Ed4dBb87lnKxaersWFGumlaEyHpAnGnlz0vCwH8/jkm4CVmror0QxbbhEQJrzNS
2+n7INOfGwbVXPiUPCZXxRoZSK8UiYNV3fA64NlT1FL15DpLrYE5aui0w1UX60pCTnfYc4Dhw9mu
QDS3qSZhTIUySXWjt3DlrJDtr6jbdNQJ8hYsGDFR+NKOTSWPxSFnvW7/XFh+I6L3qfm7eWs6LLed
3+1iGFmDOfvwd5ER5FK+CnzwZOsh0DuPckJZ+KyhpdOD7Orc1v2p/v8/Xof7Hz9r76OUNC07J9JJ
wTVCZFr4LhNE9QwV2f4EgJjRX8riFMOE5hzIyUE0gji6yD9qMnMqU7REeMGahBUDFuuisrIj6aDV
WCFD4f7zgiPYTua23JlW4qsDGi+KKQZjHC2fT85/8V6Pgc3xW2A8KJzdCcxv9G3L74RyWTyD8m2Z
DZhkBbFNDGxDkjQUTE6EcXM9DXN4I3CvaFJDRGYtjUL4ik5VCDX7ODLjH9PdneL9vCBc54BgvdbT
+KDigr87gV2UEJ9qj3hL7kBhIRaw+2BvRmlCx7e0jtj0vuv8kp51acTCTSKsrQKwWU9FfmQ3cJov
xyhfjy4L8rl0yh7icEqFsXyXvbsT1XVDNQUCQ0P0dCh5ahtThFbTa3gJNZhaVMeSzCV5KuEu606m
UNUJGwQBBN13uWuQaiMYRFlD84uWgwoCGoYZsfJ3DrfNBlXhWqEHh548hlVcMsJOEnz3l8HmC8EN
4zSLDl2S6FcdvOZitTJy7Aa+Y31g8wlX53FZI92rf+VosqfADS8Y0r6tUmaN8/482jbS+0tpgMxk
Whcm+HW0tN4pm+MCXEazOBO3sOQ7WZvsTen0oYhD8SV3PmGu6e3DXIDgf9XX+/PkvH9eom4xKeQQ
3seU5furP8ix38pcp68D1qywrCwa6kNQJfo50jP/NenIINBcVnZqBe9tRrvWNPsT53X5b/7Wcz6w
WGiDsnMyLk3jA8Q175uRem2DlHiXGEdFi4qK/LcWWFgrUGPIZ/RRr7rebivBRO0Ub9uMfKJ4SV12
AsZuGwMbSqZPbIcjnDrxkPkO5suFLyCYJ5vwcz3dDq3FyeTCgz5C78GG8sihc+vEbB36LtZcKXR9
FZFRdcw/z1I1xO6z+ZFax49dUfl9LVFFg83hqQofyNCL+4JRqurwRHEQ2Ang9cv9Pgc+0AgXC0Tg
a6WojwrwExA+utHgL0sqSuHvrBSxcsZg28MuTh2np1fqvW0Am4ZqiqMo1dI7aa71g7aXoSHwBIGw
RMNyptcLl7ZO9N2ZNI9PtR0Ajm6rMZMHFkRkrvqxVfuGa4xPvkXhVd9bVHD0QdZGaI3DfjvWvZPu
29Iicy7ndaq/LwUnrkhYGQ9ZF7c03jIS0kcnaRbRtW4V3+JHZGkrzNKi/2x+7q7wyBxUcjFaRleh
Q/RTlYi+iJcvqFU7PYQEt84RUFP725MVW8si6g29pAFSOksJD9sQrgWR17d4evqFTXgv+HpP1bAE
AkmYNcirRNLdUZQFIQiwneaTIWOAd3wTjlsXXLa5jQJAEaeW1UqJ3bKiEveJfAdKAGpSG4S/zavd
8u4T8MCuldYrKCYK6komISQbl2Kr1dkENs78gHhWYuZm9CMrixtPUXEWe8XGA2eg93Fw7RGVLUIf
Oh1s9oPw7QgXcCQYM52B91YHFD1/yDLKtdVEyZNr9YITh+8yTGOC8DJT4iplCnfCus6P4IxGScO1
bdNWLZOHqTKn4FSsJT2vRXtkshr/W1F5g0Oix7knKuwYbIeaF2VbbKpa9UpWXq4/da1mUkuFYlW4
/qqZHLvDQBi8GHOfntIAPCCeyO5CWhIiOx3nOZBXJxeSAlM7wkUlHZMd4b+ck0sdk3zXAamTbjFW
Ia27UdBRY6irHGP0/wGCTeUu++FY/Ds2dgQo/ge1/SsOeVD6jgv00PZs3tLE2bIn2411ZYH/X/zq
hEPv0FyvZVD+CZ2Z2DTT3oG5hOBikOvDbXJMjXSotNAZv28Sm+OJWnLeSzARYyK//mvRh9AdHyFs
VGTREg4g9O/qXRvphsXHyA9CcOmOZ2gez5ePPrGXHktyPUWxaWvUCk6VuFrQ6AfaukT3WDIHxhT5
mdcjLqMK6afa9rnbwQYlhsJfEmBpqTejeytIIRg5z0KDkJRQ1/Ymh6ylM24CRc2nXHq80G8AKFVO
3QB6TeOJYCJgLJ1rbNPeDxepiKevjRI+XkDdQLRZ0xsW40NMXNXcSIhJiEtIHidgvV+BamExwUYe
yKhYbtqLLFLpArBAJ9kbMZVpHvyHxGIP1e87tQEgXxRExbzTDWrs0nyISccGz+rUn6VSEZJ/KCDs
dVw3F5Kk4cVQVkeZ5b6U93N/gNwHV7u2AORSRAmbRzsw2sbyyM2pNhzidcH46cpf7e3iSAgDNqTq
udBSA0WruQm+4gnbIiZdzn8MPy/f6u4JpoQoldKGVLXMK+Fpa2Sjpboss5L37oHP+Qp1eQ1urAER
rRNA5+sDcf45gpkg/KfNYFcxW0irClWYkGYudPrTtd2C9MAmYOLRUOZwTRc+i4PcPnimYnMq7sd4
wZudFOBEyU0a6uMIWny8Xv9L9Tuf2g90ngrf/qcNoYHcnRF0/yWyf+JqbS5boYsB8kWutO93/aiN
APgSpLPGigGaqeDLK9pfgL0yYSmiUPKlf3gqNGLqOd8OL/BOYCgvWkOVtJ+e6/7tyKbhMCx1nlHO
rkJVRETGVr+1LzZyUvhxBRXq5hR9PfaTh3Hw+40pNxBqGLRm4uOLeExvczmW2Uigz2wBeZFHbZLl
6tTyY+3xsxKucSTDDNkK+tjEwm80z1S7bcG2Rd/NHN3vSqNTcC7nXw2Ek9TGHlULF81hom3wuh7r
7EMPgb4gggXzOPVLcmRQos2uf70JGJ8Ej+7F+RucSueT5zYkq5dG1HK523RguY5YljXa3Bu2AhVb
39tg2upsXkl4nGYF2NY9CsW0S7kzMdvUnkEZg1rE+GGwWgY1GvmnsNknzFlHPpl2W3040mlcNdTo
HhnA0hrG5RQ1rVsIOwcD7pndoaX9eGbPt/zrHHMQ2yLHHXy0fq8dsFBW09Dm/uNDfo/DrBJIUvs9
u5Me43217Nb6d/sSVY+7qljCqaTVpwkCmVVAUrC40JGQAW1w7aWImdc/k9ZeyGtxOIIxuGYe/sOP
iBj+HJuR4jg7ds+20uKzJhXhx2hZ0BPdGOzvsphRsML7CqmgsFNvJs0Pvc785TI4WRtZTc+PdNt+
ZIg51AevWO45RcfstBvmnAJ90gHkYqjY7SFxwcsI/bSR7gOKRuZf/nR0FBaKbpet56TTSNBp+pRa
xD67WAQ3AiSwi+ei+paOpflgsUdJfoGKDPayaJVPctKgJClagRKM9FDMtzU6rcx4FU6Huv6wibMV
AKAP5eGn4IwSq6hihOvoWger5v7x9WolJQF7uRAzet5MMaNgfsX5l25qqFyLi2SQ7FF4M/efhDs0
ZGoUD5rUXTpCmtjqncQlM3HEODrAp0jhO/0OIOZaM8b2Ny7G2loMOxl01HR+XMAUSa3lqSvVE0s6
JYhbKBFb4VTYNxGBntKzhLh2GjM9LdRhCdtqn/KpGATNk+yYpFlHzLnwljQHyl2BwDhF0R7g5kDD
98j7oHA1brUPgCX3lgxHssrCT85NPumwLVZrWqcaPZrlg3daQB5vU+Y7XZ6C7fIfpIEGoVAIOg6n
SHGdorS3IyTX4IVRgIhm5bFMAuLKRwMcJVUiEIt/1RcImwnvRLFSnTlAMUc/JNb3VnNjXEznFW1J
en4ehH2aU2FUa4ohoQWEDenI0I5bTJm2I3u4Xy8W0Ee4CB12OHf3wTrjByPylNozyD6t8qq5tM75
GwwtMhM5mp59PoQcwBTcNIx7dVexAK/Ph1JXIp/L6WSuqt94NR1MWX+SG+MFsmZgtavfS0IQQGb7
0/eonlegnpc9OdIRUE6UQ09wNlQYyHZ6W0adyvR6NP8Wig9yDLA67f7H7qhd+VEsQAfEquj+cQJP
/LBpVADwp4/iZoyz+LUFX+/2lak8YWC8DJCvAEQ4jE9Xe5I0v15yueoMTKwWiwlgsC60mvILB23o
LzvKgJoXVtoZUUK13GesWa74Mid9UB4JruPTVGi3+ctLcLhkWS1GgDd8nKsyhzHUY5QU1VID62XZ
dV1IjbVL2+mzTbRzCAAma3GdOBKyPcy5eMHwUjcVAb4WEWzy5BFZPm00R9iQj4QlkdVBa5FrF5f9
NnKteLmQ/AfXXN1RvPhPeTVXv3Qp8mJrOqAaeo4HO94O1lHQpkFmGtcs9hgRUyX48Ou53WhHV5k1
7so0lq1WdVuRTxowhKX/6KkPHfz0ijePl/qI6WFglXaSn2+sH/o8HWLZvTyKRMtpt9Aa5XIOZWWH
lLVhrjRcdEygodOYJDX+j2ff4xr4uKXPNaLppuoD7M5DJIiy9/g8MsnQz2kW1Z1I1EpJfdjRNttC
UhP9X8WTqaoU2LoIp/CHJc/xEDveprYDrTdXj5qj3QeP1+FEJJJ1jg8Kg/nHku7wOfi7zIns7eb3
fYANXumOw50kNJxG6IX4U/0LFFkxm+tl4MJtu3uw1QzBEwImpIPmBhvlkw8eIScUh99xg2ESnIBG
dqTK3yZLSbP6fTl8jceanIfdgkLn44SdLHEX0nPQH1/pkC4aQWFrdazJAakUIKFRNn+vhMTN9hsO
46u40bc9Uy+LAXYWC9iVD3ZNWgaMoC4+kmQQQ2jfF7Gui3zLaPbgdlrYfwSyUkTTnUQ8locphF3i
h5ZVaqEz6VjXxETfeUsikupSdn70DqzrDnVBLKxsNT9DrkgK8yJ1KYryvj3cSxUlWSE3rPrl38w6
GQmJORJQrdt9yosSi0V0jgh7qlSD4JxVlOkx5415gZGeAu1YNd3rfbB04sJPEzmLiexeYfTMW+zM
mJMskGWTHu3fAPOH3UhLv795Qsk/natmsqkO61lwFOM1JJ+laQKrBn+PjamyrTbgQLNNfA93vR0N
gXjxC30gTS27xhhWd0jtznzRjXS92QnShtjJifCQ0nKJPQToWfNO10JJwx6YTB8/3rRNrK2n7R3H
ZNFz5SOHxB/20X2PUvbIAeEdWPI7FYG5AKJxtEzQtbUcnCcjKG7yhUoFml3mjadS+/xRdYSe1F1d
D6WtZ3wGYX9UrA==
`protect end_protected
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fix_acc_16_c_accum_v12_0_13 is
  port (
    B : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK : in STD_LOGIC;
    ADD : in STD_LOGIC;
    C_IN : in STD_LOGIC;
    CE : in STD_LOGIC;
    BYPASS : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    SSET : in STD_LOGIC;
    SINIT : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute C_ADD_MODE : integer;
  attribute C_ADD_MODE of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of fix_acc_16_c_accum_v12_0_13 : entity is "0";
  attribute C_BYPASS_LOW : integer;
  attribute C_BYPASS_LOW of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_B_TYPE : integer;
  attribute C_B_TYPE of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of fix_acc_16_c_accum_v12_0_13 : entity is 16;
  attribute C_CE_OVERRIDES_SCLR : integer;
  attribute C_CE_OVERRIDES_SCLR of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_HAS_BYPASS : integer;
  attribute C_HAS_BYPASS of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of fix_acc_16_c_accum_v12_0_13 : entity is 1;
  attribute C_HAS_C_IN : integer;
  attribute C_HAS_C_IN of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of fix_acc_16_c_accum_v12_0_13 : entity is 1;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_IMPLEMENTATION : integer;
  attribute C_IMPLEMENTATION of fix_acc_16_c_accum_v12_0_13 : entity is 1;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of fix_acc_16_c_accum_v12_0_13 : entity is 1;
  attribute C_OUT_WIDTH : integer;
  attribute C_OUT_WIDTH of fix_acc_16_c_accum_v12_0_13 : entity is 16;
  attribute C_SCALE : integer;
  attribute C_SCALE of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_SCLR_OVERRIDES_SSET : integer;
  attribute C_SCLR_OVERRIDES_SSET of fix_acc_16_c_accum_v12_0_13 : entity is 1;
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of fix_acc_16_c_accum_v12_0_13 : entity is "0";
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of fix_acc_16_c_accum_v12_0_13 : entity is 0;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of fix_acc_16_c_accum_v12_0_13 : entity is "zynquplus";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of fix_acc_16_c_accum_v12_0_13 : entity is "yes";
end fix_acc_16_c_accum_v12_0_13;

architecture STRUCTURE of fix_acc_16_c_accum_v12_0_13 is
  attribute C_ADD_MODE of i_synth : label is 0;
  attribute C_AINIT_VAL of i_synth : label is "0";
  attribute C_BYPASS_LOW of i_synth : label is 0;
  attribute C_B_TYPE of i_synth : label is 0;
  attribute C_B_WIDTH of i_synth : label is 16;
  attribute C_CE_OVERRIDES_SCLR of i_synth : label is 0;
  attribute C_HAS_BYPASS of i_synth : label is 0;
  attribute C_HAS_CE of i_synth : label is 1;
  attribute C_HAS_C_IN of i_synth : label is 0;
  attribute C_HAS_SCLR of i_synth : label is 1;
  attribute C_HAS_SINIT of i_synth : label is 0;
  attribute C_HAS_SSET of i_synth : label is 0;
  attribute C_IMPLEMENTATION of i_synth : label is 1;
  attribute C_LATENCY of i_synth : label is 1;
  attribute C_OUT_WIDTH of i_synth : label is 16;
  attribute C_SCALE of i_synth : label is 0;
  attribute C_SCLR_OVERRIDES_SSET of i_synth : label is 1;
  attribute C_SINIT_VAL of i_synth : label is "0";
  attribute C_VERBOSITY of i_synth : label is 0;
  attribute C_XDEVICEFAMILY of i_synth : label is "zynquplus";
  attribute downgradeipidentifiedwarnings of i_synth : label is "yes";
begin
i_synth: entity work.fix_acc_16_c_accum_v12_0_13_viv
     port map (
      ADD => '0',
      B(15 downto 0) => B(15 downto 0),
      BYPASS => '0',
      CE => CE,
      CLK => CLK,
      C_IN => '0',
      Q(15 downto 0) => Q(15 downto 0),
      SCLR => SCLR,
      SINIT => '0',
      SSET => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fix_acc_16 is
  port (
    B : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of fix_acc_16 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of fix_acc_16 : entity is "fix_acc_16,c_accum_v12_0_13,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of fix_acc_16 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of fix_acc_16 : entity is "c_accum_v12_0_13,Vivado 2019.1";
end fix_acc_16;

architecture STRUCTURE of fix_acc_16 is
  attribute C_ADD_MODE : integer;
  attribute C_ADD_MODE of U0 : label is 0;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of U0 : label is "0";
  attribute C_BYPASS_LOW : integer;
  attribute C_BYPASS_LOW of U0 : label is 0;
  attribute C_B_TYPE : integer;
  attribute C_B_TYPE of U0 : label is 0;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of U0 : label is 16;
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
  attribute C_OUT_WIDTH of U0 : label is 16;
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
U0: entity work.fix_acc_16_c_accum_v12_0_13
     port map (
      ADD => '1',
      B(15 downto 0) => B(15 downto 0),
      BYPASS => '0',
      CE => CE,
      CLK => CLK,
      C_IN => '0',
      Q(15 downto 0) => Q(15 downto 0),
      SCLR => SCLR,
      SINIT => '0',
      SSET => '0'
    );
end STRUCTURE;
