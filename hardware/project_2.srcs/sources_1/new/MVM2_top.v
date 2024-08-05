`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 19:33:09
// Design Name: 
// Module Name: MVM2_top
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


module MVM2_top#(
    parameter MASK_V_WIDTH = 48,
    parameter MASK_V_ADDR_WIDTH = $clog2(MASK_V_WIDTH),
    parameter MASK_U_WIDTH = 128,
    parameter MASK_U_ADDR_WIDTH = $clog2(MASK_U_WIDTH)
)(
    input clk,
    input rst,
    input clk_en,
    input start,
    input [7:0] NZc,
    input [7:0] NZr,
    input [7:0] num_iter,

    output wire finish,
    output wire [31:0] svd_kernel_1_out_1,
    output wire [31:0] svd_kernel_1_out_2
    );

    wire [5:0] mask_v_read_addr;
    wire mask_v_read_en;

    wire [5:0] mask_u_read_addr;
    wire mask_u_read_en;

    wire mask_v_valid;
    wire [4*MASK_V_WIDTH-1:0] mask_v;

    wire [MASK_V_ADDR_WIDTH-1:0] x_read_addr_1;
    wire [MASK_V_ADDR_WIDTH-1:0] x_read_addr_2;
    wire [MASK_V_ADDR_WIDTH-1:0] x_read_addr_3;
    wire [MASK_V_ADDR_WIDTH-1:0] x_read_addr_4;
    wire x_read_en;

    wire mask_u_valid;
    wire [4*MASK_U_WIDTH-1:0] mask_u;
    wire [11:0] v_read_addr;
    wire v_read_en;

    wire [9:0] u_read_addr;
    wire u_read_en;

    wire [5:0] s_read_addr;
    wire s_read_en;

    wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_read_addr_1;
    wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_read_addr_2;
    wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_read_addr_3;
    wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_read_addr_4;
    wire ram_adder_read_addr_en;
    
    wire u_tile_valid;
    wire [255:0] u_tile;

    wire s_tile_valid;
    wire [127:0] s_tile;

    wire v_tile_valid;
    wire [255:0] v_tile;

    wire x_tile_valid;
    wire [63:0] x_tile_1;
    wire [63:0] x_tile_2;
    wire [63:0] x_tile_3;
    wire [63:0] x_tile_4;

    MVM_ctrl2 #(
        .MASK_V_WIDTH(MASK_V_WIDTH),
        .MASK_V_ADDR_WIDTH(MASK_V_ADDR_WIDTH),
        .MASK_U_WIDTH(MASK_U_WIDTH),
        .MASK_U_ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    ) MVM_ctrl2_instance_1 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .start(start),
        .NZc(NZc), 
        .NZr(NZr),
        .num_iter(num_iter),
        .mask_v_read_addr(mask_v_read_addr),
        .mask_v_read_en(mask_v_read_en),
        .mask_u_read_addr(mask_u_read_addr),
        .mask_u_read_en(mask_u_read_en),
        .mask_v_ready(mask_v_valid),
        .mask_v_1(mask_v[95:0]),
        .x_read_addr_1(x_read_addr_1),
        .x_read_en(x_read_en),
        .mask_u_ready(mask_u_valid),
        .mask_u_1(mask_u[127:0]),
        .ram_adder_read_addr_1(ram_adder_read_addr_1),
        .ram_adder_read_addr_en(ram_adder_read_addr_en),
        .v_read_addr(v_read_addr),
        .v_read_en(v_read_en),
        .u_read_addr(u_read_addr),
        .u_read_en(u_read_en),
        .s_read_addr(s_read_addr),
        .s_read_en(s_read_en),
        .finish(finish)
    );

    svd_kernel_128#(
        .MASK_V_WIDTH(MASK_V_WIDTH),
        .MASK_V_ADDR_WIDTH(MASK_V_ADDR_WIDTH),
        .MASK_U_WIDTH(MASK_U_WIDTH),
        .MASK_U_ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    ) svd_kernel_128_instance_1 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .u_tile_1(u_tile[63:32]),
        .u_tile_2(u_tile[31:0]),
        .u_tile_ready(u_tile_valid),
        .v_tile_1(v_tile[63:32]),
        .v_tile_2(v_tile[31:0]),
        .v_tile_ready(v_tile_valid),
        .x_tile_1(x_tile_1[63:32]),
        .x_tile_2(x_tile_1[31:0]),
        .x_tile_ready(x_tile_valid),
        .s(s_tile),
        .s_tile_ready(s_tile_valid),
        .ram_adder_addr_ready(ram_adder_read_addr_en),
        .ram_adder_addr(ram_adder_read_addr_1),
        .svd_kernel_out_1(svd_kernel_1_out_1),
        .svd_kernel_out_2(svd_kernel_1_out_2)
    );

    ddr_u_tile ddr_u_tile_instance_1 (
        .clk(clk),
        .addr_en(u_read_en),
        .addr(u_read_addr),
        .u_tile_valid(u_tile_valid),
        .u_tile(u_tile)
    );

    ddr_v_tile ddr_v_tile_instance_1 (
        .clk(clk),
        .addr_en(v_read_en),
        .addr(v_read_addr),
        .v_tile_valid(v_tile_valid),
        .v_tile(v_tile)
    );

    ddr_s_tile ddr_s_tile_instance_1 (
        .clk(clk),
        .addr_en(s_read_en),
        .addr(s_read_addr),
        .s_tile_valid(s_tile_valid),
        .s_tile(s_tile)
    );

    ddr_mask_v ddr_mask_v_instance_1 (
        .clk(clk),
        .addr_en(mask_v_read_en),
        .addr(mask_v_read_addr),
        .mask_v_valid(mask_v_valid),
        .mask_v(mask_v)
    );

    ddr_mask_u ddr_mask_u_instance_1 (
        .clk(clk),
        .addr_en(mask_u_read_en),
        .addr(mask_u_read_addr),
        .mask_u_valid(mask_u_valid),
        .mask_u(mask_u)
    );

    input_vector_buffer input_vector_buffer_instance_1 (
        .clk(clk),
        .addr_en(x_read_en),
        .addr(x_read_addr_1),
        .x_tile_valid(x_tile_valid),
        .x_tile(x_tile_1)
    );
endmodule

