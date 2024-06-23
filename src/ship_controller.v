module ship_controller (
  input wire clk,  // 50,000,000 Mhz
  input wire rst,     
  input wire button_ccw,           
  input wire button_cw,         
  output reg [3:0] ship_pose 
);
  parameter DIVIDE_BY = 10_000_000; // CHANGE SENSITIVITY
  reg [22:0] counter;       
  reg clk_out;              

  always @(posedge clk or negedge rst) begin
    if (~rst) begin
      counter <= 0;
      clk_out <= 0;
    end else begin
      if (counter == (DIVIDE_BY / 2 - 1)) begin
        clk_out <= ~clk_out;  
        counter <= 0;         
      end else begin
        counter <= counter + 1;  
      end
    end
  end

  always @(posedge clk_out or negedge rst) begin
    if (~rst) begin
      ship_pose <= 4'b0000; // Reset count
    end else begin
      if (button_ccw == 1'b0) begin
        if (ship_pose < 4'b1111) begin
          ship_pose <= ship_pose + 1; // Count button_ccw
        end else begin
          ship_pose <= 4'b0000; // Reset counter
        end
      end else if (button_cw == 1'b0) begin
        if (ship_pose > 4'b0000) begin
          ship_pose <= ship_pose - 1; // Count button_cw
        end else begin
          ship_pose <= 4'b1111; // Reset counter
        end
      end
    end
  end

endmodule
