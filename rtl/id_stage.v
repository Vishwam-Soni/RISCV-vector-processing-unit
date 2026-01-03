`include "defines.vh"

module id_stage (
    input         clk,
    input         rst_n,
    input  [31:0] instr_in,

    output        is_vector,
    output [2:0]  vd,
    output [2:0]  vs1,
    output [2:0]  vs2,
    output        reg_write,
    output [2:0]  alu_op
);

    // Pipeline register
    reg [31:0] instr;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            instr <= 32'b0;
        else
            instr <= instr_in;
    end

    // Decode wires (COMBINATIONAL)
    wire [6:0] opcode = instr[6:0];
    wire [2:0] funct3 = instr[14:12];

    assign is_vector = (opcode == `OP_VECTOR);
    assign vd        = instr[11:9];
    assign vs1       = instr[8:6];
    assign vs2       = instr[5:3];
    assign reg_write = is_vector;
    assign alu_op    = funct3;

endmodule

