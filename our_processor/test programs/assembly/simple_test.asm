# r4 will be used to hold mem address

addi $r1, 7
subr $r1, $r1

# simple arithmetic 
addi $r1, 5
store $r1, $r4 # [0] = 5
addi $r4, 1

addi $r2, 7
subi $r2, 3
store $r2, $r4 # [1] = 4 
addi $r4, 1

subr $r1, $r2 
store $r1, $r4 # [2] = 1
addi $r4, 1

shl $r1, 4
store $r1, $r4 # [3] = 16
addi $r4, 1

shr $r1, 2
store $r1, $r4 # [4] = 4
addi $r4, 1

shr $r1, 1
store $r1, $r4 # [5] = 2
addi $r4, 1

shl $r1, 1
store $r1, $r4 # [6] = 4
addi $r4, 1 

addi $r2, 7 # r2 holds 11 at this point
move $r1, $r2
store $r1, $r4 # [7] = 11
addi $r4, 1

subr $r1, $r1
addi $r1, 2
shl $r1, 2
addi $r1, 2
shl $r1, 2
addi $r1, 2
shl $r1, 2
addi $r1, 2
store $r1, $r4 # [8] = 170
addi $r4, 1

subr $r2, $r2
addi $r2, 1
shl $r2, 2
addi $r2, 1
shl $r2, 2
addi $r2, 1
shl $r2, 2
addi $r2, 1
store $r2, $r4 # [9] = 85
addi $r4, 1

or $r1, $r2
store $r1, $r4 # [10] = 255
addi $r4, 1

subr $r2, $r2
addi $r2, 3
shl $r2, 4
addi $r2, 2
shl $r2, 2
addi $r2, 3
store $r2, $r4 # [11] = 203
addi $r4, 1

and $r1, $r2
store $r1, $r4 # [12] = 203
addi $r4, 1

andi $r1, 2
store $r1, $r4 # [13] = 2
addi $r4, 1

subr $r1, $r1
addi $r1, 3
shl $r1, 6
store $r1, $r4 # [14] = 192
addi $r4, 1

shl $r1, 1
shl $r1, 1
store $r1, $r4 # [15] = 1
addi $r4, 1


