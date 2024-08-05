`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 11:55:48
// Design Name: 
// Module Name: svd_kernel_tb1
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


module svd_kernel_tb1;

    // Inputs to the svd_kernel module
    reg clk;
    reg clk_en;
    reg rst;
    wire [31:0] u_tile_1;
    wire [31:0] u_tile_2;
    reg u_tile_ready;
    wire [31:0] v_tile_1;
    wire [31:0] v_tile_2;
    reg v_tile_ready;
    wire [31:0] x_tile_1;
    wire [31:0] x_tile_2;
    reg x_tile_ready;
    wire [31:0] s;
    reg s_tile_ready;

    // Outputs from the svd_kernel module
    wire [31:0] svd_kernel_out_1;
    wire [31:0] svd_kernel_out_2;
    wire svd_kernel_valid;

    reg [5:0] ram_adder_addr;
    reg ram_adder_addr_ready;

    reg wea;
    reg [9:0] v_addr1;
    reg [9:0] v_addr2;

    reg [7:0] x_addr1;
    reg [7:0] x_addr2;

    reg [7:0] u_addr1;
    reg [7:0] u_addr2;

    reg [4:0] s_addr;

    // Instantiate the Unit Under Test (UUT)
    svd_kernel_32 uut (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .u_tile_1(u_tile_1),
        .u_tile_2(u_tile_2),
        .u_tile_ready(u_tile_ready),
        .v_tile_1(v_tile_1),
        .v_tile_2(v_tile_2),
        .v_tile_ready(v_tile_ready),
        .x_tile_1(x_tile_1),
        .x_tile_2(x_tile_2),
        .x_tile_ready(x_tile_ready),
        .s(s),
        .s_tile_ready(s_tile_ready),
        .ram_adder_addr_ready(ram_adder_addr_ready),
        .ram_adder_addr(ram_adder_addr),
        .svd_kernel_out_1(svd_kernel_out_1),
        .svd_kernel_out_2(svd_kernel_out_2)
    );

    u_tile_ram u_tile_instance_1 (
        .clka(clk), 
        .wea(wea), 
        .addra(u_addr1), 
        .dina(), 
        .douta(u_tile_1)
    );

    u_tile_ram u_tile_instance_2 (
        .clka(clk), 
        .wea(wea), 
        .addra(u_addr2), 
        .dina(), 
        .douta(u_tile_2)
    );

    v_tile_ram v_tile_instance_1 (
        .clka(clk), 
        .wea(wea), 
        .addra(v_addr1), 
        .dina(), 
        .douta(v_tile_1)
    );

    v_tile_ram v_tile_instance_2 (
        .clka(clk), 
        .wea(wea), 
        .addra(v_addr2), 
        .dina(), 
        .douta(v_tile_2)
    );

    x_tile_ram x_tile_instance_1 (
        .clka(clk), 
        .wea(wea), 
        .addra(x_addr1), 
        .dina(), 
        .douta(x_tile_1)
    );

    x_tile_ram x_tile_instance_2 (
        .clka(clk), 
        .wea(wea), 
        .addra(x_addr2), 
        .dina(), 
        .douta(x_tile_2)
    );

    s_tile_ram s_tile_instance_2 (
        .clka(clk), 
        .wea(wea), 
        .addra(s_addr), 
        .dina(), 
        .douta(s)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generate a clock with a 100 MHz frequency
    end

    // reset clk_en
    initial begin
        // Initialize Inputs
        clk_en = 0;
        rst = 1;

        // Apply a reset
        #30;
        rst = 0;
        clk_en = 1;  // Enable the clock for normal operation
    end

    // x and v
    initial begin
        v_tile_ready = 0;
        x_tile_ready = 0;
        wea = 0;

        x_addr1 = 0;
        x_addr2 = 1;
        v_addr1 = 0;
        v_addr2 = 1;

        #35;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        repeat (3) begin
            // Generate v_addr1 and v_addr2 from 0 to 191
            repeat (95) begin
            @(posedge clk);
                v_tile_ready <= 1;
                x_tile_ready <= 1;
                v_addr1 <= v_addr1 + 2;
                v_addr2 <= v_addr2 + 2;
                x_addr1 <= x_addr1 + 2;
                x_addr2 <= x_addr2 + 2;
            end

            // Wait one cycle
            @(posedge clk);
            
            // Set v_addr1=0, v_addr2=1, v_tile_ready=0, x_tile_ready=0
            x_addr1 = 0;
            x_addr2 = 1;
            

            repeat(1) begin
            @(posedge clk);
                v_addr1 <= v_addr1 + 2;
                v_addr2 <= v_addr2 + 2;
            end
            v_tile_ready = 0;
            x_tile_ready = 0;
        end

        v_addr1 = 0;
        v_addr2 = 1;
    end

    // s
    initial begin
        s_tile_ready = 0;
        wea = 0;

        s_addr = 0;

        #30;
        #35;
        repeat(100) begin //100
            @(posedge clk);
        end
        repeat (3) begin
            // Generate v_addr1 and v_addr2 from 0 to 191
            repeat (31) begin
            @(posedge clk);
                s_tile_ready <= 1;
            end

            // Wait one cycle
            @(posedge clk);

            repeat (1) begin
            @(posedge clk);
                s_tile_ready = 0;
                s_addr <= s_addr + 1;
            end

            repeat (64) begin
            @(posedge clk);
            end
        end

        s_addr = 0;
    end

    // u
    initial begin
        u_tile_ready = 0;
        wea = 0;

        u_addr1 = 0;
        u_addr2 = 1;

        #30;
        #35;
        repeat(103) begin //103
            @(posedge clk);
        end
        repeat (3) begin
            // Generate v_addr1 and v_addr2 from 0 to 191
            repeat (31) begin
            @(posedge clk);
                u_tile_ready <= 1;
                u_addr1 <= u_addr1 + 2;
                u_addr2 <= u_addr2 + 2;
            end

            // Wait one cycle
            @(posedge clk);

            repeat (1) begin
            @(posedge clk);
                u_tile_ready = 0;
            end

            repeat (63) begin
            @(posedge clk);
            end

            repeat(1) begin
            @(posedge clk);
                u_addr1 <= u_addr1 + 2;
                u_addr2 <= u_addr2 + 2;
            end
        end
        u_addr1 = 0;
        u_addr2 = 1;
    end

    initial begin
        ram_adder_addr = 5'b0;
        ram_adder_addr_ready = 0;
        wea = 0;

        #30;
        #35;
        repeat(105) begin //105
            @(posedge clk);
        end

        // Repeat the following sequence three times
        repeat (3) begin
            // Set ram_adder_addr_ready and ram_adder_addr to specific values
            @(posedge clk) begin
                ram_adder_addr_ready <= 1;
            end
            // Increment ram_adder_addr 31 times
            repeat (31) begin
                @(posedge clk) begin
                    ram_adder_addr <= ram_adder_addr + 1;
                end
            end

            // Reset ram_adder_addr_ready and ram_adder_addr
            @(posedge clk) begin
                ram_adder_addr_ready <= 0;
                ram_adder_addr <= 0;
            end

            #650;
        end

        #50;
        @(posedge clk) begin
            ram_adder_addr = 0;
        end
        // Increment ram_adder_addr 31 times
        repeat (31) begin
            @(posedge clk) begin
                ram_adder_addr <= ram_adder_addr + 1;
            end
        end

        // Reset ram_adder_addr_ready and ram_adder_addr
        @(posedge clk) begin
            ram_adder_addr <= 0;
        end

    end


endmodule
