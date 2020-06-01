# extra scratch space needed, going to use the following
# function params: mask0 - 69 -> 195, mask1 - 70 -> 196, message[0] - 71 -> 197, message[1] = 72 -> 198
# function return parity: 73 -> 199
# masked_message[0] - 74 -> 200. masked_message[1] - 75 -> 201, i - 76 -> 202, one_constoreore - 77 -> 203

calculate_parity: subr $r1, $r1                            # parity = 0
subr $r2, $r2 
addi $r2, 6
shl $r2, 5
addi $r2, 7                              # r2 should hold value of 199
store $r1, $r2 

subi $r2, 2                              # masked_message[0] = message[0] & mask0
load $r1, $r2 
subi $r2, 2 # r2 = 69
move $r3, $r2                              # r3 shouload hoload value 69 
load $r2, $r3 # r2 contains mask0 
and $r1, $r2
addi $r3, 5                              # r3 shouload hoload value 74
store $r1, $r3

subi $r3, 2                              # masked_mesage[1] = message[1] & mask1, r3 contains 72, pc = 15
load $r1, $r3 
subi $r3, 2
load $r2, $r3
and $r1, $r2
addi $r3, 5                              # r3 shouload hoload value 75
store $r1, $r3

subr $r4, $r4                            # i = 0
addi $r3, 1                              # r3 shouload hoload value 76
store $r4, $r3
move $r4, $r3                              # r4 shouload hoload value 76
loop1: subi $r4, 3                            # r4 shouload hoload value 73, pc = 26
  load $r1, $r4
  addi $r4, 1                            # r4 shouload hoload value 74
  load $r2, $r4                            # parity = parity ^ (masked_message[0] & 1)
  move $r3, $r2                            # save copy of masked_message[0] in r3 to shift later 
  andi $r2, 1
  xor $r1, $r2
  subi $r4, 1                            # r4 shouload hoload value 73
  store $r1, $r4

  shr $r3, 1                             # masked_message[0] = masked_message[0] >> 1, pc = 35
  addi $r4, 1                            # r4 shouload hoload value 74
  store $r3, $r4

  addi $r4, 2                            # r4 shouload hoload value 76
  load $r1, $r4
  addi $r1, 1
  store $r1, $r4
  subi $r1, 7
  subi $r1, 1
  bneqz loop1

  subr $r1, $r1                        # i = 0, pc = 45
  store $r1, $r4

loop2: subi $r4, 3                            # r4 shouload hoload value 73, pc = 47
  load $r1, $r4
  addi $r4, 2                            # r4 shouload hoload value 75
  load $r2, $r4                            # parity = parity ^ (masked_message[0] & 1)
  move $r3, $r2                            # save copy of masked_message[0] in r3 to shift later 
  andi $r2, 1
  xor $r1, $r2
  subi $r4, 2                            # r4 shouload hoload value 73
  store $r1, $r4

  shr $r3, 1                             # masked_message[0] = masked_message[0] >> 1, pc = 56
  addi $r4, 2                            # r4 shouload hoload value 75
  store $r3, $r4

  addi $r4, 1                            # r4 shouload hoload value 76
  load $r1, $r4                            # i++
  addi $r1, 1
  store $r1, $r4
  subi $r1, 7
  subi $r1, 1
  bneqz loop2
  ret 0					 # 108, pc = 66
