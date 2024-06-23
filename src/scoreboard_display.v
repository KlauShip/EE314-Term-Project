module scoreboard_display (
    input wire clk,
    input [4:0] score,
    output [6:0] seg_tens,
    output [6:0] seg_units
);

    wire [3:0] tens;
    wire [3:0] units;

    scoreBoard sb (
        .score(score),
        .tens(tens),
        .units(units)
    );

    ssdcm ssd_tens (
        .clk(clk),
        .digit(tens),
        .segments(seg_tens)
    );

    ssdcm ssd_units (
        .clk(clk),
        .digit(units),
        .segments(seg_units)
    );

endmodule


module ssdcm (
    input wire clk,
    input wire [3:0] digit,
    output reg [6:0] segments
);

always @ (posedge clk) begin
    case (digit)
        4'd0: segments = 7'b1000000; // 0
        4'd1: segments = 7'b1111001; // 1
        4'd2: segments = 7'b0100100; // 2
        4'd3: segments = 7'b0110000; // 3
        4'd4: segments = 7'b0011001; // 4
        4'd5: segments = 7'b0010010; // 5
        4'd6: segments = 7'b0000010; // 6
        4'd7: segments = 7'b1111000; // 7
        4'd8: segments = 7'b0000000; // 8
        4'd9: segments = 7'b0010000; // 9
        default: segments = 7'b1111111; 
    endcase
end

endmodule
