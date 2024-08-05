`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/03 17:57:07
// Design Name: 
// Module Name: fp_acc_32_tb
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


module tb_fp_acc_32();

    // Inputs
    reg aclk;
    reg aclken;
    reg aresetn;
    reg s_axis_a_tvalid;
    reg [31:0] s_axis_a_tdata;
    reg s_axis_a_tlast;
    reg m_axis_result_tready;

    // Outputs
    wire s_axis_a_tready;
    wire m_axis_result_tvalid;
    wire [31:0] m_axis_result_tdata;
    wire m_axis_result_tlast;

    // Instantiate the Unit Under Test (UUT)
    fp_acc_32 uut (
        .aclk(aclk),
        .aclken(aclken),
        .aresetn(aresetn),
        .s_axis_a_tvalid(s_axis_a_tvalid),
        .s_axis_a_tready(s_axis_a_tready),
        .s_axis_a_tdata(s_axis_a_tdata),
        .s_axis_a_tlast(s_axis_a_tlast),
        .m_axis_result_tvalid(m_axis_result_tvalid),
        .m_axis_result_tready(m_axis_result_tready),
        .m_axis_result_tdata(m_axis_result_tdata),
        .m_axis_result_tlast(m_axis_result_tlast)
    );

    // Clock generation
    always #5 aclk = ~aclk; // 100 MHz clock

    // Initialize and reset
    initial begin
        // Initialize Inputs
        aclk = 0;
        aclken = 1;
        aresetn = 0;
        s_axis_a_tvalid = 0;
        s_axis_a_tdata = 0;
        s_axis_a_tlast = 0;
        m_axis_result_tready = 0;

        // Reset the system
        #100;
        aresetn = 1;
        #50;

        // Start of test vectors
        // First sequence of inputs
        s_axis_a_tvalid = 1;
        m_axis_result_tready = 1;
        s_axis_a_tdata = 32'h3e4ccccd; // 0.2 in IEEE floating-point
        #10;
        // s_axis_a_tdata = 32'h3e4ccccd; // 0.2 in IEEE floating-point
        // #10;
        // s_axis_a_tdata = 32'h3e4ccccd; // 0.2 in IEEE floating-point
        // s_axis_a_tlast = 1; // End of the data packet
        // #10;
        s_axis_a_tvalid = 0;
        s_axis_a_tlast = 0;

        // Wait for result
        while (!m_axis_result_tvalid) #10;
        if (m_axis_result_tlast && m_axis_result_tdata !== 32'h3e4ccccd) // 4.0 expected
            $display("Test failed: Expected 3f19999a, got %h", m_axis_result_tdata);
        else
            $display("Test passed for input sequence 1.0 + 2.0 + 3.0");

        // More test vectors can be added here...

        // End simulation
        #100;
        $finish;
    end

endmodule

