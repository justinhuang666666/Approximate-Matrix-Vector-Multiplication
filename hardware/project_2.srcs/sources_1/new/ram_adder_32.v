`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 14:06:05
// Design Name: 
// Module Name: ram_adder_32
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



module ram_adder_32(
    input wire clk,           // Clock signal
    input wire rst,         // Rst signal
    input wire [31:0] ina_data,// Input data to be added
    input wire in_ready,      // Signal indicating if input data is ready
    input wire wea,
    input wire [4:0] waddr,
    input wire [4:0] raddr,
    output wire [31:0] ram_output,  // Output data from the memory (not used in this specific module)
    output wire [31:0] sum_output
);

    wire [31:0] B_input;
    assign B_input = ram_output;// (!in_ready|first)? 15'b0 : ram_output;
    // Instance of the fixed-point adder
    fix_add_32 adder (
        .A(ina_data),
        .B(B_input),
        .CLK(clk),
        .CE(1'b1),
        .SCLR(rst),
        .S(sum_output)
    );

    blk_mem_1 blk_mem (
    .clka(clk),    // input wire clka
    .wea(wea),      // input wire [0 : 0] wea
    .addra(waddr),  // input wire [5 : 0] addra
    .dina(sum_output),    // input wire [15 : 0] dina
    .douta(),  // output wire [15 : 0] douta
    .clkb(clk),    // input wire clkb
    .web(1'b0),      // input wire [0 : 0] web
    .addrb(raddr),  // input wire [5 : 0] addrb
    .dinb(),    // input wire [15 : 0] dinb
    .doutb(ram_output)  // output wire [15 : 0] doutb
    );

endmodule