module scoreBoard (
    input [4:0] score,
    output reg [3:0] tens,    // 0-9 range, tens place
    output reg [3:0] units    // 0-9 range, units place
);
    integer i;

    always @(*) begin
        // Initialize BCD digits to zero
        tens = 0;
        units = 0;

        // Binary to BCD conversion
        for (i = 4; i >= 0; i = i - 1) begin
            // Add 3 if the BCD digit is 5 or more
            if (tens >= 5)
                tens = tens + 3;
            if (units >= 5)
                units = units + 3;

            // Shift left
            tens = tens << 1;
            tens[0] = units[3];
            units = units << 1;
            units[0] = score[i];
        end
    end

endmodule
