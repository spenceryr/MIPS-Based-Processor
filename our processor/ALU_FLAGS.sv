module ALU_FLAGS(
    input        IN_ALU_ZERO,
                 IN_C_OUT,
                 IN_S_OUT,
                 CLK,
                 reset,
    output logic OUT_ALU_ZERO,
                 OUT_C_OUT,
                 OUT_S_OUT
);

always_ff @(posedge CLK) begin
    if (reset) begin
        OUT_ALU_ZERO <= 'b0;
        OUT_C_OUT   <= 'b0;
        OUT_S_OUT     <= 'b0;
    end else begin
        OUT_ALU_ZERO <= IN_ALU_ZERO;
        OUT_C_OUT   <= IN_C_OUT;
        OUT_S_OUT     <= IN_S_OUT;
    end
end
endmodule