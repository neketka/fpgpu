`include "alu.sv"

module vec_alu
(
    input [127:0] dest,
    input [127:0] arg,
    input [2:0] op,
    input [7:0] swizzle_mask,
    input [3:0] write_mask,
    output [127:0] dest_out,
    output [2:0] nzp_out
);
    wire [2:0] nzp[3:0];

    assign nzp_out =  nzp[3] | nzp[2] | nzp[1] | nzp[0];

    genvar i; 
    generate
        for (i = 0; i < 4; i = i + 1) begin
            full_alu alu(
                .dest(dest[31 + 32 * i:32 * i]),
                .arg(arg),
                .swizzle_mask(swizzle_mask[i * 2 + 1:i * 2]),
                .op(op),
                .write_en(write_mask[i]),
                .dest_out(dest_out[31 + 32 * i:32 * i]),
                .nzp_out(nzp[i])
            );
        end
    endgenerate
endmodule