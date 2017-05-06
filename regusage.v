module IREGUSAGE(ExRd, ExWb, MemRd, MemWb, WbRd, WbWb, ExRdOut, MemRdOut, WbRdOut);
    input [4:0] ExRd, MemRd, WbRd;
    input ExWb, MemWb, WbWb;
    output reg [31:0] ExRdOut, MemRdOut, WbRdOut;
   
    always @(ExRd or ExWb)
    begin
        if (ExWb == 1)
            case (ExRd)
                0 : ExRdOut <= 0;
                1 : ExRdOut <= 1<<1 ;
                2 : ExRdOut <= 1<<2 ;
                3 : ExRdOut <= 1<<3 ;
                4 : ExRdOut <= 1<<4 ;
                5 : ExRdOut <= 1<<5 ;
                6 : ExRdOut <= 1<<6 ;
                7 : ExRdOut <= 1<<7 ;
                8 : ExRdOut <= 1<<8 ;
                9 : ExRdOut <= 1<<9 ;
                10: ExRdOut <= 1<<10;
                11: ExRdOut <= 1<<11;
                12: ExRdOut <= 1<<12;
                13: ExRdOut <= 1<<13;
                14: ExRdOut <= 1<<14;
                15: ExRdOut <= 1<<15;
                16: ExRdOut <= 1<<16;
                17: ExRdOut <= 1<<17;
                18: ExRdOut <= 1<<18;
                19: ExRdOut <= 1<<19;
                20: ExRdOut <= 1<<20;
                21: ExRdOut <= 1<<21;
                22: ExRdOut <= 1<<22;
                23: ExRdOut <= 1<<23;
                24: ExRdOut <= 1<<24;
                25: ExRdOut <= 1<<25;
                26: ExRdOut <= 1<<26;
                27: ExRdOut <= 1<<27;
                28: ExRdOut <= 1<<28;
                29: ExRdOut <= 1<<29;
                30: ExRdOut <= 1<<30;
                31: ExRdOut <= 1<<31;
            endcase
        else
            ExRdOut <= 0;
    end

    always @(MemRd or MemWb)
    begin
        if (MemWb == 1)
            case (MemRd)
                0 : MemRdOut <= 0;
                1 : MemRdOut <= 1<<1 ;
                2 : MemRdOut <= 1<<2 ;
                3 : MemRdOut <= 1<<3 ;
                4 : MemRdOut <= 1<<4 ;
                5 : MemRdOut <= 1<<5 ;
                6 : MemRdOut <= 1<<6 ;
                7 : MemRdOut <= 1<<7 ;
                8 : MemRdOut <= 1<<8 ;
                9 : MemRdOut <= 1<<9 ;
                10: MemRdOut <= 1<<10;
                11: MemRdOut <= 1<<11;
                12: MemRdOut <= 1<<12;
                13: MemRdOut <= 1<<13;
                14: MemRdOut <= 1<<14;
                15: MemRdOut <= 1<<15;
                16: MemRdOut <= 1<<16;
                17: MemRdOut <= 1<<17;
                18: MemRdOut <= 1<<18;
                19: MemRdOut <= 1<<19;
                20: MemRdOut <= 1<<20;
                21: MemRdOut <= 1<<21;
                22: MemRdOut <= 1<<22;
                23: MemRdOut <= 1<<23;
                24: MemRdOut <= 1<<24;
                25: MemRdOut <= 1<<25;
                26: MemRdOut <= 1<<26;
                27: MemRdOut <= 1<<27;
                28: MemRdOut <= 1<<28;
                29: MemRdOut <= 1<<29;
                30: MemRdOut <= 1<<30;
                31: MemRdOut <= 1<<31;
            endcase
        else
            MemRdOut <= 0;
    end

    always @(WbRd or WbWb)
    begin
        if (WbWb == 1)
            case (WbRd)
                0 : WbRdOut <= 0;
                1 : WbRdOut <= 1<<1 ;
                2 : WbRdOut <= 1<<2 ;
                3 : WbRdOut <= 1<<3 ;
                4 : WbRdOut <= 1<<4 ;
                5 : WbRdOut <= 1<<5 ;
                6 : WbRdOut <= 1<<6 ;
                7 : WbRdOut <= 1<<7 ;
                8 : WbRdOut <= 1<<8 ;
                9 : WbRdOut <= 1<<9 ;
                10: WbRdOut <= 1<<10;
                11: WbRdOut <= 1<<11;
                12: WbRdOut <= 1<<12;
                13: WbRdOut <= 1<<13;
                14: WbRdOut <= 1<<14;
                15: WbRdOut <= 1<<15;
                16: WbRdOut <= 1<<16;
                17: WbRdOut <= 1<<17;
                18: WbRdOut <= 1<<18;
                19: WbRdOut <= 1<<19;
                20: WbRdOut <= 1<<20;
                21: WbRdOut <= 1<<21;
                22: WbRdOut <= 1<<22;
                23: WbRdOut <= 1<<23;
                24: WbRdOut <= 1<<24;
                25: WbRdOut <= 1<<25;
                26: WbRdOut <= 1<<26;
                27: WbRdOut <= 1<<27;
                28: WbRdOut <= 1<<28;
                29: WbRdOut <= 1<<29;
                30: WbRdOut <= 1<<30;
                31: WbRdOut <= 1<<31;
            endcase
        else
            WbRdOut <= 0;
    end

endmodule