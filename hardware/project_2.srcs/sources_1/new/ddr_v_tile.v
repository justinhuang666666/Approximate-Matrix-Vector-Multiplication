`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/26 14:211:57
// Design Name: 
// Module Name: ddr_v_tile
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


module ddr_v_tile(
    input clk,
    input addr_en,
    input [11:0] addr,
    output wire v_tile_valid,
    output wire [255:0] v_tile
    );

    reg [11:0] delayed_addr_1 = 0;
    reg [11:0] delayed_addr_2 = 0;
    reg [11:0] delayed_addr_3 = 0;
    reg [11:0] delayed_addr_4 = 0;
    
    always @(posedge clk) begin
        if (addr == 0) begin
            delayed_addr_1 <= addr;
        end else begin
            delayed_addr_1 <= addr - 10'b1;
        end
        delayed_addr_2 <= delayed_addr_1;
        delayed_addr_3 <= delayed_addr_2;
        delayed_addr_4 <= delayed_addr_3;
    end

    reg delayed_addr_en_1 = 0;
    reg delayed_addr_en_2 = 0;
    reg delayed_addr_en_3 = 0;
    reg delayed_addr_en_4 = 0;
    reg delayed_addr_en_5 = 0;

    always @(posedge clk) begin
        delayed_addr_en_1 <= addr_en;
        delayed_addr_en_2 <= delayed_addr_en_1;
        delayed_addr_en_3 <= delayed_addr_en_2;
        delayed_addr_en_4 <= delayed_addr_en_3;
        delayed_addr_en_5 <= delayed_addr_en_4;
    end

    assign v_tile_valid = delayed_addr_en_5;

    ram_v_tile your_instance_name (
    .clka(clk),    // input wire clka
    .wea(1'b0),      // input wire [0 : 0] wea
    .addra(delayed_addr_4),  // input wire [11 : 0] addra
    .dina(),    // input wire [63 : 0] dina
    .douta(v_tile)  // output wire [63 : 0] douta
    );
endmodule

