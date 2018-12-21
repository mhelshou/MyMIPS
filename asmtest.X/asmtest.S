.globl asmtest

#define base $1
#define val  $2
#define prev $3
#define res  $4
#define count $5
#define one  $6
asmtest:
bgez_test:
    lui     $1, 0x1111
    ori     $1, 0x1111
    bgez    $1, b1
    lui     $2, 0x2222
    ori     $2, 0x2222
b1:
    lui     $10, 0xABCD
    ori     $10, 0xEF01
    bgez    $10, b2
    lui     $3, 0x3333
    ori     $3, 0x3333
b2:
    lui     $11, 0
    bgez    $11, b3
    lui     $4, 0x4444
    ori     $4, 0x4444
b3:
    lui     $5, 0x5555
    ori     $5, 0x5555
beq_test:
    lui     $1, 0x1234
    beq     $0, $0, beqlbl
    lui     $2, 0xAAAA
    ori     $2, 0xBBBB
beqlbl:
    lui     $3, 0xAAAA
    ori     $3, 0xBBBB
jump_test:
    lui     $1, 0x1234
    addi    $1, 0x5
    j       ja
    lui     $2, 0xAAAA
    ori     $2, 0xBBBB
ja:
    lui     $3, 0xABCD
    ori     $3, 0xEF01
delay_slot_test:
    lui     $1, 0x1234
    ori     $1, 0x5678
    bne     $1, $0, take_branch
    lui     $2, 0xAAAA
    ori     $2, 0xBBBB
take_branch:
    lui     $3, 0xABCD
    ori     $3, 0xEF01

uncond_jump_test:
    lui     $1, 0x1234
    ori     $1, 0x5678
    j       j2
    nop
j2:
    lui     $2, 0xABCD
    ori     $2, 0xEF01
j1:
    lui     $3, 0xAAAA
    ori     $3, 0xBBBB

decimal_to_bin_loop:
    #lui     base, 0xA000
    #addi    base, 0x1000
    addi    base, $0, 0
    addiu    val, $0, 0xABCD
    clo     res, val
    addi    count, $0, 16
    addi    one, $0, 1
repeat:
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    sub     count, count, one
    bne     count, $0, repeat
    lui     $7, 0xDEAD
    ori     $7, 0xBEEF


branch_test:
    lui $1, 0x1234
    ori $1, 0x5678
    bne $1, $0, uncond
came_back:
    lui $3, 0xABCD
    ori $3, 0xEF01
    bne $1, $0, isequal
uncond:
    lui $2, 0x1111
    ori $2, 0x1111
    bne $1, $0, came_back
isequal:
    lui $4, 0xAAAA
    ori $4, 0xBBBB
decimal_to_bin:
    #lui     base, 0xA000
    #addi    base, 0x1000
    addi    base, $0, 0
    addi    val, $0, 0xABCD

    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1

    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1
    andi    res, val, 1
    sw      res, 0(base)
    addi    base, base, 4
    srl     val, val, 1

fibonacci:
    addi    base, $0, 0

    addi    val, $0, 1
    sw      val, 0(base)
    addi    base, base, 4
    sw      val, 0(base)
    addi    base, base, 4
    or      prev, val, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0

    add     res, val, prev
    sw      res, 0(base)
    addi    base, base, 4
    add     prev, val, $0
    add     val, res, $0
