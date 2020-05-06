// CSE141L
// making and avoiding implied latches
// incomplete case statement; what happens when sel = 1x?
always_comb case(sel)
  2'b00: output = 5;
  2'b01: output = 10;
endcase

// resolve with default:
always_comb case(sel)
  2'b00: output = 5;
  2'b01: output = 10;
  default: output = 0; 
endcase

// alternative construct; convenient for multiple outputs
always_comb begin
  output = 0;            // default
  case(sel)
    2'b00: output = 5;
    2'b01: output = 10;
  endcase
end


always_comb 
  if(sel==2'b00) output = 5;
  else if(sel==2'b01) output = 10;
// needs final "else":  else output = 0; 
