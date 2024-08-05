`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 18:40:30
// Design Name: 
// Module Name: block_ram_1_tb
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

module blk_mem_1_tb;

    // Parameters of the RAM module
    parameter DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 6;

    // Testbench Signals
    reg clk;
    reg wea, rstb;
    reg [ADDR_WIDTH-1:0] addra, addrb;
    reg [DATA_WIDTH-1:0] dina;
    wire [DATA_WIDTH-1:0] doutb;
    wire rsta_busy, rstb_busy;

    // Instantiate the RAM module
    blk_mem_1 your_instance_name (
        .clka(clk),           // synchronous clock for port A
        .wea(wea),
        .addra(addra),
        .dina(dina),
        .clkb(clk),           // synchronous clock for port B
        .addrb(addrb),
        .doutb(doutb)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Clock period of 20 ns
    end

    // Test Sequence Initialization
    initial begin
        // Initialize Inputs
        rstb = 1;             // Start with reset asserted
        wea = 0;
        addra = 0;
        addrb = 0;
        dina = 0;

        // Reset de-assertion
        #30 rstb = 0;         // Deassert reset after initial period

        // Additional initialization for realistic scenarios
        #1000;                // Run simulation for a significant time to observe behavior
        $finish;              // End simulation
    end

    // Port A address and data generation
    always @(posedge clk) begin
        if (rstb) begin
            addra <= 0;
            dina <= 0;
        end else if (wea) begin
            addra <= addrb - 2'b10;
            dina <= dina + 1;
        end
    end

    // Port B address generation
    always @(posedge clk) begin
        if (rstb) begin
            addrb <= 0;
        end else begin
            addrb <= addrb + 1'b1; // Lag behind addra by one cycle
        end
    end

    // Write enable logic
    always @(posedge clk) begin
        if (rstb) begin
            wea <= 0;
        end else begin
            wea <= 1; // Keep writing until explicitly stopped or conditionally managed
        end
    end

endmodule