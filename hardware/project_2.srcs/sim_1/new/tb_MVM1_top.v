`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/26 15:45:31
// Design Name: 
// Module Name: tb_MVM1_top
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

module tb_MVM1_top;

    // Parameters
    parameter MASK_V_WIDTH = 96;
    parameter MASK_V_ADDR_WIDTH = $clog2(MASK_V_WIDTH);
    parameter MASK_U_WIDTH = 32;
    parameter MASK_U_ADDR_WIDTH = $clog2(MASK_U_WIDTH);

    // Inputs
    reg clk;
    reg rst;
    reg clk_en;
    reg start;
    reg [7:0] NZc;
    reg [7:0] NZr;
    reg [7:0] num_iter;

    // Outputs
    wire finish;

    wire [31:0] svd_kernel_1_out_1;
    wire [31:0] svd_kernel_1_out_2;
    wire [31:0] svd_kernel_2_out_1;
    wire [31:0] svd_kernel_2_out_2;
    wire [31:0] svd_kernel_3_out_1;
    wire [31:0] svd_kernel_3_out_2;
    wire [31:0] svd_kernel_4_out_1;
    wire [31:0] svd_kernel_4_out_2;
    
    // Instantiate the Unit Under Test (UUT)
    MVM1_top #(
        .MASK_V_WIDTH(MASK_V_WIDTH),
        .MASK_V_ADDR_WIDTH(MASK_V_ADDR_WIDTH),
        .MASK_U_WIDTH(MASK_U_WIDTH),
        .MASK_U_ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    ) uut (
        .clk(clk), 
        .rst(rst), 
        .clk_en(clk_en), 
        .start(start), 
        .NZc(NZc), 
        .NZr(NZr), 
        .num_iter(num_iter), 
        .finish(finish), 
        .svd_kernel_1_out_1(svd_kernel_1_out_1),
        .svd_kernel_1_out_2(svd_kernel_1_out_2),
        .svd_kernel_2_out_1(svd_kernel_2_out_1),
        .svd_kernel_2_out_2(svd_kernel_2_out_2),
        .svd_kernel_3_out_1(svd_kernel_3_out_1),
        .svd_kernel_3_out_2(svd_kernel_3_out_2),
        .svd_kernel_4_out_1(svd_kernel_4_out_1),
        .svd_kernel_4_out_2(svd_kernel_4_out_2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100 MHz clock
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        rst = 1;
        clk_en = 1;
        start = 0;
        NZc = 8'h00;
        NZr = 8'h00;
        num_iter = 8'h00;

        // Reset pulse
        #10;
        rst = 0;

        // Set the inputs
        NZc = 8'd72;       // NZc = 72
        NZr = 8'd24;       // NZr = 24
        num_iter = 8'd6;

        // Start the processing
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;

        // Wait for the finish signal
        wait (finish == 1);

        // Add any additional checks or logging here

        // End simulation
        #1000;
        $stop;
    end
      
endmodule