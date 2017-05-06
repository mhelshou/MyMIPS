module ramtest();
    reg [31:0] addr, dataout;
    wire [31:0] data, datain;
    reg read, write, NOE;
    reg [31:0] val;

    integer i;
    
    RAM TestRAM(addr, data, read, write);
    
    assign data = NOE?32'bZ:dataout;
    assign datain = data;

    initial begin
        read = 1;
        write = 1;
        val = 12345678;
        addr = 0;
        NOE = 1;
        
        // Write Loop
        for(i=0; i<16; i=i+1) begin
            #10 dataout <= val;
            #10 NOE <= 0;
            #10 write <= 0;
            #10 write <= 1;
            #10 val <= val + 1;
            #10 addr <= addr + 1;
            #10 NOE <= 1;
        end
        
        #10 addr <= 0;
        #10 dataout <= 32'bZ;
        
        // Read Loop
        for(i=0; i<16; i=i+1) begin
            #10 read <= 0;
            #10 $display("Data = %d", datain);
            #10 read <= 1;
            #10 addr <= addr + 1;
        end
        $finish;
    end
endmodule
