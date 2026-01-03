module vector_regfile #(
    parameter VREGS  = 8,
    parameter VLEN   = 8,
    parameter EWIDTH = 32
)(
    input                    clk,
    input                    rst_n,

    input  [2:0]             rs1,
    input  [2:0]             rs2,
    output wire [EWIDTH*VLEN-1:0] rs1_data,
    output wire [EWIDTH*VLEN-1:0] rs2_data,

    input  [2:0]             rd,
    input                    we,
    input  [EWIDTH*VLEN-1:0] rd_data
);

    reg [EWIDTH-1:0] vreg [0:VREGS-1][0:VLEN-1];
    integer i, j;

    // Write / reset
    always @(posedge clk) begin
        if (!rst_n) begin
            for (i = 0; i < VREGS; i = i + 1)
                for (j = 0; j < VLEN; j = j + 1)
                    vreg[i][j] <= {EWIDTH{1'b0}};
        end else if (we) begin
            for (j = 0; j < VLEN; j = j + 1)
                vreg[rd][j] <= rd_data[j*EWIDTH +: EWIDTH];
        end
    end

genvar k;
generate
    for (k = 0; k < VLEN; k = k + 1) begin
        assign rs1_data[k*EWIDTH +: EWIDTH] = vreg[rs1][k];
        assign rs2_data[k*EWIDTH +: EWIDTH] = vreg[rs2][k];
    end
endgenerate

endmodule
