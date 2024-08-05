`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/23 14:33:33
// Design Name: 
// Module Name: tb_MVM1_ctrl
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


module tb_MVM1_ctrl;
    parameter MASK_V_WIDTH = 96;
    parameter MASK_V_ADDR_WIDTH = $clog2(MASK_V_WIDTH);
    // parameter MASK_U_WIDTH = 32;
    // parameter MASK_U_ADDR_WIDTH = $clog2(MASK_U_WIDTH);
    parameter MASK_U_WIDTH = 128;
    parameter MASK_U_ADDR_WIDTH = $clog2(MASK_U_WIDTH);

    // Testbench signals
    reg clk;
    reg rst;
    reg clk_en;
    reg start;
    reg [7:0] NZc;
    reg [7:0] NZr;
    reg [7:0] num_iter;
    wire [11:0] v_read_addr;
    wire v_read_en;
    wire [9:0] u_read_addr;
    wire u_read_en;
    wire [5:0] s_read_addr;
    wire s_read_en;

    reg [MASK_V_WIDTH-1:0] mask_v;
    reg mask_v_ready;
    wire [MASK_V_ADDR_WIDTH-1:0] x_read_addr;
    wire x_read_en;

    reg [MASK_U_WIDTH-1:0] mask_u;
    reg mask_u_ready;

    wire [5:0] mask_v_read_addr;
    wire mask_v_read_en;
    wire [5:0] mask_u_read_addr;
    wire mask_u_read_en;

    wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_read_addr;
    wire ram_adder_read_addr_en;

    wire finish;

    // // Instantiate the DUT (Device Under Test)
    // MVM1_ctrl #(
    //     .MASK_V_WIDTH(MASK_V_WIDTH),
    //     .MASK_V_ADDR_WIDTH(MASK_V_ADDR_WIDTH),
    //     .MASK_U_WIDTH(MASK_U_WIDTH),
    //     .MASK_U_ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    // ) dut (
    //     .clk(clk),
    //     .clk_en(clk_en),
    //     .rst(rst),
    //     .start(start),
    //     .NZc(NZc), 
    //     .NZr(NZr),
    //     .num_iter(num_iter),
    //     .mask_v_read_addr(mask_v_read_addr),
    //     .mask_v_read_en(mask_v_read_en),
    //     .mask_u_read_addr(mask_u_read_addr),
    //     .mask_u_read_en(mask_u_read_en),
    //     .mask_v_ready(mask_v_ready),
    //     .mask_v(mask_v),
    //     .x_read_addr(x_read_addr),
    //     .x_read_en(x_read_en),
    //     .mask_u_ready(mask_u_ready),
    //     .mask_u(mask_u),
    //     .ram_adder_read_addr(ram_adder_read_addr),
    //     .ram_adder_read_addr_en(ram_adder_read_addr_en),
    //     .v_read_addr(v_read_addr),
    //     .v_read_en(v_read_en),
    //     .u_read_addr(u_read_addr),
    //     .u_read_en(u_read_en),
    //     .s_read_addr(s_read_addr),
    //     .s_read_en(s_read_en),
    //     .finish(finish)
    // );


    MVM_ctrl1 #(
        .MASK_V_WIDTH(MASK_V_WIDTH),
        .MASK_V_ADDR_WIDTH(MASK_V_ADDR_WIDTH),
        .MASK_U_WIDTH(MASK_U_WIDTH),
        .MASK_U_ADDR_WIDTH(MASK_U_ADDR_WIDTH)
    ) dut (
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
        .mask_v_1(mask_v),
        .x_read_addr_1(x_read_addr),
        .mask_v_2(),
        .x_read_addr_2(),
        .mask_v_3(),
        .x_read_addr_3(),
        .mask_v_4(),
        .x_read_addr_4(),
        .x_read_en(x_read_en),
        .mask_u_ready(mask_u_valid),
        .mask_u_1(mask_u),
        .ram_adder_read_addr_1(ram_adder_read_addr),
        .mask_u_2(),
        .ram_adder_read_addr_2(),
        .mask_u_3(),
        .ram_adder_read_addr_3(),
        .mask_u_4(),
        .ram_adder_read_addr_4(),
        .ram_adder_read_addr_en(ram_adder_read_addr_en),
        .v_read_addr(v_read_addr),
        .v_read_en(v_read_en),
        .u_read_addr(u_read_addr),
        .u_read_en(u_read_en),
        .s_read_addr(s_read_addr),
        .s_read_en(s_read_en),
        .finish(finish)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize signals
        clk = 0;
        clk_en = 0;
        rst = 1;
        start = 0;
        NZc = 8'd72;       // NZc = 72
        // NZr = 8'd24;       // NZr = 24
        NZr = 8'd96;       // NZr = 24
        num_iter = 8'd2;   // Number of iterations

        mask_v_ready = 0;
        mask_v = 0;
        
        // Apply reset
        // #25;
        @(posedge clk);
        @(posedge clk);
        rst = 0;
        clk_en = 1;

        // Start the FSM
        @(posedge clk);
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Wait for FSM to finish
        wait (dut.fsm_state == dut.fsm_IDLE);

        // Stop simulation
        #100;
        $stop;
    end

    initial begin
        // Initialize signals
        mask_v_ready = 0;
        mask_v = 0;
        
        // Apply reset
        @(posedge clk);
        @(posedge clk);
        // Start the FSM
        
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        mask_v_ready = 1;
        mask_v = 96'hFFFFF7FB4F9B37FCBFBD2F2A;
        @(posedge clk);
        start = 0;
        mask_v = 0;
        mask_v_ready = 0;
        repeat (72) begin
            @(posedge clk);
        end
        repeat (24) begin
            @(posedge clk);
        end
        // #730;
        // #240;
        mask_v_ready = 1;
        mask_v = 96'hFFFFF7FB4F9B37FCBFBD2F2A;
        @(posedge clk);
        start = 0;
        mask_v = 0;
        mask_v_ready = 0;
        repeat (72) begin
            @(posedge clk);
        end
        repeat (24) begin
            @(posedge clk);
        end
        // #730;
        // #240;
        mask_v_ready = 1;
        mask_v = 96'hFFFFF7FB4F9B37FCBFBD2F2A;
        @(posedge clk);
        start = 0;
        mask_v = 0;
        mask_v_ready = 0;

        // Wait for FSM to finish
        wait (dut.fsm_state == dut.fsm_IDLE);

        // Stop simulation
        #100;
        $stop;
    end

    // initial begin
    //     // Initialize signals
    //     mask_u_ready = 0;
    //     mask_u = 0;
        
    //     // Apply reset
    //     @(posedge clk);
    //     @(posedge clk);
    //     // Start the FSM
    //     @(posedge clk);
    //     @(posedge clk);
    //     @(posedge clk);
    //     @(posedge clk);

    //     // #850;
    //     repeat (85) begin
    //         @(posedge clk);
    //     end
    //     mask_u_ready = 1;
    //     mask_u = 32'hAF7BF6BB;
    //     @(posedge clk);
    //     start = 0;
    //     mask_u = 0;
    //     mask_u_ready = 0;
    //     repeat (72) begin
    //         @(posedge clk);
    //     end
    //     // #730;
    //     // #240;
    //     mask_u_ready = 1;
    //     mask_u = 32'hDF4FF9D7;
    //     @(posedge clk);
    //     start = 0;
    //     mask_u = 0;
    //     mask_u_ready = 0;
    //     repeat (72) begin
    //         @(posedge clk);
    //     end
    //     // #730;
    //     // #240;
    //     mask_u_ready = 1;
    //     mask_u = 32'hAF7BF6BB;
    //     @(posedge clk);
    //     start = 0;
    //     mask_u = 0;
    //     mask_u_ready = 0;

    //     // Wait for FSM to finish
    //     wait (dut.fsm_state == dut.fsm_IDLE);

    //     // Stop simulation
    //     #100;
    //     $stop;
    // end

    initial begin
        // Initialize signals
        mask_u_ready = 0;
        mask_u = 0;
        
        // Apply reset
        @(posedge clk);
        @(posedge clk);
        // Start the FSM
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        repeat (85) begin
            @(posedge clk);
        end
        mask_u_ready = 1;
        mask_u = 128'hFFFF9FFF9FE3FEEE8F92639FFFFFFF00;
        @(posedge clk);
        start = 0;
        mask_u = 0;
        mask_u_ready = 0;
        repeat (72) begin
            @(posedge clk);
        end
        repeat (24) begin
            @(posedge clk);
        end
        // #730;
        // #240;
        mask_u_ready = 1;
        mask_u = 128'hFC5DEDA7FFDD7E7A5FFDFB5EFFFFFF00;
        @(posedge clk);
        start = 0;
        mask_u = 0;
        mask_u_ready = 0;
        repeat (72) begin
            @(posedge clk);
        end
        repeat (24) begin
            @(posedge clk);
        end
        // #730;
        // #240;
        mask_u_ready = 1;
        mask_u = 128'hFFFF9FFF9FE3FEEE8F92639FFFFFFF00;
        @(posedge clk);
        start = 0;
        mask_u = 0;
        mask_u_ready = 0;

        // Wait for FSM to finish
        wait (dut.fsm_state == dut.fsm_IDLE);

        // Stop simulation
        #100;
        $stop;
    end

endmodule