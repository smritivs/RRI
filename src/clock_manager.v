module clock_manager(
    input wire clk_in,         // Input clock
    input wire rst,            // Reset signal
    input wire [31:0] period,  // Known pulsar period in clock cycles
    input wire [31:0] epoch,   // Known epoch timestamp
    input wire pulse_detected, // Pulse detected signal
    output reg clk_out,        // Managed clock output
    output reg [9:0] bin_index // Computed bin index (assuming 1024 bins)
);

    reg [3:0] clk_div;  // Clock divider register
    reg [31:0] time_counter; // Time counter to track phase

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            clk_div <= 0;
            clk_out <= 0;
            time_counter <= 0;
            bin_index <= 0;
        end else begin
            clk_div <= clk_div + 1;
            if (clk_div == 4'd8) begin // Divide clock by 8 (adjust as needed)
                clk_out <= ~clk_out;
                clk_div <= 0;
            end

            if (pulse_detected) begin
                time_counter <= 0; // Reset time counter on pulse detection
            end else begin
                time_counter <= time_counter + 1;
            end

            // Compute bin index: (time - epoch) * (1024 / period)
            bin_index <= ((time_counter - epoch) * 1024) / period;
        end
    end

endmodule

