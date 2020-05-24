module ABS_LUT #(parameter SIZE=5, WIDTH=32) (
    input [SIZE-1:0] in,
    output logic [WIDTH-1:0] out
);

always_comb begin
    case(in)
	 'd3: out = 'd19;
	 'd4: out = 'd20;
	 'd1: out = 'd11;
    default: out = 'b0;
    endcase
end
endmodule
