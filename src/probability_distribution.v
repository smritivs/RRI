module probability_distribution(
    input wire clk,
    input wire rst,
    input wire [9:0] bin_index,
    output reg [31:0] distribution [0:1023]
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            integer i;
            for (i = 0; i < 1024; i = i + 1)
                distribution[i] <= 0;
        end else begin
            distribution[bin_index] <= distribution[bin_index] + 1;
        end
    end
endmodule