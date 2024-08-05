`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/20 22:23:34
// Design Name: 
// Module Name: tb_db_u_pruned
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

module tb_db_u_pruned;

    // Testbench Signals
    reg clk;
    reg db_u_pruned_sel;
    reg [5:0] db_u_pruned_addr1;
    reg [5:0] db_u_pruned_addr2;
    wire db_u_pruned_ready;
    wire [31:0] db_u_pruned_out1;
    wire [31:0] db_u_pruned_out2;

    // Instantiate the Unit Under Test (UUT)
    db_u_pruned uut (
        .clk(clk),
        .db_u_pruned_sel(db_u_pruned_sel),
        .db_u_pruned_addr1(db_u_pruned_addr1),
        .db_u_pruned_addr2(db_u_pruned_addr2),
        .db_u_pruned_ready(db_u_pruned_ready),
        .db_u_pruned_out1(db_u_pruned_out1),
        .db_u_pruned_out2(db_u_pruned_out2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generate a clock with 100 MHz frequency
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        db_u_pruned_sel = 0;
        db_u_pruned_addr1 = 0;
        db_u_pruned_addr2 = 1;
        @(posedge clk); // Synchronize to the first positive edge of the clock
        @(posedge clk);
        db_u_pruned_sel = 0;
        db_u_pruned_addr1 = 6'b000010;  // Set some address
        db_u_pruned_addr2 = db_u_pruned_addr1 + 1;  // Set some address
        @(posedge clk);  // Allow changes to propagate
        db_u_pruned_sel = 0;
        db_u_pruned_addr1 = 6'b000100;  // Set some address
        db_u_pruned_addr2 = db_u_pruned_addr1 + 1;  // Set some address
        @(posedge clk);  // Allow changes to propagate
        db_u_pruned_addr1 = 6'b000110;  // Set some address
        db_u_pruned_addr2 = db_u_pruned_addr1 + 1;  // Set some address
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        db_u_pruned_sel = 1;
        db_u_pruned_addr1 = 6'b0;  // Change address
        db_u_pruned_addr2 = db_u_pruned_addr1 + 1;  // Change address
        @(posedge clk);  // Allow changes to propagate

        // Continue to toggle the selection
        repeat (5) begin
            @(posedge clk);
            db_u_pruned_sel = ~db_u_pruned_sel;
        end

        @(posedge clk);  // Additional cycle to observe the final toggle
        $finish;
    end

endmodule
