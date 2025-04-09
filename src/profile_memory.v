module profile_memory (
    input wire [9:0] address,
    output reg [31:0] profile_value
);
    reg [31:0] profile [0:1023];

    initial begin
        $readmemh("~RRI\pulse_profile.mem", profile); // Load from external memory file
    end

    always @(*) begin
        profile_value = profile[address];
    end
endmodule

