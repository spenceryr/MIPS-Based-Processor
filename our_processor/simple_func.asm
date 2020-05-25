
main: addi $r2, 3
  addi $r2, 1
  call 1
  subi $r2, 4
  jmp done

test: load $r1, $r4 
  addi $r1, 1
  store $r1, $r4
  addi $r1, 2
  addi $r1, 3
  addi $r1, 7
  ret ret_label

done: subr $r2, $r2
