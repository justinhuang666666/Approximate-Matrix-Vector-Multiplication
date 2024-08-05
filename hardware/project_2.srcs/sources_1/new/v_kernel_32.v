`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 13:56:03
// Design Name: 
// Module Name: v_kernel_32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module v_kernel_32(
    input clk,
    input clk_en,
    input acc_rst,
    input [31:0] v_tile_1,
    input [31:0] v_tile_2,
    input [31:0] x_tile_1,
    input [31:0] x_tile_2,
    output wire [31:0] v_kernel_out
);

// Internal signals for the multiplication results
wire [31:0] fix_mult_32_instance_1_result;
wire [31:0] fix_mult_32_instance_2_result;
wire [31:0] fix_add_32_instance_1_result;

// Instantiate two instances of fix_mult_32 module for multiplying v_tile and x_tile
fix_mult_32 fix_mult_32_instance_1 (
    .CLK(clk),
    .A(v_tile_1),
    .B(x_tile_1),
    .CE(clk_en),
    .SCLR(1'b0),
    .P(fix_mult_32_instance_1_result)
);

fix_mult_32 fix_mult_32_instance_2 (
    .CLK(clk),
    .A(v_tile_2),
    .B(x_tile_2),
    .CE(clk_en),
    .SCLR(1'b0),
    .P(fix_mult_32_instance_2_result)
);

fix_add_32 fix_add_32_instance_1 (
    .A(fix_mult_32_instance_1_result), 
    .B(fix_mult_32_instance_2_result),
    .CLK(clk), 
    .CE(clk_en), 
    .SCLR(1'b0),
    .S(fix_add_32_instance_1_result)
);

fix_acc_32 fix_acc_32_instance_1 (
    .B(fix_add_32_instance_1_result),
    .CLK(clk),
    .CE(clk_en),
    .SCLR(acc_rst),
    .Q(v_kernel_out)
);

endmodule