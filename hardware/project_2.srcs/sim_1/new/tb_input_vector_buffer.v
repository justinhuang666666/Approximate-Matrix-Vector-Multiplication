`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/26 14:50:46
// Design Name: 
// Module Name: tb_input_vector_buffer
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

module tb_input_vector_buffer;

    // Testbench signals
    reg clk;
    reg addr_en;
    reg [9:0] addr;
    wire x_tile_valid;
    wire [63:0] x_tile;

    // Instantiate the DUT (Device Under Test)
    input_vector_buffer dut (
        .clk(clk),
        .addr_en(addr_en),
        .addr(addr),
        .x_tile_valid(x_tile_valid),
        .x_tile(x_tile)
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
        addr = 10'b0;
        addr_en = 1;
        @(posedge clk)
        addr = 10'd1;
        @(posedge clk)
        addr = 10'd2;
        @(posedge clk)
        addr = 10'd3;
        @(posedge clk)
        addr = 10'd4;
        @(posedge clk)
        addr_en = 0;
        #20;
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
        @(posedge clk)

        // Finish the simulation
        $finish;
    end
endmodule