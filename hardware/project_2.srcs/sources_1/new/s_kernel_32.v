`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 14:00:18
// Design Name: 
// Module Name: s_kernel_32
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


module s_kernel_32(
    input clk,
    input clk_en,
    input rst,
    input [31:0] vx,
    input [31:0] s,
    output wire [31:0] s_kernel_out
);

fix_mult_32 fix_mult_32_instance_1 (
    .CLK(clk),
    .A(vx),
    .B(s),
    .CE(clk_en),
    .SCLR(rst),
    .P(s_kernel_out)
);
endmodule