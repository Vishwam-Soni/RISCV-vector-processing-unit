`ifndef DEFINES_VH
`define DEFINES_VH

// Custom vector opcode (RISC-V style)
`define OP_VECTOR 7'b1011011

// funct3 encodings
`define FUNCT3_VADD 3'b000
`define FUNCT3_VSUB 3'b001
`define FUNCT3_VAND 3'b010
`define FUNCT3_VOR  3'b011

// ALU operation encodings
`define ALU_ADD 3'b000
`define ALU_SUB 3'b001
`define ALU_AND 3'b010
`define ALU_OR  3'b011

`endif
