module LUT_16 #(parameter WIDTH=16,
                parameter [WIDTH-1:0]
                 c0=0, c1=0, c2=0, c3=0,
                 c4=0, c5=0, c6=0, c7=0,
                 c8=0, c9=0, c10=0, c11=0,
                 c12=0, c13=0, c14=0, c15=0)(
    input [3:0] in,
    output logic [WIDTH-1:0] out
);

always_comb begin
    case(in)
    0: out = c0;
    1: out = c1;
    2: out = c2;
    3: out = c3;
    4: out = c4;
    5: out = c5;
    6: out = c6;
    7: out = c7;
    8: out = c8;
    9: out = c9;
    10: out = c10;
    11: out = c11;
    12: out = c12;
    13: out = c13;
    14: out = c14;
    15: out = c15;
    default: out = 'b0;
    endcase
end
endmodule
