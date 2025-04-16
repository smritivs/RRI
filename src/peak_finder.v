module peak_finder(
    input wire clk,
    input wire rst,
    input wire [9:0] bin_index,
    input wire [31:0] distribution_value,  // Value at the selected bin index
    output reg [9:0] peak_index,
    output reg [31:0] peak_value
);

    reg [31:0] max_value;  // To track the peak value

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            peak_index <= 0;
            peak_value <= 0;
            max_value <= 0;
        end else begin
            // Compare the current distribution value with the maximum value
            if (distribution_value > max_value) begin
                max_value <= distribution_value;
                peak_value <= max_value;
                peak_index <= bin_index;  // Store the index of the peak
            end
        end
    end
endmodule

