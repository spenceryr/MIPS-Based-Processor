

prepare: addi $r3, 1
  store $r3, $r4 # [0] = 1
  addi $r3, 1
  addi $r4, 1
  store $r3, $r4 # [1] = 2
  addi $r3, 1
  addi $r4, 1
  store $r3, $r4 # [2] = 3
  addi $r3, 1
  addi $r4, 1
  store $r3, $r4 # [3] = 4
  addi $r3, 1
  addi $r4, 1
  subr $r3, $r3
  subr $r4, $r4

main: call 1 # instr 15
  addi $r4, 1
  subr $r1, $r1
  addi $r1, 7
  subr $r1, $r1
  call 2
  addi $r4, 1
  subr $r1, $r1
  addi $r1, 7
  subr $r1, $r1
  call 3
  addi $r4, 1
  subr $r1, $r1
  addi $r1, 7
  subr $r1, $r1
  call 4
  jmp done

inc: load $r1, $r4  # 32
  addi $r1, 7
  store $r1, $r4
  ret 0

done: subr $r1, $r1  # 36
  subr $r2, $r2
  subr $r3, $r3
  subr $r4, $r4
