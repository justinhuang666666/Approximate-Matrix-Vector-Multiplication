`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 18:48:54
// Design Name: 
// Module Name: fix_acc_16_sset_tb
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


`timescale 1ns / 1ps

module fix_acc_16_sset_tb;

    // Inputs
    reg [15:0] B;
    reg CLK;
    reg CE;
    reg SCLR;
    reg SSET;

    // Output
    wire [15:0] Q;

    // Instantiate the Unit Under Test (UUT)
    fix_acc_16_sset uut (
        .B(B),
        .CLK(CLK),
        .CE(CE),
        .SCLR(SCLR),
        .SSET(SSET),
        .Q(Q)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK; // 100MHz clock
    end

    // Initial setup and test vectors
    initial begin
        // Initialize Inputs
        B = 0;
        CE = 0;
        SCLR = 0;
        SSET = 0;

        // Wait for global reset
        #100;
        
        // Test Case 1: Synchronous Set
        SSET = 1; // Set the accumulator to its set value
        CE = 1; // Enable the clock for operations
        B = 16'sh1000;
        #20; // Hold the set for one clock cycle
        SSET = 0;

        // Test Case 3: Synchronous Clear
        SCLR = 1; // Clear the accumulator
        B = 0;
        #20; // Clear effect on one clock cycle
        SCLR = 0;
        #20;
        
        // Test Case 2: Normal Operation
        B = 16'sh1000; // Fractional part represents 0.125 for a fixed-point format with 13 fractional bits
        #20; // Allow one cycle for accumulation
        B = 16'sh2000; // Fractional part represents 0.25
        #40; // Allow two cycles for accumulation
        


        // Test Case 4: Resume normal operation
        B = 16'sh0800; // Fractional part represents 0.0625
        #20;
        B = 16'sh0400; // Fractional part represents 0.03125
        #40;

        // Finish the simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %t, B = %h, Q = %h", $time, B, Q);
    end

endmodule

