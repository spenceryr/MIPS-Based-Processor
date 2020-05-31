

# extra scratch space needed, going to use the following
# function params: mask0 - 69, mask1 - 70, message[0] - 71, message[1] = 72
# function return parity: 73
# masked_message[0] - 74. masked_message[1] - 75, i - 76, one_constoreore - 77,

calculate_parity: subr $r1, $r1                            # parity = 0
subr $r2, $r2 
addi $r2, 1
shl $r2, 6
addi $r2, 7
addi $r2, 2                              # r2 shouload hoload value 73
store $r2, $r1 

subi $r2, 2                              # masked_message[0] = message[0] & mask0
load $r2, $r1 
subi $r2, 2
move $r3, $r2                              # r3 shouload hoload value 69 
load $r3, $r2 
and $r1, $r2
addi $r3, 5                              # r3 shouload hoload value 74
store $r3, $r1

subi $r3, 2                              # masked_mesage[1] = message[1] & mask1
load $r3, $r1 
subi $r3, 2
load $r3, $r2
and $r1, $r2
addi $r3, 5                              # r3 shouload hoload value 75
store $r3, $r1

subr $r4, $r4                            # i = 0
addi $r3, 1                              # r3 shouload hoload value 76
store $r3, $r4
move $r4, $r3                              # r4 shouload hoload value 76
loop1: subi $r4, 3                            # r4 shouload hoload value 73
  load $r4, $r1
  addi $r4, 1                            # r4 shouload hoload value 74
  load $r4, $r2                            # parity = parity ^ (masked_message[0] & 1)
  move $r3, $r2                            # save copy of masked_message[0] in r3 to shift later 
  andi $r2, 1
  xor $r1, $r2
  subi $r4, 1                            # r4 shouload hoload value 73
  store $r4, $r1

  shr $r3, 1                             # masked_message[0] = masked_message[0] >> 1
  addi $r4, 1                            # r4 shouload hoload value 74
  store $r4, $r3 


  addi $r4, 2                            # r4 shouload hoload value 76
  load $r4, $r1
  addi $r1, 1
  store $r4, $r1
  subi $r1, 7
  subi $r1, 1
  beqz loop2_init
  jmp loop1


loop2_init: subr $r1, $r1                        # i = 0
  store $r4, $r1

loop2: subi $r4, 3                            # r4 shouload hoload value 73
  load $r4, $r1
  addi $r4, 2                            # r4 shouload hoload value 75
  load $r4, $r2                            # parity = parity ^ (masked_message[0] & 1)
  move $r3, $r2                            # save copy of masked_message[0] in r3 to shift later 
  andi $r2, 1
  xor $r1, $r2
  subi $r4, 2                            # r4 shouload hoload value 73
  store $r4, $r1

  shr $r3, 1                             # masked_message[0] = masked_message[0] >> 1
  addi $r4, 2                            # r4 shouload hoload value 75
  store $r4, $r3 


  addi $r4, 1                            # r4 shouload hoload value 76
  load $r4, $r1                            # i++
  addi $r1, 1
  store $r4, $r1
  subi $r1, 7
  subi $r1, 1
  beqz done
  jmp loop2

  #done: ret


