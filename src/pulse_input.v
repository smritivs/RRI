module pulse_input(
    input wire clk,
    input wire rst,
    input wire pulse_in,
    output reg pulse_detected
);

    reg pulse_prev;

    always @(posedge clk or posedge rst) begin 
        if(rst) begin 
            pulse_prev <= 0;
            pulse_detected <= 0;
        end else begin 
            pulse_prev <= pulse_in;

            if(pulse_in && !pulse_prev) begin
                pulse_detected <= 1;
            end else begin 
                pulse_detected <= 0;
            end 
        end
    end

endmodule 


