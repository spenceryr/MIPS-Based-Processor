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

sub $r0, $r0
sub $r1, $r1
addi $r0, 3
shl $r0, 5
addi $r0, 7
shl $r0, 1
addi $r0, 4 # 210
store $r1, $r0
main2: sub $r0, $r0
  sub $r1, $r1
  sub $r2, $r2
  sub $r3, $r3
  addi $r0, 7
  shl $r0, 5 # 224
  addi $r1, 1
  shl $r1, 5
  subi $r1, 2 # 30
  add $r0, $r1 # 254
  sub $r1, $r1
  addi $r1, 3
  shl $r1, 6
  addi $r1, 3 # 195
  store $r0, $r1
  subi $r0, 1 # 255
  addi $r1, 1 # 196
  store $r0, $r1
  move $r0, $r1
  addi $r0, 7 # 203
  load $r2, $r0 # first pointer to message byte loaded
  load $r3, $r2 # first message byte loaded
  addi $r1, 1 # 197
  store $r3, $r1
  addi $r2, 1
  load $r3, $r2 # second message byte loaded
  addi $r1, 1 # 198
  store $r3, $r1
  call 15
  addi $r1, 3
  shl $r1, 6
  addi $r1, 7 # 199
  load $r0, $r1 # Load function result
  move $r2, $r1
  addi $r2, 4 # 203
  load $r3, $r2 # first pointer to message byte loaded
  load $r3, $r3 # first message byte loaded
  andi $r3, 1
  xor $r3, $r0 # p0 ^ func_result
  addi $r2, 2 # 205
  store $r3, $r2 # Store
  sub $r0, $r0
  addi $r2, 3 # 208
  store $r0, $r2
  loop_parity: subi $r1, 4 # 195
    sub $r0, $r0
    sub $r2, $r2
    sub $r3, $r3
    move $r2, $r1
    addi $r2, 7 # 202
    addi $r2, 6 # 208
    load $r2, $r2
    subi $r2, 0
    bneq b_8
      addi $r0, 5
      shl $r0, 5
      addi $r0, 7
      addi $r0, 1 # 168
      sub $r2, $r2
      addi $r2, 2 # 2
      jmp store_second
    b_8: subi $r2, 1
      bneq b_8
      move $r0, $r1
      addi $r0, 5 # 200
      sub $r2, $r2
      addi $r2, 4 # 4
      jmp store_second
      mov $r0, $r0 # Dummy instruction to make rel jumps same length here
    b_8: addi $r2, 1
      subi $r2, 2
      bneq b_8
      addi $r0, 7
      shl $r0, 5 # 224
      sub $r2, $r2
      addi $r2, 1
      shl $r2, 4 # 16
      jmp store_second
      mov $r0, $r0 # Dummy instruction to make rel jumps same length here
      mov $r0, $r0 # Dummy instruction to make rel jumps same length here
    b_8: addi $r2, 7
      shl $r2, 3
      addi $r2, 7
      shl $r2, 2
      addi $r2, 3
    store_second: store $r0, $r1
    add $r0, $r2
    addi $r1, 1 # 196
    store $r0, $r1
    move $r0, $r1
    addi $r0, 7 # 203
    load $r2, $r0 # first pointer to message byte loaded
    load $r3, $r2 # first message byte loaded
    addi $r1, 1 # 197
    store $r3, $r1
    addi $r2, 1
    load $r3, $r2 # second message byte loaded
    addi $r1, 1 # 198
    store $r3, $r1
    call 16
    addi $r1, 3
    shl $r1, 6
    addi $r1, 7 # 199
    load $r0, $r1 # Load function result
    move $r2, $r1
    addi $r2, 4 # 203
    load $r3, $r2 # first pointer to message byte loaded
    move $r0, $r3
    load $r3, $r3 # first message byte loaded
    addi $r2, 5 # 208
    load $r2, $r2
    subi $r2, 0
    bneq b_4
      shr $r3, 1
      jmp calc_incorrect
      move $r0, $r0 # dummy instruction to make rel jumps same here
    b_4: subi $r2, 1
      bneq b_4
      addi $r2, 1
      shr $r3, 2
      jmp calc_incorrect
    b_4: subi $r2, 1
      bneq b_4
      addi $r2, 2
      shr $r3, 4
      jmp calc_incorrect
    b_4: addi $r2, 2
      addi $r0, 1
      load $r3, $r0
    calc_incorrect: andi $r3, 1
    xor $r3, $r0 # p ^  calc_p
    addi $r1, 7 # 206
    load $r0, $r1
    or $r0, $r3
    store $r0, $r1
    addi $r1, 1 # 207
    load $r0, $r1
    rshl $r3, $r2
    or $r0, $r3
    store $r0, $r1
    move $r0, $r2
    addi $r2, 1
    addi $r1, 1 # 208
    move $r3, $r1
    store $r2, $r1
    subi $r2, 7
    subi $r2, 2
    subi $r0, 3
  bneq loop_parity # Branch relative -111
  subi $r3, 1 # 207
  load $r2, $r3 # contains "needs_fixing"
  load $r0, $r3 # contains "needs_fixing"
  subi $r3, 7 # 200
  subi $r3, 3 # 197
  shr $r2, 3
  add $r3, $r2
  load $r1, $r3
  andi $r0, 7
  sub $r2, $r2
  addi $r2, 1
  rshl $r2, $r0
  xor $r1, $r2
  store $r1, $r3
  addi $r3, 7
  addi $r3, 4 # 208
  sub $r0, $r0
  store $r0, $r3
  addi $r3, 1 # 209
  store $r0, $r3
  loop_3_bits: sub $r3, $r3
    addi $r3, 1
    shl $r3, 3
    addi $r3, 5
    shl $r3, 4 # 208
    load $r0, $r3 # contains i
    sub $r1, $r1
    addi $r1, 3
    sub $r1, $r3
    beq loop_bits_3_end
    subi $r3, 7
    subi $r3, 4 # 197
    load $r0, $r3
    addi $r3, 1
    load $r1, $r3
    shr $r1, 1
    shr $r0, 1
    store $r1, $r3
    subi $r3, 1
    store $r0, $r3
    addi $r3, 7
    addi $r3, 4 # 208
    load $r0, $r3 # load i
    addi $r0, 1
    store $r0, $r3
    jmp loop_3_bits
  loop_bits: sub $r3, $r3
    addi $r3, 1
    shl $r3, 3
    addi $r3, 5
    shl $r3, 4 # 208
    load $r0, $r3 # contains i
    sub $r1, $r1
    addi $r1, 1
    shl $r1, 4
    sub $r1, $r0
    beq loop_bits_end
    sub $r1, $r1
    addi $r1, 4
    move $r2, $r1
    xor $r1, $r0 # i ^ 4
    beq shift_msg_1
    shl $r2, 1
    xor $r2, $r0 # i ^ 8
    beq shift_msg_2
    addi $r3, 1 # 209
    load $r1, $r3 # j
    subi $r3, 7
    subi $r3, 5 # 197
    load $r2, $r3 # message[0]
    andi $r2, 1
    andi $r1, 7
    rshl $r2, $r1 # ((message[0] & 1) << (j & 7))
    addi $r3, 7 # 204
    load $r0, $r3 #
    addi $r3, 6 # 209
    load $r1, $r3
    shr $r1, 3
    add $r0, $r1 # new_message + (j >> 3)
    load $r1, $r0 # *(new_message + (j >> 3))
    or $r1, $r2 # new_message[j >> 3] | ((message[0] & 1) << (j & 7))
    store $r1, $r0
    subi $r3, 7
    subi $r3, 5 # 197
    load $r0, $r3
    addi $r3, 1 # 198
    load $r1, $r3
    shr $r1, 1
    shr $r0, 1
    store $r1, $r3
    subi $r3, 1 # 197
    store $r0, $r3
    addi $r3, 7
    addi $r3, 4 # 208
    load $r0, $r3 # load i
    addi $r0, 1
    store $r0, $r3
    jmp loop_bits
  loop_bits_end: subi $r3, 3 # 205
  load $r0, $r3 # (p0 ^ calc_p0)
  addi $r3, 1 # 206
  load $r1, $r3 # "incorrect"
  xor $r1, $r0
  shl $r1, 7
  subi $r3, 2 # 204
  load $r0, $r3
  addi $r0, 1
  load $r2, $r0
  or $r2, $r1
  store $r2, $r0
  subi $r3, 1 # 203
  load $r0, $r3
  addi $r0, 2
  store $r0, $r3
  addi $r3, 1 # 204
  load $r0, $r3
  addi $r0, 2
  store $r0, $r3
  addi $r3, 6 # 210
  load $r0, $r3
  addi $r0, 1
  sub $r1, $r1
  addi $r1, 1
  shl $r1, 4 # 16
  sub $r1, $r0
  bneq main2
