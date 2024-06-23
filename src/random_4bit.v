module random_4bit(
    input wire clk,
    input wire reset,
    output reg [3:0] random_number
);

    reg [15:0] lfsr;
    wire feedback;

    // Feedback is the XOR of bits 16 and 14 (based on a primitive polynomial for 16-bit LFSR)
    assign feedback = lfsr[15] ^ lfsr[4]^lfsr[11] ^ lfsr[8];

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            // Reset the LFSR to a non-zero value
            lfsr <= 16'd10;
				random_number <= 4'd0;
        end else begin
            // Shift the register and input the feedback value
            lfsr <= {lfsr[14:0], feedback};
				random_number <= lfsr[3:0];
        end
    end
endmodule
