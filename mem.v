module IMEM(Reset, Clk, ExResult, ExDstIn, ExWbIn, ExStoreVal, isMemRead, isMemWrite, AddrOut, Data, ReadRAM, WriteRAM, Result_or_MemVal, MemDstOut, MemWbOut);
	input Reset, Clk;
	input [31:0] ExResult, ExStoreVal;
	input [4:0] ExDstIn;
	input ExWbIn, isMemRead, isMemWrite;
	output [31:0] AddrOut;
	inout [31:0] Data;
    output ReadRAM, WriteRAM;
	output reg [31:0] Result_or_MemVal;
	output reg [4:0] MemDstOut;
	output reg MemWbOut;
	
	wire   [31:0] datain;
    reg    write_strobe_control;
	
	assign AddrOut = ExResult;
	
	assign datain = isMemRead?Data:32'bZ;
	assign Data = isMemWrite?ExStoreVal:32'bZ;
	
	assign ReadRAM = Reset | !isMemRead | !Clk;
    assign WriteRAM = Reset | !(isMemWrite & write_strobe_control);	
    
    // Generate the Write strobe to avoid glitches
    always @(negedge Clk)
        write_strobe_control <= isMemWrite?0:1;
            
	always @(posedge Clk)
	begin
		if (Reset == 1)
			MemWbOut <= 0;
		else
			begin
				if (isMemRead)
					Result_or_MemVal <= datain;
				else
				begin
					Result_or_MemVal <= ExResult;
				end
				
				MemWbOut <= ExWbIn;
				MemDstOut <= ExDstIn;				
			end
    end
endmodule