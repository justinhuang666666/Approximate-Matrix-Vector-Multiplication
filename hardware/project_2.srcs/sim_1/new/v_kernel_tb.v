`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 14:11:15
// Design Name: 
// Module Name: v_kernel_tb
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

module v_kernel_tb;

    // Inputs
    reg clk;
    reg clk_en;
    reg acc_rst;
    reg [15:0] v_tile_1;
    reg [15:0] v_tile_2;
    reg [15:0] x_tile_1;
    reg [15:0] x_tile_2;

    // Output
    wire [15:0] out;

    // Instantiate the Unit Under Test (UUT)
    v_kernel uut (
        .clk(clk),
        .clk_en(clk_en),
        .acc_rst(acc_rst),
        .v_tile_1(v_tile_1),
        .v_tile_2(v_tile_2),
        .x_tile_1(x_tile_1),
        .x_tile_2(x_tile_2),
        .v_kernel_out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Clock with a period of 20 ns (50 MHz)
    end

    // Stimulus
    initial begin
        // Initialize Inputs
        clk_en = 0;
        acc_rst = 1;
        v_tile_1 = 0;
        v_tile_2 = 0;
        x_tile_1 = 0;
        x_tile_2 = 0;
        #50;
        acc_rst = 0;
        clk_en = 1;  // Enable the clock

        // Apply test vectors
        #60;
        v_tile_1 = 16'sh0800;  // Example input values
        v_tile_2 = 16'sh0800;
        x_tile_1 = 16'sh0800;
        x_tile_2 = 16'sh0800;
        #60;
        v_tile_1 = 0;  // Example input values
        v_tile_2 = 0;
        x_tile_1 = 0;
        x_tile_2 = 0;
        #20;
        v_tile_1 = 16'sh1000;  // Example input values
        v_tile_2 = 16'sh1000;
        x_tile_1 = 16'sh1000;
        x_tile_2 = 16'sh1000;
        #60;
        acc_rst = 1;
        v_tile_1 = 0;  // Example input values
        v_tile_2 = 0;
        x_tile_1 = 0;
        x_tile_2 = 0;
        #20;
        acc_rst = 0;
        v_tile_1 = 16'sh0400;  // Example input values
        v_tile_2 = 16'sh0400;
        x_tile_1 = 16'sh0400;
        x_tile_2 = 16'sh0400;
        #60;
        acc_rst = 1;
        v_tile_1 = 0;  // Example input values
        v_tile_2 = 0;
        x_tile_1 = 0;
        x_tile_2 = 0;
        #20;
        acc_rst = 0;        
        #60;
        acc_rst = 1;
        // Further inputs can be added to test other conditions
        #100;
        $finish;  // End the simulation
    end

    // Output monitoring
    initial begin
        $monitor("At time %t, output = %d", $time, out);
    end

endmodule
