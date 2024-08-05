`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/27 22:03:43
// Design Name: 
// Module Name: MVM_ctrl1
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



module MVM_ctrl1#(
    parameter MASK_V_WIDTH = 96,
    parameter MASK_V_ADDR_WIDTH = $clog2(MASK_V_WIDTH),
    parameter MASK_U_WIDTH = 32,
    parameter MASK_U_ADDR_WIDTH = $clog2(MASK_U_WIDTH)
)(
    input wire clk,
    input wire clk_en,
    input wire rst,
    input wire start,
    input wire [7:0] NZc,
    input wire [7:0] NZr,
    input wire [7:0] num_iter,

    output reg [5:0] mask_v_read_addr,
    output reg mask_v_read_en,

    output reg [5:0] mask_u_read_addr,
    output reg mask_u_read_en,
    
    input wire mask_v_ready,
    input wire [MASK_V_WIDTH-1:0] mask_v_1,
    output wire [MASK_V_ADDR_WIDTH-1:0] x_read_addr_1,
    input wire [MASK_V_WIDTH-1:0] mask_v_2,
    output wire [MASK_V_ADDR_WIDTH-1:0] x_read_addr_2,
    input wire [MASK_V_WIDTH-1:0] mask_v_3,
    output wire [MASK_V_ADDR_WIDTH-1:0] x_read_addr_3,
    input wire [MASK_V_WIDTH-1:0] mask_v_4,
    output wire [MASK_V_ADDR_WIDTH-1:0] x_read_addr_4,
    output wire x_read_en,

    input wire mask_u_ready,
    input wire [MASK_U_WIDTH-1:0] mask_u_1,
    output wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_read_addr_1,
    input wire [MASK_U_WIDTH-1:0] mask_u_2,
    output wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_read_addr_2,
    input wire [MASK_U_WIDTH-1:0] mask_u_3,
    output wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_read_addr_3,
    input wire [MASK_U_WIDTH-1:0] mask_u_4,
    output wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_read_addr_4,
    output wire ram_adder_read_addr_en,

    output reg [11:0] v_read_addr,
    output reg v_read_en,

    output reg [9:0] u_read_addr,
    output reg u_read_en,

    output reg [5:0] s_read_addr,
    output reg s_read_en,

    output reg finish
);
    // mask_v FSM state and counter registers
    reg [3:0] mask_v_fsm_state;
    reg [7:0] mask_v_fsm_iter_count;
    reg [7:0] mask_v_fsm_wait_count;
    // reg [7:0] mask_v_fsm_addr_count;

    // FSM state parameters
    parameter mask_v_fsm_IDLE = 4'b0001, 
              mask_v_fsm_LOAD = 4'b0010,
              mask_v_fsm_WAIT_U = 4'b0100,
              mask_v_fsm_FINISH = 4'b1000; 
    
    // FSM logic
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            mask_v_fsm_state <= mask_v_fsm_IDLE;
            mask_v_fsm_iter_count <= 0;
            mask_v_fsm_wait_count <= 0;
            mask_v_read_addr <= 0;
            mask_v_read_en <= 0;
        end else if (clk_en) begin
            case (mask_v_fsm_state)
                mask_v_fsm_IDLE: begin
                    if (start) begin
                        mask_v_fsm_state <= mask_v_fsm_LOAD;
                        mask_v_fsm_iter_count <= 0;
                        mask_v_fsm_wait_count <= 0;
                        mask_v_read_addr <= 0;
                    end
                end
                mask_v_fsm_LOAD: begin
                    mask_v_read_addr <= mask_v_read_addr + 1;
                    mask_v_read_en <= 1'b1;
                    mask_v_fsm_state <= mask_v_fsm_WAIT_U;
                end
                mask_v_fsm_WAIT_U: begin
                    mask_v_read_en <= 1'b0;
                    if (NZc > NZr) begin
                        if (mask_v_fsm_iter_count < num_iter) begin
                            if(mask_v_fsm_wait_count < (NZc - 1)) begin
                                mask_v_fsm_wait_count <= mask_v_fsm_wait_count + 1'b1;
                            end else begin
                                mask_v_fsm_state <= mask_v_fsm_LOAD;
                                mask_v_fsm_iter_count <= mask_v_fsm_iter_count + 1;
                                mask_v_fsm_wait_count <= 0;
                            end
                        end else begin
                            mask_v_fsm_state <= mask_v_fsm_FINISH;
                        end
                    end else begin
                        if (mask_v_fsm_wait_count < (NZr - 1)) begin
                            mask_v_fsm_wait_count <= mask_v_fsm_wait_count + 1'b1;
                        end else begin
                            mask_v_fsm_wait_count <= 0;
                            if (mask_v_fsm_iter_count < num_iter) begin
                                mask_v_fsm_state <= mask_v_fsm_LOAD;
                                mask_v_fsm_iter_count <= mask_v_fsm_iter_count + 1;
                            end else begin
                                mask_v_fsm_state <= mask_v_fsm_FINISH;
                            end
                        end
                    end
                end
                mask_v_fsm_FINISH: begin
                    mask_v_fsm_state <= mask_v_fsm_IDLE;
                end
                default: begin
                    mask_v_fsm_state <= mask_v_fsm_IDLE;
                end
            endcase
        end
    end

    // v FSM state and counter registers
    reg [4:0] v_fsm_state;
    reg [7:0] v_fsm_iter_count;
    reg [7:0] v_fsm_wait_count;
    reg [7:0] v_fsm_addr_count;

    // FSM state parameters
    parameter v_fsm_IDLE = 5'b00001, 
              v_fsm_START_UP = 5'b00010,
              v_fsm_LOAD = 5'b00100,
              v_fsm_WAIT_U = 5'b01000,
              v_fsm_FINISH = 5'b10000; 
    
    // FSM logic
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            v_fsm_state <= v_fsm_IDLE;
            v_fsm_iter_count <= 0;
            v_fsm_wait_count <= 0;
            v_fsm_addr_count <= 0;
            v_read_addr <= 0;
            v_read_en <= 0;
        end else if (clk_en) begin
            case (v_fsm_state)
                v_fsm_IDLE: begin
                    v_fsm_addr_count <= 0;
                    v_fsm_iter_count <= 0;
                    v_fsm_wait_count <= 0;
                    v_read_addr <= 0;
                    if (mask_v_read_en) begin
                        v_fsm_state <= v_fsm_START_UP;
                        // v_fsm_iter_count <= v_fsm_iter_count + 1;
                        // v_read_addr <= v_read_addr + 1;
                        // v_read_en <= 1'b1;
                        // v_fsm_addr_count <= 1;
                    end
                end
                v_fsm_START_UP: begin
                    v_fsm_state <= v_fsm_LOAD;

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
                            v_read_addr <= v_read_addr + 1;
                            v_read_en <= 1'b1;
                            v_fsm_addr_count <= 1;
                            v_fsm_iter_count <= v_fsm_iter_count + 1;
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
                                v_read_addr <= v_read_addr + 1;
                                v_read_en <= 1'b1;
                                v_fsm_addr_count <= 1;
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

    // u FSM state and counter registers
    reg [4:0] u_fsm_state;
    reg [7:0] u_fsm_iter_count;
    reg [7:0] u_fsm_wait_count;
    reg [7:0] u_fsm_addr_count;

    // FSM state parameters
    parameter u_fsm_IDLE = 4'b00001, 
            //   u_fsm_START_UP = 4'b00010,
              u_fsm_WAIT_U = 4'b0010,
              u_fsm_LOAD = 4'b0100, 
              u_fsm_FINISH = 4'b1000; 
    
    // FSM logic
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            u_fsm_state <= u_fsm_IDLE;
            u_fsm_iter_count <= 0;
            u_fsm_wait_count <= 0;
            u_fsm_addr_count <= 0;
            u_read_addr <= 0;
            u_read_en <= 0;
        end else if (clk_en) begin
            case (u_fsm_state)
                u_fsm_IDLE: begin
                    if (mask_v_read_en) begin
                        u_fsm_state <= u_fsm_WAIT_U;
                        u_fsm_addr_count <= 0;
                        u_fsm_iter_count <= 0;
                        u_fsm_wait_count <= 0;
                        u_read_addr <= 0;
                    end
                end
                // u_fsm_START_UP: begin
                //     if (mask_v_ready) begin
                //         u_fsm_state <= u_fsm_WAIT_U;
                //     end
                // end
                u_fsm_WAIT_U: begin
                    if (u_fsm_iter_count == 0) begin
                        u_fsm_wait_count <= u_fsm_wait_count + 1;
                        if (u_fsm_wait_count == NZc + 8) begin /////////////////7
                            u_fsm_wait_count <= 0;
                            u_fsm_state <= u_fsm_LOAD;
                            u_read_addr <= u_read_addr + 1;
                            u_fsm_addr_count <= 1;
                            u_read_en <= 1'b1;
                        end
                    end else begin
                        if (NZr < NZc) begin
                            if (u_fsm_wait_count < (NZc - NZr)) begin
                                u_fsm_wait_count <= u_fsm_wait_count + 1;
                            end else begin
                                u_fsm_wait_count <= 0;
                                u_fsm_state <= u_fsm_LOAD;
                                u_read_addr <= u_read_addr + 1;
                                u_fsm_addr_count <= 1;
                                u_read_en <= 1'b1;
                            end
                        end else begin
                            u_fsm_state <= u_fsm_LOAD;
                            u_read_addr <= u_read_addr + 1;
                            u_fsm_addr_count <= 1;
                            u_read_en <= 1'b1;
                        end
                    end
                end
                u_fsm_LOAD: begin
                    if (u_fsm_addr_count < NZr) begin
                        u_read_addr <= u_read_addr + 1;
                        u_fsm_addr_count <= u_fsm_addr_count + 1;
                        u_read_en <= 1'b1;
                    end else begin
                        u_read_en <= 1'b0;
                        if (u_fsm_iter_count < num_iter) begin
                            u_fsm_addr_count <= 0;
                            u_fsm_state <= u_fsm_WAIT_U;
                            u_fsm_iter_count <= u_fsm_iter_count + 1;
                        end else begin
                            u_fsm_addr_count <= 0;
                            u_fsm_state <= u_fsm_FINISH;
                        end
                    end
                end
                u_fsm_FINISH: begin
                    u_fsm_state <= u_fsm_IDLE;
                end
                default: begin
                    u_fsm_state <= u_fsm_IDLE;
                end
            endcase
        end
    end


    // s FSM state and counter registers
    reg [4:0] s_fsm_state;
    reg [7:0] s_fsm_iter_count;
    reg [7:0] s_fsm_wait_count;
    reg [7:0] s_fsm_addr_count;

    // FSM state parameters
    parameter s_fsm_IDLE = 4'b0001, 
            //   s_fsm_START_UP = 5'b00010,
              s_fsm_WAIT_U = 4'b0010,
              s_fsm_LOAD = 4'b0100, 
              s_fsm_FINISH = 4'b1000; 
    
    // FSM logic
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            s_fsm_state <= s_fsm_IDLE;
            s_fsm_iter_count <= 0;
            s_fsm_wait_count <= 0;
            s_fsm_addr_count <= 0;
            s_read_addr <= 0;
            s_read_en <= 0;
        end else if (clk_en) begin
            case (s_fsm_state)
                s_fsm_IDLE: begin
                    if (mask_v_read_en) begin
                        s_fsm_state <= s_fsm_WAIT_U;
                        s_fsm_addr_count <= 0;
                        s_fsm_iter_count <= 0;
                        s_fsm_wait_count <= 0;
                        s_read_addr <= 0;
                    end
                end
                // s_fsm_START_UP: begin
                //     if (mask_v_ready) begin
                //         s_fsm_state <= s_fsm_WAIT_U;
                //     end
                // end
                s_fsm_WAIT_U: begin
                    if (s_fsm_iter_count == 0) begin
                        s_fsm_wait_count <= s_fsm_wait_count + 1;
                        if (s_fsm_wait_count == NZc + 5) begin //////////////////////////////////////////4
                            s_fsm_wait_count <= 0;
                            s_read_addr <= s_read_addr + 1;
                            s_read_en <= 1'b1;
                            s_fsm_state <= s_fsm_LOAD;
                            // s_fsm_addr_count <= 0;
                        end
                    end else begin
                        
                        if (NZr < NZc) begin
                            if (s_fsm_wait_count < (NZc - NZr)) begin
                                s_fsm_wait_count <= s_fsm_wait_count + 1;
                            end else begin
                                s_fsm_wait_count <= 0;
                                s_read_addr <= s_read_addr + 1;
                                s_read_en <= 1'b1;
                                s_fsm_state <= s_fsm_LOAD;
                                // s_fsm_addr_count <= 0;
                            end
                        end else begin
                            if (s_fsm_wait_count < 1) begin
                                s_fsm_wait_count <= s_fsm_wait_count + 1;
                            end else begin
                            s_fsm_wait_count <= 0;
                            s_read_addr <= s_read_addr + 1;
                            s_read_en <= 1'b1;
                            s_fsm_state <= s_fsm_LOAD;
                            s_fsm_addr_count <= 0;
                            end
                        end
                    end
                end
                s_fsm_LOAD: begin
                    if (s_fsm_addr_count < (NZr - 1)) begin
                        s_fsm_addr_count <= s_fsm_addr_count + 1;
                    end else begin
                        s_read_en <= 1'b0;
                        s_fsm_addr_count <= 0;
                        if (s_fsm_iter_count < num_iter) begin
                            s_fsm_state <= s_fsm_WAIT_U;
                            s_fsm_iter_count <= s_fsm_iter_count + 1;
                        end else begin
                            s_fsm_state <= s_fsm_FINISH;
                        end
                    end
                end
                s_fsm_FINISH: begin
                    s_fsm_state <= s_fsm_IDLE;
                end
                default: begin
                    s_fsm_state <= s_fsm_IDLE;
                end
            endcase
        end
    end

    // u FSM state and counter registers
    reg [4:0] mask_u_fsm_state;
    reg [7:0] mask_u_fsm_iter_count;
    reg [7:0] mask_u_fsm_wait_count;
    reg [7:0] mask_u_fsm_addr_count;

    // FSM state parameters
    parameter mask_u_fsm_IDLE = 5'b00001, 
              mask_u_fsm_START_UP = 5'b00010,
              mask_u_fsm_WAIT_U = 5'b00100,
              mask_u_fsm_LOAD = 5'b01000, 
              mask_u_fsm_FINISH = 5'b10000; 
    
    // FSM logic
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            mask_u_fsm_state <= mask_u_fsm_IDLE;
            mask_u_fsm_iter_count <= 0;
            mask_u_fsm_wait_count <= 0;
            mask_u_fsm_addr_count <= 0;
            mask_u_read_addr <= 0;
            mask_u_read_en <= 0;
        end else if (clk_en) begin
            case (mask_u_fsm_state)
                mask_u_fsm_IDLE: begin
                    if (start) begin
                        mask_u_fsm_state <= mask_u_fsm_START_UP;
                        mask_u_fsm_addr_count <= 0;
                        mask_u_fsm_iter_count <= 0;
                        mask_u_fsm_wait_count <= 0;
                        mask_u_read_addr <= 0;
                    end
                end
                mask_u_fsm_START_UP: begin
                    if (mask_v_ready) begin
                        mask_u_fsm_state <= mask_u_fsm_WAIT_U;
                    end
                end
                mask_u_fsm_WAIT_U: begin
                    mask_u_read_en <= 1'b0;
                    if (mask_u_fsm_iter_count == 0) begin
                        mask_u_fsm_wait_count <= mask_u_fsm_wait_count + 1;
                        if (mask_u_fsm_wait_count == NZc + 2) begin //////////////////////8  4
                            mask_u_fsm_wait_count <= 0;
                            mask_u_fsm_state <= mask_u_fsm_LOAD;
                        end
                    end else begin
                        if (NZr < NZc) begin
                            if (mask_u_fsm_wait_count < (NZc - 1)) begin
                                mask_u_fsm_wait_count <= mask_u_fsm_wait_count + 1;
                            end else begin
                                mask_u_fsm_wait_count <= 0;
                                mask_u_fsm_state <= mask_u_fsm_LOAD;
                            end
                        end else begin
                            if (mask_u_fsm_wait_count < (NZr - 1)) begin
                                mask_u_fsm_wait_count <= mask_u_fsm_wait_count + 1;
                            end else begin
                                mask_u_fsm_wait_count <= 0;
                                mask_u_fsm_state <= mask_u_fsm_LOAD;
                            end
                        end
                    end
                end
                mask_u_fsm_LOAD: begin
                    mask_u_read_addr <= mask_u_read_addr + 1;
                    mask_u_read_en <= 1'b1;
                    if (mask_u_fsm_iter_count < num_iter) begin
                        mask_u_fsm_state <= mask_u_fsm_WAIT_U;
                        mask_u_fsm_iter_count <= mask_u_fsm_iter_count + 1;
                    end else begin
                        mask_u_fsm_state <= mask_u_fsm_FINISH;
                    end
                end
                mask_u_fsm_FINISH: begin
                    mask_u_read_en <= 1'b0;
                    mask_u_fsm_state <= mask_u_fsm_IDLE;
                end
                default: begin
                    mask_u_fsm_state <= mask_u_fsm_IDLE;
                end
            endcase
        end
    end

    mask2addr_v2 #(
    .WIDTH(MASK_V_WIDTH),
    .ADDR_WIDTH(MASK_V_ADDR_WIDTH)
    ) mask2addr_mask_v_instance_1 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .mask_ready(mask_v_ready),
        .mask(mask_v_1),
        .valid(x_read_en),
        .out(x_read_addr_1)
    );
    mask2addr_v2 #(
    .WIDTH(MASK_V_WIDTH),
    .ADDR_WIDTH(MASK_V_ADDR_WIDTH)
    ) mask2addr_mask_v_instance_2 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .mask_ready(mask_v_ready),
        .mask(mask_v_2),
        .valid(),
        .out(x_read_addr_2)
    );
    mask2addr_v2 #(
    .WIDTH(MASK_V_WIDTH),
    .ADDR_WIDTH(MASK_V_ADDR_WIDTH)
    ) mask2addr_mask_v_instance_3 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .mask_ready(mask_v_ready),
        .mask(mask_v_3),
        .valid(),
        .out(x_read_addr_3)
    );
    mask2addr_v2 #(
    .WIDTH(MASK_V_WIDTH),
    .ADDR_WIDTH(MASK_V_ADDR_WIDTH)
    ) mask2addr_mask_v_instance_4 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .mask_ready(mask_v_ready),
        .mask(mask_v_4),
        .valid(),
        .out(x_read_addr_4)
    );

    wire mask2addr_mask_u_addr_en;
    wire [MASK_U_ADDR_WIDTH-1:0] mask2addr_mask_u_addr_1;
    wire [MASK_U_ADDR_WIDTH-1:0] mask2addr_mask_u_addr_2;
    wire [MASK_U_ADDR_WIDTH-1:0] mask2addr_mask_u_addr_3;
    wire [MASK_U_ADDR_WIDTH-1:0] mask2addr_mask_u_addr_4;

    mask2addr_v2 #(
    .WIDTH(MASK_U_WIDTH),
    .ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    ) mask2addr_mask_u_instance_1 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .mask_ready(mask_u_ready),
        .mask(mask_u_1),
        .valid(mask2addr_mask_u_addr_en),
        .out(mask2addr_mask_u_addr_1)
    );
    mask2addr_v2 #(
    .WIDTH(MASK_U_WIDTH),
    .ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    ) mask2addr_mask_u_instance_2 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .mask_ready(mask_u_ready),
        .mask(mask_u_2),
        .valid(),
        .out(mask2addr_mask_u_addr_2)
    );
    mask2addr_v2 #(
    .WIDTH(MASK_U_WIDTH),
    .ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    ) mask2addr_mask_u_instance_3 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .mask_ready(mask_u_ready),
        .mask(mask_u_3),
        .valid(),
        .out(mask2addr_mask_u_addr_3)
    );

    mask2addr_v2 #(
    .WIDTH(MASK_U_WIDTH),
    .ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    ) mask2addr_mask_u_instance_4 (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .mask_ready(mask_u_ready),
        .mask(mask_u_4),
        .valid(),
        .out(mask2addr_mask_u_addr_4)
    );

    // s FSM state and counter registers
    reg [4:0] fsm_state;
    reg [MASK_U_ADDR_WIDTH:0] fsm_addr_count;
    reg [4:0] fsm_wait_count;

    reg [MASK_U_ADDR_WIDTH-1:0] fsm_ram_adder_read_addr;
    // reg fsm_ram_adder_read_addr_en;

    // FSM state parameters
    parameter fsm_IDLE = 3'b001, 
            fsm_PROCESSING = 3'b010,
            fsm_FINISH = 3'b100;

    // FSM logic
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            fsm_state <= fsm_IDLE;
            fsm_ram_adder_read_addr <= 0;
            fsm_addr_count <= 0;
            fsm_wait_count <= 0;
            // fsm_ram_adder_read_addr_en <= 0;
            finish <= 0;
        end else if (clk_en) begin
            case (fsm_state)
                fsm_IDLE: begin
                    finish <= 0;
                    if(start) begin 
                        fsm_state <= fsm_PROCESSING;
                        fsm_ram_adder_read_addr <= 0;
                        fsm_addr_count <= 0;
                        fsm_wait_count <= 0;
                        // fsm_ram_adder_read_addr_en <= 0;
                    end
                end
                fsm_PROCESSING: begin
                    if ((v_fsm_state == 4'b0001) & (s_fsm_state == 5'b00001) & (u_fsm_state == 5'b00001) & (mask_u_fsm_state == 5'b00001) & (mask_v_fsm_state == 4'b0001)) begin
                        if(fsm_wait_count < 4'd12) begin
                            fsm_wait_count <= fsm_wait_count + 1;
                        end else begin
                            fsm_ram_adder_read_addr <= 0;
                            // fsm_ram_adder_read_addr_en <= 1'b1;
                            // fsm_addr_count <= fsm_addr_count + 1;
                            finish <= 0;
                            fsm_state <= fsm_FINISH;
                        end
                    end
                end
                fsm_FINISH: begin
                    if (fsm_addr_count < (MASK_U_WIDTH - 1)) begin
                        fsm_addr_count <= fsm_addr_count + 1;
                        fsm_ram_adder_read_addr <= fsm_ram_adder_read_addr + 1;
                        finish <= 1;
                    end else begin
                        // fsm_ram_adder_read_addr_en <= 1'b0;
                        finish <= 1;
                        fsm_state <= fsm_IDLE;
                    end
                end
                default: begin
                    fsm_state <= fsm_IDLE;
                end
            endcase

        end
    end

    assign ram_adder_read_addr_1 = (fsm_state == fsm_PROCESSING)? mask2addr_mask_u_addr_1 : fsm_ram_adder_read_addr;
    assign ram_adder_read_addr_2 = (fsm_state == fsm_PROCESSING)? mask2addr_mask_u_addr_2 : fsm_ram_adder_read_addr;
    assign ram_adder_read_addr_3 = (fsm_state == fsm_PROCESSING)? mask2addr_mask_u_addr_3 : fsm_ram_adder_read_addr;
    assign ram_adder_read_addr_4 = (fsm_state == fsm_PROCESSING)? mask2addr_mask_u_addr_4 : fsm_ram_adder_read_addr;
    assign ram_adder_read_addr_en = (fsm_state == fsm_PROCESSING)? mask2addr_mask_u_addr_en : 0; //fsm_ram_adder_read_addr_en;
endmodule