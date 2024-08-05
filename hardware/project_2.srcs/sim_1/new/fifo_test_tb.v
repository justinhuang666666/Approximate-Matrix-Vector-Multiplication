`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/06 16:11:28
// Design Name: 
// Module Name: fifo_test_tb
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

 
module fifo_test_tb();
//时钟和复位
    reg     clk      ;
    reg     rst_n       ;
//输入信号
    reg [15:0]    wr_din;
    reg          wr_en ;
    reg          rd_en ;
//输出信号
    wire        rd_out_vld  ;
    wire [15:0]  rd_dout     ;
    wire wr_full;
    wire rd_empty;
//待测试的模块例化
//     fifo_test u_fifo_test(
//     .clk         (clk  ),//时钟
//     .rst_n          (rst_n   ),//复位
//     .wr_din         (wr_din  ),//写入 FIFO 的数据
//     .wr_en          (wr_en   ),//写使能
//     .rd_en          (rd_en   ),//读使能
//     .rd_dout        (rd_dout ),//从 FIFO 读出的数据
//     .rd_out_vld     (rd_out_vld )//从 FIFO 读出的数据有效指示信号
// );

    fifo1 your_instance_name (
    .clk(clk),                  // input wire clk
    .srst(!rst_n),                // input wire srst
    .din(wr_din),                  // input wire [15 : 0] din
    .wr_en(wr_en),              // input wire wr_en
    .rd_en(rd_en),              // input wire rd_en
    .dout(rd_dout),                // output wire [15 : 0] dout
    .full(wr_full),                // output wire full
    .empty(rd_empty),              // output wire empty
    .wr_rst_busy(),  // output wire wr_rst_busy
    .rd_rst_busy()  // output wire rd_rst_busy
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Generate a clock with a 100 MHz frequency
    end

// Test stimulus
    initial begin
        // Initialize Inputs
        rst_n = 0;
        wr_din = 0;
        wr_en = 0;
        rd_en = 0;
        #30;
        rst_n = 1;
        #100;
        wr_din = 16'h0001;
        wr_en = 1;
        #20;
        rd_en = 1;
        wr_din = 16'h0002;
        #20;
        rd_en = 0;
        wr_din = 16'h0003;
        #20;
        rd_en = 1;
        wr_din = 0;
        wr_en = 0;
        #20;
        rd_en = 0;
        #100;
        $finish;  // End the simulation
    end
    
endmodule
