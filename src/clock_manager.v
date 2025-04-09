module pulse_input(
    input wire clk,            // system clock
    input wire rst,            // reset
    input wire pulse_in,       // from oscilloscope 
    output reg pulse_detected  // detected pulse flag 
);

    reg pulse_prev;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pulse_prev <= 0;
            pulse_detected <= 0;
        end else begin
            pulse_prev <= pulse_in;
            
            // Detect rising edge of pulse_in
            if (pulse_in && !pulse_prev) begin
                pulse_detected <= 1;
            end else begin
                pulse_detected <= 0;
            end
        end
    end

endmodule
