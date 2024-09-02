module alu
(
    input [31:0] val_a,
    input [31:0] val_b,
    input [2:0] op,
    output reg [31:0] result,
    output reg [2:0] nzp
);
    always_comb begin
        case (op)
            3'b000: result = val_a + val_b;
            3'b001: result = val_a - val_b;
            3'b010: result = val_a * val_b;
            3'b011: result = ~val_a;
            3'b100: result = val_a & val_b;
            3'b101: result = val_a | val_b;
            3'b110: result = val_a << val_b;
            3'b111: result = val_a >>> val_b;
        endcase

        if (result[31] == 1'b1)
            nzp = 3'b100;
        else if (result == 32'd0)
            nzp = 3'b010;
        else
            nzp = 3'b001;
    end

endmodule

module full_alu
(
    input [31:0] dest,
    input [127:0] arg,
    input [1:0] swizzle_mask,
    input [2:0] op,
    output [31:0] dest_out,
    output [2:0] nzp_out
);
    wire [31:0] result;
    integer arg_chosen;

    alu alu_inst(
        .val_a(arg_chosen),
        .val_b(dest),
        .op(op),
        .result(dest_out),
        .nzp(nzp_out)
    );

    always_comb begin
        case (swizzle_mask)
            2'b00: arg_chosen = arg[31:0];
            2'b01: arg_chosen = arg[63:32];
            2'b10: arg_chosen = arg[95:64];
            2'b11: arg_chosen = arg[127:96];
        endcase
    end
endmodule