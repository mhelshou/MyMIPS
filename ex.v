`include "instruction_set.vh"

module IEX(Reset, Clk, Op1, Op2, Op3, DstIn, SA, Control, NextPCIn, DstOut, Result, WriteBack, ExStoreValOut, isMemRead, isMemWrite, BranchTaken, BranchTarget);
    input Reset, Clk;
    input [4:0] DstIn, SA;
    input [31:0] Op1, Op2, Op3, Control, NextPCIn;
    output reg [4:0] DstOut;
    output reg [31:0] Result, ExStoreValOut, BranchTarget;
    output reg WriteBack, isMemRead, isMemWrite;
    output BranchTaken;
    
    wire op_add, op_sub, op_mult, op_div, op_and, op_or, op_nor, op_xor, op_shiftl, op_shiftr, op_testneg, op_testpos, op_testz, op_testnz;  // Control
	wire op_memread, op_memwrite; // Memory
    wire op_unsigned, op_shiftar; // Overrides
    wire condition_true, cmptrue, testtrue, Op1isZero;
    
    reg  [31:0] add_result, sub_result, mult_result, div_result, and_result, or_result, nor_result, xor_result, shiftl_result, shiftr_result, mem_addr;
    reg  cmpeq_true, cmplt_true, cmpgt_true, testneg_true, testpos_true, testz_true, testnz_true;
    
    assign op_add       = Control[1];
    assign op_sub       = Control[2];
    assign op_mult      = Control[3];
    assign op_div       = Control[4];
    assign op_and       = Control[5];
    assign op_or        = Control[6];
    assign op_nor       = Control[7];
    assign op_xor       = Control[8];
    assign op_shiftl    = Control[9];
    assign op_shiftr    = Control[10];
    
    assign op_unsigned  = Control[0];
    assign op_shiftar   = Control[11];
    
	assign op_memread	= Control[13];
	assign op_memwrite	= Control[14];

    assign op_branch    = Control[15];
    assign op_cmpeq     = Control[16];
    assign op_compcond  = Control[17];
    
    assign op_jump      = Control[18];
    
    assign op_testneg   = Control[19];
    assign op_testpos   = Control[20];
    assign op_testz     = Control[21];
    assign op_testnz    = Control[22];
    
    assign cmptrue = cmpeq_true | cmplt_true | cmpgt_true;
    assign testtrue = testneg_true | testpos_true | testz_true | testnz_true;
    assign condition_true = op_compcond ^ (cmptrue | testtrue) ;
    
    assign BranchTaken = op_jump | (op_branch & condition_true);
    
    // Adder
    always @(Op1 or Op2 or op_add)
    begin
        if (op_add == 1)
            add_result <= Op1 + Op2;
        else
            add_result <= 0;
    end
    
    // Subtractor
    always @(Op1 or Op2 or op_sub)
    begin
        if (op_sub == 1)
            sub_result <= Op1 - Op2;
        else
            sub_result <= 0;
    end
    
    // Multiplier
    always @(Op1 or Op2 or op_mult)
    begin
        if (op_mult == 1)
            mult_result <= Op1 * Op2;
        else
            mult_result <= 0;
    end
    
    // Divider
    always @(Op1 or Op2 or op_div)
    begin
        if (op_div == 1)
            div_result <= Op1 / Op2;
        else
            div_result <= 0;
    end
    
    // AND
    always @(Op1 or Op2 or op_and)
    begin
        if (op_and == 1)
            and_result <= Op1 & Op2;
        else
            and_result <= 0;
    end
    
    // OR
    always @(Op1 or Op2 or op_or)
    begin
        if (op_or == 1)
            or_result <= Op1 | Op2;
        else
            or_result <= 0;
    end
    
    // NOR
    always @(Op1 or Op2 or op_nor)
    begin
        if (op_nor == 1)
            nor_result <= ~(Op1 | Op2);
        else
            nor_result <= 0;
    end
    
    // XOR
    always @(Op1 or Op2 or op_xor)
    begin
        if (op_xor == 1)
            xor_result <= Op1 ^ Op2;
        else
            xor_result <= 0;
    end
        
    // Shifter Left
    always @(Op2 or SA or op_shiftl)
    begin
        if (op_shiftl == 1)
            shiftl_result <= Op2 << SA;
        else
            shiftl_result <= 0;
    end
    
    // Shifter Right
    always @(Op2 or SA or op_shiftr)
    begin
        if (op_shiftr == 1)
            shiftr_result <= Op2 >> SA;
        else
            shiftr_result <= 0;
    end
    
    // Comparison
    // TODO: These comparison could be done with one subraction unit along with monitoring the carries and sign bit
    always @(Op1 or Op3 or op_cmpeq)
    begin
        if (op_cmpeq == 1)
            cmpeq_true <= (Op1 == Op3) ?1:0;
        else
            cmpeq_true <= 0;
    end

    
//    always @(Op1 or Op3 or op_cmplt)
//    begin
//        if (op_cmplt == 1)
//            cmplt_true <= (Op1 < Op3) ?1:0;
//        else
//            cmplt_true <= 0;
//    end
//
//    always @(Op1 or Op3 or op_cmpgt)
//    begin
//        if (op_cmpgt == 1)
//            cmpgt_true <= (Op1 > Op3) ?1:0;
//        else
//            cmpgt_true <= 0;
//    end

    // Tests
    always @(Op1 or op_testneg)
    begin
        if (op_testneg == 1)
            testneg_true <= !Op1[31];
        else
            testneg_true <= 0;
    end

    always @(Op1 or op_testpos)
    begin
        if (op_testpos == 1)
            testpos_true <= Op1[31];
        else
            testpos_true <= 0;
    end

    assign Op1isZero = (Op1==0)?1:0;

    always @(Op1 or op_testz or Op1isZero)
    begin
        if (op_testz == 1)
            testz_true <= Op1isZero;
        else
            testz_true <= 0;
    end

    always @(Op1 or op_testnz or Op1isZero)
    begin
        if (op_testnz == 1)
            testnz_true <= !Op1isZero;
        else
            testnz_true <= 0;
    end

	// Memory
	always @(Op1 or Op2 or op_memread or op_memwrite)
	begin
		if (op_memread | op_memwrite)
			mem_addr <= Op1 + {Op2[15]?16'b1111111111111111:16'b0, Op2[15:0]}; // Add base to sign-extended immediate
		else
			mem_addr <= 0;
	end
	
    // Branch Target Calculation
    always @(NextPCIn or Op2 or op_jump)
    begin
        if(op_jump)
            BranchTarget <= Op2;
        else
            BranchTarget <= NextPCIn + {Op2[15]?14'b11111111111111:14'b0, Op2[15:0], 2'b00};
    end
    
    always @(posedge Clk)
    begin
        if (Reset == 1)
            begin
                WriteBack   <= 0;   
				isMemRead	<= 0;
				isMemWrite 	<= 0;
            end
        else
            begin
                Result      	<= add_result | sub_result | mult_result | div_result | and_result | or_result | nor_result | xor_result | shiftl_result | shiftr_result | mem_addr;
                DstOut      	<= DstIn;
                WriteBack   	<= Control[31];
				ExStoreValOut	<= Op3;
				isMemRead		<= op_memread;
				isMemWrite 		<= op_memwrite;
            end
    end
endmodule
