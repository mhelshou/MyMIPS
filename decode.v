`include "instruction_set.vh"

module IDECODE(Reset, Clk, Instruction, Regfile_flat, NextPCIn, RdEx, RdMem, RdWb, BranchTaken, Op1, Op2, Op3, Dst, SA, Control, Stall, NextPCOut, UnconditionalBranch, UnconditionalBranchTarget);
    input Reset, Clk;
    input [31:0] Instruction;
    input [1023:0] Regfile_flat;
    input [31:0] NextPCIn;
    input [31:0] RdEx, RdMem, RdWb;
    input BranchTaken;
    output reg [31:0] Op1, Op2, Op3;
    output reg [4:0] Dst, SA;
    output reg [31:0] Control, NextPCOut;
    output Stall;
    output UnconditionalBranch;
    output [31:0] UnconditionalBranchTarget;
    
    wire [5:0] opcode, opfunction;
    wire [4:0] rs, rt, rd, sa;
    wire [15:0] immediate;
    wire [31:0] rs_val, rt_val;
    wire [31:0] regfile [0:31];
    reg  [1:0] inst_type;
    reg  [30:0] control_sig;
    wire op_shfvar, op_branch, stall_sig;
    reg  [4:0] dst_reg;
    
    assign { regfile[0], regfile[1], regfile[2], regfile[3], regfile[4], regfile[5], regfile[6], regfile[7], regfile[8], regfile[9], regfile[10], regfile[11], regfile[12], regfile[13], regfile[14], regfile[15], regfile[16], regfile[17], regfile[18], regfile[19], regfile[20], regfile[21], regfile[22], regfile[23], regfile[24], regfile[25], regfile[26], regfile[27], regfile[28], regfile[29], regfile[30], regfile[31]} = Regfile_flat;
    
    //regfile[31], regfile[30], regfile[29], regfile[28], regfile[27], regfile[26], regfile[25], regfile[24], regfile[23], regfile[22], regfile[21], regfile[20], regfile[19], regfile[18], regfile[17], regfile[16], regfile[15], regfile[14], regfile[13], regfile[12], regfile[11], regfile[10], regfile[9], regfile[8], regfile[7], regfile[6], regfile[5], regfile[4], regfile[3], regfile[2], regfile[1], regfile[0]} = Regfile_flat;
            
    assign opcode = Instruction[31:26];
    assign rs = Instruction[25:21];
    assign rt = Instruction[20:16];
    assign rd = Instruction[15:11];
    assign sa = Instruction[10:6];
    assign immediate = Instruction[15:0];
    assign opfunction = Instruction[5:0];
    assign rs_val = regfile[rs];
    assign rt_val = regfile[rt];
    assign op_shfvar = control_sig[12];
    assign op_branch = control_sig[15];
    
    always @ (opcode or opfunction)
    begin
        case (opcode)
            `SPECIAL:    begin
                            case (opfunction)
                                `ADD:        control_sig <= `OP_ADD;
                                `ADDU:       control_sig <= `OP_UNSIGNED | `OP_ADD;
                                `SUB:        control_sig <= `OP_SUB;
                                `SUBU:       control_sig <= `OP_UNSIGNED | `OP_SUB;
                                `MULT:       control_sig <= `OP_MULT;
                                `MULTU:      control_sig <= `OP_UNSIGNED | `OP_MULT;
                                `DIV:        control_sig <= `OP_DIV;
                                `DIVU:       control_sig <= `OP_UNSIGNED | `OP_DIV;
                                `AND:        control_sig <= `OP_AND;
                                `OR:         control_sig <= `OP_OR;
                                `NOR:        control_sig <= `OP_NOR;
                                `XOR:        control_sig <= `OP_XOR;
                                `SLL:        control_sig <= `OP_SHIFTL;
                                `SLLV:       control_sig <= `OP_SHIFTL | `OP_SHFVAR;
                                `SRA:        control_sig <= `OP_SHIFTR | `OP_SHFAR;
                                `SRAV:       control_sig <= `OP_SHIFTR | `OP_SHFAR | `OP_SHFVAR;
                                `SRL:        control_sig <= `OP_SHIFTR;
                                `SRLV:       control_sig <= `OP_SHIFTR | `OP_SHFVAR;
                                default:     control_sig <= 0;
                            endcase
                            
                            inst_type <= `REGINST;
                        end
						
			// Immediate Instructions
            `LUI:       begin control_sig <= `OP_SHIFTL;                inst_type <= `IMMINST; end
            `ORI:       begin control_sig <= `OP_OR;                    inst_type <= `IMMINST; end
            `ADDI:      begin control_sig <= `OP_ADD;                   inst_type <= `IMMINST; end
            `ADDIU:     begin control_sig <= `OP_ADD | `OP_UNSIGNED;    inst_type <= `IMMINST; end
            `ANDI:      begin control_sig <= `OP_AND;                   inst_type <= `IMMINST; end
            
			// Load Store Instructions
			`LW:		begin control_sig <= `OP_LOAD;					inst_type <= `IMMINST; end
			`SW:		begin control_sig <= `OP_STORE;					inst_type <= `IMMINST; end
			
            // Branch Instructions
            `BE:        begin control_sig <= `OP_BRANCH | `OP_CMPEQ; 	            inst_type <= `IMMINST; end
            `BNE:       begin control_sig <= `OP_BRANCH | `OP_CMPEQ | `OP_COMPCOND; inst_type <= `IMMINST; end
            
            // Jump Instructions
            `J:         begin control_sig <= 0;                                     inst_type <= `JMPINST; end
            
            default:    begin control_sig <= 0; inst_type <= `REGINST; end
        endcase
    end
    
    // Control the Shift amount. Override in case of LUI
    always @(posedge Clk)
    begin
        if (Reset == 1)
            SA <= 0;
        else
            if (opcode == `LUI)
                SA <= 16;
            else
                if (op_shfvar == 1)
                    SA <= rs_val[4:0];
                else
                    SA <= sa;
    end
    
    // Figure out destination register to latch depending on the instruction type
    always @(inst_type or rd or rt)
    begin
        if (inst_type == `REGINST)
            dst_reg <= rd;
        else if (inst_type == `IMMINST)
			dst_reg <= rt;
        else
            dst_reg <= rt;
    end
    
    // Data Values
    always @(posedge Clk)
    begin
        if (Reset == 1)
            begin
                Control <= 0;
                Op1 <= 0;
                Op2 <= 0;
                Dst <= 0;
            end
        else
            begin
                if (stall_sig == 1)
                    Control <= 0;
                else
                    begin
                        Control[30:0] <= control_sig;
                        
                        Op1 <= rs_val;
                        if (inst_type == `REGINST)
                            begin
                                Op2 <= rt_val;
                                Control [31] <= !op_branch & ((rd==0)?0:1);  // WriteBack Reg
                                Dst <= dst_reg;
                            end
                        else
                            if (inst_type == `IMMINST)
                                begin
                                    Op2 <= immediate;
                                    Control [31] <= !op_branch & ( (rt == 0) | (control_sig == `OP_STORE) | (control_sig == `OP_BRANCH)?0:1);  // WriteBack Reg
                                    Dst <= dst_reg;
                                end
                            else
                                begin
                                    Op2 <= immediate;
                                    Control [31] <= 0;  // WriteBack Reg
                                    Dst <= dst_reg;
                                end
                    end
            end
    end
    
	always @(posedge Clk)
	begin
		Op3 <= rt_val;
        NextPCOut <= NextPCIn;
	end
	
    assign stall_sig = RdEx[rs] | RdEx[rt] | RdMem[rs] | RdMem[rt] | RdWb[rs] | RdWb[rt];
    assign Stall = stall_sig;
    assign UnconditionalBranch = (inst_type==`JMPINST)?1:0; // !Reset & Uncon branch detected
    assign UnconditionalBranchTarget = {4'b0, Instruction[25:0], 2'b00};
endmodule