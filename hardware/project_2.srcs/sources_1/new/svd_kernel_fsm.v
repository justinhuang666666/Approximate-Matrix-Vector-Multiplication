`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 13:14:38
// Design Name: 
// Module Name: svd_kernel_fsm
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

module svd_kernel_fsm#(
    parameter MASK_V_WIDTH = 96,
    parameter MASK_V_ADDR_WIDTH = $clog2(MASK_V_WIDTH),
    parameter MASK_U_WIDTH = 32,
    parameter MASK_U_ADDR_WIDTH = $clog2(MASK_U_WIDTH)
)(
    input clk,
    input clk_en,
    input rst,

    input u_tile_ready,
    
    input x_tile_ready,
    input v_tile_ready,
    input ram_adder_addr_ready,
    output wire v_kernel_en,
    output wire s_kernel_en,
    output wire u_kernel_en,
    output reg v_kernel_acc_rst,
    output wire ram_adder_in_ready,
    output wire ram_adder_wea,
    
    input [MASK_U_ADDR_WIDTH-1:0] ram_adder_raddr,
    output wire [MASK_U_ADDR_WIDTH-1:0] ram_adder_waddr,
    output reg ram_addr_raddr_valid,

    input s_tile_ready
);

// v_kernel_en
// reg [3:0] delayed_v_tile_ready_reg = 4'b0;
// reg delayed_v_tile_ready = 0;
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         // Reset the delay registers and ram_adder_in_ready
//         delayed_v_tile_ready_reg <= 4'b0000;
//     end else if (clk_en) begin
//         // Shift register logic to delay u_tile_ready by 3 cycles
//         delayed_v_tile_ready_reg[0] <= v_tile_ready; // Capture the current u_tile_ready
//         delayed_v_tile_ready_reg[1] <= delayed_v_tile_ready_reg[0]; // Shift to next stage
//         delayed_v_tile_ready_reg[2] <= delayed_v_tile_ready_reg[1]; // Shift to next stage
//         delayed_v_tile_ready_reg[3] <= delayed_v_tile_ready_reg[2];
//         // The output ram_adder_in_ready takes the value of the last stage of the shift register
//         delayed_v_tile_ready <= delayed_v_tile_ready_reg[3];
//     end
// end

// assign v_kernel_en = delayed_v_tile_ready | v_tile_ready;

// v_kernel_en
reg [3:0] delayed_v_tile_ready_reg = 4'b0;
reg delayed_v_tile_ready = 0;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset the delay registers
        delayed_v_tile_ready_reg <= 4'b0000;
        delayed_v_tile_ready <= 0;
    end else if (clk_en) begin
        // Shift register logic to delay v_tile_ready by 3 cycles
        delayed_v_tile_ready_reg <= {delayed_v_tile_ready_reg[2:0], v_tile_ready};
        // The output delayed_v_tile_ready takes the value of the last stage of the shift register
        delayed_v_tile_ready <= delayed_v_tile_ready_reg[3];
    end
end

assign v_kernel_en = delayed_v_tile_ready | v_tile_ready;

// s_kernel_en
reg [2:0] delayed_s_tile_ready_reg = 3'b0;
reg delayed_s_tile_ready = 0;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset the delay registers and ram_adder_in_ready
        delayed_s_tile_ready_reg <= 3'b0000;
    end else if (clk_en) begin
        // Shift register logic to delay u_tile_ready by 3 cycles
        delayed_s_tile_ready_reg[0] <= s_tile_ready; // Capture the current u_tile_ready
        delayed_s_tile_ready_reg[1] <= delayed_s_tile_ready_reg[0]; // Shift to next stage
        delayed_s_tile_ready_reg[2] <= delayed_s_tile_ready_reg[1]; // Shift to next stage
        // The output ram_adder_in_ready takes the value of the last stage of the shift register
        delayed_s_tile_ready <= delayed_s_tile_ready_reg[2];
    end
end

assign s_kernel_en = delayed_s_tile_ready | s_tile_ready;

// s_kernel_en
reg [2:0] delayed_u_tile_ready_reg = 3'b0;
reg delayed_u_tile_ready = 0;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset the delay registers and ram_adder_in_ready
        delayed_u_tile_ready_reg <= 3'b0000;
    end else if (clk_en) begin
        // Shift register logic to delay u_tile_ready by 3 cycles
        delayed_u_tile_ready_reg[0] <= u_tile_ready; // Capture the current u_tile_ready
        delayed_u_tile_ready_reg[1] <= delayed_u_tile_ready_reg[0]; // Shift to next stage
        delayed_u_tile_ready_reg[2] <= delayed_u_tile_ready_reg[1]; // Shift to next stage
        // The output ram_adder_in_ready takes the value of the last stage of the shift register
        delayed_u_tile_ready <= delayed_u_tile_ready_reg[2];
    end
end

assign u_kernel_en = delayed_u_tile_ready | u_tile_ready;

// States for the u_tile FSM
localparam U_IDLE = 0,
           U_COUNT = 1,
           U_RESET = 2;

// States for the v_tile FSM
localparam V_IDLE = 0,
           V_COUNT = 1,
           V_RESET = 2;
           

// State registers for both FSMs
reg [1:0] u_state = U_IDLE;
reg [1:0] v_state = V_IDLE;

// Count registers
// reg [2:0] u_count = 0;
reg [2:0] v_count = 0;

// Previous values of u_tile_ready, x_tile_ready and v_tile_ready to detect edges
reg u_tile_ready_prev;
reg x_tile_ready_prev;
reg v_tile_ready_prev;


always @(posedge clk or posedge rst) begin
    if (rst) begin
        // u_kernel_acc_rst <= 0;
        v_kernel_acc_rst <= 0;
        u_state <= U_IDLE;
        v_state <= V_IDLE;
        // u_count <= 0;
        v_count <= 0;
        u_tile_ready_prev <= 0;
        x_tile_ready_prev <= 0;
        v_tile_ready_prev <= 0;
    end
    else if (clk_en) begin
        // Update previous state signals
        u_tile_ready_prev <= u_tile_ready;
        x_tile_ready_prev <= x_tile_ready;
        v_tile_ready_prev <= v_tile_ready;

        // FSM for x_tile_ready and v_tile_ready
        case (v_state)
            V_IDLE: begin
                v_kernel_acc_rst <= 0;
                if (!v_tile_ready && v_tile_ready_prev) // Falling edge detected
                    v_state <= V_COUNT;
            end
            V_COUNT: begin
                if (v_count < 2) begin ///3
                    v_kernel_acc_rst <= 0;
                    v_count <= v_count + 1;
                end else begin
                    v_count <= 0;
                    v_kernel_acc_rst <= 1;
                    if (!v_tile_ready && v_tile_ready_prev) begin // Falling edge detected
                        v_state <= V_COUNT;
                    end else begin
                        v_state <= V_IDLE;
                    end
                end
            end
            V_RESET: begin
                v_kernel_acc_rst <= 0;
                v_state <= V_IDLE;
            end
        endcase
    end
end

// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         v_kernel_acc_rst <= 0;
//         u_state <= U_IDLE;
//         v_state <= V_IDLE;
//         u_count <= 0;
//         v_count <= 0;
//         u_tile_ready_prev <= 0;
//         x_tile_ready_prev <= 0;
//         v_tile_ready_prev <= 0;
//     end
//     else if (clk_en) begin
//         // Update previous state signals
//         u_tile_ready_prev <= u_tile_ready;
//         x_tile_ready_prev <= x_tile_ready;
//         v_tile_ready_prev <= v_tile_ready;

//         // FSM for x_tile_ready and v_tile_ready
//         case (v_state)
//             V_IDLE: begin
//                 v_kernel_acc_rst <= 0;
//                 if (!v_tile_ready && v_tile_ready_prev) // Falling edge detected
//                     v_state <= V_COUNT;
//             end
//             V_COUNT: begin
//                 if (v_count < 1) begin
//                     v_kernel_acc_rst <= 0;
//                     v_count <= v_count + 1;
//                 end else begin
//                     v_count <= 0;
//                     v_state <= V_ASSERT_RESET;
//                 end
//             end
//             V_ASSERT_RESET: begin
//                 v_kernel_acc_rst <= 1;
//                 if (v_count < 1) begin
//                     v_count <= v_count + 1;
//                 end else begin
//                     v_kernel_acc_rst <= 0;
//                     v_count <= 0;
//                     v_state <= V_IDLE;
//                 end
//             end
//         endcase
//     end
// end

// ram adder control logic
// ram_adder_in_ready
// Registers to store the delayed signals
reg delayed_ram_adder_addr_ready1;
reg delayed_ram_adder_addr_ready2;
reg delayed_ram_adder_addr_ready3;

// Delay by 1 clock cycle
always @(posedge clk or posedge rst) begin
    if (rst) begin
        delayed_ram_adder_addr_ready1 <= 1'b0; // Reset to 0
    end else begin
        delayed_ram_adder_addr_ready1 <= ram_adder_addr_ready; // Delay by 1 clock cycle
    end
end

// Delay by 2 clock cycles
always @(posedge clk or posedge rst) begin
    if (rst) begin
        delayed_ram_adder_addr_ready2 <= 1'b0; // Reset to 0
    end else begin
        delayed_ram_adder_addr_ready2 <= delayed_ram_adder_addr_ready1; // Delay by 1 more clock cycle
    end
end

// Delay by 3 clock cycles
always @(posedge clk or posedge rst) begin
    if (rst) begin
        delayed_ram_adder_addr_ready3 <= 1'b0; // Reset to 0
    end else begin
        delayed_ram_adder_addr_ready3 <= delayed_ram_adder_addr_ready2; // Delay by 1 more clock cycle
    end
end

assign ram_adder_in_ready = delayed_ram_adder_addr_ready1;
assign ram_adder_wea = delayed_ram_adder_addr_ready2;

// ram_adder_waddr
reg [MASK_U_ADDR_WIDTH-1:0] delayed_ram_adder_waddr1;
reg [MASK_U_ADDR_WIDTH-1:0] delayed_ram_adder_waddr2;
reg [MASK_U_ADDR_WIDTH-1:0] delayed_ram_adder_waddr3;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset the delay registers and ram_adder_in_ready
        delayed_ram_adder_waddr1 <= 6'b0000;
        delayed_ram_adder_waddr2 <= 6'b0000;
    end else if (clk_en) begin
        // Shift register logic to delay u_tile_ready by 3 cycles
        delayed_ram_adder_waddr1 <= ram_adder_raddr; // Capture the current u_tile_ready
        delayed_ram_adder_waddr2 <= delayed_ram_adder_waddr1; // Shift to next stage
        delayed_ram_adder_waddr3 <= delayed_ram_adder_waddr2; // Shift to next stage
    end
end

assign ram_adder_waddr = delayed_ram_adder_waddr2;


// ram_adder_raddr
// State definition for the FSM
// localparam IDLE_RADDR = 2'b00,
//             WAIT_RADDR = 2'b01,
//             RUN_RADDR  = 2'b10,
//             STOP_RADDR = 2'b11;

// // State registers
// reg [1:0] current_state_raddr, next_state_raddr;
// reg [1:0] delay_count_raddr;   // Counter to track consecutive low cycles of u_tile_ready
// reg [1:0] wait_count_raddr;
// // State transition and output logic
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         current_state_raddr <= IDLE_RADDR;
//         ram_adder_raddr <= 0;
//         delay_count_raddr <= 0;
//     end else begin
//         current_state_raddr <= next_state_raddr;
//         case (current_state_raddr)
//             IDLE_RADDR: begin
//                 ram_adder_raddr <= 0;  // Initialize the address
//             end
//             WAIT_RADDR: begin
//                 if (u_tile_ready)
//                     wait_count_raddr <= wait_count_raddr + 1;
//             end
//             RUN_RADDR: begin
//                 if (u_tile_ready)
//                     ram_adder_raddr <= ram_adder_raddr + 1;  // Increment address each cycle
//                 else
//                     ram_adder_raddr <= ram_adder_raddr + 1;
//                     delay_count_raddr <= delay_count_raddr + 1;
//             end
//             STOP_RADDR: begin
//                 // Optionally hold the last address or reset it
//                 ram_adder_raddr <= 0;
//             end
//         endcase
//     end
// end

// // Next state logic
// always @(*) begin
//     next_state_raddr = current_state_raddr;
//     case (current_state_raddr)
//         IDLE_RADDR: begin
//             if (u_tile_ready)
//                 next_state_raddr = WAIT_RADDR;  // Wait for two cycles after u_tile_ready is high
//         end
//         WAIT_RADDR: begin
//             // if(wait_count_raddr >= 1)
//                 next_state_raddr = RUN_RADDR;  // Start running after two cycles
//         end
//         RUN_RADDR: begin
//             if (delay_count_raddr >= 1)
//                 next_state_raddr = STOP_RADDR;  // Stop if u_tile_ready is low for 2 cycles
//         end
//         STOP_RADDR: begin
//             if (u_tile_ready)
//                 next_state_raddr = WAIT_RADDR;  // Restart if u_tile_ready goes high again
//             else
//                 next_state_raddr = IDLE_RADDR;
//         end
//     endcase
// end

// // Handling the delay_count_raddr
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         delay_count_raddr <= 0;
//     end else if (u_tile_ready || current_state_raddr != RUN_RADDR) begin
//         delay_count_raddr <= 0;
//     end
// end

// // Handling the wait_count_raddr
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         wait_count_raddr <= 0;
//     end else if (current_state_raddr != WAIT_RADDR) begin
//         wait_count_raddr <= 0;
//     end
// end

// // ram_adder_waddr
// // State definition for the FSM
// localparam IDLE_WADDR = 2'b00,
//             WAIT_WADDR = 2'b01,
//             RUN_WADDR  = 2'b10,
//             STOP_WADDR = 2'b11;

// // State registers
// reg [1:0] current_state_waddr, next_state_waddr;
// reg [1:0] delay_count_waddr;   // Counter to track consecutive low cycles of ram_adder_in_ready
// // reg [1:0] wait_count_waddr;
// // State transition and output logic
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         current_state_waddr <= IDLE_WADDR;
//         ram_adder_waddr <= 0;
//         delay_count_waddr <= 0;
//     end else begin
//         current_state_waddr <= next_state_waddr;
//         case (current_state_waddr)
//             IDLE_WADDR: begin
//                 ram_adder_waddr <= 0;  // Initialize the address
//             end
//             // WAIT_WADDR: begin
//             //     if (ram_adder_in_ready)
//             //         wait_count_waddr <= wait_count_waddr + 1;
//             // end
//             RUN_WADDR: begin
//                 if (ram_adder_in_ready)
//                     ram_adder_waddr <= ram_adder_waddr + 1;  // Increment address each cycle
//                 else
//                     ram_adder_waddr <= 0;
//                     // delay_count_waddr <= delay_count_waddr + 1;
//             end
//             STOP_WADDR: begin
//                 // Optionally hold the last address or reset it
//                 ram_adder_waddr <= 0;
//             end
//         endcase
//     end
// end

// // Next state logic
// always @(*) begin
//     next_state_waddr = current_state_waddr;
//     case (current_state_waddr)
//         IDLE_WADDR: begin
//             if (ram_adder_in_ready)
//                 next_state_waddr = RUN_WADDR;  // Wait_WADDR for two cycles after ram_adder_in_ready is high
//         end
//         // WAIT_WADDR: begin
//         //     // if(wait_count_waddr >= 1)
//         //     next_state_waddr = RUN_WADDR;  // Start run_WADDRning after 5 cycles
//         // end
//         RUN_WADDR: begin
//             if (!ram_adder_in_ready)
//                 next_state_waddr = STOP_WADDR;  // Stop_WADDR if ram_adder_in_ready is low for 5 cycles
//         end
//         STOP_WADDR: begin
//             if (ram_adder_in_ready)
//                 next_state_waddr = WAIT_WADDR;  // Restart if ram_adder_in_ready goes high again
//             else
//                 next_state_waddr = IDLE_WADDR;
//         end
//     endcase
// end

// Handling the delay_count_waddr
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         delay_count_waddr <= 0;
//     end else if (ram_adder_in_ready || current_state_waddr != RUN_WADDR) begin
//         delay_count_waddr <= 0;
//     end
// end

// Handling the wait_count_waddr
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         wait_count_waddr <= 0;
//     end else if (current_state_waddr != WAIT_WADDR) begin
//         wait_count_waddr <= 0;
//     end
// end
endmodule

