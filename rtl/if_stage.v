module if_stage (
    input         clk,
    input         rst_n,
    input         stall,

    input  [31:0] instr_in,
    output reg [31:0] instr_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            instr_out <= 32'b0;
        else if (!stall)
            instr_out <= instr_in;
    end

endmodule
