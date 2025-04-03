module time_phase_calculator(
    input wire clk,
    input wire rst,
    input wire pulse_detected, // signal indicating a detected pulse
    input wire [31:0] period,  // known pulsar period in clock cycles
    input wire [31:0] epoch,   // known epoch timestamp
    output reg [9:0] bin_index // computed bin index (1024 bins)
);

    reg [31:0] time_counter; // time counter to track phase

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            time_counter <= 0;
            bin_index <= 0;
        end else begin
            if (pulse_detected) begin
                time_counter <= 0; // reset time counter on pulse detection
            end else begin
                time_counter <= time_counter + 1;
            end

            // compute bin index: (time - epoch) * (1024 / period)
            bin_index <= ((time_counter - epoch) * 1024) / period;
        end
    end

endmodule
