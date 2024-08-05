`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/30 17:14:17
// Design Name: 
// Module Name: mask2addr_v2
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

module mask2addr_v2 #(
    parameter WIDTH = 96,                     // Default width of 32
    parameter ADDR_WIDTH = $clog2(WIDTH)      // Calculate address width needed
)(
    input wire clk,
    input wire clk_en,
    input wire rst,
    input wire mask_ready,
    input wire [WIDTH-1:0] mask,              // Parameterized mask width
    output reg valid,
    output reg [ADDR_WIDTH-1:0] out           // Adjust output width to match address width
);

    reg [WIDTH-1:0] current_mask;
    reg [$clog2(WIDTH)-1:0] priority_enc;
    integer i;

    wire [WIDTH-1:0] mask_out;

    // Mask reversal module
    mask_reverse #(WIDTH) mask_reverser (
        .mask_in(mask),
        .mask_out(mask_out)
    );

    // Priority encoder logic
    always @* begin
        priority_enc = 0;
        for (i = WIDTH-1; i >= 0; i = i - 1) begin
            if (current_mask[i]) begin
                priority_enc = i;
            end
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            valid <= 0;
            out <= 0;
            current_mask <= 0;
        end else if (clk_en & mask_ready) begin //(mask_ready)
            valid <= 0;
            current_mask <= mask_out;
        end else if (clk_en & !mask_ready) begin //(clk_en)
            if (current_mask != 0) begin
                out <= priority_enc;
                valid <= 1;
                current_mask[priority_enc] <= 0; // Clear the bit that has been processed
            end else begin
                valid <= 0;
                out <= 0;
            end
        end
    end
endmodule

// module mask2addr_v2 #(
//     parameter WIDTH = 96,                     // Default width of 32
//     parameter ADDR_WIDTH = $clog2(WIDTH)      // Calculate address width needed
// )(
//     input wire clk,
//     input wire clk_en,
//     input wire rst,
//     input wire mask_ready,
//     input wire [WIDTH-1:0] mask,              // Parameterized mask width
//     output reg valid,
//     output reg [ADDR_WIDTH-1:0] out           // Adjust output width to match address width
// );

//     reg [WIDTH-1:0] current_mask;
//     reg [$clog2(WIDTH)-1:0] priority_enc;
//     integer i;

//     wire [WIDTH-1:0] mask_out;

//     // Mask reversal module
//     mask_reverse #(WIDTH) mask_reverser (
//         .mask_in(mask),
//         .mask_out(mask_out)
//     );

//     // Priority encoder logic
//     always @* begin
//         priority_enc = 0;
//         for (i = WIDTH-1; i >= 0; i = i - 1) begin
//             if (current_mask[i]) begin
//                 priority_enc = i;
//             end
//         end
//     end

//     always @(posedge clk or posedge rst) begin
//         if (rst) begin
//             valid <= 0;
//             out <= 0;
//             current_mask <= 0;
//         end else if (clk_en) begin
//             if (mask_ready) begin
//                 valid <= 0;
//                 current_mask <= mask_out;
//             end else begin
//                 if (current_mask != 0) begin
//                     out <= priority_enc;
//                     valid <= 1;
//                     current_mask[priority_enc] <= 0; // Clear the bit that has been processed
//                 end else begin
//                     valid <= 0;
//                     out <= 0;
//                 end
//             end
//         end
//     end
// endmodule

// module mask2addr_v2 #(
//     parameter WIDTH = 96,                     // Default width of 32
//     parameter ADDR_WIDTH = $clog2(WIDTH)      // Calculate address width needed
// )(
//     input wire clk,
//     input wire clk_en,
//     input wire rst,
//     input wire mask_ready,
//     input wire [WIDTH-1:0] mask,              // Parameterized mask width
//     output reg valid,
//     output reg [ADDR_WIDTH-1:0] out           // Adjust output width to match address width
// );

//     reg [WIDTH-1:0] current_mask;
//     reg [$clog2(WIDTH)-1:0] priority_enc;
//     reg [2:0] state; // State machine state
//     integer i;

//     wire [WIDTH-1:0] mask_out;

//     // Mask reversal module
//     mask_reverse #(WIDTH) mask_reverser (
//         .mask_in(mask),
//         .mask_out(mask_out)
//     );

//     // State machine definition
//     localparam IDLE_STATE = 3'b001;
//     localparam PROCESS_MASK_STATE = 3'b010;
//     localparam OUTPUT_STATE = 3'b100;

//     // Priority encoder logic
//     always @* begin
//         priority_enc = 0;
//         for (i = WIDTH-1; i >= 0; i = i - 1) begin
//             if (current_mask[i]) begin
//                 priority_enc = i;
//             end
//         end
//     end

//     // State machine control
//     always @(posedge clk or posedge rst) begin
//         if (rst) begin
//             valid <= 0;
//             out <= 0;
//             current_mask <= 0;
//             state <= IDLE_STATE;
//         end else begin
//             case (state)
//                 IDLE_STATE: begin
//                     valid <= 0;
//                     out <= 0;
//                     if(mask_ready) begin
//                         state <= OUTPUT_STATE;
//                         current_mask <= mask_out;
//                     end
//                 end
//                 OUTPUT_STATE: begin
//                     if(current_mask == 0) begin
//                         out <= 0;
//                         valid <= 1;
//                     end else begin
//                         out <= priority_enc;
//                         valid <= 1;
//                         current_mask[priority_enc] <= 0; // Clear the bit that has been processed
//                     end
//                 end
//                 default: begin
//                     valid <= 0;
//                     out <= 0;
//                 end
//             endcase
//         end
//     end
// endmodule