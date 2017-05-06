// TODO: add another for MemWr stage
module IREGUSAGE(ExRd, ExWb, WbRd, WbWb, ExRdOut, WbRdOut);
    input [4:0] ExRd, WbRd;
    input ExWb, WbWb;
    output reg [31:0] ExRdOut, WbRdOut;
   
    always @(ExRd or ExWb)
    begin
        if (ExWb == 1)
            case (ExRd)
                0 : ExRdOut <= 1<<0;
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

    always @(WbRd or WbWb)
    begin
        if (WbWb == 1)
            case (WbRd)
                0 : WbRdOut <= 1<<0;
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

    //TODO: Add another case for MemWr
endmodule