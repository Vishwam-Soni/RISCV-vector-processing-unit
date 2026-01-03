`include "defines.vh"


module vpu_top (
    input         clk,
    input         rst_n,
    input  [31:0] instr_in,
    output [31:0] debug_out
);

    wire [31:0] if_instr;
    wire        stall;

    wire        is_vector;
    wire [2:0]  vd, vs1, vs2;
    wire        reg_write;
    wire [2:0]  alu_op;

    wire [255:0] rs1_data, rs2_data;
    wire [255:0] ex_result;
    wire        ex_done, stall_ex;

    assign stall = stall_ex;
    

    if_stage IF (
        .clk(clk), .rst_n(rst_n), .stall(stall),
        .instr_in(instr_in), .instr_out(if_instr)
    );

    id_stage ID (
        .instr_in(if_instr),
        .is_vector(is_vector),
        .vd(vd), .vs1(vs1), .vs2(vs2),
        .reg_write(reg_write),
        .alu_op(alu_op)
    );

    vector_regfile VRF (
        .clk(clk), .rst_n(rst_n),
        .rs1(vs1), .rs2(vs2),
        .rs1_data(rs1_data), .rs2_data(rs2_data),
        .rd(vd),
        .we(ex_done & reg_write),
        .rd_data(ex_result)
    );

    ex_stage EX (
        .clk(clk), .rst_n(rst_n),
        .alu_op(alu_op),
        .ex_valid(is_vector),
        .src1(rs1_data), .src2(rs2_data),
        .stall_ex(stall_ex),
        .ex_result(ex_result),
        .ex_done(ex_done)
    );
     
 always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        debug_out <= 32'b0;
    else
        debug_out <= instr_in;
end


endmodule
