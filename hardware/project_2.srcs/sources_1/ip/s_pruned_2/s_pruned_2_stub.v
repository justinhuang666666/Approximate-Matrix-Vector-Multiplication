// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Tue May 21 20:54:05 2024
// Host        : DESKTOP-P5DFUUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top s_pruned_2 -prefix
//               s_pruned_2_ s_pruned_2_stub.v
// Design      : s_pruned_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module s_pruned_2(clka, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[0:0],dina[31:0],douta[31:0]" */;
  input clka;
  input [0:0]wea;
  input [0:0]addra;
  input [31:0]dina;
  output [31:0]douta;
endmodule
