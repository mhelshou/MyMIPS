// The Fetch module is simple, it either latches the output of the IRAM or outputs NOPs in case of a stall

module IFETCH(Reset, Clk, Inst, Stall, IRead, Fetched, Flush);
    input Reset, Clk;
    input [31:0] Inst;
    input Stall;
    output IRead;
    output reg [31:0] Fetched;
    output reg Flush;

    reg [31:0] iread;
    reg [2:0] flush_count;
    
    assign IRead = !Clk | Reset;
    
    // Flush the pipeline after Reset. Coming out of Reset always take a few clocks to clear the content of essential control signals.
    // This was needed because Fetching was depending on Stall but Stall was dependent on Fetch, so another signal is introduced to first
    // Make sure Stall is at a good level before proceeding
    always @ (posedge Clk)
    begin
        if (Reset == 1)
        begin
            Flush <= 1;
            flush_count <= 0;
        end
        else
        begin
            if ((Flush == 1) &(flush_count < 6))
                flush_count <= flush_count + 1;
            else
                Flush <= 0;
        end
    end
    
    always @ (negedge Clk)
    begin
        iread <= Inst;
    end

    always @ (posedge Clk)
    begin
        if ( (Reset == 1) | (Flush == 1) )
            Fetched <= 0;
        else if(Stall == 0)
            Fetched <= iread;
    end

endmodule