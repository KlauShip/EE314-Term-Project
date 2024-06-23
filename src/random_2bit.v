module random_2bit(
    input wire clk,
    input wire reset,
    output reg [1:0] random_number
);

    reg [5:0] lfsr;
    wire feedback;

    // Feedback is the XOR of bits 6 and 5 (based on a primitive polynomial for 6-bit LFSR)
    assign feedback = lfsr[5] ^ lfsr[4];

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            // Reset the LFSR to a non-zero value
            lfsr <= 6'b000001;
        end else begin
            // Shift the register and input the feedback value
            lfsr <= {lfsr[4:0], feedback};
            // Take the 2 bits as the random number
            random_number <= lfsr[1:0];
        end
    end

endmodule

