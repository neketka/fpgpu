`include "shader_core/alu.sv"

module top
(
    input clk,
    input btn1,
    input btn2,
    output [5:0] led
);
    integer arg_0 = 0;
    integer arg_1 = 0;
    reg [2:0] op = 0;

    reg bt1_down = 0;
    reg bt2_down = 0;

    reg [3:0] bt1_downcount = 0;
    reg [3:0] bt2_downcount = 0;

    wire [31:0] result;
    wire [2:0] nzp;

    alu alu_inst(
        .val_a(arg_0),
        .val_b(arg_1),
        .result(result),
        .op(op),
        .nzp(nzp)
    );

    always @(posedge clk) begin
        arg_1 <= result;

        if (bt1_down) begin
            op <= 3'b000;
            arg_0 <= 32'd1;
        end else if (bt2_down) begin
            op <= 3'b001;
            arg_0 <= 32'd0;
        end else begin
            op <= 3'b000;
            arg_0 <= 32'd0;
        end
    end

    always @(posedge clk) begin
        if (btn1 && bt1_downcount == 0) begin
            bt1_downcount <= 4'd10;
            bt1_down <= 1'b1;
        end else if (btn1) begin
            bt1_downcount <= 4'd10;
            bt1_down <= 1'b0;
        end else if (!btn1 && bt1_downcount > 0) begin
            bt1_downcount <= bt1_downcount - 1;
            bt1_down <= 1'b0;
        end

        if (btn2 && bt2_downcount == 0) begin
            bt2_downcount <= 4'd10;
            bt2_down <= 1'b1;
        end else if (btn2) begin
            bt2_downcount <= 4'd10;
            bt2_down <= 1'b0;
        end else if (!btn2 && bt2_downcount > 0) begin
            bt2_downcount <= bt2_downcount - 1;
            bt2_down <= 1'b0;
        end
    end

    assign led = { ~result[5:0] }; 
endmodule