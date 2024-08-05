// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May  4 18:47:52 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/project_2/project_2.srcs/sources_1/ip/fix_acc_16_sset/fix_acc_16_sset_stub.v
// Design      : fix_acc_16_sset
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_accum_v12_0_13,Vivado 2019.1" *)
module fix_acc_16_sset(B, CLK, CE, SCLR, SSET, Q)
/* synthesis syn_black_box black_box_pad_pin="B[15:0],CLK,CE,SCLR,SSET,Q[15:0]" */;
  input [15:0]B;
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  output [15:0]Q;
endmodule
