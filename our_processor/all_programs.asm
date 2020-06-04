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
loop1: subi $r4, 3                            # r4 shouload hoload value 73, pc = 25
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

  subr $r1, $r1                        # i = 0, pc = 44
  store $r1, $r4

loop2: subi $r4, 3                            # r4 shouload hoload value 73, pc = 46
  load $r1, $r4
  addi $r4, 2                            # r4 shouload hoload value 75
  load $r2, $r4                            # parity = parity ^ (masked_message[0] & 1)
  move $r3, $r2                            # save copy of masked_message[0] in r3 to shift later
  andi $r2, 1
  xor $r1, $r2
  subi $r4, 2                            # r4 shouload hoload value 73
  store $r1, $r4

  shr $r3, 1                             # masked_message[0] = masked_message[0] >> 1, pc = 55
  addi $r4, 2                            # r4 shouload hoload value 75
  store $r3, $r4

  addi $r4, 1                            # r4 shouload hoload value 76
  load $r1, $r4                            # i++
  addi $r1, 1
  store $r1, $r4
  subi $r1, 7
  subi $r1, 1
  bneqz loop2
  ret 					 # 108, pc = 65
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
  addi $r4, 5  # r4 should hold 197
  # subi $r4, 6

  store $r1, $r4
  addi $r4, 1                # r4 shouload contain 198
  store $r2, $r4

  # p8_mask0 - 60, p8_mask1 - 61, p8 - 79
  subr $r4, $r4		     # pc = 87
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
  call p1_return1

p1_return1:
  subr $r4, $r4              # save result in correct location, pc = 103
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
  subr $r4, $r4 # pc = 113
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
  call p1_return2

p1_return2:
  subr $r4, $r4              # save result in correct location, pc = 128
  addi $r4, 6
  shl $r4, 5                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 199
  load $r1, $r4

  subr $r4, $r4
  addi $r4, 5
  shl $r4, 4                # r4 shouload contain 80
  store $r1, $r4

  # p2_mask0 - 64, p2_mask1 - 65, p2 - 81
  subr $r4, $r4 # pc = 137
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
  call p1_return3

p1_return3:
  subr $r4, $r4              # save result in correct location, pc = 151
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
  subr $r4, $r4 # pc = 161
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
  call p1_return4

