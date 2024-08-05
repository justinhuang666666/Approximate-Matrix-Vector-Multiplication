`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/26 14:46:40
// Design Name: 
// Module Name: input_vector_buffer
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


module input_vector_buffer(
    input clk,
    input addr_en,
    input [6:0] addr,
    output wire x_tile_valid,
    output wire [63:0] x_tile
    );

    // reg [6:0] delayed_addr_1 = 0;
    // reg [6:0] delayed_addr_2 = 0;
    // reg [6:0] delayed_addr_3 = 0;
    // always @(posedge clk) begin
    //     if (addr == 0) begin
    //         delayed_addr_1 <= addr;
    //     end else begin
    //         delayed_addr_1 <= addr - 10'b1;
    //     end
    //     delayed_addr_2 <= delayed_addr_1;
    //     delayed_addr_3 <= delayed_addr_2;
    // end

    reg delayed_addr_en_1 = 0;
    reg delayed_addr_en_2 = 0;
    always @(posedge clk) begin
        delayed_addr_en_1 <= addr_en;
        delayed_addr_en_2 <= delayed_addr_en_1;
    end

    assign x_tile_valid = delayed_addr_en_1;

    ram_input_vector your_instance_name (
    .clka(clk),    // input wire clka
    .wea(1'b0),      // input wire [0 : 0] wea
    .addra(addr),  // input wire [7 : 0] addra
    .dina(),    // input wire [63 : 0] dina
    .douta(x_tile)  // output wire [63 : 0] douta
    );
endmodule
