`timescale 1ns / 1ps
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 12:19:11
// Design Name: 
// Module Name: fix_acc_16_tb
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


module fix_acc_16_tb;

    // Inputs
    reg [15:0] B;
    reg CLK;
    reg CE;
    reg SCLR;

    // Outputs
    wire [15:0] Q;

    // Instantiate the Unit Under Test (UUT)
    fix_acc_16 your_instance_name (
        .B(B),
        .CLK(CLK),
        .CE(CE),
        .SCLR(SCLR),
        .Q(Q)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;  // Generate a clock with a period of 20ns (50 MHz)
    end

    // Initialize Inputs and apply test stimulus
    initial begin
        // Initialize Inputs
        B = 0;
        CE = 0;
        SCLR = 0;

        // Wait for global reset
        #100;

        // Apply stimulus
        CE = 1;  // Enable the accumulator
        SCLR = 1;  // Clear the accumulator

        #20 SCLR = 0;

        B = 16'sh0200;  // Example input (small positive number)

        #40;  // Wait two clock cycles
        
        B = 16'shFD00;  // Example input (small negative number)

        #40;  // Accumulate previous and this
        
        B = 16'sh0100;  // Another small positive
        #20;
        
        CE = 0;
        #20;  // Wait one clock cycle
        B = 16'sh3000;  // Input should pass through
        #20

        #100;
        $finish;  // End simulation
    end

endmodule