p1_return4:
  subr $r4, $r4              # save result in correct location, pc = 176
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
  subr $r4, $r4 # pc = 186
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
  call p1_return5

  p1_return5:
  subr $r4, $r4              # save result in correct location, pc = 178
  addi $r4, 6
  shl $r4, 5                 # r4 shouload contain 64
  addi $r4, 7                # r4 shouload contain 199
  load $r1, $r4

  subr $r4, $r4
  addi $r4, 5
  shl $r4, 4
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

  addi $r4, 4                # r4 now points to 83, pc = 221
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
  subr $r4, $r4
  subr $r1, $r1
  addi $r4, 3
  shl $r4, 5
  addi $r4, 7
  shl $r4, 1
  addi $r4, 4 # 210
  store $r1, $r4
  main2: subr $r4, $r4
    subr $r1, $r1
    subr $r2, $r2
    subr $r3, $r3
    addi $r1, 3
    shl $r1, 5
    addi $r1, 6
    shl $r1, 1 # 204
    load $r4, $r1
    store $r2, $r4
    subr $r4, $r4
    addi $r1, 1 # 205
    store $r4, $r1
    addi $r1, 1 # 206
    store $r4, $r1
    addi $r1, 1 # 207
    store $r4, $r1
    addi $r1, 1 # 208
    store $r4, $r1
    subr $r1, $r1
    addi $r4, 7
    shl $r4, 5 # 224
    addi $r1, 1
    shl $r1, 5
    subi $r1, 2 # 30
    addr $r4, $r1 # 254
    subr $r1, $r1
    addi $r1, 3
    shl $r1, 6
    addi $r1, 3 # 195
    store $r4, $r1
    addi $r4, 1 # 255
    addi $r1, 1 # 196
    store $r4, $r1
    move $r4, $r1
    addi $r4, 7 # 203
    load $r2, $r4 # first pointer to message byte loaded
    load $r3, $r2 # first message byte loaded
    addi $r1, 1 # 197
    store $r3, $r1
    addi $r2, 1
    load $r3, $r2 # second message byte loaded
    addi $r1, 1 # 198
    store $r3, $r1
    call return_point_1
    return_point_1: subr $r1, $r1
    addi $r1, 3
    shl $r1, 6
    addi $r1, 7 # 199
    load $r4, $r1 # Load function result
    move $r2, $r1
    addi $r2, 4 # 203
    load $r3, $r2 # first pointer to message byte loaded
    load $r3, $r3 # first message byte loaded
    andi $r3, 1
    xor $r3, $r4 # p0 ^ func_result
    addi $r2, 2 # 205
    store $r3, $r2 # Store
    addi $r2, 1 # 206
    store $r3, $r2
    subr $r4, $r4
    addi $r2, 2 # 208
    store $r4, $r2
    loop_parity: subr $r1, $r1
      subr $r4, $r4
      subr $r2, $r2
      subr $r3, $r3
      addi $r1, 3
      shl  $r1, 6
      addi $r1, 3 # 195
      move $r2, $r1
      addi $r2, 7 # 202
      addi $r2, 6 # 208
      load $r2, $r2
      subi $r2, 0
      bneqz calc_second_1
        addi $r4, 5
        shl $r4, 5
        addi $r4, 7
        addi $r4, 1 # 168
        subr $r2, $r2
        addi $r2, 2 # 2
        jmp store_second
      calc_second_1: subi $r2, 1
        bneqz calc_second_2
        move $r4, $r1
        addi $r4, 5 # 200
        subr $r2, $r2
        addi $r2, 4 # 4
        jmp store_second
      calc_second_2: addi $r2, 1
        subi $r2, 2
        bneqz calc_second_3
        addi $r4, 7
        shl $r4, 5 # 224
        subr $r2, $r2
        addi $r2, 1
        shl $r2, 4 # 16
        jmp store_second
      calc_second_3: subr $r2, $r2
        subi $r2, 2
      store_second: store $r4, $r1
      addr $r4, $r2
      addi $r1, 1 # 196
      store $r4, $r1
      move $r4, $r1
      addi $r4, 7 # 203
      load $r2, $r4 # first pointer to message byte loaded
      load $r3, $r2 # first message byte loaded
      addi $r1, 1 # 197
      store $r3, $r1
      addi $r2, 1
      load $r3, $r2 # second message byte loaded
      addi $r1, 1 # 198
      store $r3, $r1
      call return_point_2
      return_point_2: addi $r1, 3
      shl $r1, 6
      addi $r1, 7 # 199
      move $r2, $r1
      addi $r2, 4 # 203
      load $r3, $r2 # first pointer to message byte loaded
      move $r4, $r3
      load $r3, $r3 # first message byte loaded
      addi $r2, 5 # 208
      load $r2, $r2
      subi $r2, 0
      bneqz p_1
        shr $r3, 1
        jmp calc_incorrect
        move $r4, $r4 # dummy instruction to make rel jumps same here
      p_1: subi $r2, 1
        bneqz p_2
        addi $r2, 1
        shr $r3, 2
        jmp calc_incorrect
      p_2: subi $r2, 1
        bneqz p_3
        addi $r2, 2
        shr $r3, 4
        jmp calc_incorrect
      p_3: addi $r2, 2
        addi $r4, 1
        load $r3, $r4
      calc_incorrect: load $r4, $r1
      andi $r3, 1
      xor $r3, $r4 # p ^  calc_p
      addi $r1, 7 # 206
      load $r4, $r1
      or $r4, $r3
      store $r4, $r1
      addi $r1, 1 # 207
      load $r4, $r1
      rshl $r3, $r2
      or $r4, $r3
      store $r4, $r1
      move $r4, $r2
      addi $r2, 1
      addi $r1, 1 # 208
      move $r3, $r1
      store $r2, $r1
      subi $r2, 7
      subi $r2, 2
      subi $r4, 3
      bneqz loop_parity
    subi $r3, 1 # 207
    load $r2, $r3 # contains "needs_fixing"
    load $r4, $r3 # contains "needs_fixing"
    subi $r3, 7 # 200
    subi $r3, 3 # 197
    shr $r2, 3
    addr $r3, $r2
    load $r1, $r3
    andi $r4, 7
    subr $r2, $r2
    addi $r2, 1
    rshl $r2, $r4
    xor $r1, $r2
    store $r1, $r3
    subr $r3, $r3
    addi $r3, 6
    shl $r3, 1
    addi $r3, 1
    shl $r3, 4 # 208
    subr $r4, $r4
    store $r4, $r3
    addi $r3, 1 # 209
    store $r4, $r3
    loop_3_bits: subr $r3, $r3
      addi $r3, 1
      shl $r3, 3
      addi $r3, 5
      shl $r3, 4 # 208
      load $r4, $r3 # contains i
      subr $r1, $r1
      addi $r1, 3
      subr $r1, $r4
      beqz loop_bits
      subi $r3, 7
      subi $r3, 4 # 197
      load $r4, $r3
      addi $r3, 1
      load $r1, $r3
      shr $r1, 1
      shr $r4, 1
      store $r1, $r3
      subi $r3, 1
      store $r4, $r3
      addi $r3, 7
      addi $r3, 4 # 208
      load $r4, $r3 # load i
      addi $r4, 1
      store $r4, $r3
      jmp loop_3_bits
    loop_bits: subr $r3, $r3
      addi $r3, 1
      shl $r3, 3
      addi $r3, 5
      shl $r3, 4 # 208
      load $r4, $r3 # contains i
      subr $r1, $r1
      addi $r1, 1
      shl $r1, 4 # 16
      subr $r1, $r4
      beqz loop_bits_end
      subr $r1, $r1
      addi $r1, 4
      move $r2, $r1
      xor $r1, $r4 # i ^ 4
      beqz shift_msg
      shl $r2, 1
      xor $r2, $r4 # i ^ 8
      beqz shift_msg
      addi $r3, 1 # 209
      load $r1, $r3 # j
      subi $r3, 7
      subi $r3, 5 # 197
      load $r2, $r3 # message[0]
      andi $r2, 1
      andi $r1, 7
      rshl $r2, $r1 # ((message[0] & 1) << (j & 7))
      addi $r3, 7 # 204
      load $r4, $r3 # new_message pointer loaded
      addi $r3, 5 # 209
      load $r1, $r3
      shr $r1, 3
      addr $r4, $r1 # new_message + (j >> 3)
      load $r1, $r4 # *(new_message + (j >> 3))
      or $r1, $r2 # new_message[j >> 3] | ((message[0] & 1) << (j & 7))
      store $r1, $r4
      load $r4, $r3 # j
      addi $r4, 1 # j + 1
      store $r4, $r3 # j++
      shift_msg: subr $r3, $r3
      addi $r3, 3
      shl $r3, 6
      addi $r3, 5 # 197
      load $r4, $r3
      addi $r3, 1 # 198
      load $r1, $r3
      shr $r1, 1
      shr $r4, 1
      store $r1, $r3
      subi $r3, 1 # 197
      store $r4, $r3
      addi $r3, 7
      addi $r3, 4 # 208
      load $r4, $r3 # load i
      addi $r4, 1
      store $r4, $r3
      jmp loop_bits
    loop_bits_end: subi $r3, 3 # 205
    load $r4, $r3 # (p0 ^ calc_p0)
    addi $r3, 1 # 206
    load $r1, $r3 # "incorrect"
    xor $r4, $r1
    addr $r1, $r4
    shl $r1, 6
    subi $r3, 2 # 204
    load $r4, $r3
    addi $r4, 1
    load $r2, $r4
    or $r2, $r1
    store $r2, $r4
    subi $r3, 1 # 203
    load $r4, $r3
    addi $r4, 2
    store $r4, $r3
    addi $r3, 1 # 204
    load $r4, $r3
    addi $r4, 2
    store $r4, $r3
    addi $r3, 6 # 210
    load $r4, $r3
    addi $r4, 1
    store $r4, $r3
    subr $r1, $r1
    addi $r1, 1
    shl $r1, 4
    subi $r1, 1 # 15
    subr $r1, $r4
    bneqz main2
  # Storing locations
  # [203] = 64, pointer to where parity message is located
  # [204] = 94, pointer to where to place de-paritied, fixed messages
  # Scratch work
  # [205] = Where to store p0 ^ calc_p0
  # [206] = Where to store "incorrect" variable
  # [207] = Where to store "needs_fixing" variable
  # [208] = Where to store "i" for looping parity bits 1-3/looping over all bits in message
  # [209] = Where to store "j" for tracking which bit in message
  # [210] = Where to store "k" for looping main 15 times




  # can use 0-15 for scratch space
  # withinBytesCounter stored in 0
  # anywhereCounter stored in 1
  # numBytes stored in 2
  # i counter stored at 3
  # j counter stored at 4
  # mask stored at 5
  # bytePointer stored at 6
  # WITHIN_BOUNDS_MASK stored at 7
  # UPPER_FIVE_BITS_MASK stored at 8
  # temp data 1 stored at 9
  # temp data 2 stored at 10
  # foundWithinByte stored at 11

  # clear everything and load in data
  p3_main:subr $r1, $r1
    subr $r2, $r2
    subr $r3, $r3
    subr $r4, $r4
    addi $r4, 4     # init j to 0
    store $r1, $r4
    addi $r4, 2     # r4 should hold 6 at this point
    load $r3, $r4   # r3 should hold address of first byte of data
    load $r1, $r3   # r1 should hold first byte of data at this point
    addi $r3, 1     # r3 shold hold address of second byte of data
    load $r2, $r3
    addi $r4, 3     # r4 shold hold 9 at this point
    store $r1, $r4  # store first byte of data in scratch space
    addi $r4, 1     # r4 should hold 10 at this point
    store $r2, $r4  # store second byte of data in scratch space

  # at start of loop, first byte is in r1 and second byte is in r2
  bit_loop: subr $r4, $r4     # pc = 15
    addi $r4, 7
    addi $r4, 1     # r4 should hold 8 at this point
    load $r2, $r4   # load in mask to get the 5 bits we are comparing
    addi $r4, 1
    load $r1, $r4
    and $r1, $r2

    subi $r4, 4     # r4 should hold 5 at this point
    shl $r4, 5      # r4 should hold 160 at this point
    load $r2, $r4   # r2 should hold the pattern
    subr $r1, $r2
    bneqz after_pattern_match     # if the data does not match the pattern, go to end of loop

    subr $r4, $r4   # pc = 27
    addi $r4, 4     # r4 should hold 4 at this point
    load $r1, $r4   # load in value of j
    addi $r4, 3     # r4 should hold 7 at this point
    load $r2, $r4   # load in WITHIN_BOUNDS_MASK
    and $r1, $r2
    bneqz inc_anywhere_counter

    # increment byteCounter and set foundWithinByte to 1
    subr $r4, $r4   # pc = 34
    load $r1, $r4
    addi $r1, 1         # increment byteCounter and store
    store $r1, $r4
    addi $r4, 7         # r4 should hold 7
    addi $r4, 4         # r4 should hold 11
    subr $r1, $r1
    addi $r1, 1
    store $r1, $r4      # set foundWithinByte to 1 and store

  inc_anywhere_counter: subr $r4, $r4     # pc = 43
    addi $r4, 1         # r4 should hold 1 at this point
    load $r1, $r4
    addi $r1, 1
    store $r1, $r4

  after_pattern_match: subr $r4, $r4       # shift data bytes by 1 and store back in memory
    addi $r4, 7
    addi $r4, 2         # r4 should hold 9
    load $r1, $r4
    addi $r4, 1         # r4 should hold 10, pc = 52
    load $r2, $r4
    shl $r2, 1
    shl $r1, 1
    store $r2, $r4
    subi $r4, 1         # r4 should hold value 9
    store $r1, $r4

    # load in value of j and see if we need to loop again
    subi $r4, 5         # r4 should hold value 4
    load $r1, $r4       # r1 should hold value of j
    addi $r1, 1
    store $r1, $r4    # pc = 62
    subi $r1, 7
    subi $r1, 1
    bneqz bit_loop

    # increment numBytes if needed and increment bytePtr
    addi $r4, 7         # r4 should hold value of 11
    load $r1, $r4       # r1 should hold foundWithinByte
    subi $r1, 1
    bneqz after_byte_check
    store $r1, $r4    # set foundWithinByte to 0
    subi $r4, 7       # r4 should hold 4
    subi $r4, 2       # r4 should hold 2, pc = 72
    load $r1, $r4     # inc numByte
    addi $r1, 1
    store $r1, $r4


  after_byte_check: subr $r4, $r4
    addi $r4, 6      # r4 should hold 6
    load $r1, $r4    # inc bytePointer to the next data byte
    addi $r1, 1
    store $r1, $r4

    # inc i and check if we need to loop again
    subi $r4, 3        # r4 should now point to 3
    load $r1, $r4    # pc = 82
    addi $r1, 1
    store $r1, $r4
    subi $r1, 7
    subi $r1, 7
    subi $r1, 7
    subi $r1, 7
    subi $r1, 3
    bneqz p3_main

  # do pattern check over only the last byte
  last_byte: subr $r1, $r1
    subr $r2, $r2   # pc = 92
    subr $r3, $r3
    subr $r4, $r4
    addi $r4, 4     # init j to 0
    store $r1, $r4
    addi $r4, 2     # r4 should hold 6 at this point
    load $r3, $r4   # r3 should hold address of the last byte of data
    load $r1, $r3
    addi $r4, 3     # r4 should hold 9 at this point
    store $r1, $r4

  last_byte_bit_loop: subr $r4, $r4
    addi $r4, 7     # r4 should hold 7, pc = 102
    addi $r4, 2     # r4 should hold 2
    load $r1, $r4   # r1 should hold data byte
    subi $r4, 1     # r4 should hold 8
    load $r2, $r4   # r2 should hold UPPER_FIVE_BIST_MASK
    move $r3, $r1
    and $r1, $r2

    # load in the pattern
    subi $r4, 3     # r4 should hold 5 at this point
    shl $r4, 5      # r4 should hold 160 at this point
    load $r2, $r4   # r2 should hold the pattern
    subr $r1, $r2    # pc = 112
    bneqz after_last_pattern_check
    subr $r4, $r4

    load $r1, $r4
    addi $r1, 1
    store $r1, $r4
    addi $r4, 1     # r4 should hold 1 at this point
    load $r1, $r4
    addi $r1, 1
    store $r1, $r4
    addi $r4, 7     # r4 should hold 8 at this point, pc = 122
    addi $r4, 3     # r4 should hold 11 at this point
    load $r1, $r4
    subr $r1, $r1
    addi $r1, 1
    store $r1, $r4


  # shift data byte and update
  after_last_pattern_check: subr $r4, $r4
    addi $r4, 7
    addi $r4, 2       # r4 should hold 9 at this point, pc = 128
    load $r1, $r4
    shl $r1, 1
    store $r1, $r4

    # inc j and check if we need to loop again
    subi $r4, 5       # r4 should hold 4 at this point, pc = 132
    load $r1, $r4
    addi $r1, 1
    store $r1, $r4
    subi $r1, 4
    bneqz last_byte_bit_loop

    # check foundWithinByte and inc numBytes if needed
    addi $r4, 7       # r4 should contain 11 at this point
    load $r1, $r4
    subi $r1, 1
    bneqz p3_done
    subi $r4, 7       # r4 should hold 4 at this point, pc = 142
    subi $r4, 2       # r4 should hold 2 at this point
    load $r1, $r4
    addi $r1, 1
    store $r1, $r4


    # move counters to right memory locations
    p3_done: subr $r4, $r4
      load $r1, $r4     # wihtinByte stored in r1
      addi $r4, 1       # r4 should contain 1
      load $r2, $r4     # r2 should contain anywhereCounter
      addi $r4, 1       # r4 should contain 2
      load $r3, $r4     # r3 should contain numBytes, pc = 152

      addi $r4, 1       # r4 should contain 3
      shl $r4, 6        # r4 should contain 192
      store $r1, $r4
      addi $r4, 1       # r4 should contain 193
      store $r3, $r4
      addi $r4, 1       # r4 should contain 194
      store $r2, $r4   # pc = 159
