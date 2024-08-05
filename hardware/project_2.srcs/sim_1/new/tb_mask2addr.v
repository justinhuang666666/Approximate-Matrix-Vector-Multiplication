`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/21 11:01:30
// Design Name: 
// Module Name: tb_mask2addr
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

// module tb_mask2addr;

//     // Inputs
//     reg clk;
//     reg clk_en;
//     reg rst;
//     reg mask_ready;
//     reg [31:0] mask;

//     // Outputs
//     wire valid;
//     wire [4:0] out;

//     // Instantiate the Unit Under Test (UUT)
//     mask2addr uut (
//         .clk(clk),
//         .clk_en(clk_en),
//         .rst(rst),
//         .mask_ready(mask_ready),
//         .mask(mask),
//         .valid(valid),
//         .out(out)
//     );

//     // Clock generation
//     initial begin
//         clk = 0;
//         forever #10 clk = ~clk; // 100 MHz clock
//     end

//     // Test Stimuli
//     initial begin
//         // Initialize Inputs
//         rst = 1;
//         clk_en = 0;
//         mask_ready = 0;
//         mask = 0;
//         #50; // Allow for reset

//         rst = 0;
//         clk_en = 1;
//         mask_ready = 1;
//         mask = 32'hA5A5A5A5; // Test mask with alternating bits set
//         #20;

//         mask_ready = 0; // No new mask is ready
//         #320; // Allow time for all addresses to be output

//         mask = 32'hFFFF0000; // Upper half bits set
//         mask_ready = 1;
//         #20;

//         mask_ready = 0;
//         #320; // Allow time for all addresses to be output

//         mask = 32'h0000FFFF; // Lower half bits set
//         mask_ready = 1;
//         #20;

//         mask_ready = 0;
//         #360; // Allow time for all addresses to be output

//         rst = 1; // Test reset functionality
//         #40;

//         rst = 0;
//         #20;
//         mask = 32'hFFFFFFFF; // All bits set
//         mask_ready = 1;
//         #20;

//         mask_ready = 0;
//         #400; // Allow time for all addresses to be output

//         $finish; // End simulation
//     end

//     // Monitoring Outputs
//     initial begin
//         $monitor("At time %t, mask = %032b, out = %032b, valid = %b", 
//                  $time, mask, out, valid);
//     end

// endmodule


// module tb_mask2addr;

//     // Inputs
//     reg clk;
//     reg clk_en;
//     reg rst;
//     reg mask_ready;
//     reg [31:0] mask;

//     // Outputs
//     wire valid;
//     wire [4:0] out;

//     // Instantiate the Unit Under Test (UUT)
//     mask2addr uut (
//         .clk(clk),
//         .clk_en(clk_en),
//         .rst(rst),
//         .mask_ready(mask_ready),
//         .mask(mask),
//         .valid(valid),
//         .out(out)
//     );

//     // Clock generation
//     initial begin
//         clk = 0;
//         forever #10 clk = ~clk; // Generate a clock with a period of 20ns (50 MHz)
//     end

//     // Test Stimuli
//     initial begin
//         // Initialize Inputs
//         @(posedge clk) rst = 1; clk_en = 0; mask_ready = 0; mask = 0;
//         @(posedge clk) rst = 0; @(posedge clk) clk_en = 1;

//         // Test Case 1: Alternating bits set
//         @(posedge clk) mask = 32'hA5A5A5A5; mask_ready = 1;
//         @(posedge clk) mask = 0; mask_ready = 0; // Wait for some clock cycles
//         repeat (16) @(posedge clk);

//         // Test Case 2: Upper half bits set
//         @(posedge clk) mask = 32'hFFFF0000; mask_ready = 1;
//         @(posedge clk) mask = 0; mask_ready = 0;
//         repeat (16) @(posedge clk);

//         // Test Case 3: Lower half bits set
//         @(posedge clk) mask = 32'h0000FFFF; mask_ready = 1;
//         @(posedge clk) mask = 0; mask_ready = 0;
//         repeat (16) @(posedge clk);

//         // Test Reset functionality
//         @(posedge clk) rst = 0; //
//         @(posedge clk) rst = 0;

//         // Test Case 4: All bits set
//         @(posedge clk) mask = 32'hFFFFFFFF; mask_ready = 1;
//         @(posedge clk) mask = 0; mask_ready = 0;
//         repeat (32) @(posedge clk);

//         @(posedge clk);
//         $finish; // End simulation
//     end

//     // Monitoring Outputs
//     initial begin
//         $monitor("At time %t, mask = %032b, out = %05b, valid = %b", 
//                  $time, mask, out, valid);
//     end

// endmodule

module tb_mask2addr;

    // Parameters for the testbench to match UUT parameterization
    parameter WIDTH = 8;
    parameter ADDR_WIDTH = $clog2(WIDTH);

    // Inputs
    reg clk;
    reg clk_en;
    reg rst;
    reg mask_ready;
    reg [WIDTH-1:0] mask;  // Adjusted mask width

    // Outputs
    wire valid;
    wire [ADDR_WIDTH-1:0] out;  // Adjusted output width

    // Instantiate the Unit Under Test (UUT) with parameters
    mask2addr #(
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
        forever #10 clk = ~clk; // Generate a clock with a period of 20ns (50 MHz)
    end

    // Test Stimuli
    initial begin
        // Initialize Inputs
        @(posedge clk) rst = 1; clk_en = 0; mask_ready = 0; mask = 0;
        @(posedge clk) rst = 0; @(posedge clk) clk_en = 1;

        // Test Case 1: Alternating bits set
        @(posedge clk) mask = 8'h66; mask_ready = 1;
        @(posedge clk) mask = 0; mask_ready = 0; // Wait for some clock cycles
        repeat (48) @(posedge clk);

        // Test Case 2: Upper half bits set
        @(posedge clk) mask = 8'h66; mask_ready = 1;
        @(posedge clk) mask = 0; mask_ready = 0;
        repeat (48) @(posedge clk);

        // Test Case 3: Lower half bits set
        @(posedge clk) mask = 8'h66; mask_ready = 1;
        @(posedge clk) mask = 0; mask_ready = 0;
        repeat (48) @(posedge clk);

        // Test Reset functionality
        @(posedge clk) rst = 0; //
        @(posedge clk) rst = 0;

        // Test Case 4: All bits set
        @(posedge clk) mask = 8'h66; mask_ready = 1;
        @(posedge clk) mask = 0; mask_ready = 0;
        repeat (96) @(posedge clk);

        @(posedge clk);
        $finish; // End simulation
    end

    // Monitoring Outputs
    initial begin
        $monitor("At time %t, mask = %032b, out = %05b, valid = %b", 
                 $time, mask, out, valid);
    end

endmodule