`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 19:38:08
// Design Name: 
// Module Name: svd_kernel_tb
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


module svd_kernel_tb;

    // Inputs to the svd_kernel module
    reg clk;
    reg clk_en;
    reg rst;
    reg [15:0] u_tile_1;
    reg [15:0] u_tile_2;
    reg u_tile_ready;
    reg [15:0] v_tile_1;
    reg [15:0] v_tile_2;
    reg v_tile_ready;
    reg [15:0] x_tile_1;
    reg [15:0] x_tile_2;
    reg x_tile_ready;
    reg [15:0] s;
    reg s_tile_ready;

    // Outputs from the svd_kernel module
    wire [15:0] u_kernel_out_1;
    wire [15:0] u_kernel_out_2;
    wire svd_kernel_valid;

    // Instantiate the Unit Under Test (UUT)
    svd_kernel uut (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .u_tile_1(u_tile_1),
        .u_tile_2(u_tile_2),
        .u_tile_ready(u_tile_ready),
        .v_tile_1(v_tile_1),
        .v_tile_2(v_tile_2),
        .v_tile_ready(v_tile_ready),
        .x_tile_1(x_tile_1),
        .x_tile_2(x_tile_2),
        .x_tile_ready(x_tile_ready),
        .s(s),
        .s_tile_ready(s_tile_ready),
        .u_kernel_out_1(u_kernel_out_1),
        .u_kernel_out_2(u_kernel_out_2),
        .svd_kernel_valid(svd_kernel_valid)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Generate a clock with a 100 MHz frequency
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        clk_en = 0;
        rst = 1;
        u_tile_1 = 0;
        u_tile_2 = 0;
        u_tile_ready = 0;
        v_tile_1 = 0;
        v_tile_2 = 0;
        v_tile_ready = 0;
        x_tile_1 = 0;
        x_tile_2 = 0;
        x_tile_ready = 0;
        s = 0;
        s_tile_ready = 0;

        // Apply a reset
        #60;
        rst = 0;
        clk_en = 1;  // Enable the clock for normal operation
        #30;

        // Apply test vectors
        v_tile_1 = 16'h0100;
        v_tile_2 = 16'h0110;
        v_tile_ready = 1;
        x_tile_1 = 16'h2000;
        x_tile_2 = 16'h2000;
        x_tile_ready = 1;
        #20;
        v_tile_1 = 16'h0140;
        v_tile_2 = 16'h0150;
        x_tile_1 = 16'h2000;
        x_tile_2 = 16'h2000;
        #20;
        v_tile_1 = 16'h0180;
        v_tile_2 = 16'h0190;
        x_tile_1 = 16'h2000;
        x_tile_2 = 16'h2000;
        #20;
        v_tile_1 = 16'h01c0;
        v_tile_2 = 16'h01d0;
        x_tile_1 = 16'h2000;
        x_tile_2 = 16'h2000;
        #20;
        v_tile_1 = 16'h0200;
        v_tile_2 = 16'h0210;
        x_tile_1 = 16'h2000;
        x_tile_2 = 16'h2000;
        #20;
        v_tile_1 = 0;
        v_tile_2 = 0;
        v_tile_ready = 0;
        x_tile_1 = 0;
        x_tile_2 = 0;
        x_tile_ready = 0;
        #20;

        v_tile_1 = 16'h0240;
        v_tile_2 = 16'h0250;
        v_tile_ready = 1;
        x_tile_1 = 16'h3000;
        x_tile_2 = 16'h3000;
        x_tile_ready = 1;
        #20;
        v_tile_1 = 16'h0280;
        v_tile_2 = 16'h0290;
        x_tile_1 = 16'h3000;
        x_tile_2 = 16'h3000;
        #20;
        v_tile_1 = 16'h02c0;
        v_tile_2 = 16'h02d0;
        x_tile_1 = 16'h3000;
        x_tile_2 = 16'h3000;
        #20;
        s = 16'h1000;
        s_tile_ready = 1;
        v_tile_1 = 16'h0300;
        v_tile_2 = 16'h0310;
        x_tile_1 = 16'h3000;
        x_tile_2 = 16'h3000;
        #20;
        v_tile_1 = 16'h0340;
        v_tile_2 = 16'h0350;
        x_tile_1 = 16'h3000;
        x_tile_2 = 16'h3000;
        #20;
        v_tile_1 = 0;
        v_tile_2 = 0;
        v_tile_ready = 0;
        x_tile_1 = 0;
        x_tile_2 = 0;
        x_tile_ready = 0;
        #20;
        s = 0;
        s_tile_ready = 0;
        
        v_tile_1 = 16'h0380;
        v_tile_2 = 16'h0390;
        v_tile_ready = 1;
        x_tile_1 = 16'h4000;
        x_tile_2 = 16'h4000;
        x_tile_ready = 1;

        u_tile_1 = 16'h1000;
        u_tile_2 = 16'h1100;
        u_tile_ready = 1;
        #20;
        v_tile_1 = 16'h03c0;
        v_tile_2 = 16'h03d0;
        x_tile_1 = 16'h4000;
        x_tile_2 = 16'h4000;
        u_tile_1 = 16'h1200;
        u_tile_2 = 16'h1300;
        #20;
        v_tile_1 = 16'h0400;
        v_tile_2 = 16'h0410;
        x_tile_1 = 16'h4000;
        x_tile_2 = 16'h4000;
        u_tile_1 = 16'h1400;
        u_tile_2 = 16'h1500;
        #20;
        v_tile_1 = 16'h0440;
        v_tile_2 = 16'h0450;
        x_tile_1 = 16'h4000;
        x_tile_2 = 16'h4000;
        s = 16'h0800;
        s_tile_ready = 1;
        u_tile_1 = 0;
        u_tile_2 = 0;
        u_tile_ready = 0;
        #20;
        v_tile_1 = 16'h0480;
        v_tile_2 = 16'h0490;
        x_tile_1 = 16'h4000;
        x_tile_2 = 16'h4000;
        #20;
        v_tile_1 = 0;
        v_tile_2 = 0;
        v_tile_ready = 0;
        x_tile_1 = 0;
        x_tile_2 = 0;
        x_tile_ready = 0;
        #20;
        s = 0;
        s_tile_ready = 0;
        u_tile_1 = 16'h2600;
        u_tile_2 = 16'h2700;
        u_tile_ready = 1;
        #20;
        u_tile_1 = 16'h2800;
        u_tile_2 = 16'h2900;
        #20;
        u_tile_1 = 16'h2a00;
        u_tile_2 = 16'h2b00;
        #20;
        s = 16'h0400;
        s_tile_ready = 1;
        u_tile_1 = 0;
        u_tile_2 = 0;
        u_tile_ready = 0;
        #60;
        s = 0;
        s_tile_ready = 0;
        u_tile_1 = 16'h2c00;
        u_tile_2 = 16'h2d00;
        u_tile_ready = 1;
        #20;
        u_tile_1 = 16'h2e00;
        u_tile_2 = 16'h2f00;
        #20;
        u_tile_1 = 16'h3000;
        u_tile_2 = 16'h3100;
        #20;
        u_tile_1 = 0;
        u_tile_2 = 0;
        u_tile_ready = 0;
        #200;
        $finish;  // End the simulation
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t, Output1 = %h, Output2 = %h", $time, u_kernel_out_1, u_kernel_out_2);
    end

endmodule
