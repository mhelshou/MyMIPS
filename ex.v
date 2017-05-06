module IEX(Reset, Clk, Op1, Op2, DstIn, SA, Control, DstOut, Result, WriteBack);
    input Reset, Clk;
    input [4:0] DstIn, SA;
    input [31:0] Op1, Op2, Control;
    output reg [4:0] DstOut;
    output reg [31:0] Result;
    output reg WriteBack;
    
    wire op_add, op_sub, op_mult, op_div, op_and, op_or, op_nor, op_xor, op_shiftl, op_shiftr;  // Control
    wire op_unsigned, op_shiftar; // Overrides
    reg  [31:0] add_result, sub_result, mult_result, div_result, and_result, or_result, nor_result, xor_result, shiftl_result, shiftr_result;
    
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
    
    // Adder
    always @(Op1 or Op2)
    begin
        if (op_add == 1)
            add_result <= Op1 + Op2;
        else
            add_result <= 0;
    end
    
    // Subtractor
    always @(Op1 or Op2)
    begin
        if (op_sub == 1)
            sub_result <= Op1 - Op2;
        else
            sub_result <= 0;
    end
    
    // Multiplier
    always @(Op1 or Op2)
    begin
        if (op_mult == 1)
            mult_result <= Op1 * Op2;
        else
            mult_result <= 0;
    end
    
    // Divider
    always @(Op1 or Op2)
    begin
        if (op_div == 1)
            div_result <= Op1 / Op2;
        else
            div_result <= 0;
    end
    
    // AND
    always @(Op1 or Op2)
    begin
        if (op_and == 1)
            and_result <= Op1 & Op2;
        else
            and_result <= 0;
    end
    
    // OR
    always @(Op1 or Op2)
    begin
        if (op_or == 1)
            or_result <= Op1 | Op2;
        else
            or_result <= 0;
    end
    
    // NOR
    always @(Op1 or Op2)
    begin
        if (op_nor == 1)
            nor_result <= ~(Op1 | Op2);
        else
            nor_result <= 0;
    end
    
    // XOR
    always @(Op1 or Op2)
    begin
        if (op_xor == 1)
            xor_result <= Op1 ^ Op2;
        else
            xor_result <= 0;
    end
        
    // Shifter Left
    always @(Op2 or SA)
    begin
        if (op_shiftl == 1)
            shiftl_result <= Op2 << SA;
        else
            shiftl_result <= 0;
    end
    
    // Shifter Right
    always @(Op2 or SA)
    begin
        if (op_shiftr == 1)
            shiftr_result <= Op2 >> SA;
        else
            shiftr_result <= 0;
    end
    
    always @(posedge Clk)
    begin
        if (Reset == 1)
            begin
                Result      <= 0;
                DstOut      <= 0;
                WriteBack   <= 0;   
            end
        else
            begin
                Result      <= add_result | sub_result | mult_result | div_result | and_result | or_result | nor_result | xor_result | shiftl_result | shiftr_result;
                DstOut      <= DstIn;
                WriteBack   <= Control[31];
            end
    end
endmodule
