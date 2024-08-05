`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/21 22:14:25
// Design Name: 
// Module Name: tb_db_u_tile
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

module tb_db_u_tile;

    // Testbench signals
    reg clk;
    reg rst;
    reg clk_en;
    reg u_tile_ready;
    reg read;
    reg [63:0] u_tile;
    wire db_ready;
    wire [63:0] db_out;
    wire db_valid;

    // Instantiate the DUT (Device Under Test)
    db_u_tile uut (
        .clk(clk),
        .rst(rst),
        .clk_en(clk_en),
        .u_tile_ready(u_tile_ready),
        .read(read),
        .u_tile(u_tile),
        // .db_ready(db_ready),
        .db_out(db_out),
        .db_valid(db_valid)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        clk_en = 0;
        u_tile_ready = 0;
        read = 0;
        u_tile = 64'h0;

        // Reset pulse
        #25;
        rst = 0;

        // Enable clock and start test
        clk_en = 1;

        // Test case 1: Write data to buffer 0
        #10;
        u_tile_ready = 1;
        #10;
        #10;
        u_tile = 64'h0000000000000001;
        #10;
        u_tile = 64'h0000000000000010;
        #10;
        u_tile = 64'h0000000000000011;
        #10;
        u_tile = 64'h0000000000000100;
        #10;
        u_tile = 64'h0000000000000101;
        #10;
        u_tile_ready = 0;
        #10;
        u_tile_ready = 1;
        u_tile = 64'h0000000000000001;
        #10;
        u_tile = 64'h0000000000000010;
        #10;
        u_tile = 64'h0000000000000011;
        #10;
        u_tile = 64'h0000000000000100;
        #10;
        u_tile = 64'h0000000000000101;
        #10;
        u_tile_ready = 0;
        #100;
        $stop;
    end

    // initial begin
    //     #25;
    //     #10;
    //     #10;
    //     #10;
    //     read = 1;
    //     #10;
    //     read = 0;
    //     #10;
    //     read = 1;
    //     #10;
    //     read = 0;
    //     #10;
    //     read = 1;
    //     #10;
    //     read = 0;
    //     #90;
    //     $stop;
    // end

endmodule
