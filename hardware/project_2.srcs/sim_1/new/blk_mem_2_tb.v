`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/06 12:04:09
// Design Name: 
// Module Name: blk_mem_2_tb
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


module blk_mem_2_tb;
	
	reg			clk 		;		// 同步时钟
	reg			wea		;		// 读写控制
	reg  [9:0]		addr 		;		// 地址总线
	reg  [7:0]		data_in 	;		// 数据输入
	wire [7:0]		data_out	;		// 数据输出

	blk_mem_2 	U_blk_mem_gen_0
	(
		.clka		( clk 		)	,
		.wea		( wea 		)	,
		.addra	( addr 		)	,
		.dina		( data_in 	)	,
		.douta	( data_out 	)	
	);
	
	// tb初始化
	initial begin
		clk 		= 0		;
		wea 		= 1		;
		addr 		= 10'b0 	;
		data_in 	= 8'd10	;
	// clk生成
		#10
		forever
			#1 clk = ~clk;
	end
	
	
	
	// RAM读写
	always @(posedge clk) begin
		if( addr == 10'd10 )begin
			addr <= 10'b0;
			data_in <= 8'd10;
			if( wea == 1'b1 )
				wea <= 1'b0;
			else
				wea <= 1'b1;
		end
		else begin
			if( wea == 1'b1 )begin
				addr <= addr + 1'b1;
				data_in <= data_in - 1'b1;
			end
			else if( wea == 1'b0 )begin
				addr <= addr + 1'b1;
			end
		end
	end

endmodule