module RAM(Addr, Data, Read, Write, OE);

input   [31:0] Addr;
inout   [31:0] Data;
input	Read, Write, OE;

reg     [31:0] ramcells[0:1023];       // 1K x 32-bit 

reg     [31:0] dataout;
wire    [31:0] datain;

assign  datain = Data;
assign  Data = OE?dataout:32'bZ;

always @ (Read or Addr)
begin
    if (Read == 0)
        dataout <= ramcells[Addr[9:0]];    
end

always @ (posedge Write)
begin
    ramcells[Addr[9:0]] <= datain;
end

endmodule
