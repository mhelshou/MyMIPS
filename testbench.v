`include "instruction_set.vh"

`define PGM_ARRAY_SIZE  1024

module MIPS_TEST();
    
    
    reg clk, reset;
    
    wire [31:0] iaddr, cpu_iaddr, inst, cpu_inst, daddr, data;
    wire        iread, iwrite, cpu_iread, cpu_iwrite, dread, dwrite, cpu_oe;

    integer i, data_file, scan_file;
    reg [31:0] testaddr, pgm_inst;
    reg test_override, test_write, OE;
    reg [31:0] program_memory[0:`PGM_ARRAY_SIZE-1];
    
    always #5 clk = ~clk;
    
    
    MIPS_CPU CPU(reset, clk, cpu_iaddr, cpu_inst, cpu_iread, cpu_iwrite, daddr, data, dread, dwrite, cpu_oe);
    
    assign iaddr = test_override? testaddr:cpu_iaddr;
    assign cpu_inst = inst;
    assign inst = test_override?pgm_inst:32'bZ;
    assign iwrite = test_override?test_write:cpu_iwrite;
    assign iread = test_override?1:cpu_iread;

    RAM IRAM(iaddr, inst, iread, iwrite, OE);
    RAM DRAM(daddr, data, dread, dwrite, cpu_oe);

    initial begin
        clk <= 0;
        reset <= 1;
        testaddr <= 0;
        test_override <= 1;
        test_write <= 1;
        OE <= 0;

        #100 for(i=0; i<`PGM_ARRAY_SIZE; i=i+1) begin        
            #10 pgm_inst <= program_memory[i];
            #10 test_write <= 0;
            #10 test_write <= 1;
            #10 testaddr <= testaddr + 1;
        end
            
        #10 test_override <= 0; OE <= 1;
        //#10 print_program_memory();
        
        #10 reset <= 0;        

        #4000 for (i=0; i<32; i=i+1) 
                if (i==0)
                    $display("Register R%d = 0x%x", i, 32'b0);
                else
                    $display("Register R%d = 0x%x", i, CPU.cpureg[i]);
        #1000 for(i=0; i<16; i=i+1)
                $display("Memory Address %02x = %d", i*4, DRAM.ramcells[i]);
        #10 $finish;
        
    end

    initial begin
        i = 0;
        
        data_file = $fopen("pgmmem.txt", "r");
        
        while (!$feof(data_file))
        begin
            scan_file = $fscanf(data_file, "%x\n", program_memory[i]);
            i = i+1;
        end
        
        for(i=i; i<`PGM_ARRAY_SIZE;i=i+1)
            program_memory[i] = 0;
    end
    
    always @ (negedge clk)
    begin
        //$display("The current fetched instruction is 0x%x", CPU.fetched);
        //$display("Result is 0x%x", CPU.result);
    end
//initial
//    begin
//        $dumpfile("test.vcd");
//        $dumpvars(0,clk);
//    end

task print_program_memory;
    // Test that RAM is written
    for(i=0; i<`PGM_ARRAY_SIZE; i=i+1) begin        
        $display("Data is 0x%x", IRAM.ramcells[i]);
    end
endtask

endmodule