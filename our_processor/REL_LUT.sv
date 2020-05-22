module REL_LUT #(parameter SIZE=4, WIDTH=16) (
    input [SIZE-1:0] in,
    output logic [WIDTH-1:0] out
);

always_comb begin
    case(in)
    default: out = 'b0;
    endcase
end
endmodule
