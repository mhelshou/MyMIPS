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
    DWrite
);

    input   Reset, Clk;
    input   [31:0] Inst;
    inout   [31:0] Data;
    output  [31:0] IAddr, DAddr;
    output  IRead, IWrite, DRead, DWrite;
    
    // CPU Registers
    reg     [31:0] pc;
    reg     [31:0] cpureg[0:31];
    wire    [1023:0] regfile_flat;

    // Signals
    reg     loadpc, incpc;
    wire    [31:0] pcout, fetched, op1, op2, decode_control, result, rdex, rdwb;
    wire    [4:0] decoded_dst, ex_dst, sa;
    wire    write_back, stall, decode_stall, flush;
    
    assign regfile_flat = { 32'd0, cpureg[1], cpureg[2], cpureg[3], cpureg[4], cpureg[5], cpureg[6], cpureg[7], cpureg[8], cpureg[9], cpureg[10], cpureg[11], cpureg[12], cpureg[13], cpureg[14], cpureg[15], cpureg[16], cpureg[17], cpureg[18], cpureg[19], cpureg[20], cpureg[21], cpureg[22], cpureg[23], cpureg[24], cpureg[25], cpureg[26], cpureg[27], cpureg[28], cpureg[29], cpureg[30], cpureg[31]};

    assign IAddr = {2'b0, pc[31:2]};
    
    // Program Counter
    always @ (posedge Clk)
    begin
        if (Reset == 1) begin
            pc <= 0;
            loadpc <= 0;
            incpc <= 1;
        end
        else begin
            if (loadpc == 1)
                pc <= pcout;
            else if ( (incpc == 1) & !stall & !flush)
                pc <= pc + 4;
        end
    end
    
    IFETCH  fetch(Reset, Clk, Inst, stall, IRead, fetched, flush);
    IDECODE decode(Reset, Clk, fetched, regfile_flat, rdex, rdwb, op1, op2, decoded_dst, sa, decode_control, decode_stall);
    IEX     ex(Reset, Clk, op1, op2, decoded_dst, sa, decode_control, ex_dst, result, write_back);
    IREGUSAGE regusage(decoded_dst, decode_control[31], ex_dst, write_back, rdex, rdwb); //TODO: another output needed for the MEM stage
    
    assign stall = decode_stall; // TODO: may include other stalls later
    
    // WB Stage
    always @(posedge Clk)
    begin
        if ((Reset == 0) & (write_back == 1))
            cpureg[ex_dst] <= result;
    end
    
//    IMEM mem();
//    IWB wb();
endmodule