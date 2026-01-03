

module ex_stage #(
    parameter VLEN   = 8,
    parameter EWIDTH = 32,
    parameter LANES  = 2
)(
    input                     clk,
    input                     rst_n,
    input        [2:0]         alu_op,
    input                     ex_valid,
    input  [EWIDTH*VLEN-1:0]  src1,
    input  [EWIDTH*VLEN-1:0]  src2,
    output                    stall_ex,
    output reg [EWIDTH*VLEN-1:0] ex_result,
    output reg                ex_done
);

    reg start;
    wire busy;
    wire [EWIDTH*VLEN-1:0] alu_result;

    assign stall_ex = busy;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            start <= 1'b0;
        else
            start <= ex_valid && !busy;
    end

    vector_alu #(
        .VLEN(VLEN), .EWIDTH(EWIDTH), .LANES(LANES)
    ) VALU (
        .clk(clk), .rst_n(rst_n),
        .alu_op(alu_op), .start(start),
        .busy(busy),
        .src1(src1), .src2(src2),
        .result(alu_result)
    );

    reg vec_active;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ex_result  <= {EWIDTH*VLEN{1'b0}};
        ex_done    <= 1'b0;
        vec_active <= 1'b0;
    end else begin
        ex_done <= 1'b0;

        // Mark start of vector instruction
        if (start)
            vec_active <= 1'b1;

        // When ALU finishes, write result
        if (vec_active && !busy) begin
            ex_result  <= alu_result;
            ex_done    <= 1'b1;
            vec_active <= 1'b0;
        end
    end
end


endmodule