main: subr $r3, $r3             # storeore message[0] and message[1] as func call params
  load $r3, $r1 
  addi $r3, 1
  load $r3, $r2
  shl $r3, 6                 # r3 shouload contain 64
  addi $r3, 7                # r3 shouload contains 71
  store $r3, $r1 
  addi $r3, 1                # r3 shouload contain 72
  store $r3, $r2  


  # p8_mask0 - 60, p8_mask1 - 61, p8 - 79
  subr $r4, $r4 
  addi $r4, 3
  shl $r4, 4                 # r4 shouload be 48 
  addi $r4, 7                # r4 shouload be 56
  addi $r4, 5                # r4 shouload be 60
  load $r4, $r1                # r1 shouload contain p8_mask0 
  addi $r4, 1                # r4 shouload contain 61
  load $r4, $r2                # r2 shouload contain p8_mask1
  addi $r4, 7                # r4 shouload contain 68
  addi $r4, 1                # r4 shouload contain 69
  store $r4, $r1                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r4, $r2
  call calculate_parity


  subr $r4, $r4              # save result in correct location
  addi $r4, 1
  shl $r4, 6                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 71
  addi $r4, 2                # r4 shouload contain 73
  load $r4, $r1
  addi $r4, 6                # r4 shouload contain 79
  store $r4, $r1

  # p4_mask0 - 62, p4_mask1 - 63, p4 - 80
  subr $r4, $r4 
  shl $r4, 6                 # r4 shouload be 64 
  subi $r4, 2                # r4 shouload be 62
  load $r4, $r1                # r1 shouload contain p4_mask0 
  addi $r4, 1                # r4 shouload contain 63
  load $r4, $r2                # r2 shouload contain p4_mask1
  addi $r4, 5                # r4 shouload contain 69
  store $r4, $r1                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r4, $r2
  call calculate_parity

  subr $r4, $r4              # save result in correct location
  addi $r4, 1
  shl $r4, 6                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 71
  addi $r4, 2                # r4 shouload contain 73
  load $r4, $r1
  addi $r4, 7                # r4 shouload contain 80
  store $r4, $r1

  # p2_mask0 - 64, p2_mask1 - 65, p2 - 81
  subr $r4, $r4 
  shl $r4, 6                 # r4 shouload be 64 
  load $r4, $r1                # r1 shouload contain p4_mask0 
  addi $r4, 1                # r4 shouload contain 65
  load $r4, $r2                # r2 shouload contain p4_mask1
  addi $r4, 4                # r4 shouload contain 69
  store $r4, $r1                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r4, $r2
  call calculate_parity

  subr $r4, $r4              # save result in correct location
  addi $r4, 1
  shl $r4, 6                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 71
  addi $r4, 2                # r4 shouload contain 73
  load $r4, $r1
  addi $r4, 7                # r4 shouload contain 80
  addi $r4, 1                # r4 shouload contain 81
  store $r4, $r1

  # p1_mask0 - 66, p1_mask1 - 67, p1 - 82
  subr $r4, $r4 
  shl $r4, 6                 # r4 shouload be 64 
  addi $r4, 2                # r4 shouload be 66
  load $r4, $r1                # r1 shouload contain p4_mask0 
  addi $r4, 1                # r4 shouload contain 67
  load $r4, $r2                # r2 shouload contain p4_mask1
  addi $r4, 2                # r4 shouload contain 69
  store $r4, $r1                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r4, $r2
  call calculate_parity

  subr $r4, $r4              # save result in correct location
  addi $r4, 1
  shl $r4, 6                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 71
  addi $r4, 2                # r4 shouload contain 73
  load $r4, $r1
  addi $r4, 7                # r4 shouload contain 80
  addi $r4, 2                # r4 shouload contain 82
  store $r4, $r1

  # p0_mask0 - 68, p0_mask1 - 68, p0 - 83
  subr $r4, $r4 
  shl $r4, 6                 # r4 shouload be 64 
  addi $r4, 3                # r4 shouload be 67
  load $r4, $r1                # r1 shouload contain p4_mask0 
  addi $r4, 1                # r4 shouload contain 68
  load $r4, $r2                # r2 shouload contain p4_mask1
  addi $r4, 1                # r4 shouload contain 69
  store $r4, $r1                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r4, $r2
  call calculate_parity

  subr $r4, $r4              # save result in correct location
  addi $r4, 1
  shl $r4, 6                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 71
  addi $r4, 2                # r4 shouload contain 73
  load $r4, $r1
  addi $r4, 7                # r4 shouload contain 80
  addi $r4, 3                # r4 shouload contain 83
  store $r4, $r1

  subi $r4, 1                # po = p0 ^ p1 ^ p2 ^ p4 ^ p8
  load $r4, $r2 
  xor $r1, $r2 
  subi $r4, 1                # r4 now points to 81
  load $r4, $r2 
  xor $r1, $r2
  subi $r4, 1                # r4 now points to 80
  load $r4, $r2 
  xor $r1, $r2
  subi $r4, 1                # r4 now points to 79
  load $r4, $r2 
  xor $r1, $r2

  addi $r4, 4                # r4 now points to 83
  store $r4, $r1                # update p0 value  
  
