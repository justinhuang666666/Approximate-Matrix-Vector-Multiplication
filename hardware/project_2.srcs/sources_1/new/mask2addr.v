`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/21 10:55:05
// Design Name: 
// Module Name: mask2addr
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


module mask2addr #(
    parameter WIDTH = 32,                     // Default width of 32
    parameter ADDR_WIDTH = $clog2(WIDTH)      // Calculate address width needed
)(
    input wire clk,
    input wire clk_en,
    input wire rst,
    input wire mask_ready,
    input wire [WIDTH-1:0] mask,              // Parameterized mask width
    output reg valid,
    output reg [ADDR_WIDTH:0] out           // Adjust output width to match address width
);

reg [ADDR_WIDTH:0] count;
reg [WIDTH*ADDR_WIDTH:0] addrs;             // Buffer to store addresses (5 bits each, up to WIDTH)
reg [ADDR_WIDTH:0] counter;                 // Output address index

integer i;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        addrs <= 0;
        valid <= 0;
        out <= 0;
        counter <= 0;
    end else if (clk_en && mask_ready) begin
        // Calculate addresses and count
        count = 0;
        addrs = 0;
        for (i = WIDTH-1; i >= 0; i = i - 1) begin
            if (mask[i]) begin
                if (count < WIDTH) begin  // Ensure that count does not exceed buffer size
                    addrs[count * ADDR_WIDTH +: ADDR_WIDTH] = WIDTH - 1 - i; // Store adjusted position
                    count = count + 1;
                end
            end
        end
        out <= addrs[0 +: ADDR_WIDTH];
        counter <= 1; // Reset output index
        valid <= 1; // Reset valid flag
    end else if (clk_en && counter < count) begin
        // Output the addresses one by one
        out <= addrs[counter * ADDR_WIDTH +: ADDR_WIDTH];
        counter <= counter + 1;
        valid <= 1;
    end else begin
        valid <= 0;
        out <= 0; // Optionally reset output when done
    end
end

endmodule
