module vector_alu #(
    parameter VLEN   = 8,
    parameter EWIDTH = 32,
    parameter LANES  = 2
)(
    input                    clk,
    input                    rst_n,
    input        [2:0]        alu_op,
    input                    start,
    output reg               busy,
    input  [EWIDTH*VLEN-1:0] src1,
    input  [EWIDTH*VLEN-1:0] src2,
    output reg [EWIDTH*VLEN-1:0] result
);

    integer i;
    reg [3:0] idx;
    reg [EWIDTH-1:0] a, b, r;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            busy   <= 1'b0;
            idx    <= 4'b0000;
            result <= {EWIDTH*VLEN{1'b0}};
        end else begin
            if (start && !busy) begin
                busy <= 1'b1;
                idx  <= 0;
            end else if (busy) begin
                for (i = 0; i < LANES; i = i + 1) begin
                    if ((idx + i) < VLEN) begin
                        a = src1[(idx+i)*EWIDTH +: EWIDTH];
                        b = src2[(idx+i)*EWIDTH +: EWIDTH];
                        case (alu_op)
                            3'b000: r = a + b;
                            3'b001: r = a - b;
                            3'b010: r = a & b;
                            3'b011: r = a | b;
                            default: r = {EWIDTH{1'b0}};
                        endcase
                        result[(idx+i)*EWIDTH +: EWIDTH] <= r;
                    end
                end
                idx <= idx + LANES;
                if (idx + LANES >= VLEN)
                    busy <= 1'b0;
            end
        end
    end

endmodule
