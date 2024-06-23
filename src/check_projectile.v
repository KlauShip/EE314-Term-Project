module check_projectile(
    input clk,
    input wire [3:0] ship_pose,
    output reg [3:0] addr0,
    output reg [3:0] addr1,
    output reg [3:0] addr2,
    output reg [3:0] addr3,
    output reg [3:0] addr4
);

always @(posedge clk) begin
    case(ship_pose)
        4'd0: begin
            addr0 <= 4'd15 ; // -1 (wrap around)
            addr1 <= 4'd0;   // itself
            addr2 <= 4'd1;   // +1
            addr3 <= 4'd14;  // -2 (wrap around)
            addr4 <= 4'd2;   // +2
        end
        4'd1: begin
            addr0 <= 4'd0;   // -1
            addr1 <= 4'd1;   // itself
            addr2 <= 4'd2;   // +1
            addr3 <= 4'd15;  // -2 (wrap around)
            addr4 <= 4'd3;   // +2
        end
        4'd2: begin
            addr0 <= 4'd1;   // -1
            addr1 <= 4'd2;   // itself
            addr2 <= 4'd3;   // +1
            addr3 <= 4'd0;   // -2
            addr4 <= 4'd4;   // +2
        end
        4'd3: begin
            addr0 <= 4'd2;   // -1
            addr1 <= 4'd3;   // itself
            addr2 <= 4'd4;   // +1
            addr3 <= 4'd1;   // -2
            addr4 <= 4'd5;   // +2
        end
        4'd4: begin
            addr0 <= 4'd3;   // -1
            addr1 <= 4'd4;   // itself
            addr2 <= 4'd5;   // +1
            addr3 <= 4'd2;   // -2
            addr4 <= 4'd6;   // +2
        end
        4'd5: begin
            addr0 <= 4'd4;   // -1
            addr1 <= 4'd5;   // itself
            addr2 <= 4'd6;   // +1
            addr3 <= 4'd3;   // -2
            addr4 <= 4'd7;   // +2
        end
        4'd6: begin
            addr0 <= 4'd5;   // -1
            addr1 <= 4'd6;   // itself
            addr2 <= 4'd7;   // +1
            addr3 <= 4'd4;   // -2
            addr4 <= 4'd8;   // +2
        end
        4'd7: begin
            addr0 <= 4'd6;   // -1
            addr1 <= 4'd7;   // itself
            addr2 <= 4'd8;   // +1
            addr3 <= 4'd5;   // -2
            addr4 <= 4'd9;   // +2
        end
        4'd8: begin
            addr0 <= 4'd7;   // -1
            addr1 <= 4'd8;   // itself
            addr2 <= 4'd9;   // +1
            addr3 <= 4'd6;   // -2
            addr4 <= 4'd10;  // +2
        end
        4'd9: begin
            addr0 <= 4'd8;   // -1
            addr1 <= 4'd9;   // itself
            addr2 <= 4'd10;  // +1
            addr3 <= 4'd7;   // -2
            addr4 <= 4'd11;  // +2
        end
		  4'd10: begin
            addr0 <= 4'd9;   // -1
            addr1 <= 4'd10;  // itself
            addr2 <= 4'd11;  // +1
            addr3 <= 4'd8;   // -2
            addr4 <= 4'd12;  // +2
        end
        4'd11: begin
            addr0 <= 4'd10;  // -1
            addr1 <= 4'd11;  // itself
            addr2 <= 4'd12;  // +1
            addr3 <= 4'd9;   // -2
            addr4 <= 4'd13;  // +2
        end
        4'd12: begin
            addr0 <= 4'd11;  // -1
            addr1 <= 4'd12;  // itself
            addr2 <= 4'd13;  // +1
            addr3 <= 4'd10;  // -2
            addr4 <= 4'd14;  // +2
        end
        4'd13: begin
            addr0 <= 4'd12;  // -1
            addr1 <= 4'd13;  // itself
            addr2 <= 4'd14;  // +1
            addr3 <= 4'd11;  // -2
            addr4 <= 4'd15;  // +2
        end
        4'd14: begin
            addr0 <= 4'd13;  // -1
            addr1 <= 4'd14;  // itself
            addr2 <= 4'd15;  // +1
            addr3 <= 4'd12;  // -2
            addr4 <= 4'd0;   // +2 (wrap around)
        end
        4'd15: begin
            addr0 <= 4'd14;  // -1
            addr1 <= 4'd15;  // itself
            addr2 <= 4'd0;   // +1 (wrap around)
            addr3 <= 4'd13;  // -2
            addr4 <= 4'd1;   // +2 (wrap around)
        end
    endcase
end

endmodule
           
