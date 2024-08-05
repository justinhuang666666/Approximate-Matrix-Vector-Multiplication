`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
// Create Date: 2024/05/20 21:44:21
// Design Name: 
// Module Name: db_mask_v
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

module db_mask_v(
    // Inputs and outputs for the double buffer module
    input clk,
    input db_mask_v_sel,
    output wire db_mask_v_ready,
    output wire [95:0] db_mask_v_out
);

    wire [95:0] mask_v_1;
    wire [95:0] mask_v_2;
    
    // First buffer instance
    mask_v_1 mask_v_1_instance_1 (
        .clka(clk),
        .wea(1'b0),
        .addra(1'b0),
        .dina(),
        .douta(mask_v_1)
    );

    // Second buffer instance
    mask_v_2 mask_v_2_instance_1 (
        .clka(clk),
        .wea(1'b0),
        .addra(1'b0),
        .dina(),
        .douta(mask_v_2)
    );

    // Output buffer selection
    assign db_mask_v_out = db_mask_v_sel ? mask_v_2 : mask_v_1;
    assign db_mask_v_ready = 1'b1;

endmodule