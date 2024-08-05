`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/17 20:31:08
// Design Name: 
// Module Name: blk_mem_u_tb
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


module blk_mem_u_tb;

  // Inputs
  reg clka;
  reg [0:0] wea;
  reg [5:0] addra;
  reg [15:0] dina;

  // Outputs
  wire [15:0] douta;

  // Instantiate the Unit Under Test (UUT)
  blk_mem_u uut (
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

    // Wait 100 ns for global reset to finish
    #100;

    // Read RAM from address 0 to 63
    for (addra = 0; addra < 64; addra = addra + 1) begin
      #10; // Wait for a clock cycle
      $display("Read Addr: %d, Data: %h", addra, douta);
    end

    // Stop simulation
    $stop;
  end

  // Clock generation
  always #5 clka = ~clka; // 100MHz clock

endmodule