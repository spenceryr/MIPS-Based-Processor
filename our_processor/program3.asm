

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
  addi $r4, 6     # r4 should hold 9 at this point
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
after_last_pattern_check: subi $r4, 2       # r4 should hold 9 at this point, pc = 128
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
