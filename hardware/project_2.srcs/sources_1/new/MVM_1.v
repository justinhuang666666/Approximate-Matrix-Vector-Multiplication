`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/23 11:17:24
// Design Name: 
// Module Name: MVM_1
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


module MVM_1(
    input clk,
    input clk_en,
    input rst,

    input [7:0] num_iter,
    input [7:0] NZc,
    input [7:0] NZr,
    input start,

    input [63:0] u_tile,
    input u_tile_ready,
    output reg [63:0] u_read_addr,
    output reg u_read_en,

    input [31:0] s_tile,
    input s_tile_ready,
    output reg [63:0] s_read_addr,
    output reg rs_read_en,

    input [63:0] v_tile,
    input v_tile_ready,
    output reg [63:0] v_read_addr,
    output reg v_read_en,

    input [63:0] x_tile,
    input x_tile_ready,
    output [8:0] x_read_addr,
    output reg x_read_en,

    input [31:0] mask_u,
    input mask_u_ready,
    output reg [63:0] mask_u_read_addr,
    output reg mask_u_read_en,

    input [96:0] mask_v,
    input mask_v_ready,
    output reg [63:0] mask_v_read_addr,
    output reg mask_v_read_en,

    input [4:0] out_read_addr,
    output mvm_out_ready,

    output reg [31:0] mvm_out_1,
    output reg [31:0] mvm_out_2,
    output reg [31:0] mvm_out_3,
    output reg [31:0] mvm_out_4,
    output reg [31:0] mvm_out_5,
    output reg [31:0] mvm_out_6,
    output reg [31:0] mvm_out_7,
    output reg [31:0] mvm_out_8
    );

    // reg [7:0] reg_num_iter;
    // reg [7:0] reg_NZc;
    // reg [7:0] reg_NZr;

    // always @(posedge clk) begin
    //     if(rst) begin
    //         reg_num_iter <= 8'b0;
    //         reg_NZc <= 8'b0;
    //         reg_NZr <= 8'b0;
    //     end else if(start) begin
    //         reg_num_iter <= num_iter;
    //         reg_NZc <= NZc;
    //         reg_NZr <= NZr;
    //     end
    // end

    // v finite state machine
    reg [3:0] v_fsm_state;
    reg [7:0] v_fsm_iter_count;
    reg [7:0] v_fsm_wait_count;
    reg [7:0] v_fsm_addr_count;

    parameter v_fsm_IDLE = 4'b0001, 
    v_fsm_LOAD = 4'b0010,
    v_fsm_WAIT_U = 4'b0100, 
    v_fsm_FINISH = 4'b1000; 

    // FSM logic
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            v_fsm_state <= v_fsm_IDLE;
            v_fsm_iter_count <= 0;
            v_fsm_wait_count <= 0;
            v_fsm_addr_count <= 0;
            v_read_addr <= 0;
            v_read_en <= 0;
        end else begin
            case (v_fsm_state)
                v_fsm_IDLE: begin
                    if (start) begin
                        v_fsm_state <= v_fsm_LOAD;
                        v_fsm_addr_count <= 0;
                        v_fsm_iter_count <= 0;
                        v_fsm_wait_count <= 0;
                        v_read_addr <= 0;
                    end
                end
                v_fsm_LOAD: begin
                    if (v_fsm_addr_count < NZc) begin
                        v_read_addr <= v_read_addr + 1;
                        v_fsm_addr_count <= v_fsm_addr_count + 1;
                        v_read_en <= 1'b1;
                    end else begin
                        v_read_en <= 1'b0;
                        v_fsm_state <= v_fsm_WAIT_U;
                    end
                end
                v_fsm_WAIT_U: begin
                    if (NZc > NZr) begin
                        if (v_fsm_iter_count < num_iter) begin
                            v_fsm_state <= v_fsm_LOAD;
                            v_fsm_iter_count <= v_fsm_iter_count + 1;
                            v_fsm_addr_count <= 0;
                        end else begin
                            v_fsm_state <= v_fsm_FINISH;
                        end
                    end else begin
                        if (v_fsm_wait_count < (NZr - NZc)) begin
                            v_fsm_wait_count <= v_fsm_wait_count + 1'b1;
                        end else begin
                            v_fsm_wait_count <= 0;
                            if (v_fsm_iter_count < num_iter) begin
                                v_fsm_state <= v_fsm_LOAD;
                                v_fsm_iter_count <= v_fsm_iter_count + 1;
                                v_fsm_addr_count <= 0;
                            end else begin
                                v_fsm_state <= v_fsm_FINISH;
                            end
                        end
                    end
                end
                v_fsm_FINISH: begin
                    v_fsm_state <= v_fsm_IDLE;
                end
                default: begin
                    v_fsm_state <= v_fsm_IDLE;
                end
            endcase
        end
    end

    // always@(negedge clk or negedge rst) begin
    //     if(rst)
    //         v_fsm_state <= v_fsm_IDLE;
    //     else case(v_fsm_state)
    //         v_fsm_IDLE:
    //             if(start)
    //                 v_fsm_state <= v_fsm_LOAD;
    //         v_fsm_LOAD:
    //             if (v_fsm_addr_count < NZc) begin
    //                 v_read_addr <= v_read_addr + 1;
    //                 v_read_en <= 1'b1;
    //             end else begin
    //                 v_read_en <= 1'b0;
    //                 v_fsm_state <= v_fsm_WAIT_U;
    //             end
    //         v_fsm_WAIT_U:
    //             if(NZc > NZr) begin
    //                 if(v_fsm_iter_count < num_iter) begin
    //                     v_fsm_state <= v_fsm_LOAD;
    //                 end else begin
    //                     v_fsm_state <= v_fsm_FINISH;
    //                 end
    //             end else begin
    //                 if(v_fsm_wait_count < (NZr - NZc)) begin
    //                     v_fsm_wait_count <= v_fsm_wait_count + 1'b1;
    //                 end else begin
    //                     v_fsm_wait_count <= 0;
    //                     if(v_fsm_iter_count < num_iter) begin
    //                         v_fsm_state <= v_fsm_LOAD;
    //                     end else begin
    //                         v_fsm_state <= v_fsm_FINISH;
    //                     end
    //                 end
    //             end
    //         v_fsm_FINISH:
    //                 v_fsm_state <= v_fsm_IDLE;
    //         default:
    //             v_fsm_state <= v_fsm_IDLE;
    //     endcase
    // end

    // svd_kernel_32 svd_kernel_32_instance_1 (
    //     .clk(clk),
    //     .clk_en(clk_en),
    //     .rst(rst),
    //     .u_tile_1(u_tile[63:32]),
    //     .u_tile_2(u_tile[31:0]),
    //     .u_tile_ready(u_tile_ready),
    //     .v_tile_1(v_tile_1),
    //     .v_tile_2(v_tile_2),
    //     .v_tile_ready(v_tile_ready),
    //     .x_tile_1(x_tile_1),
    //     .x_tile_2(x_tile_2),
    //     .x_tile_ready(x_tile_ready),
    //     .s(s),
    //     .s_tile_ready(s_tile_ready),
    //     .ram_adder_addr_ready(ram_adder_addr_ready),
    //     .ram_adder_addr(ram_adder_addr),
    //     .svd_kernel_out_1(svd_kernel_out_1),
    //     .svd_kernel_out_2(svd_kernel_out_2)
    // );
    
    // svd_kernel_32 svd_kernel_32_instance_2 (
    //     .clk(clk),
    //     .clk_en(clk_en),
    //     .rst(rst),
    //     .u_tile_1(u_tile[63:32]),
    //     .u_tile_2(u_tile[31:0]),
    //     .u_tile_ready(u_tile_ready),
    //     .v_tile_1(v_tile_1),
    //     .v_tile_2(v_tile_2),
    //     .v_tile_ready(v_tile_ready),
    //     .x_tile_1(x_tile_1),
    //     .x_tile_2(x_tile_2),
    //     .x_tile_ready(x_tile_ready),
    //     .s(s),
    //     .s_tile_ready(s_tile_ready),
    //     .ram_adder_addr_ready(ram_adder_addr_ready),
    //     .ram_adder_addr(ram_adder_addr),
    //     .svd_kernel_out_1(svd_kernel_out_1),
    //     .svd_kernel_out_2(svd_kernel_out_2)
    // );
    
    // svd_kernel_32 svd_kernel_32_instance_3 (
    //     .clk(clk),
    //     .clk_en(clk_en),
    //     .rst(rst),
    //     .u_tile_1(u_tile[63:32]),
    //     .u_tile_2(u_tile[31:0]),
    //     .u_tile_ready(u_tile_ready),
    //     .v_tile_1(v_tile_1),
    //     .v_tile_2(v_tile_2),
    //     .v_tile_ready(v_tile_ready),
    //     .x_tile_1(x_tile_1),
    //     .x_tile_2(x_tile_2),
    //     .x_tile_ready(x_tile_ready),
    //     .s(s),
    //     .s_tile_ready(s_tile_ready),
    //     .ram_adder_addr_ready(ram_adder_addr_ready),
    //     .ram_adder_addr(ram_adder_addr),
    //     .svd_kernel_out_1(svd_kernel_out_1),
    //     .svd_kernel_out_2(svd_kernel_out_2)
    // );
    
    // svd_kernel_32 svd_kernel_32_instance_4 (
    //     .clk(clk),
    //     .clk_en(clk_en),
    //     .rst(rst),
    //     .u_tile_1(u_tile[63:32]),
    //     .u_tile_2(u_tile[31:0]),
    //     .u_tile_ready(u_tile_ready),
    //     .v_tile_1(v_tile_1),
    //     .v_tile_2(v_tile_2),
    //     .v_tile_ready(v_tile_ready),
    //     .x_tile_1(x_tile_1),
    //     .x_tile_2(x_tile_2),
    //     .x_tile_ready(x_tile_ready),
    //     .s(s),
    //     .s_tile_ready(s_tile_ready),
    //     .ram_adder_addr_ready(ram_adder_addr_ready),
    //     .ram_adder_addr(ram_adder_addr),
    //     .svd_kernel_out_1(svd_kernel_out_1),
    //     .svd_kernel_out_2(svd_kernel_out_2)
    // );
endmodule
