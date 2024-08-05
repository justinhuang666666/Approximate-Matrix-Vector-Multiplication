`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 20:19:07
// Design Name: 
// Module Name: svd_kernel_3
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


module svd_kernel_3#(
    parameter MASK_V_WIDTH = 96,
    parameter MASK_V_ADDR_WIDTH = $clog2(MASK_V_WIDTH),
    parameter MASK_U_WIDTH = 32,
    parameter MASK_U_ADDR_WIDTH = $clog2(MASK_U_WIDTH)
)(
    input clk,
    input clk_en,
    input rst,

    input [31:0] u_tile_1,
    input [31:0] u_tile_2,
    input u_tile_ready,

    input [31:0] v_tile_1,
    input [31:0] v_tile_2,
    input v_tile_ready,

    input [31:0] x_tile_1,
    input [31:0] x_tile_2,
    input x_tile_ready,

    input [31:0] s_tile_1,
    input [31:0] s_tile_2,
    input [31:0] s_tile_3,
    input [31:0] s_tile_4,
    input s_tile_ready,

    input ram_adder_addr_ready,
    input [MASK_U_ADDR_WIDTH-1:0] ram_adder_addr,

    output wire [31:0] svd_kernel_out_1_1,
    output wire [31:0] svd_kernel_out_1_2,
    output wire [31:0] svd_kernel_out_2_1,
    output wire [31:0] svd_kernel_out_2_2,
    output wire [31:0] svd_kernel_out_3_1,
    output wire [31:0] svd_kernel_out_3_2,
    output wire [31:0] svd_kernel_out_4_1,
    output wire [31:0] svd_kernel_out_4_2
);

    wire [31:0] v_kernel_result;
    wire [31:0] s_kernel_result_1;
    wire [31:0] s_kernel_result_2;
    wire [31:0] s_kernel_result_3;
    wire [31:0] s_kernel_result_4;

    wire u_kernel_acc_rst;
    wire v_kernel_acc_rst;

    wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_raddr;
    wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_waddr;

    wire v_kernel_en;

    wire ram_adder_in_ready;
    wire ram_adder_wea;

    wire [31:0] u_kernel_out_1_1;
    wire [31:0] u_kernel_out_1_2;
    wire [31:0] u_kernel_out_2_1;
    wire [31:0] u_kernel_out_2_2;
    wire [31:0] u_kernel_out_3_1;
    wire [31:0] u_kernel_out_3_2;
    wire [31:0] u_kernel_out_4_1;
    wire [31:0] u_kernel_out_4_2;

    svd_kernel_fsm#(
        .MASK_V_WIDTH(MASK_V_WIDTH),
        .MASK_V_ADDR_WIDTH(MASK_V_ADDR_WIDTH),
        .MASK_U_WIDTH(MASK_U_WIDTH),
        .MASK_U_ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    ) svd_kernel_fsm_instance_1 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .u_tile_ready(u_tile_ready),
        .x_tile_ready(x_tile_ready),
        .v_tile_ready(v_tile_ready),
        .ram_adder_addr_ready(ram_adder_addr_ready),
        .v_kernel_en(v_kernel_en),
        .s_kernel_en(s_kernel_en),
        .u_kernel_en(u_kernel_en),
        .v_kernel_acc_rst(v_kernel_acc_rst),
        .ram_adder_in_ready(ram_adder_in_ready),
        .ram_adder_wea(ram_adder_wea),
        .ram_adder_raddr(ram_adder_addr),
        .ram_adder_waddr(ram_adder_waddr),
        .s_tile_ready(s_tile_ready)
    );

    v_kernel_32 v_kernel_instance_1 (
        .clk(clk),
        .clk_en(clk_en & v_kernel_en),
        .acc_rst(v_kernel_acc_rst),
        .v_tile_1(v_tile_1),
        .v_tile_2(v_tile_2),
        .x_tile_1(x_tile_1),
        .x_tile_2(x_tile_2),
        .v_kernel_out(v_kernel_result)
    );

    reg [31:0] buffer;
    wire [31:0] vx_input;
    reg v_kernel_acc_rst_prev;

    always @(posedge clk) begin
        if (rst)
            v_kernel_acc_rst_prev <= 0;  // Clear the buffer on reset
        else
            v_kernel_acc_rst_prev <= v_kernel_acc_rst;  // Store the result in the buffer when v_tile_ready is high

    end

    // Buffer logic to store v_kernel_result
    always @(posedge clk) begin
        if (rst)
            buffer <= 0;  // Clear the buffer on reset
        else if (!v_kernel_acc_rst_prev & v_kernel_acc_rst)
            buffer <= v_kernel_result;  // Store the result in the buffer when v_tile_ready is high
        else if (!s_tile_ready)
            buffer <= 0;  // Clear the buffer when s_tile_ready is low
    end

    assign vx_input = (!v_kernel_acc_rst_prev & v_kernel_acc_rst) ? v_kernel_result : buffer;
    // assign vx_input = buffer;

    s_kernel_32 s_kernel_instance_1 (
        .clk(clk),
        .clk_en(s_kernel_en),
        .rst(rst),
        .vx(vx_input),
        .s(s_tile_1),
        .s_kernel_out(s_kernel_result_1)
    );

    s_kernel_32 s_kernel_instance_2 (
        .clk(clk),
        .clk_en(s_kernel_en),
        .rst(rst),
        .vx(vx_input),
        .s(s_tile_4),
        .s_kernel_out(s_kernel_result_2)
    );

    s_kernel_32 s_kernel_instance_3 (
        .clk(clk),
        .clk_en(s_kernel_en),
        .rst(rst),
        .vx(vx_input),
        .s(s_tile_2),
        .s_kernel_out(s_kernel_result_3)
    );

    s_kernel_32 s_kernel_instance_4 (
        .clk(clk),
        .clk_en(s_kernel_en),
        .rst(rst),
        .vx(vx_input),
        .s(s_tile_3),
        .s_kernel_out(s_kernel_result_4)
    );

    u_kernel_32 u_kernel_instance_1 (
        .clk(clk),
        .clk_en(u_kernel_en),
        .acc_rst(u_kernel_acc_rst),
        .svx(s_kernel_result_1),
        .u_tile_1(u_tile_1),
        .u_tile_2(u_tile_2),
        .u_kernel_out_1(u_kernel_out_1_1),
        .u_kernel_out_2(u_kernel_out_1_2)
    );

    ram_adder_32 ram_adder_instance_1 (
        .clk(clk),           // Clock signal
        .rst(rst),         // Rst signal
        .ina_data(u_kernel_out_1_1),// Input data to be added
        .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
        .wea(ram_adder_wea),
        .waddr(ram_adder_waddr),
        .raddr(ram_adder_addr),
        .ram_output(svd_kernel_out_1_1),  // Output data from the memory (not used in this specific module)
        .sum_output()
    );

    ram_adder_32 ram_adder_instance_2 (
        .clk(clk),           // Clock signal
        .rst(rst),         // Rst signal
        .ina_data(u_kernel_out_1_2),// Input data to be added
        .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
        .wea(ram_adder_wea),
        .waddr(ram_adder_waddr),
        .raddr(ram_adder_addr),
        .ram_output(svd_kernel_out_1_2),  // Output data from the memory (not used in this specific module)
        .sum_output()
    );

    u_kernel_32 u_kernel_instance_2 (
        .clk(clk),
        .clk_en(u_kernel_en),
        .acc_rst(u_kernel_acc_rst),
        .svx(s_kernel_result_2),
        .u_tile_1(u_tile_1),
        .u_tile_2(u_tile_2),
        .u_kernel_out_1(u_kernel_out_2_1),
        .u_kernel_out_2(u_kernel_out_2_2)
    );

    ram_adder_32 ram_adder_instance_3 (
        .clk(clk),           // Clock signal
        .rst(rst),         // Rst signal
        .ina_data(u_kernel_out_2_1),// Input data to be added
        .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
        .wea(ram_adder_wea),
        .waddr(ram_adder_waddr),
        .raddr(ram_adder_addr),
        .ram_output(svd_kernel_out_2_1),  // Output data from the memory (not used in this specific module)
        .sum_output()
    );

    ram_adder_32 ram_adder_instance_4 (
        .clk(clk),           // Clock signal
        .rst(rst),         // Rst signal
        .ina_data(u_kernel_out_2_2),// Input data to be added
        .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
        .wea(ram_adder_wea),
        .waddr(ram_adder_waddr),
        .raddr(ram_adder_addr),
        .ram_output(svd_kernel_out_2_2),  // Output data from the memory (not used in this specific module)
        .sum_output()
    );

    u_kernel_32 u_kernel_instance_3 (
        .clk(clk),
        .clk_en(u_kernel_en),
        .acc_rst(u_kernel_acc_rst),
        .svx(s_kernel_result_3),
        .u_tile_1(u_tile_1),
        .u_tile_2(u_tile_2),
        .u_kernel_out_1(u_kernel_out_3_1),
        .u_kernel_out_2(u_kernel_out_3_2)
    );

    ram_adder_32 ram_adder_instance_5 (
        .clk(clk),           // Clock signal
        .rst(rst),         // Rst signal
        .ina_data(u_kernel_out_3_1),// Input data to be added
        .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
        .wea(ram_adder_wea),
        .waddr(ram_adder_waddr),
        .raddr(ram_adder_addr),
        .ram_output(svd_kernel_out_3_1),  // Output data from the memory (not used in this specific module)
        .sum_output()
    );

    ram_adder_32 ram_adder_instance_6 (
        .clk(clk),           // Clock signal
        .rst(rst),         // Rst signal
        .ina_data(u_kernel_out_3_2),// Input data to be added
        .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
        .wea(ram_adder_wea),
        .waddr(ram_adder_waddr),
        .raddr(ram_adder_addr),
        .ram_output(svd_kernel_out_3_2),  // Output data from the memory (not used in this specific module)
        .sum_output()
    );

    u_kernel_32 u_kernel_instance_4 (
        .clk(clk),
        .clk_en(u_kernel_en),
        .acc_rst(u_kernel_acc_rst),
        .svx(s_kernel_result_4),
        .u_tile_1(u_tile_1),
        .u_tile_2(u_tile_2),
        .u_kernel_out_1(u_kernel_out_4_1),
    .u_kernel_out_2(u_kernel_out_4_2)
    );

    ram_adder_32 ram_adder_instance_7 (
        .clk(clk),           // Clock signal
        .rst(rst),         // Rst signal
        .ina_data(u_kernel_out_4_1),// Input data to be added
        .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
        .wea(ram_adder_wea),
        .waddr(ram_adder_waddr),
        .raddr(ram_adder_addr),
        .ram_output(svd_kernel_out_4_1),  // Output data from the memory (not used in this specific module)
        .sum_output()
    );

    ram_adder_32 ram_adder_instance_8 (
        .clk(clk),           // Clock signal
        .rst(rst),         // Rst signal
        .ina_data(u_kernel_out_4_2),// Input data to be added
        .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
        .wea(ram_adder_wea),
        .waddr(ram_adder_waddr),
        .raddr(ram_adder_addr),
        .ram_output(svd_kernel_out_4_2),  // Output data from the memory (not used in this specific module)
        .sum_output()
    );

endmodule
