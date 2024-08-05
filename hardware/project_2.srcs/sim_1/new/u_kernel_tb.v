`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 18:25:35
// Design Name: 
// Module Name: u_kernel_tb
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



module u_kernel_tb;

    // Inputs to the u_kernel module
    reg clk;
    reg clk_en;
    reg acc_rst;
    reg [15:0] svx;
    reg [15:0] u_tile_1;
    reg [15:0] u_tile_2;

    // Outputs from the u_kernel module
    wire [15:0] u_kernel_out_1;
    wire [15:0] u_kernel_out_2;

    // Instantiate the Unit Under Test (UUT)
    u_kernel uut (
        .clk(clk),
        .clk_en(clk_en),
        .acc_rst(acc_rst),
        .svx(svx),
        .u_tile_1(u_tile_1),
        .u_tile_2(u_tile_2),
        .u_kernel_out_1(u_kernel_out_1),
        .u_kernel_out_2(u_kernel_out_2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Generate a 100MHz clock
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        clk_en = 0;
        acc_rst = 1;
        svx = 0;
        u_tile_1 = 0;
        u_tile_2 = 0;

        // Reset the system
        #100;             // Wait 100 ns for global reset
        acc_rst = 0;          // Deassert reset
        #30;
        clk_en = 1;       // Enable clock for normal operation

        // Apply test vectors
        #20;              // Wait 20 ns after clock enable
        svx = 16'h0200;
        u_tile_1 = 16'h1000;
        u_tile_2 = 16'h2000;

        #20;              // Duration for the test input
        svx = 16'h0200;
        u_tile_1 = 16'h1000;
        u_tile_2 = 16'h2000;

        #20;              // Change inputs while keeping the clock running
        svx = 16'h0200;
        u_tile_1 = 16'h1000;
        u_tile_2 = 16'h2000;
        
        #20;              // Change inputs while keeping the clock running
        svx = 0;
        u_tile_1 = 0;
        u_tile_2 = 0;
        
        #140;              // Further input to test
        $finish;          // Terminate simulation
    end

    // Monitoring the outputs
    initial begin
        $monitor("At time %t, Output1 = %h, Output2 = %h", $time, u_kernel_out_1, u_kernel_out_2);
    end

endmodule
