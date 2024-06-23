module shoot_detector (
    input wire clk,
    input wire reset,
    input wire button_shoot,
    output reg shoot_exist
);

reg shoot_button_sync1, shoot_button_sync2;
reg shoot_button_prev;

always @(posedge clk or negedge reset) begin
    if (~reset) begin
        shoot_button_sync1 <= 1'b0;
        shoot_button_sync2 <= 1'b0;
        shoot_button_prev <= 1'b0;
        shoot_exist <= 1'b0;
    end else begin
        // Synchronize shoot_button to clk domain
        shoot_button_sync1 <= button_shoot;
        shoot_button_sync2 <= shoot_button_sync1;

        // Detect negative edge(1 to 0
        if (~shoot_button_sync2 && shoot_button_prev) begin
            shoot_exist <= 1'b1;
        end else begin
            shoot_exist <= 1'b0;
        end

        // Update previous state
        shoot_button_prev <= shoot_button_sync2;
    end
end

endmodule
