`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/26 13:59:36
// Design Name: 
// Module Name: tb_ddr_u_tile
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

module tb_ddr_u_tile;

    // Testbench signals
    reg clk;
    reg addr_en;
    reg [9:0] addr;
    wire u_tile_valid;
    wire [63:0] u_tile;

    // Instantiate the DUT (Device Under Test)
    ddr_u_tile dut (
        .clk(clk),
        .addr_en(addr_en),
        .addr(addr),
        .u_tile_valid(u_tile_valid),
        .u_tile(u_tile)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize signals
        clk = 0;
        addr_en = 0;
        addr = 10'b0;
        
        // Apply some test vectors
        @(posedge clk)
        addr = 10'd1;
        addr_en = 1;
        @(posedge clk)
        addr = 10'd2;
        @(posedge clk)
        addr = 10'd3;
        @(posedge clk)
        addr = 10'd4;
        @(posedge clk)
        addr_en = 0;
        @(posedge clk)
        @(posedge clk)
        addr = 10'd5;
        addr_en = 1;
        @(posedge clk)
        addr = 10'd6;
        @(posedge clk)
        addr_en = 0;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        
        // Finish the simulation
        $finish;
    end

    initial begin
        // Monitor signals
        $monitor("Time: %0t, clk: %b, addr_en: %b, addr: %d, u_tile_valid: %b, u_tile: %h",
                 $time, clk, addr_en, addr, u_tile_valid, u_tile);
    end
endmodule
