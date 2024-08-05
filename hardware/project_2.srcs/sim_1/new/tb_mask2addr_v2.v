`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/30 17:17:29
// Design Name: 
// Module Name: tb_mask2addr_v2
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

module tb_mask2addr_v2;

    parameter WIDTH = 96;
    parameter ADDR_WIDTH = $clog2(WIDTH);

    reg clk;
    reg clk_en;
    reg rst;
    reg mask_ready;
    reg [WIDTH-1:0] mask;
    wire valid;
    wire [ADDR_WIDTH-1:0] out;

    // Instantiate the mask2addr_v2 module
    mask2addr_v2 #(
        .WIDTH(WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .mask_ready(mask_ready),
        .mask(mask),
        .valid(valid),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk_en = 1;
        rst = 0;
        mask_ready = 0;
        mask = 0;

        // Reset the module

        rst = 1;
        // #10;

        @(posedge clk)
        rst = 0;

        @(posedge clk)
        @(posedge clk) begin
        // Test Case 1: Single bit mask
        mask = 96'h600000000000000000000001;
        mask_ready = 1;
        end
        
        @(posedge clk)
        mask_ready = 0;
        mask = 0;

        // Wait for processing
        repeat(5) begin
            @(posedge clk);
        end

        // Test Case 2: Multiple bits mask
        mask = 96'hF000000000000000000000FF;
        mask_ready = 1;
        @(posedge clk)
        mask_ready = 0;
        mask = 0;

        // Wait for processing
        repeat(13) begin
            @(posedge clk);
        end

        // Test Case 3: No bits set
        mask = 96'h000000000000000000000000;
        mask_ready = 1;
        @(posedge clk);
        mask_ready = 0;
        mask = 0;

        // Wait for processing
        @(posedge clk);
        @(posedge clk);

        // Test Case 4: Random bits
        mask = 96'h00000000000000FF000000FF;
        mask_ready = 1;
        @(posedge clk);
        mask_ready = 0;
        mask = 0;

        repeat(17) begin
            @(posedge clk);
        end

        // Finish the simulation
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0d, Valid: %b, Out: %0d", $time, valid, out);
    end

endmodule
