`include "vec_alu.sv"

module vec_unit
(
    input [31:0] instr,
    input [128*8 - 1:0] core_regs,
    input [128*2 - 1:0] unit_streams,
    input write_en,
    input stream_write_en,
    input clk,
    output [127:0] result
);
    // 000-010: stream, 011-111: general purpose
    reg [128*7 - 1:0] unit_regfile = 0;
    reg [2:0] nzp = 0;

    // Read stream from inputs
    always @(posedge clk) begin
        if (stream_write_en) begin
            unit_regfile[128*3 - 1:0] <= unit_streams;            
        end
    end

    reg [127:0] cur_result = 0;
    reg [2:0] result_dest = 0;

    vec_alu alu_inst(
        .dest(unit_regfile[14:10]),
        .arg(arg),
        .op(op),
        .swizzle_mask(swizzle_mask),
        .write_mask(write_mask),
        .dest_out(dest_out),
        .nzp_out(nzp_out)
    );

    always @(posedge clk) begin
        
    end
endmodule