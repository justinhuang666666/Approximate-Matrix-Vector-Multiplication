`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 13:58:32
// Design Name: 
// Module Name: u_kernel_32
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

module u_kernel_32(
    input clk,
    input clk_en,
    input acc_rst,  // Renamed for consistency
    input [31:0] svx,
    input [31:0] u_tile_1,
    input [31:0] u_tile_2,
    output wire [31:0] u_kernel_out_1,  // Added comma
    output wire [31:0] u_kernel_out_2
);

// Instantiate multipliers
fix_mult_32 fix_mult_32_instance_1 (
    .CLK(clk),
    .A(svx),
    .B(u_tile_1),
    .CE(clk_en),
    .SCLR(1'b0),  // Updated to rst
    .P(u_kernel_out_1)
);

fix_mult_32 fix_mult_32_instance_2 (
    .CLK(clk),
    .A(svx),
    .B(u_tile_2),
    .CE(clk_en),
    .SCLR(1'b0),  // Updated to rst
    .P(u_kernel_out_2)
);

endmodule
