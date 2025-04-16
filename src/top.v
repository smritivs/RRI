module top(
    input wire clk,
    input wire rst,
    input wire pulse_in,
    input wire [31:0] period,
    input wire [31:0] epoch,
    output wire [31:0] profile_out
);
    wire pulse_detected;
    wire [9:0] bin_index;
    wire [31:0] distribution_value;
    wire [31:0] peak_value;
    wire [9:0] peak_index;

    // Declare the distribution wire and connect it to the probability_distribution
    wire [31:0] distribution [0:1023];  // Array of 1024 entries

    pulse_input u_pulse_input (
        .clk(clk),
        .rst(rst),
        .pulse_in(pulse_in),
        .pulse_detected(pulse_detected)
    );

    time_phase_calculator u_time_phase_calculator (
        .clk(clk),
        .rst(rst),
        .pulse_detected(pulse_detected),
        .period(period),
        .epoch(epoch),
        .bin_index(bin_index)
    );

    profile_memory u_profile_memory (
        .address(bin_index),
        .profile_value(profile_out)
    );

    clock_manager u_clock_manager (
        .clk_in(clk),
        .rst(rst),
        .period(period),
        .epoch(epoch),
        .pulse_detected(pulse_detected),
        .clk_out(clk_out),
        .bin_index(bin_index)
    );

    peak_finder u_peak_finder (
        .clk(clk),
        .rst(rst),
        .bin_index(bin_index),
        .distribution_value(distribution_value),  // Passing value from the memory
        .peak_index(peak_index),
        .peak_value(peak_value)
    );

    probability_distribution u_probability_distribution (
        .clk(clk),
        .rst(rst),
        .bin_index(bin_index),
        .distribution_value(distribution_value)
    );
    initial begin
        $display("Simulation started...");
    end

    always @(posedge clk) begin
        $display("time=%d, bin_index=%d, profile_out=%d, peak_index=%d, peak_value=%d", $time, bin_index, profile_out, peak_index, peak_value);
    end

endmodule


