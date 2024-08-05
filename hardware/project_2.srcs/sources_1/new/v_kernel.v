`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/03 20:13:09
// Design Name: 
// Module Name: v_kernel
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

module v_kernel(
    input clk,
    input clk_en,
    input acc_rst,
    input [15:0] v_tile_1,
    input [15:0] v_tile_2,
    input [15:0] x_tile_1,
    input [15:0] x_tile_2,
    output wire [15:0] v_kernel_out
);

// Internal signals for the multiplication results
wire [15:0] fix_mult_16_instance_1_result;
wire [15:0] fix_mult_16_instance_2_result;
wire [15:0] fix_add_16_instance_1_result;

// Instantiate two instances of fix_mult_16 module for multiplying v_tile and x_tile
fix_mult_16 fix_mult_16_instance_1 (
    .CLK(clk),
    .A(v_tile_1),
    .B(x_tile_1),
    .CE(clk_en),
    .SCLR(1'b0),
    .P(fix_mult_16_instance_1_result)
);

fix_mult_16 fix_mult_16_instance_2 (
    .CLK(clk),
    .A(v_tile_2),
    .B(x_tile_2),
    .CE(clk_en),
    .SCLR(1'b0),
    .P(fix_mult_16_instance_2_result)
);

fix_add_16 fix_add_16_instance_1 (
    .A(fix_mult_16_instance_1_result), 
    .B(fix_mult_16_instance_2_result),
    .CLK(clk), 
    .CE(clk_en), 
    .SCLR(1'b0),
    .S(fix_add_16_instance_1_result)
);

fix_acc_16 fix_acc_16_instance_1 (
    .B(fix_add_16_instance_1_result),
    .CLK(clk),
    .CE(clk_en),
    .SCLR(acc_rst),
    .Q(v_kernel_out)
);

endmodule
