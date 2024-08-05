`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 20:12:59
// Design Name: 
// Module Name: ram_adder_tb
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

module ram_adder_tb();

    // Parameters of the DUT (Device Under Test)
    reg clk;
    reg rst;
    reg [15:0] in_data;
    reg in_ready;
    reg [5:0] raddr;
    reg [5:0] waddr;
    reg wea;
    reg first;
    wire [15:0] ram_output;
    wire [15:0] sum_output;


    // Instantiate the Device Under Test (DUT)
    ram_adder dut (
        .clk(clk),           // Clock signal
        .rst(rst),         // Rst signal
        .in_data(in_data),// Input data to be added
        .in_ready(in_ready),      // Signal indicating if input data is ready
        .wea(wea),
        .waddr(waddr),
        .first(first),
        .raddr(raddr),
        .ram_output(ram_output),  // Output data from the memory (not used in this specific module)
        .sum_output(sum_output)
    );

    // Clock generation
    always #10 clk = ~clk; // 100MHz Clock

    // Initial block to set up the environment and inputs
    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        in_data = 0;
        in_ready = 0;  // Initially, in_ready is low
        first = 0;
        in_data = 0;
        in_ready = 0;
        raddr = 0;
        waddr = 0;
        wea = 0;
        // Wait for 100 ns for global rst to finish
        #70;
        rst = 0;
        #20;
        raddr = 5'd1;
        #20;
        raddr = 5'd2;
        in_data = 16'd1;
        in_ready = 1;  // Initially, in_ready is low
        #20;
        raddr = 5'd3;
        in_data = 16'd2;
        waddr = 5'd1;
        #20;
        wea = 1; //////
        raddr = 5'd4;
        in_data = 16'd3;
        waddr = 5'd2;
        #20;
        raddr = 0;
        in_data = 16'd4;
        waddr = 5'd3;
        #20;
        in_data = 0;
        in_ready = 0;
        waddr = 5'd4;
        #20;
        waddr = 0;
        #20;
        wea = 0;
        #20; 
        raddr = 5'd1;
        #20;
        raddr = 5'd2;
        in_data = 16'd1;
        in_ready = 1;  // Initially, in_ready is low
        #20;
        raddr = 5'd3;
        in_data = 16'd2;
        waddr = 5'd1;
        #20;
        wea = 1;//////
        raddr = 5'd4;
        in_data = 16'd3;
        waddr = 5'd2;
        #20;
        raddr = 0;
        in_data = 16'd4;
        waddr = 5'd3;
        #20;
        in_data = 0;
        in_ready = 0;
        waddr = 5'd4;
        #20;
        waddr = 0;
        #20;
        wea = 0;
        #20; 
        raddr = 5'd1;
        #20;
        raddr = 5'd2;
        in_data = 16'd1;
        in_ready = 1;  // Initially, in_ready is low
        first = 1;
        #20;
        raddr = 5'd3;
        in_data = 16'd2;
        waddr = 5'd1;
        #20;
        wea = 1;//////
        raddr = 5'd4;
        in_data = 16'd3;
        waddr = 5'd2;
        #20;
        raddr = 0;
        in_data = 16'd4;
        waddr = 5'd3;
        #20;
        in_data = 0;
        in_ready = 0;
        first = 0;
        waddr = 5'd4;
        #20;
        waddr = 0;
        #20;
        wea = 0;
        $finish; // Terminate simulation
    end

endmodule
