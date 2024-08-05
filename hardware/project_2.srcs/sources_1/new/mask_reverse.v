`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/30 19:51:42
// Design Name: 
// Module Name: mask_reverse
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

module mask_reverse #(
    parameter WIDTH = 96
)(
    input wire [WIDTH-1:0] mask_in,
    output reg [WIDTH-1:0] mask_out
);

    integer i;

    always @* begin
        for (i = 0; i < WIDTH; i = i + 1) begin
            mask_out[i] = mask_in[WIDTH - i - 1]; // Reverse the order of bits
        end
    end

endmodule

