// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat May 18 13:15:35 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top fix_acc_32 -prefix
//               fix_acc_32_ fix_acc_16_stub.v
// Design      : fix_acc_16
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_accum_v12_0_13,Vivado 2019.1" *)
module fix_acc_32(B, CLK, CE, SCLR, Q)
/* synthesis syn_black_box black_box_pad_pin="B[31:0],CLK,CE,SCLR,Q[31:0]" */;
  input [31:0]B;
  input CLK;
  input CE;
  input SCLR;
  output [31:0]Q;
endmodule
