`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 13:32:37
// Design Name: 
// Module Name: svd_kernel_fsm_tb
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

module svd_kernel_fsm_tb;

    // Inputs to the svd_kernel module
    reg clk;
    reg clk_en;
    reg rst;

    reg u_tile_ready;
    wire u_kernel_acc_rst;  // Changed to wire
    reg v_tile_ready;
    reg x_tile_ready;
    wire v_kernel_acc_rst;  // Changed to wire
    reg s_tile_ready;

    wire v_kernel_en;
    reg ram_adder_addr_ready;
    wire ram_adder_in_ready;
    wire ram_adder_wea;

    svd_kernel_fsm svd_kernel_fsm_instance_1 (
    .clk(clk),
    .clk_en(clk_en),
    .rst(rst),
    .u_tile_ready(u_tile_ready),
    .x_tile_ready(x_tile_ready),
    .v_tile_ready(v_tile_ready),
    .ram_adder_addr_ready(ram_adder_addr_ready),
    .v_kernel_en(v_kernel_en),
    .v_kernel_acc_rst(v_kernel_acc_rst),
    .ram_adder_in_ready(ram_adder_in_ready),
    .ram_adder_wea(ram_adder_wea),
    .ram_adder_raddr(),
    .ram_adder_waddr(),
    .s_tile_ready(s_tile_ready)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Generate a clock with a 100 MHz frequency
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        clk_en = 0;
        rst = 1;

        u_tile_ready = 0;
        v_tile_ready = 0;
        x_tile_ready = 0;
        s_tile_ready = 0;
        ram_adder_addr_ready = 0;

        // Apply a reset
        #60;
        rst = 0;
        clk_en = 1;  // Enable the clock for normal operation
        #30;

        repeat (32) begin
            @(posedge clk) begin
                ram_adder_addr_ready = 1;
            end
        end
        ram_adder_addr_ready = 0;
        #200;
        $finish;  // End the simulation
    end
    // Monitor outputs
    initial begin
        $monitor("At time %t, u_kernel_acc_rst = %b, v_kernel_acc_rst = %b", $time, u_kernel_acc_rst, v_kernel_acc_rst);
    end

endmodule
