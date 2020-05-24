module REL_LUT #(parameter SIZE=5, WIDTH=32) (
    input [SIZE-1:0] in,
    output logic [WIDTH-1:0] out
);

always_comb begin
    case(in)
	 'd2: out = 'd4;
	 'd6: out = 'd5;
    default: out = 'b0;
    endcase
end
endmodule
