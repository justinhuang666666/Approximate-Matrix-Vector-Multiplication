`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 15:30:42
// Design Name: 
// Module Name: s_kernel
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

module s_kernel(
    input clk,
    input clk_en,
    input rst,
    input [15:0] vx,
    input [15:0] s,
    output wire [15:0] s_kernel_out
);

fix_mult_16 fix_mult_16_instance_1 (
    .CLK(clk),
    .A(vx),
    .B(s),
    .CE(clk_en),
    .SCLR(rst),
    .P(s_kernel_out)
);
endmodule
