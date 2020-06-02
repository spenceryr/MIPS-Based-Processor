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
  subi $r4, 1 # 255
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
  return_point_1: addi $r1, 3
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
  subr $r4, $r4
  addi $r2, 3 # 208
  store $r4, $r2
  loop_parity: subi $r1, 4 # 195
    subr $r4, $r4
    subr $r2, $r2
    subr $r3, $r3
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
    calc_second_3: addi $r2, 7
      shl $r2, 3
      addi $r2, 7
      shl $r2, 2
      addi $r2, 3
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
    load $r4, $r1 # Load function result
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
    calc_incorrect: andi $r3, 1
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
    bneqz loop_parity # Branch relative -111
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
  addi $r3, 7
  addi $r3, 4 # 208
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
    subr $r1, $r3
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
    shl $r1, 4
    subr $r1, $r4
    beqz loop_bits_end
    subr $r1, $r1
    addi $r1, 4
    move $r2, $r1
    xor $r1, $r4 # i ^ 4
    beqz shift_msg_1
    shl $r2, 1
    xor $r2, $r4 # i ^ 8
    beqz shift_msg_2
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
    addi $r3, 6 # 209
    load $r1, $r3
    shr $r1, 3
    addr $r4, $r1 # new_message + (j >> 3)
    load $r1, $r4 # *(new_message + (j >> 3))
    or $r1, $r2 # new_message[j >> 3] | ((message[0] & 1) << (j & 7))
    store $r1, $r4
    shift_msg_1: subr $r3, $r3
    shift_msg_2: subr $r3, $r3
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
  xor $r1, $r4
  shl $r1, 7
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
  subr $r1, $r1
  addi $r1, 1
  shl $r1, 4 # 16
  subr $r1, $r4
  bneqz main2
