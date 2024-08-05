`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/21 21:36:53
// Design Name: 
// Module Name: db_u_tile
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

module db_u_tile (
    input wire clk,
    input wire rst,
    input wire clk_en,
    input wire u_tile_ready,
    input wire read,
    input wire [63:0] u_tile,
    // output reg db_ready,
    output reg [63:0] db_out,
    output reg db_valid
);

//parameter define
parameter IDLE = 4'b0001, 
WRAM1 = 4'b0010,
WRAM2_RRAM1 = 4'b0100, 
WRAM1_RRAM2 = 4'b1000; 

//reg define
reg [3:0] state ;
reg [63:0] u_tile_reg ;

wire [63:0] ram1_wr_data;
wire [63:0] ram2_wr_data;

reg ram1_wr_en;
reg ram2_wr_en;

reg ram1_rd_en;
reg ram2_rd_en;

reg ram2_wr_addr;
reg ram2_rd_addr;

reg ram1_wr_addr;
reg ram1_rd_addr;

wire [63:0] ram1_rd_data;
wire [63:0] ram2_rd_data;

assign ram1_wr_data = (ram1_wr_en == 1'b1) ? u_tile_reg: 64'b0;
assign ram2_wr_data = (ram2_wr_en == 1'b1) ? u_tile_reg: 64'b0;

reg delayed_u_tile_ready;

always@(negedge clk or negedge rst) begin
    if(rst) begin
        delayed_u_tile_ready <= 1'b0;
        db_valid <= 1'b0;
    end else begin
        delayed_u_tile_ready <= u_tile_ready;
        db_valid <= delayed_u_tile_ready;
    end
end

always@(negedge clk or negedge rst) begin
    if(rst | !u_tile_ready)
        u_tile_reg <= 64'b0;
    else
        u_tile_reg <= u_tile;
end

always@(negedge clk or negedge rst) begin
    if(rst)
        state <= IDLE;
    else case(state)
        IDLE:
            if(u_tile_ready == 1'b1)
                state <= WRAM1;
        WRAM1:
            if(u_tile_ready == 1'b1)
                state <= WRAM2_RRAM1;
        WRAM2_RRAM1:
            if(u_tile_ready == 1'b1)
                state <= WRAM1_RRAM2;
        WRAM1_RRAM2:
            if(u_tile_ready == 1'b1)
                state <= WRAM2_RRAM1;
        default:
            state <= IDLE;
    endcase
end

always@(*) begin
    case(state)
        IDLE:
        begin
            ram1_wr_en = 1'b0;
            ram2_wr_en = 1'b0;
        end
        WRAM1:
        begin
            ram1_wr_en = 1'b1;
            ram2_wr_en = 1'b0;
        end
        WRAM2_RRAM1:
        begin
            ram1_wr_en = 1'b0;
            ram2_wr_en = 1'b1;
        end
        WRAM1_RRAM2:
        begin
            ram1_wr_en = 1'b1;
            ram2_wr_en = 1'b0;
        end
        default:;
    endcase
end

always@(negedge clk or negedge rst) begin
    if(rst)
        ram1_rd_en <= 1'b0;
    else if(state == WRAM2_RRAM1)
        ram1_rd_en <= 1'b1;
    else
        ram1_rd_en <= 1'b0;
end

always@(negedge clk or negedge rst) begin
    if(rst)
        ram2_rd_en <= 1'b0;
    else if(state == WRAM1_RRAM2)
        ram2_rd_en <= 1'b1;
    else
        ram2_rd_en <= 1'b0;
end

always@(negedge clk or negedge rst) begin
    if(rst) begin
        db_out <= 64'b0;
    end else if(ram1_rd_en == 1'b1) begin
        db_out <= ram1_rd_data;
    end else if(ram2_rd_en == 1'b1) begin
        db_out <= ram2_rd_data;
    end else begin
        db_out <= 64'b0;
    end
end

db_u_tile_ram db_u_tile_ram_instance_1 (
    .clka(clk),   // input wire clka
    .wea(ram1_wr_en),    // input wire [0 : 0] wea
    .addra(1'b0),// input wire [0 : 0] addra
    .dina(u_tile_reg),  // input wire [63 : 0] dina
    .douta(),// output wire [63 : 0] douta
    .clkb(clk),   // input wire clkb
    .web(1'b0),    // input wire [0 : 0] web
    .addrb(1'b0),// input wire [0 : 0] addrb
    .dinb(dinb),  // input wire [63 : 0] dinb
    .doutb(ram1_rd_data) // output wire [63 : 0] doutb
);

db_u_tile_ram db_u_tile_ram_instance_2 (
    .clka(clk),   // input wire clka
    .wea(ram2_wr_en),    // input wire [0 : 0] wea
    .addra(1'b0),// input wire [0 : 0] addra
    .dina(u_tile_reg),  // input wire [63 : 0] dina
    .douta(),// output wire [63 : 0] douta
    .clkb(clk),   // input wire clkb
    .web(1'b0),    // input wire [0 : 0] web
    .addrb(1'b0),// input wire [0 : 0] addrb
    .dinb(),  // input wire [63 : 0] dinb
    .doutb(ram2_rd_data) // output wire [63 : 0] doutb
);

endmodule


