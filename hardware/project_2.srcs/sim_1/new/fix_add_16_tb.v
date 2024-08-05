`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 12:07:08
// Design Name: 
// Module Name: fix_add_16_tb
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

module fix_add_16_tb;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;
    reg CLK;
    reg CE;
    reg SCLR;

    // Outputs
    wire [15:0] S;

    // Instantiate the Unit Under Test (UUT)
    fix_add_16 your_instance_name (
        .A(A), 
        .B(B),
        .CLK(CLK), 
        .CE(CE), 
        .SCLR(SCLR),
        .S(S)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK; // Clock period of 20ns
    end

    // Initialize Inputs and Stimulate Inputs
    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        CE = 0;
        SCLR = 1; // Assert reset to start

        // Wait for global reset to finish
        #100;
        SCLR = 0; // Deassert reset
        CE = 1;   // Enable the circuit
        
        // Apply test vectors
        // Test Case 1
        A = 16'sh2000; // Example fixed-point value
        B = 16'sh1000; // Example fixed-point value
        #40; // Wait two clock cycles
        check_result(16'sh3000, "Test Case 1");

        // Test Case 2
        A = -16'sh2000; // Negative value
        B = 16'sh1000;  // Positive value
        #40; // Wait two clock cycles
        check_result(-16'sh1000, "Test Case 2");

        // Test Case 3
        A = -16'sh3000; // Larger negative value
        B = -16'sh7000; // Larger negative value
        #40; // Wait two clock cycles
        check_result(-16'shA000, "Test Case 3");

        // Finish simulation
        $finish;
    end

    // Output monitoring and result checking
    task check_result;
        input [15:0] expected_value;
        input [127:0] test_case_description;
        begin
            if (S !== expected_value) begin
                $display("%s failed at %t: Expected %h, got %h", test_case_description, $time, expected_value, S);
            end else begin
                $display("%s passed at %t: Expected %h, got %h", test_case_description, $time, expected_value, S);
            end
        end
    endtask

    initial begin
        $monitor("At time %t, A = %h, B = %h, S = %h", $time, A, B, S);
    end

endmodule

