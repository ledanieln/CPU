// update content & output updated content at rising edge
// 1. hazard control signal (sync rising edge)
// if EX_Flush equals 1,
// then clear all WB, MEM control signal to 0 on rising edge
// do not need to clear addr or data content
//input EX_Flush;
// 2. WB control signal
//input RegWrite_in, MemtoReg_in;
//output RegWrite_out, MemtoReg_out;
// 3. MEM control signal
//input Branch_in, MemRead_in, MemWrite_in, Jump_in;
//output Branch_out, MemRead_out, MemWrite_out, Jump_out;
// 4. addr content
//input [31:0] jump_addr_in, branch_addr_in;
//output [31:0] jump_addr_out, branch_addr_out;
// 5. data content
//input ALU_zero_in;
//output ALU_zero_out;
//input [31:0] ALU_result_in, reg_read_data_2_in;
//output [31:0] ALU_result_out, reg_read_data_2_out;
//input [4:0] ID_EX_RegisterRd_in;
//output [4:0] EX_MEM_RegisterRd_out;
// general signal
// rst: async; set all register content to 0
//input clk, rst;
	
module EX_MEM (	
	input clk, rst,
	input EX_Flush,
	input RegWrite_in, 
	input [1:0] MemtoReg_in,
	input Branch_in, MemRead_in, MemWrite_in, Jump_in,
	input [31:0] jump_addr_in, branch_addr_in, PC_plus_4_in,
	input ALU_zero_in,
	input [31:0] ALU_result_in, reg_read_data_2_in, 
	input [4:0] ID_EX_RegisterRd_in,
	
	output RegWrite_out, 
	output [1:0] MemtoReg_out,
	output Branch_out, MemRead_out, MemWrite_out, Jump_out,
	output [31:0] jump_addr_out, branch_addr_out, PC_plus_4_out,
	output ALU_zero_out,
	output [31:0] ALU_result_out, reg_read_data_2_out,
	output [4:0] EX_MEM_RegisterRd_out
);

	reg RegWrite_out;
	reg [1:0] MemtoReg_out;
	reg Branch_out, MemRead_out, MemWrite_out, Jump_out;
	reg [31:0] jump_addr_out, branch_addr_out, PC_plus_4_out;
	reg ALU_zero_out;
	reg [31:0] ALU_result_out, reg_read_data_2_out;
	reg [4:0] EX_MEM_RegisterRd_out;

	always @(negedge clk) begin
		if (rst == 1'b1) begin
		  RegWrite_out <= 1'b0;
		  MemtoReg_out <= 2'b00;
		  Branch_out <= 1'b0;
		  MemRead_out <= 1'b0;
		  MemWrite_out <= 1'b0;
		  Jump_out <= 1'b0;
		  jump_addr_out <= 32'b0;
		  PC_plus_4_out <= 32'b0;
		  branch_addr_out <= 32'b0;
		  ALU_zero_out <= 1'b0;
		  ALU_result_out <= 32'b0;
		  reg_read_data_2_out <= 32'b0;
		  EX_MEM_RegisterRd_out <= 5'b0; 
		end

		else begin

			RegWrite_out <= RegWrite_in;
		 	MemtoReg_out <= MemtoReg_in;
		  	Branch_out <= Branch_in;
		  	MemRead_out <= MemRead_in;
		  	MemWrite_out <= MemWrite_in;
		  	Jump_out <= Jump_in;
		  	jump_addr_out <= jump_addr_in;
		  	branch_addr_out <= branch_addr_in;
		  	PC_plus_4_out <= PC_plus_4_in;
		  	ALU_zero_out <= ALU_zero_in;
		  	ALU_result_out <= ALU_result_in;
		  	reg_read_data_2_out <= reg_read_data_2_in;
		  	EX_MEM_RegisterRd_out <= ID_EX_RegisterRd_in;

			if (EX_Flush == 1'b1) begin

				RegWrite_out <= 1'b0;
			  	MemtoReg_out <= 2'b00;
			  	Branch_out <= 1'b0;
			  	MemRead_out <= 1'b0;
			  	MemWrite_out <= 1'b0;
			  	Jump_out <= 1'b0;

			end
		end
	end
endmodule