# 84 should hold data pointer
main: subr $r1, $r1  
  subr $r2, $r2
  subr $r3, $r3             # storeore message[0] and message[1] as func call params
  subr $r4, $r4

  addi $r4, 5    # r4 should contain 5
  shl $r4, 4     # r4 should contain 80
  addi $r4, 4    # r4 should contain 84
  load $r3, $r4  # r3 should hold index of next data

  load $r1, $r3 # r1 should hold LSB
  addi $r3, 1
  load $r2, $r3 # r2 should hold MSB
  addi $r3, 1
  store $r3, $r4 # store the new index for the next iteration, r4 should contain 84

  subr $r4, $r4 
  addi $r4, 6
  shl $r4, 5
  addi $r4, 5
  subi $r4, 6   # r4 should hold 197

  store $r1, $r4 
  addi $r4, 1                # r4 shouload contain 198
  store $r2, $r4  

  # p8_mask0 - 60, p8_mask1 - 61, p8 - 79
  subr $r4, $r4		     # pc = 85 
  addi $r4, 3
  shl $r4, 4                 # r4 shouload be 48 
  addi $r4, 7                # r4 shouload be 56
  addi $r4, 5                # r4 shouload be 60
  load $r1, $r4                # r1 shouload contain p8_mask0 
  addi $r4, 1                # r4 shouload contain 61
  load $r2, $r4                # r2 shouload contain p8_mask1
  
  subr $r4, $r4
  addi $r4, 6 
  shl $r4, 5
  addi $r4, 3                   # r4 shouload contain 195               
  store $r1, $r4                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r2, $r4
  call 0

  subr $r4, $r4              # save result in correct location, pc = 99
  addi $r4, 6
  shl $r4, 5                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 199
  load $r1, $r4
  subr $r4, $r4
  addi $r4, 5
  shl $r4, 4
  subi $r4, 1                # r4 shouload contain 79               
  store $r1, $r4

  # p4_mask0 - 62, p4_mask1 - 63, p4 - 80
  subr $r4, $r4 # pc = 107 
  addi $r4, 1 
  shl $r4, 6                 # r4 shouload be 64 
  subi $r4, 2                # r4 shouload be 62
  load $r1, $r4                # r1 shouload contain p4_mask0 
  addi $r4, 1                # r4 shouload contain 63
  load $r2, $r4                # r2 shouload contain p4_mask1

  subr $r4, $r4 
  addi $r4, 6
  shl $r4, 5
  addi $r4, 3                   # r4 shouload contain 195               
  store $r1, $r4                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r2, $r4
  call 1

  subr $r4, $r4              # save result in correct location, pc = 119
  addi $r4, 6
  shl $r4, 5                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 199               
  load $r1, $r4

  subr $r4, $r4 
  addi $r4, 5
  shl $r4, 4                # r4 shouload contain 80
  store $r1, $r4

  # p2_mask0 - 64, p2_mask1 - 65, p2 - 81
  subr $r4, $r4 # pc = 127
  addi $r4, 1 
  shl $r4, 6                 # r4 shouload be 64 
  load $r1, $r4                 # r1 shouload contain p4_mask0 
  addi $r4, 1                # r4 shouload contain 65
  load $r2, $r4                # r2 shouload contain p4_mask1

  subr $r4, $r4
  addi $r4, 6
  shl $r4, 5
  addi $r4, 3                # r4 shouload contain 195
  store $r1, $r4                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r2, $r4
  call 2

  subr $r4, $r4              # save result in correct location, pc = 138
  addi $r4, 6
  shl $r4, 5                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 199
  load $r1, $r4

  subr $r4, $r4 
  addi $r4, 5
  shl $r4, 4
  addi $r4, 1                # r4 shouload contain 81
  store $r1, $r4

  # p1_mask0 - 66, p1_mask1 - 67, p1 - 82
  subr $r4, $r4 # pc = 147
  addi $r4, 1 
  shl $r4, 6                 # r4 shouload be 64 
  addi $r4, 2                # r4 shouload be 66
  load $r1, $r4                # r1 shouload contain p4_mask0 
  addi $r4, 1                # r4 shouload contain 67
  load $r2, $r4                # r2 shouload contain p4_mask1

  subr $r4, $r4 
  addi $r4, 6
  shl $r4, 5
  addi $r4, 3                # r4 shouload contain 195
  store $r1, $r4                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r2, $r4
  call 3

  subr $r4, $r4              # save result in correct location, pc = 159
  addi $r4, 6
  shl $r4, 5                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 199              
  load $r1, $r4

  subr $r4, $r4 
  addi $r4, 5
  shl $r4, 4
  addi $r4, 2                # r4 shouload contain 82
  store $r1, $r4

  # p0_mask0 - 68, p0_mask1 - 68, p0 - 83
  subr $r4, $r4 # pc = 168
  addi $r4, 1 
  shl $r4, 6                 # r4 shouload be 64 
  addi $r4, 4                # r4 shouload be 68
  load $r1, $r4                # r1 shouload contain p4_mask0 

  subr $r4, $r4 
  addi $r4, 6
  shl $r4, 5
  addi $r4, 3                # r4 shouload contain 195
  store $r1, $r4                # storeore mask0 and mask1 for function call
  addi $r4, 1 
  store $r1, $r4
  call 4

  subr $r4, $r4              # save result in correct location, pc = 178
  addi $r4, 6
  shl $r4, 5                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 199                
  load $r1, $r4

  subr $r4, $r4
  addi $r4, 5
  shle $r4, 4
  addi $r4, 3                # r4 shouload contain 83
  store $r1, $r4

  subi $r4, 1                # p0 = p0 ^ p1 ^ p2 ^ p4 ^ p8, pc = 187
  load $r2, $r4  
  xor $r1, $r2 
  subi $r4, 1                # r4 now points to 81
  load $r2, $r4 
  xor $r1, $r2
  subi $r4, 1                # r4 now points to 80
  load $r2, $r4 
  xor $r1, $r2
  subi $r4, 1                # r4 now points to 79
  load $r2, $r4 
  xor $r1, $r2

  addi $r4, 4                # r4 now points to 83, pc = 199
  store $r1, $r4                # update p0 value 

  # create MSB with parity
  subr $r4, $r4  # pc = 201
  addi $r4, 5    # r4 should contain 5
  shl $r4, 4     # r4 should contain 80
  addi $r4, 4    # r4 should contain 84
  load $r2, $r4  # r2 should hold index + 2 for LSB of data
  subi $r2, 2
  load $r2, $r2  # message[0] in r2
  move $r3, $r2   # save a copy in r3
  load $r1, $r4   # r1 should hold index + 1 for MSB of data
  subi $r1, 1 
  load $r1, $r1  # message[1] in r1
  shl $r1, 5
  shr $r2, 3
  or $r1, $r2
  subr $r4, $r4
  addi $r4, 1
  shl $r4, 6    # r4 should hold 64
  addi $r4, 4   # r4 should hold 68
  load $r2, $r4 # r2 should contain mask 0xff
  subi $r2, 1
  and $r1, $r2
  addi $r4, 7   # r4 should contain 75
  addi $r4, 4   # r4 should contain 79
  load $r2, $r4 # pc = 224
  or $r1, $r2 
  addi $r4, 5
  load $r2, $r4  # load updated data index into r2, need to store into r2 + 29
  addi $r2, 7
  addi $r2, 7
  addi $r2, 7
  addi $r2, 7
  addi $r2, 1
  store $r1, $r2  # message[1] with parity stored

  move $r1, $r3   # move copy of message[0] back into r1, pc = 234
  shr $r1, 1      # knock off b1
  shl $r1, 5      # should be b4 b3 b2 0 0 0 0 0
  move $r2, $r3    #  move copy of message[0] into r2
  shl $r2, 7
  shr $r2, 4      # shift b1 into right spot, then combine
  or $r1, $r2

  # now put the rest of the parity bits in the right spot
  subr $r4, $r4
  addi $r4, 5
  shl $r4, 4    # r4 should contain 80, pc = 243
  load $r2, $r4  
  shl $r2, 4
  or $r1, $r2 
  addi $r4, 1   # r4 should contain 81
  load $r2, $r4   # r2 should hold p2
  shl $r2, 2
  or $r1, $r2  # pc = 250
  addi $r4, 1   # r4 should contain 82
  load $r2, $r4  # r2 should hold p1
  shl $r2, 1
  or $r1, $r2 
  addi $r4, 1   # r4 should contain 83
  load $r2, $r4 
  or $r1, $r2  # r1 should now contain message[0] with parity 

  # save message[0] with parity in memory 
  addi $r4, 1   # r4 should contain 84, pc = 258
  load $r2, $r4 # need to store value in r2 + 28
  addi $r2, 7
  addi $r2, 7
  addi $r2, 7
  addi $r2, 7
  store $r1, $r2

  # check to see if we need to iterate
  subr $r4, $r4
  addi $r4, 1
  shl $r4, 6
  addi $r4, 7
  addi $r4, 7
  addi $r4, 6
  load $r1, $r4  # r1 should hold index for next data

  subi $r1, 7 # pc = 271
  subi $r1, 7 
  subi $r1, 7
  subi $r1, 7
  subi $r1, 2
  bneqz main  # pc = 276





