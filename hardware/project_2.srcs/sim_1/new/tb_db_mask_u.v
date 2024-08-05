`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/20 21:39:00
// Design Name: 
// Module Name: tb_db_mask_u
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

module tb_db_mask_u();

    // Inputs to the db_mask_u module
    reg clk;
    reg sel;
    
    // Outputs from the db_mask_u module
    wire db_mask_u_ready;
    wire [31:0] db_mask_u_out;

    // Instantiate the db_mask_u module
    db_mask_u uut (
        .clk(clk),
        .sel(sel),
        .db_mask_u_ready(db_mask_u_ready),
        .db_mask_u_out(db_mask_u_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // 50 MHz Clock
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        sel = 0;

        // Wait for global reset, synchronize with the clock
        @(posedge clk);
        #20;  // Ensuring we are off the clock edge

        // Case 1: Select the first buffer
        @(posedge clk);
        sel = 0;
        @(posedge clk);  // Waiting a clock cycle after changing the selection
        
        // Case 2: Select the second buffer
        @(posedge clk);
        sel = 1;
        @(posedge clk);  // Waiting a clock cycle after changing the selection

        // Repeat changing selection, synchronized with clock edges
        repeat (5) begin
            @(posedge clk);
            sel = ~sel;
        end

        // Wait a few cycles to observe the final state
        repeat (3) @(posedge clk);

        // End simulation
        $finish;
    end

endmodule
