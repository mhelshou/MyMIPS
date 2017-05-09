module MIPS_CPU(
    Reset,
    Clk,
    IAddr,
    Inst,
    IRead,
    IWrite,
    DAddr,
    Data,
    DRead,
    DWrite,
    CPU_OE
);

    input   Reset, Clk;
    input   [31:0] Inst;
    inout   [31:0] Data;
    output  [31:0] IAddr, DAddr;
    output  IRead, IWrite, DRead, DWrite, CPU_OE;
    
    // CPU Registers
    reg     [31:0] pc;
    reg     [31:0] cpureg[0:31];
    wire    [1023:0] regfile_flat;

    // Signals
    reg     incpc;
    wire    [31:0] fetched, op1, op2, op3, decode_control, exresult, memresult, rdex, rdmem, rdwb, ex_storeval, memaddr, pc_dc_ex, unconditional_branch_target, exbranch_target;
    wire    [4:0] decoded_dst, ex_dst, mem_dst, sa;
    wire    loadpc, exwrite_back, memwrite_back, stall, decode_stall, flush, ismemread, ismemwrite, unconditional_branch, exbranch_taken;
    
    assign regfile_flat = { 32'd0, cpureg[1], cpureg[2], cpureg[3], cpureg[4], cpureg[5], cpureg[6], cpureg[7], cpureg[8], cpureg[9], cpureg[10], cpureg[11], cpureg[12], cpureg[13], cpureg[14], cpureg[15], cpureg[16], cpureg[17], cpureg[18], cpureg[19], cpureg[20], cpureg[21], cpureg[22], cpureg[23], cpureg[24], cpureg[25], cpureg[26], cpureg[27], cpureg[28], cpureg[29], cpureg[30], cpureg[31]};

    assign IAddr = {2'b0, pc[31:2]};
    assign DAddr = {2'b0, memaddr[31:2]};
    
    assign loadpc = exbranch_taken | unconditional_branch;
    
    // Program Counter
    always @ (posedge Clk)
    begin
        if (Reset == 1) begin
            pc <= 0;
            incpc <= 1;
        end
        else begin
            if (loadpc == 1)
                if(unconditional_branch)
                    pc <= unconditional_branch_target;
                else
                    pc <= exbranch_target;
            else if ( (incpc == 1) & !stall & !flush)
                pc <= pc + 4;
        end
    end
    
    IFETCH  fetch(Reset, Clk, Inst, stall, loadpc, IRead, fetched, flush);
    IDECODE decode(Reset, Clk, fetched, regfile_flat, pc, rdex, rdmem, rdwb, exbranch_taken, op1, op2, op3, decoded_dst, sa, decode_control, decode_stall, pc_dc_ex, unconditional_branch, unconditional_branch_target);
    IEX     ex(Reset, Clk, op1, op2, op3, decoded_dst, sa, decode_control, pc_dc_ex, ex_dst, exresult, exwrite_back, ex_storeval, ismemread, ismemwrite, exbranch_taken, exbranch_target);
	IMEM    mem(Reset, Clk, exresult, ex_dst, exwrite_back, ex_storeval, ismemread, ismemwrite, memaddr, Data, DRead, DWrite, memresult, mem_dst, memwrite_back);
	
    IREGUSAGE regusage(decoded_dst, decode_control[31], ex_dst, exwrite_back, mem_dst, memwrite_back, rdex, rdmem, rdwb); //TODO: another output needed for the MEM stage
	
    assign stall = decode_stall; // TODO: may include other stalls later
    assign CPU_OE = ismemread;
    
    // WB Stage
    always @(posedge Clk)
    begin
        if ((Reset == 0) & (memwrite_back == 1))
            cpureg[mem_dst] <= memresult;
    end
    
//    IMEM mem();
//    IWB wb();
endmodule