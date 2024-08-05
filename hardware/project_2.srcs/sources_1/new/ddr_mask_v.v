`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/26 14:34:30
// Design Name: 
// Module Name: ddr_mask_v
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

module ddr_mask_v(
    input clk,
    input addr_en,
    input [5:0] addr,
    output wire mask_v_valid,
    output wire [383:0] mask_v
    );

    reg [5:0] delayed_addr_1 = 0;
    reg [5:0] delayed_addr_2 = 0;
    reg [5:0] delayed_addr_3 = 0;
    reg [5:0] delayed_addr_4 = 0;
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

    assign mask_v_valid = delayed_addr_en_5;

    ram_mask_v your_instance_name (
    .clka(clk),    // input wire clka
    .wea(1'b0),      // input wire [0 : 0] wea
    .addra(delayed_addr_4),  // input wire [9 : 0] addra
    .dina(),    // input wire [63 : 0] dina
    .douta(mask_v)  // output wire [63 : 0] douta
    );
endmodule
