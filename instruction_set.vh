// Opcodes

// Types
`define REGINST 2'b01
`define IMMINST 2'b10
`define JMPINST 2'b11

// NOP
`define NOP     0

// Register Opcode (SPECIAL == 0)
`define SPECIAL 6'b000000

// Arithmetic
`define ADD     6'b100000
`define ADDU    6'b100001
`define SUB     6'b100010
`define SUBU    6'b100011
`define MULT    6'b011000
`define MULTU   6'b011001
`define DIV     6'b011010
`define DIVU    6'b011011

// Logic
`define AND     6'b100100
`define OR      6'b100101
`define NOR     6'b100111
`define XOR     6'b100110

// Shift
`define SLL     6'b000000
`define SLLV    6'b000100
`define SRA     6'b000011
`define SRAV    6'b000111
`define SRL     6'b000010
`define SRLV    6'b000110

`define SLT     6'b101010
`define SLTU    6'b101011
`define MOVZ    6'b001010

// Immediate Opcodes
`define LUI     6'b001111
`define ORI     6'b001101
`define ADDI    6'b001000
`define ADDIU   6'b001001
`define ANDI    6'b001100

// Load/Store Opcodes
`define LW		6'b100011
`define SW		6'b101011

// Branch Opcodes
`define BE      6'b000100
`define BNE     6'b000101
`define BGEZ    6'b000001

// Jump Instructions
`define J       6'b000010

// Control Operations
`define OP_UNSIGNED (1<<0)
`define OP_ADD      (1<<1)
`define OP_SUB      (1<<2)
`define OP_MULT     (1<<3)
`define OP_DIV      (1<<4)
`define OP_AND      (1<<5)
`define OP_OR       (1<<6)
`define OP_NOR      (1<<7)
`define OP_XOR      (1<<8)

`define OP_SHIFTL   (1<<9)
`define OP_SHIFTR   (1<<10)
`define OP_SHFAR    (1<<11)
`define OP_SHFVAR   (1<<12)

`define OP_LOAD		(1<<13)
`define OP_STORE	(1<<14)

`define OP_BRANCH   (1<<15)
`define OP_CMPEQ    (1<<16)
`define OP_COMPCOND (1<<17)

`define OP_JUMP     (1<<18)

`define OP_TESTNEG  (1<<19)
`define OP_TESTPOS  (1<<20)
`define OP_TESTZ    (1<<21)
`define OP_TESTNZ   (1<<22)

// Assembly Instructions
// Arithmetic
`define I_ADD       `ADD  
`define I_ADDU      `ADDU 
`define I_SUB       `SUB  
`define I_SUBU      `SUBU 
`define I_MULT      `MULT 
`define I_MULTU     `MULTU
`define I_DIV       `DIV  
`define I_DIVU      `DIVU 
                
// Logic        
`define I_AND       `AND 
`define I_OR        `OR  
`define I_NOR       `NOR 
`define I_XOR       `XOR 
                
// Shift        
`define I_SLL       `SLL 
`define I_SLLV      `SLLV
`define I_SRA       `SRA 
`define I_SRAV      `SRAV
`define I_SRL       `SRL 
`define I_SRLV      `SRLV
                
`define I_SLT       `SLT 
`define I_SLTU      `SLTU
`define I_MOVZ      `MOVZ

// Immediate
`define I_LUI       (`LUI<<26)
`define I_ORI       (`ORI<<26)

// Registers
// rs field
`define RS0         (0  << 21)
`define RS1         (1  << 21)
`define RS2         (2  << 21)
`define RS3         (3  << 21)
`define RS4         (4  << 21)
`define RS5         (5  << 21)
`define RS6         (6  << 21)
`define RS7         (7  << 21)
`define RS8         (8  << 21)
`define RS9         (9  << 21)
`define RS10        (10 << 21)
`define RS11        (11 << 21)
`define RS12        (12 << 21)
`define RS13        (13 << 21)
`define RS14        (14 << 21)
`define RS15        (15 << 21)
`define RS16        (16 << 21)
`define RS17        (17 << 21)
`define RS18        (18 << 21)
`define RS19        (19 << 21)
`define RS20        (20 << 21)
`define RS21        (21 << 21)
`define RS22        (22 << 21)
`define RS23        (23 << 21)
`define RS24        (24 << 21)
`define RS25        (25 << 21)
`define RS26        (26 << 21)
`define RS27        (27 << 21)
`define RS28        (28 << 21)
`define RS29        (29 << 21)
`define RS30        (30 << 21)
`define RS31        (31 << 21)

// rt field
`define RT0         (0  << 16)
`define RT1         (1  << 16)
`define RT2         (2  << 16)
`define RT3         (3  << 16)
`define RT4         (4  << 16)
`define RT5         (5  << 16)
`define RT6         (6  << 16)
`define RT7         (7  << 16)
`define RT8         (8  << 16)
`define RT9         (9  << 16)
`define RT10        (10 << 16)
`define RT11        (11 << 16)
`define RT12        (12 << 16)
`define RT13        (13 << 16)
`define RT14        (14 << 16)
`define RT15        (15 << 16)
`define RT16        (16 << 16)
`define RT17        (17 << 16)
`define RT18        (18 << 16)
`define RT19        (19 << 16)
`define RT20        (20 << 16)
`define RT21        (21 << 16)
`define RT22        (22 << 16)
`define RT23        (23 << 16)
`define RT24        (24 << 16)
`define RT25        (25 << 16)
`define RT26        (26 << 16)
`define RT27        (27 << 16)
`define RT28        (28 << 16)
`define RT29        (29 << 16)
`define RT30        (30 << 16)
`define RT31        (31 << 16)

// rd field
`define RD0         (0  << 11)
`define RD1         (1  << 11)
`define RD2         (2  << 11)
`define RD3         (3  << 11)
`define RD4         (4  << 11)
`define RD5         (5  << 11)
`define RD6         (6  << 11)
`define RD7         (7  << 11)
`define RD8         (8  << 11)
`define RD9         (9  << 11)
`define RD10        (10 << 11)
`define RD11        (11 << 11)
`define RD12        (12 << 11)
`define RD13        (13 << 11)
`define RD14        (14 << 11)
`define RD15        (15 << 11)
`define RD16        (16 << 11)
`define RD17        (17 << 11)
`define RD18        (18 << 11)
`define RD19        (19 << 11)
`define RD20        (20 << 11)
`define RD21        (21 << 11)
`define RD22        (22 << 11)
`define RD23        (23 << 11)
`define RD24        (24 << 11)
`define RD25        (25 << 11)
`define RD26        (26 << 11)
`define RD27        (27 << 11)
`define RD28        (28 << 11)
`define RD29        (29 << 11)
`define RD30        (30 << 11)
`define RD31        (31 << 11)
