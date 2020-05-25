# r4 will be used as counter
# count the number of 1's and 0's in memory 0-7
# r1 will hols number of 0's and r2 will hold number of 1's

# prepare memory
# this label should have no effect
prepare: addi $r1, 1 # 0
  store $r1, $r4 # [0] = 1
  addi $r4, 1
  store $r1, $r4 # [1] = 1
  addi $r4, 3
  store $r1, $r4 # [4] = 1
  addi $r4, 2
  store $r1, $r4 # [6] = 1
  addi $r4, 1 # [7] = 1
  subr $r1, $r1
  subr $r4, $r4

loop: load $r3, $r4 # 11
  subi $r3, 0
  beqz is_zero
  jmp is_one
  addi $r1, 7
  addi $r1, 7
  
is_zero: addi $r1, 1 # 17
  jmp check
is_one: addi $r2, 1 # 19

check: addi $r4, 1 # 20
  move $r3, $r4
  subi $r3, 7
  subi $r3, 1
  beqz done
  jmp loop

skip_this: addi $r1, 7
  addi $r1, 7
  addi $r1, 7


done: subr $r3, $r3
  subr $r4, $r4



