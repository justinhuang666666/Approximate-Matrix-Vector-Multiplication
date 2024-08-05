`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/17 20:53:22
// Design Name: 
// Module Name: tb_u_tile_ram
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

module tb_u_tile_ram;

  // Inputs
  reg clka;
  reg wea;
  reg [5:0] addra;
  reg [15:0] dina;

  // Outputs
  wire [15:0] douta;

  // Instantiate the Unit Under Test (UUT)
  u_tile_ram uut (
    .clka(clka), 
    .wea(wea), 
    .addra(addra), 
    .dina(dina), 
    .douta(douta)
  );

  initial begin
    // Initialize Inputs
    clka = 0;
    wea = 0;
    addra = 0;
    dina = 0;

    // Wait for global reset
    #100;

    // Read from address 0 to 63
    repeat (192) begin
      @(posedge clka);
      addra = addra + 1;
    end

    // End the simulation
    #100;
    $finish;
  end

  // Clock generation
  always #5 clka = ~clka;

endmodule
