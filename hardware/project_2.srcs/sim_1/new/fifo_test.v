`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/06 16:05:08
// Design Name: 
// Module Name: fifo_test
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


module fifo_test(
    input clk ,
    input rst_n ,//复位
    input [15:0] wr_din ,//写入 FIFO 的数据
    input wr_en ,//写使能
    input rd_en ,//读使能
 
    output wire [15:0] rd_dout,//从 FIFO 读出的数据
    output wire rd_out_vld    //从 FIFO 读出的数据有效指示信号
 );
    //信号定义
    wire [15:0] wr_data ;
    wire [15:0] q ;
 
    wire wr_req ;
    wire rd_req ;
 
    wire rd_empty ;
    wire wr_full ;
 
    wire [15:0] wr_rst_busy ;
    wire [15:0] rd_rst_busy ;

    fifo1 your_instance_name (
    .clk(clk),                  // input wire clk
    .srst(!rst_n),                // input wire srst
    .din(din),                  // input wire [15 : 0] din
    .wr_en(wr_req),              // input wire wr_en
    .rd_en(rd_req),              // input wire rd_en
    .dout(q),                // output wire [15 : 0] dout
    .full(wr_full),                // output wire full
    .empty(rd_empty),              // output wire empty
    .wr_rst_busy(wr_rst_busy),  // output wire wr_rst_busy
    .rd_rst_busy(rd_rst_busy)  // output wire rd_rst_busy
    );

    assign wr_req = (wr_full  == 1'b0)?wr_en:1'b0;//非满才写
    assign rd_req = (rd_empty == 1'b0)?rd_en:1'b0;//非空才读
    assign rd_dout = q;
    assign rd_out_vld = rd_req;
    // always @(posedge clk or negedge rst_n)begin
    //     if(!rst_n)begin
    //         rd_dout <= 0;
    //     end
    //         else begin
    //         rd_dout <= q;
    //     end
    // end
    // always @(posedge clk or negedge rst_n)begin
    //     if(!rst_n)begin
    //         rd_out_vld <= 1'b0;
    //     end
    //     else begin
    //         rd_out_vld <= rd_req;
    //     end
    // end
 endmodule
