`timescale 1ns / 1ps

module tb_top_module;

    // Inputs
    reg clk;
    reg rst;
    reg pulse_in;
    reg [31:0] period;
    reg [31:0] epoch;

    // Outputs
    wire [31:0] profile_out;

    // Instantiate the top module
    top_module uut (
        .clk(clk),
        .rst(rst),
        .pulse_in(pulse_in),
        .period(period),
        .epoch(epoch),
        .profile_out(profile_out)
    );

    // Clock generation
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        pulse_in = 0;
        period = 100;  // Example: 100 clock cycles
        epoch = 20;    // Example: Epoch offset

        // Reset pulse
        #20;
        rst = 0;

        // Simulate some pulses
        #30 pulse_in = 1;  // Pulse 1 (rising edge)
        #10 pulse_in = 0;
        #100;

        #50 pulse_in = 1;  // Pulse 2
        #10 pulse_in = 0;
        #100;

        #50 pulse_in = 1;  // Pulse 3
        #10 pulse_in = 0;
        #100;

        // End simulation
        $display("Simulation complete.");
        $stop;
    end

endmodule
