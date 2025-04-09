module top_module(
    input wire clk,
    input wire rst,
    input wire pulse_in,
    input wire [31:0] period,
    input wire [31:0] epoch,
    output wire [31:0] profile_out
);
    wire pulse_detected;
    wire [9:0] bin_index;

    pulse_input u_pulse_input (
        .clk(clk),
        .rst(rst),
        .pulse_in(pulse_in),
        .pulse_detected(pulse_detected)
    );

    time_phase_calculator u_time_phase (
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
endmodule

