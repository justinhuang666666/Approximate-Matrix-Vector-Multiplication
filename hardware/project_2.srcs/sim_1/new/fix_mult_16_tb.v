`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 12:51:51
// Design Name: 
// Module Name: fix_mult_16_tb
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


module fix_mult_16_tb;

    // Inputs
    reg CLK;
    reg CE;
    reg SCLR;
    reg [15:0] A;
    reg [15:0] B;

    // Outputs
    wire [15:0] P;

    // Instantiate the Unit Under Test (UUT)
    fix_mult_16 your_instance_name (
        .CLK(CLK),
        .A(A),
        .B(B),
        .CE(CE),
        .SCLR(SCLR),
        .P(P)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;  // Clock with a period of 20ns (50 MHz)
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        CE = 0;
        SCLR = 0;
        A = 0;
        B = 0;

        // Reset Pulse
        #5;
        SCLR = 1;  // Assert reset
        #20;
        SCLR = 0;  // Deassert reset
        #15;

        // Enable circuit and apply test cases
        CE = 1;    // Enable operation
        A = 16'sh0800; // 0.25 in Q2.13
        B = 16'sh0800; // 0.25 in Q2.13
        #20;

        A = 16'sh3000; // 1.5 in Q2.13
        B = 16'sh2800; // 1.25 in Q2.13
        #20;

        A = 16'sh8800; // -3.75 in Q2.13
        B = 16'sh0800;  // 0.25 in Q2.13
        #100;
    end

    // Monitor and check results
    initial begin
        $monitor("Time = %t, A = %h, B = %h, P = %h", $time, A, B, P);
    end

endmodule

