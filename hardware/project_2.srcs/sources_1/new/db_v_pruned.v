`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/21 10:46:59
// Design Name: 
// Module Name: db_v_pruned
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

module db_v_pruned(
    // Inputs and outputs for the double buffer module
    input clk,
    input db_v_pruned_sel,
    input [7:0] db_v_pruned_addr1,
    input [7:0] db_v_pruned_addr2,
    output wire db_v_pruned_ready,
    output wire [31:0] db_v_pruned_out1,
    output wire [31:0] db_v_pruned_out2
    );

    wire [31:0] db_v_pruned_1_out1;
    wire [31:0] db_v_pruned_1_out2;
    wire [31:0] db_v_pruned_2_out1;
    wire [31:0] db_v_pruned_2_out2;

    v_pruned_1 v_pruned_1_instance_1 (
        .clka(clk),    // input wire clka
        .wea(1'b0),      // input wire wea (write enable, inactive)
        .addra(db_v_pruned_addr1),  // input wire [7:0] addra
        .dina(),    // input wire [31:0] dina (not used in this context)
        .douta(db_v_pruned_1_out1),  // output wire [31:0] douta
        .clkb(clk),    // input wire clkb
        .web(1'b0),      // input wire web (write enable, inactive)
        .addrb(),  // input wire [7:0] addrb
        .dinb(),    // input wire [31:0] dinb (not used in this context)
        .doutb()  // output wire [31:0] doutb
    );

    v_pruned_1 v_pruned_1_instance_2 (
        .clka(clk),    // input wire clka
        .wea(1'b0),      // input wire wea (write enable, inactive)
        .addra(db_v_pruned_addr2),  // input wire [7:0] addra
        .dina(),    // input wire [31:0] dina (not used in this context)
        .douta(db_v_pruned_1_out2),  // output wire [31:0] douta
        .clkb(clk),    // input wire clkb
        .web(1'b0),      // input wire web (write enable, inactive)
        .addrb(),  // input wire [7:0] addrb
        .dinb(),    // input wire [31:0] dinb (not used in this context)
        .doutb()  // output wire [31:0] doutb
    );

    v_pruned_2 v_pruned_2_instance_1 (
        .clka(clk),    // input wire clka
        .wea(1'b0),      // input wire wea (write enable, inactive)
        .addra(db_v_pruned_addr1),  // input wire [7:0] addra
        .dina(),    // input wire [31:0] dina (not used)
        .douta(db_v_pruned_2_out1),  // output wire [31:0] douta
        .clkb(clk),    // input wire clkb
        .web(1'b0),      // input wire web (write enable, inactive)
        .addrb(),  // input wire [7:0] addrb
        .dinb(),    // input wire [31:0] dinb (not used)
        .doutb()  // output wire [31:0] doutb
    );

    v_pruned_2 v_pruned_2_instance_2 (
        .clka(clk),    // input wire clka
        .wea(1'b0),      // input wire wea (write enable, inactive)
        .addra(db_v_pruned_addr2),  // input wire [7:0] addra
        .dina(),    // input wire [31:0] dina (not used)
        .douta(db_v_pruned_2_out2),  // output wire [31:0] douta
        .clkb(clk),    // input wire clkb
        .web(1'b0),      // input wire web (write enable, inactive)
        .addrb(),  // input wire [7:0] addrb
        .dinb(),    // input wire [31:0] dinb (not used)
        .doutb()  // output wire [31:0] doutb
    );

    assign db_v_pruned_out1 = db_v_pruned_sel? db_v_pruned_2_out1 : db_v_pruned_1_out1;
    assign db_v_pruned_out2 = db_v_pruned_sel? db_v_pruned_2_out2 : db_v_pruned_1_out2;
    assign db_v_pruned_ready = 1'b1;
endmodule