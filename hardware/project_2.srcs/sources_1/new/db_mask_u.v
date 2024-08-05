`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/20 21:20:18
// Design Name: 
// Module Name: db_mask_u
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

module db_mask_u(
    // Inputs and outputs for the double buffer module
    input clk,
    input db_mask_u_sel,
    output wire db_mask_u_ready,
    output wire [31:0] db_mask_u_out
);

    wire [31:0] mask_u_1;
    wire [31:0] mask_u_2;
    
    // First buffer instance
    mask_u_1 mask_u_1_instance_1 (
        .clka(clk),
        .wea(1'b0),
        .addra(1'b0),
        .dina(),
        .douta(mask_u_1)
    );

    // Second buffer instance
    mask_u_2 mask_u_2_instance_1 (
        .clka(clk),
        .wea(1'b0),
        .addra(1'b0),
        .dina(),
        .douta(mask_u_2)
    );

    assign db_mask_u_out = db_mask_u_sel ? mask_u_2 : mask_u_1;
    assign db_mask_u_ready = 1'b1;

endmodule
