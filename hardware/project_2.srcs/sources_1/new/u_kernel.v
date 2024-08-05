`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 15:39:11
// Design Name: 
// Module Name: u_kernel
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

module u_kernel(
    input clk,
    input clk_en,
    input acc_rst,  // Renamed for consistency
    input [15:0] svx,
    input [15:0] u_tile_1,
    input [15:0] u_tile_2,
    output wire [15:0] u_kernel_out_1,  // Added comma
    output wire [15:0] u_kernel_out_2
);

// Instantiate multipliers
fix_mult_16 fix_mult_16_instance_1 (
    .CLK(clk),
    .A(svx),
    .B(u_tile_1),
    .CE(clk_en),
    .SCLR(1'b0),  // Updated to rst
    .P(u_kernel_out_1)
);

fix_mult_16 fix_mult_16_instance_2 (
    .CLK(clk),
    .A(svx),
    .B(u_tile_2),
    .CE(clk_en),
    .SCLR(1'b0),  // Updated to rst
    .P(u_kernel_out_2)
);

endmodule
