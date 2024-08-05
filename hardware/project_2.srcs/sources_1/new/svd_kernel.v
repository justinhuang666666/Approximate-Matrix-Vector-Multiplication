`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 18:06:37
// Design Name: 
// Module Name: svd_kernel
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

module svd_kernel(
    input clk,
    input clk_en,
    input rst,

    input [15:0] u_tile_1,
    input [15:0] u_tile_2,
    input u_tile_ready,

    input [15:0] v_tile_1,
    input [15:0] v_tile_2,
    input v_tile_ready,
    input [15:0] x_tile_1,
    input [15:0] x_tile_2,
    input x_tile_ready,

    input [15:0] s,
    input s_tile_ready,

    output wire [15:0] u_kernel_out_1,
    output wire [15:0] u_kernel_out_2,
    output wire svd_kernel_valid
);

wire [15:0] v_kernel_result;
wire [15:0] s_kernel_result;

wire u_kernel_acc_rst;
wire v_kernel_acc_rst;

wire ram_adder_in_ready;
wire ram_adder_wea;

wire [5:0] ram_adder_raddr;
wire [5:0] ram_adder_waddr;

svd_kernel_fsm svd_kernel_fsm_instance_1 (
    .clk(clk),
    .clk_en(clk_en),
    .rst(rst),
    .u_tile_ready(u_tile_ready),
    // .u_kernel_acc_rst(u_kernel_acc_rst),
    .x_tile_ready(x_tile_ready),
    .v_tile_ready(v_tile_ready),
    .v_kernel_acc_rst(v_kernel_acc_rst),
    .ram_adder_in_ready(ram_adder_in_ready),
    .ram_adder_wea(ram_adder_wea),
    .ram_adder_raddr(ram_adder_raddr),
    .ram_adder_waddr(ram_adder_waddr),
    .s_tile_ready(s_tile_ready)
);

v_kernel v_kernel_instance_1 (
    .clk(clk),
    .clk_en(clk_en),
    .acc_rst(v_kernel_acc_rst),
    .v_tile_1(v_tile_1),
    .v_tile_2(v_tile_2),
    .x_tile_1(x_tile_1),
    .x_tile_2(x_tile_2),
    .v_kernel_out(v_kernel_result)
);

reg [15:0] buffer;
wire [15:0] vx_input;
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

assign vx_input = v_kernel_acc_rst ? v_kernel_result : buffer;

s_kernel s_kernel_instance_1 (
    .clk(clk),
    .clk_en(clk_en),
    .rst(rst),
    .vx(vx_input),
    .s(s),
    .s_kernel_out(s_kernel_result)
);

u_kernel u_kernel_instance_1 (
    .clk(clk),
    .clk_en(clk_en),
    .acc_rst(u_kernel_acc_rst),
    .svx(s_kernel_result),
    .u_tile_1(u_tile_1),
    .u_tile_2(u_tile_2),
    .u_kernel_out_1(u_kernel_out_1),
    .u_kernel_out_2(u_kernel_out_2)
);

ram_adder ram_adder_instance_1 (
    .clk(clk),           // Clock signal
    .rst(rst),         // Rst signal
    .in_data(u_kernel_out_1),// Input data to be added
    .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
    .wea(ram_adder_wea),
    .waddr(ram_adder_waddr),
    .first(first),
    .raddr(ram_adder_raddr),
    .ram_output(),  // Output data from the memory (not used in this specific module)
    .sum_output()
);

ram_adder ram_adder_instance_2 (
    .clk(clk),           // Clock signal
    .rst(rst),         // Rst signal
    .in_data(u_kernel_out_2),// Input data to be added
    .in_ready(ram_adder_in_ready),      // Signal indicating if input data is ready
    .wea(ram_adder_wea),
    .waddr(ram_adder_waddr),
    .first(first),
    .raddr(ram_adder_raddr),
    .ram_output(),  // Output data from the memory (not used in this specific module)
    .sum_output()
);

// assign svd_kernel_valid = u_kernel_acc_rst;

endmodule
