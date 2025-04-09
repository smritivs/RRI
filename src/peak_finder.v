module peak_finder(
    input wire clk,
    input wire rst,
    input wire [31:0] distribution [0:1023],
    output reg [9:0] peak_index,
    output reg [31:0] peak_value
);
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            peak_index <= 0;
            peak_value <= 0;
        end else begin
            peak_value <= distribution[0];
            peak_index <= 0;
            for (i = 1; i < 1024; i = i + 1) begin
                if (distribution[i] > peak_value) begin
                    peak_value <= distribution[i];
                    peak_index <= i;
                end
            end
        end
    end
endmodule
