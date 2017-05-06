.globl asmtest

#define base $1
#define val  $2
#define prev $3
#define res  $4

asmtest:

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
