module ABS_LUT #(parameter SIZE=4, WIDTH=16
                 c0=0, c1=0, c2=0, c3=0,
                 c4=0, c5=0, c6=0, c7=0,
                 c8=0, c9=0, c10=0, c11=0,
                 c12=0, c13=0, c14=0, c15=0)(
    input [SIZE-1:0] in,
    output logic [WIDTH-1:0] out
);

always_comb begin
    case(in)
    default: out = 'b0;
    endcase
end
endmodule
