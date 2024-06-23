`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Montvydas Klumbys 
// 
// Create Date:    
// Design Name: 
// Module Name:    MainActivity 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MainActivity(
   input CLK,					//clock signal
   output [7:0] COLOUR_OUT,//bit patters for colour that goes to VGA port
   output HS,					//Horizontal Synch signal that goes into VGA port
   output VS,					//Vertical Synch signal that goes into VGA port
	output clk25MHz,
	
	input wire [3:0] ship_pose,
   input wire [10:0] enemy0_out,
   input wire [10:0] enemy1_out,
   input wire [10:0] enemy2_out,
   input wire [10:0] enemy3_out,
   input wire [10:0] enemy4_out,
   input wire [10:0] enemy5_out,
   input wire [10:0] enemy6_out,
   input wire [10:0] enemy7_out,
	input wire [4:0] score,   
	input wire shoot_mode,
	input wire game_over
	);
	
	reg DOWNCOUNTER = 0;		//need a downcounter to 25MHz
	parameter Gimpy = 13'd900;	//overall there are 6400 pixels
	parameter GimpyXY = 7'd30;	//Gimp has 80x80 pixels

	//Downcounter to 25MHz		
	always @(posedge CLK)begin     
		DOWNCOUNTER <= ~DOWNCOUNTER;	//Slow down the counter to 25MHz
	end
	
	assign  clk25MHz = DOWNCOUNTER;
	
	wire [7:0] COLOUR_IN;
	reg [7:0] COLOUR_DATA [0:Gimpy-1];
	wire [12:0] STATE;
	wire TrigRefresh;			//Trigger gives a pulse when displayed refreshed
	wire [9:0] ADDRH;			//wire for getting Horizontal pixel value
	wire [8:0] ADDRV;			//wire for getting vertical pixel value
	
	//VGA Interface gets values of ADDRH & ADDRV and by puting COLOUR_IN, gets valid output COLOUR_OUT
	//Also gets a trigger, when the screen is refreshed
	VGAInterface VGA(
				.CLK(CLK),
			   .COLOUR_IN (COLOUR_IN),
				.COLOUR_OUT(),
				.HS(HS),
				.VS(VS),
				.REFRESH(TrigRefresh),
				.ADDRH(ADDRH),
				.ADDRV(ADDRV),
				.DOWNCOUNTER(DOWNCOUNTER)
				);
	
	Picture axc(
				.CLK(CLK),
				.ADDRH(ADDRH),
				.ADDRV(ADDRV),
				.COLOUR_OUT(COLOUR_OUT),
				.ship_pose(ship_pose),
			   .enemy0_out(enemy0_out),
			   .enemy1_out(enemy1_out),
			   .enemy2_out(enemy2_out),
			   .enemy3_out(enemy3_out),
			   .enemy4_out(enemy4_out),
			   .enemy5_out(enemy5_out),
			   .enemy6_out(enemy6_out),
			   .enemy7_out(enemy7_out),
			   .score(score),   
			   .shoot_mode(shoot_mode),
			   .game_over(game_over)
				);

endmodule



