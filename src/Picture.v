module Picture (
	input CLK,
	input [9:0] ADDRH,
	input [8:0] ADDRV,
	output reg [7:0] COLOUR_OUT,
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

	positionDecoder positionDecoder_inst(
		.enemy0_out(enemy0_out),
		.enemy1_out(enemy1_out),
		.enemy2_out(enemy2_out),
		.enemy3_out(enemy3_out),
		.enemy4_out(enemy4_out),
		.enemy5_out(enemy5_out),
		.enemy6_out(enemy6_out),
		.enemy7_out(enemy7_out),
		.enemy0_X(enemy0_X),
		.enemy1_X(enemy1_X),
		.enemy2_X(enemy2_X),
		.enemy3_X(enemy3_X),
		.enemy4_X(enemy4_X),
		.enemy5_X(enemy5_X),
		.enemy6_X(enemy6_X),
		.enemy7_X(enemy7_X),
		.enemy0_Y(enemy0_Y),
		.enemy1_Y(enemy1_Y),
		.enemy2_Y(enemy2_Y),
		.enemy3_Y(enemy3_Y),
		.enemy4_Y(enemy4_Y),
		.enemy5_Y(enemy5_Y),
		.enemy6_Y(enemy6_Y),
		.enemy7_Y(enemy7_Y)
	);

	scoreBoard scoreBoard_inst(
		 .score(score),
		 .tens(tens),    
		 .units(units) 
	);

	initial begin
		$readmemh ("Images/ship_0.list", SHIPPOSE_DATA_0);
		$readmemh ("Images/ship_1.list", SHIPPOSE_DATA_1);
		$readmemh ("Images/ship_2.list", SHIPPOSE_DATA_2);
		$readmemh ("Images/ship_3.list", SHIPPOSE_DATA_3);
		$readmemh ("Images/ship_4.list", SHIPPOSE_DATA_4);
		$readmemh ("Images/ship_5.list", SHIPPOSE_DATA_5);
		$readmemh ("Images/ship_6.list", SHIPPOSE_DATA_6);
		$readmemh ("Images/ship_7.list", SHIPPOSE_DATA_7);
		$readmemh ("Images/ship_8.list", SHIPPOSE_DATA_8);
		$readmemh ("Images/ship_9.list", SHIPPOSE_DATA_9);
		$readmemh ("Images/ship_10.list", SHIPPOSE_DATA_10);
		$readmemh ("Images/ship_11.list", SHIPPOSE_DATA_11);
		$readmemh ("Images/ship_12.list", SHIPPOSE_DATA_12);
		$readmemh ("Images/ship_13.list", SHIPPOSE_DATA_13);
		$readmemh ("Images/ship_14.list", SHIPPOSE_DATA_14);
		$readmemh ("Images/ship_15.list", SHIPPOSE_DATA_15);
		$readmemh ("Images/enemy2g.list", ENEMY_2G);
		$readmemh ("Images/enemy2y.list", ENEMY_2Y);
		$readmemh ("Images/enemy3g.list", ENEMY_3G);
		$readmemh ("Images/enemy3r.list", ENEMY_3R);
		$readmemh ("Images/enemy3y.list", ENEMY_3Y);
		$readmemh ("Images/enemy4b.list", ENEMY_4B);
		$readmemh ("Images/enemy4g.list", ENEMY_4G);
		$readmemh ("Images/enemy4r.list", ENEMY_4R);
		$readmemh ("Images/enemy4y.list", ENEMY_4Y);
		$readmemh ("Images/smiley.list", SMILEY);
		$readmemh ("Images/game_over.list", GAMEOVER);
		$readmemh ("Images/num0.list", NUM0);
		$readmemh ("Images/num1.list", NUM1);
		$readmemh ("Images/num2.list", NUM2);
		$readmemh ("Images/num3.list", NUM3);
		$readmemh ("Images/num4.list", NUM4);
		$readmemh ("Images/num5.list", NUM5);
		$readmemh ("Images/num6.list", NUM6);
		$readmemh ("Images/num7.list", NUM7);
		$readmemh ("Images/num8.list", NUM8);
		$readmemh ("Images/num9.list", NUM9);
		$readmemh ("Images/background.list", BACKGROUND);
		
	end
	
	parameter Background = 18'd230400;
	parameter BackgroundXY = 9'd480;
	parameter X_Background = 1'd0;
	parameter Y_Background = 1'd0;
	
	parameter Ship = 13'd3600;
	parameter ShipXY = 7'd60;
	parameter X_SHIP = 10'd225;
	parameter Y_SHIP = 10'd225;
	
	parameter GameOver = 13'd3600;
	parameter GameOverXY = 7'd60;
	parameter X_GameOver = 10'd540;
	parameter Y_GameOver = 10'd240;
	
	parameter Mode = 11'd1024;
	parameter ModeXY = 6'd32;
	parameter X_Mode = 10'd540;
	parameter Y_Mode = 10'd400;
	
	parameter X_DIGIT1 = 10'd400;  
	parameter Y_DIGIT1 = 10'd10;
	parameter X_DIGIT2 = 10'd440;  
	parameter Y_DIGIT2 = 10'd10;
	
	parameter Enemy = 11'd1024;
	parameter EnemyXY = 6'd32;
	
	wire [3:0] tens;
	wire [3:0] units;
	wire [8:0] enemy0_X;
	wire [8:0] enemy1_X;
	wire [8:0] enemy2_X;
	wire [8:0] enemy3_X;
	wire [8:0] enemy4_X;
	wire [8:0] enemy5_X;
	wire [8:0] enemy6_X;
	wire [8:0] enemy7_X;
	wire [8:0] enemy0_Y;
	wire [8:0] enemy1_Y;
	wire [8:0] enemy2_Y;
	wire [8:0] enemy3_Y;
	wire [8:0] enemy4_Y;
	wire [8:0] enemy5_Y;
	wire [8:0] enemy6_Y;
	wire [8:0] enemy7_Y;
	
	reg [7:0] BACKGROUND [0:Background-1];
	reg [7:0] GAMEOVER [0:GameOver-1];
	reg [7:0] SHIPPOSE_DATA_0 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_1 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_2 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_3 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_4 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_5 [0:Ship-1];
	reg [7:8] SHIPPOSE_DATA_6 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_7 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_8 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_9 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_10 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_11 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_12 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_13 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_14 [0:Ship-1];
	reg [7:0] SHIPPOSE_DATA_15 [0:Ship-1];
	reg [7:0] NUM0 [0:Mode-1];
	reg [7:0] NUM1 [0:Mode-1];
	reg [7:0] NUM2 [0:Mode-1];
	reg [7:0] NUM3 [0:Mode-1];
	reg [7:0] NUM4 [0:Mode-1];
	reg [7:0] NUM5 [0:Mode-1];
	reg [7:0] NUM6 [0:Mode-1];
	reg [7:0] NUM7 [0:Mode-1];
	reg [7:0] NUM8 [0:Mode-1];
	reg [7:0] NUM9 [0:Mode-1];
	reg [7:0] ENEMY_2G [0:Enemy-1];
	reg [7:0] ENEMY_2Y [0:Enemy-1];
	reg [7:0] ENEMY_3G [0:Enemy-1];
	reg [7:0] ENEMY_3R [0:Enemy-1];
	reg [7:0] ENEMY_3Y [0:Enemy-1];
	reg [7:0] ENEMY_4B [0:Enemy-1];
	reg [7:0] ENEMY_4G [0:Enemy-1];
	reg [7:0] ENEMY_4R [0:Enemy-1];
	reg [7:0] ENEMY_4Y [0:Enemy-1];
	reg [7:0] SMILEY   [0:Enemy-1];
	
   //////////
	///WIRE///
	//////////
	wire [17:0] STATE_BACKGROUND;
	wire [12:0] STATE_GAMEOVER;
	wire [12:0] STATE_SHIP;
	wire [12:0] STATE_MODE;
	wire [12:0] STATE_DIGIT1;
	wire [12:0] STATE_DIGIT2;
	wire [10:0] STATE_ENEMY0;
	wire [10:0] STATE_ENEMY1;
	wire [10:0] STATE_ENEMY2;
	wire [10:0] STATE_ENEMY3;
	wire [10:0] STATE_ENEMY4;
	wire [10:0] STATE_ENEMY5;
	wire [10:0] STATE_ENEMY6;
	wire [10:0] STATE_ENEMY7;
	
	/////////////////////
	////ASSIGN STATE/////
	/////////////////////
	assign STATE_BACKGROUND = (ADDRH-X_Background)*BackgroundXY+ADDRV-Y_Background;
	assign STATE_SHIP = (ADDRH-X_SHIP)*ShipXY+ADDRV-Y_SHIP;
	assign STATE_GAMEOVER = (ADDRH-X_GameOver)*GameOverXY+ADDRV-Y_GameOver;
	assign STATE_MODE = (ADDRH-X_Mode)*ModeXY+ADDRV-Y_Mode;
	
	assign STATE_DIGIT1 = (ADDRH-X_DIGIT1)*ModeXY+ADDRV-Y_DIGIT1;
	assign STATE_DIGIT2 = (ADDRH-X_DIGIT2)*ModeXY+ADDRV-Y_DIGIT2;
	
	assign STATE_ENEMY0 = (ADDRH-enemy0_X)*EnemyXY+ADDRV-enemy0_Y;	
	assign STATE_ENEMY1 = (ADDRH-enemy1_X)*EnemyXY+ADDRV-enemy1_Y;	
	assign STATE_ENEMY2 = (ADDRH-enemy2_X)*EnemyXY+ADDRV-enemy2_Y;	
	assign STATE_ENEMY3 = (ADDRH-enemy3_X)*EnemyXY+ADDRV-enemy3_Y;	
	assign STATE_ENEMY4 = (ADDRH-enemy4_X)*EnemyXY+ADDRV-enemy4_Y;	
	assign STATE_ENEMY5 = (ADDRH-enemy5_X)*EnemyXY+ADDRV-enemy5_Y;	
	assign STATE_ENEMY6 = (ADDRH-enemy6_X)*EnemyXY+ADDRV-enemy6_Y;	
	assign STATE_ENEMY7 = (ADDRH-enemy7_X)*EnemyXY+ADDRV-enemy7_Y;	
	
	/////////////////////
	////ALWAYS CHECK POS/
	/////////////////////

	always @(posedge CLK) begin
		// Display ship
		if (ADDRH >= X_GameOver && ADDRH < X_GameOver + GameOverXY &&
        ADDRV >= Y_GameOver && ADDRV < Y_GameOver + GameOverXY) begin
        if (game_over == 1) 
          COLOUR_OUT <= GAMEOVER[{STATE_GAMEOVER}];
		end
		else if (ADDRH >= X_DIGIT1 && ADDRH < X_DIGIT1 + ModeXY &&
        ADDRV >= Y_DIGIT1 && ADDRV < Y_DIGIT1 + ModeXY) begin
        if(tens == 0) 
				COLOUR_OUT <= NUM0[{STATE_DIGIT1}];
        else if (tens == 1)
            COLOUR_OUT <= NUM1[{STATE_DIGIT1}];
			else if (tens == 2)
            COLOUR_OUT <= NUM2[{STATE_DIGIT1}];
			else if (tens == 3)
            COLOUR_OUT <= NUM3[{STATE_DIGIT1}];
			else if (tens == 4)
            COLOUR_OUT <= NUM4[{STATE_DIGIT1}];
			else if (tens == 5)
            COLOUR_OUT <= NUM5[{STATE_DIGIT1}];
			else if (tens == 6)
            COLOUR_OUT <= NUM6[{STATE_DIGIT1}];
			else if (tens == 7)
            COLOUR_OUT <= NUM7[{STATE_DIGIT1}];
			else if (tens == 8)
            COLOUR_OUT <= NUM8[{STATE_DIGIT1}];
			else if (tens == 9)
            COLOUR_OUT <= NUM9[{STATE_DIGIT1}];
		end
		
		else if (ADDRH >= X_DIGIT2 && ADDRH < X_DIGIT2 + ModeXY &&
				ADDRV >= Y_DIGIT2 && ADDRV < Y_DIGIT2 + ModeXY) begin
		 if (units == 0) 
			  COLOUR_OUT <= NUM0[{STATE_DIGIT2}];
		 else if (units == 1)
			  COLOUR_OUT <= NUM1[{STATE_DIGIT2}];
		 else if (units == 2)
			  COLOUR_OUT <= NUM2[{STATE_DIGIT2}];
		 else if (units == 3)
			  COLOUR_OUT <= NUM3[{STATE_DIGIT2}];
		 else if (units == 4)
			  COLOUR_OUT <= NUM4[{STATE_DIGIT2}];
		 else if (units == 5)
			  COLOUR_OUT <= NUM5[{STATE_DIGIT2}];
		 else if (units == 6)
			  COLOUR_OUT <= NUM6[{STATE_DIGIT2}];
		 else if (units == 7)
			  COLOUR_OUT <= NUM7[{STATE_DIGIT2}];
		 else if (units == 8)
			  COLOUR_OUT <= NUM8[{STATE_DIGIT2}];
		 else if (units == 9)
			  COLOUR_OUT <= NUM9[{STATE_DIGIT2}];
	end
		
		else if (ADDRH>=X_SHIP && ADDRH<X_SHIP+ShipXY && ADDRV>=Y_SHIP && ADDRV<Y_SHIP+ShipXY) begin
		  if (ship_pose == 4'b0000)
            COLOUR_OUT <= SHIPPOSE_DATA_0[{STATE_SHIP}];
        else if (ship_pose == 4'b0001)
            COLOUR_OUT <= SHIPPOSE_DATA_1[{STATE_SHIP}];
        else if (ship_pose == 4'b0010)
            COLOUR_OUT <= SHIPPOSE_DATA_2[{STATE_SHIP}];
        else if (ship_pose == 4'b0011)
            COLOUR_OUT <= SHIPPOSE_DATA_3[{STATE_SHIP}];
        else if (ship_pose == 4'b0100)
            COLOUR_OUT <= SHIPPOSE_DATA_4[{STATE_SHIP}];
        else if (ship_pose == 4'b0101)
            COLOUR_OUT <= SHIPPOSE_DATA_5[{STATE_SHIP}];
        else if (ship_pose == 4'b0110)
            COLOUR_OUT <= SHIPPOSE_DATA_6[{STATE_SHIP}];
        else if (ship_pose == 4'b0111)
            COLOUR_OUT <= SHIPPOSE_DATA_7[{STATE_SHIP}];
        else if (ship_pose == 4'b1000)
            COLOUR_OUT <= SHIPPOSE_DATA_8[{STATE_SHIP}];
        else if (ship_pose == 4'b1001)
            COLOUR_OUT <= SHIPPOSE_DATA_9[{STATE_SHIP}];
        else if (ship_pose == 4'b1010)
            COLOUR_OUT <= SHIPPOSE_DATA_10[{STATE_SHIP}];
        else if (ship_pose == 4'b1011)
            COLOUR_OUT <= SHIPPOSE_DATA_11[{STATE_SHIP}];
        else if (ship_pose == 4'b1100)
            COLOUR_OUT <= SHIPPOSE_DATA_12[{STATE_SHIP}];
        else if (ship_pose == 4'b1101)
            COLOUR_OUT <= SHIPPOSE_DATA_13[{STATE_SHIP}];
        else if (ship_pose == 4'b1110)
            COLOUR_OUT <= SHIPPOSE_DATA_14[{STATE_SHIP}];
        else if (ship_pose == 4'b1111)
            COLOUR_OUT <= SHIPPOSE_DATA_15[{STATE_SHIP}];
    end 
	
	else if (ADDRH >= X_Mode && ADDRH < X_Mode + ModeXY &&
        ADDRV >= Y_Mode && ADDRV < Y_Mode + ModeXY) begin
        if (shoot_mode == 1) 
          COLOUR_OUT <= NUM2[{STATE_MODE}];
		  else
			COLOUR_OUT <= NUM1[{STATE_MODE}];
	end
	
	
		///////////////////////////////
		////////////ENEMYYYY///////////
		///////////////////////////////
	else if (ADDRH >= enemy0_X && ADDRH < enemy0_X + EnemyXY &&
             ADDRV >= enemy0_Y && ADDRV < enemy0_Y + EnemyXY) begin
        if (enemy0_out[10] == 1) begin
            if (enemy0_out[3:2] == 2'd3 && enemy0_out[1:0] == 2'd3)
                COLOUR_OUT <= ENEMY_4B[{STATE_ENEMY0}];
            else if (enemy0_out[3:2] == 2'd3 && enemy0_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_4R[{STATE_ENEMY0}];
            else if (enemy0_out[3:2] == 2'd3 && enemy0_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_4G[{STATE_ENEMY0}];
            else if (enemy0_out[3:2] == 2'd3 && enemy0_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_4Y[{STATE_ENEMY0}];
            else if (enemy0_out[3:2] == 2'd2 && enemy0_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_3R[{STATE_ENEMY0}];
            else if (enemy0_out[3:2] == 2'd2 && enemy0_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_3G[{STATE_ENEMY0}];
            else if (enemy0_out[3:2] == 2'd2 && enemy0_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_3Y[{STATE_ENEMY0}];
            else if (enemy0_out[3:2] == 2'd1 && enemy0_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_2G[{STATE_ENEMY0}];
            else if (enemy0_out[3:2] == 2'd1 && enemy0_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_2Y[{STATE_ENEMY0}];
            else if (enemy0_out[3:2] == 2'd0 && enemy0_out[1:0] == 2'd0)
                COLOUR_OUT <= SMILEY[{STATE_ENEMY0}];
        end
    end

    // Enemy 1 display logic
    else if (ADDRH >= enemy1_X && ADDRH < enemy1_X + EnemyXY &&
             ADDRV >= enemy1_Y && ADDRV < enemy1_Y + EnemyXY) begin
        if (enemy1_out[10] == 1) begin
            if (enemy1_out[3:2] == 2'd3 && enemy1_out[1:0] == 2'd3)
                COLOUR_OUT <= ENEMY_4B[{STATE_ENEMY1}];
            else if (enemy1_out[3:2] == 2'd3 && enemy1_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_4R[{STATE_ENEMY1}];
            else if (enemy1_out[3:2] == 2'd3 && enemy1_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_4G[{STATE_ENEMY1}];
            else if (enemy1_out[3:2] == 2'd3 && enemy1_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_4Y[{STATE_ENEMY1}];
            else if (enemy1_out[3:2] == 2'd2 && enemy1_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_3R[{STATE_ENEMY1}];
            else if (enemy1_out[3:2] == 2'd2 && enemy1_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_3G[{STATE_ENEMY1}];
            else if (enemy1_out[3:2] == 2'd2 && enemy1_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_3Y[{STATE_ENEMY1}];
            else if (enemy1_out[3:2] == 2'd1 && enemy1_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_2G[{STATE_ENEMY1}];
            else if (enemy1_out[3:2] == 2'd1 && enemy1_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_2Y[{STATE_ENEMY1}];
            else if (enemy1_out[3:2] == 2'd0 && enemy1_out[1:0] == 2'd0)
                COLOUR_OUT <= SMILEY[{STATE_ENEMY1}];
        end
    end

    // Enemy 2 display logic
    else if (ADDRH >= enemy2_X && ADDRH < enemy2_X + EnemyXY &&
             ADDRV >= enemy2_Y && ADDRV < enemy2_Y + EnemyXY) begin
        if (enemy2_out[10] == 1) begin
            if (enemy2_out[3:2] == 2'd3 && enemy2_out[1:0] == 2'd3)
                COLOUR_OUT <= ENEMY_4B[{STATE_ENEMY2}];
            else if (enemy2_out[3:2] == 2'd3 && enemy2_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_4R[{STATE_ENEMY2}];
            else if (enemy2_out[3:2] == 2'd3 && enemy2_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_4G[{STATE_ENEMY2}];
            else if (enemy2_out[3:2] == 2'd3 && enemy2_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_4Y[{STATE_ENEMY2}];
            else if (enemy2_out[3:2] == 2'd2 && enemy2_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_3R[{STATE_ENEMY2}];
            else if (enemy2_out[3:2] == 2'd2 && enemy2_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_3G[{STATE_ENEMY2}];
            else if (enemy2_out[3:2] == 2'd2 && enemy2_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_3Y[{STATE_ENEMY2}];
            else if (enemy2_out[3:2] == 2'd1 && enemy2_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_2G[{STATE_ENEMY2}];
            else if (enemy2_out[3:2] == 2'd1 && enemy2_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_2Y[{STATE_ENEMY2}];
            else if (enemy2_out[3:2] == 2'd0 && enemy2_out[1:0] == 2'd0)
                COLOUR_OUT <= SMILEY[{STATE_ENEMY2}];
        end
    end

    // Enemy 3 display logic
    else if (ADDRH >= enemy3_X && ADDRH < enemy3_X + EnemyXY &&
             ADDRV >= enemy3_Y && ADDRV < enemy3_Y + EnemyXY) begin
        if (enemy3_out[10] == 1) begin
            if (enemy3_out[3:2] == 2'd3 && enemy3_out[1:0] == 2'd3)
                COLOUR_OUT <= ENEMY_4B[{STATE_ENEMY3}];
            else if (enemy3_out[3:2] == 2'd3 && enemy3_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_4R[{STATE_ENEMY3}];
            else if (enemy3_out[3:2] == 2'd3 && enemy3_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_4G[{STATE_ENEMY3}];
            else if (enemy3_out[3:2] == 2'd3 && enemy3_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_4Y[{STATE_ENEMY3}];
            else if (enemy3_out[3:2] == 2'd2 && enemy3_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_3R[{STATE_ENEMY3}];
            else if (enemy3_out[3:2] == 2'd2 && enemy3_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_3G[{STATE_ENEMY3}];
            else if (enemy3_out[3:2] == 2'd2 && enemy3_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_3Y[{STATE_ENEMY3}];
            else if (enemy3_out[3:2] == 2'd1 && enemy3_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_2G[{STATE_ENEMY3}];
            else if (enemy3_out[3:2] == 2'd1 && enemy3_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_2Y[{STATE_ENEMY3}];
            else if (enemy3_out[3:2] == 2'd0 && enemy3_out[1:0] == 2'd0)
                COLOUR_OUT <= SMILEY[{STATE_ENEMY3}];
        end
    end

    // Enemy 4 display logic
    else if (ADDRH >= enemy4_X && ADDRH < enemy4_X + EnemyXY &&
             ADDRV >= enemy4_Y && ADDRV < enemy4_Y + EnemyXY) begin
        if (enemy4_out[10] == 1) begin
            if (enemy4_out[3:2] == 2'd3 && enemy4_out[1:0] == 2'd3)
                COLOUR_OUT <= ENEMY_4B[{STATE_ENEMY4}];
            else if (enemy4_out[3:2] == 2'd3 && enemy4_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_4R[{STATE_ENEMY4}];
            else if (enemy4_out[3:2] == 2'd3 && enemy4_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_4G[{STATE_ENEMY4}];
            else if (enemy4_out[3:2] == 2'd3 && enemy4_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_4Y[{STATE_ENEMY4}];
            else if (enemy4_out[3:2] == 2'd2 && enemy4_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_3R[{STATE_ENEMY4}];
            else if (enemy4_out[3:2] == 2'd2 && enemy4_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_3G[{STATE_ENEMY4}];
            else if (enemy4_out[3:2] == 2'd2 && enemy4_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_3Y[{STATE_ENEMY4}];
            else if (enemy4_out[3:2] == 2'd1 && enemy4_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_2G[{STATE_ENEMY4}];
            else if (enemy4_out[3:2] == 2'd1 && enemy4_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_2Y[{STATE_ENEMY4}];
            else if (enemy4_out[3:2] == 2'd0 && enemy4_out[1:0] == 2'd0)
                COLOUR_OUT <= SMILEY[{STATE_ENEMY4}];
        end
    end

    // Enemy 5 display logic
    else if (ADDRH >= enemy5_X && ADDRH < enemy5_X + EnemyXY &&
             ADDRV >= enemy5_Y && ADDRV < enemy5_Y + EnemyXY) begin
        if (enemy5_out[10] == 1) begin
            if (enemy5_out[3:2] == 2'd3 && enemy5_out[1:0] == 2'd3)
                COLOUR_OUT <= ENEMY_4B[{STATE_ENEMY5}];
            else if (enemy5_out[3:2] == 2'd3 && enemy5_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_4R[{STATE_ENEMY5}];
            else if (enemy5_out[3:2] == 2'd3 && enemy5_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_4G[{STATE_ENEMY5}];
            else if (enemy5_out[3:2] == 2'd3 && enemy5_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_4Y[{STATE_ENEMY5}];
            else if (enemy5_out[3:2] == 2'd2 && enemy5_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_3R[{STATE_ENEMY5}];
            else if (enemy5_out[3:2] == 2'd2 && enemy5_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_3G[{STATE_ENEMY5}];
            else if (enemy5_out[3:2] == 2'd2 && enemy5_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_3Y[{STATE_ENEMY5}];
            else if (enemy5_out[3:2] == 2'd1 && enemy5_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_2G[{STATE_ENEMY5}];
            else if (enemy5_out[3:2] == 2'd1 && enemy5_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_2Y[{STATE_ENEMY5}];
            else if (enemy5_out[3:2] == 2'd0 && enemy5_out[1:0] == 2'd0)
                COLOUR_OUT <= SMILEY[{STATE_ENEMY5}];
        end
    end

    // Enemy 6 display logic
    else if (ADDRH >= enemy6_X && ADDRH < enemy6_X + EnemyXY &&
             ADDRV >= enemy6_Y && ADDRV < enemy6_Y + EnemyXY) begin
        if (enemy6_out[10] == 1) begin
            if (enemy6_out[3:2] == 2'd3 && enemy6_out[1:0] == 2'd3)
                COLOUR_OUT <= ENEMY_4B[{STATE_ENEMY6}];
            else if (enemy6_out[3:2] == 2'd3 && enemy6_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_4R[{STATE_ENEMY6}];
            else if (enemy6_out[3:2] == 2'd3 && enemy6_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_4G[{STATE_ENEMY6}];
            else if (enemy6_out[3:2] == 2'd3 && enemy6_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_4Y[{STATE_ENEMY6}];
            else if (enemy6_out[3:2] == 2'd2 && enemy6_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_3R[{STATE_ENEMY6}];
            else if (enemy6_out[3:2] == 2'd2 && enemy6_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_3G[{STATE_ENEMY6}];
            else if (enemy6_out[3:2] == 2'd2 && enemy6_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_3Y[{STATE_ENEMY6}];
            else if (enemy6_out[3:2] == 2'd1 && enemy6_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_2G[{STATE_ENEMY6}];
            else if (enemy6_out[3:2] == 2'd1 && enemy6_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_2Y[{STATE_ENEMY6}];
            else if (enemy6_out[3:2] == 2'd0 && enemy6_out[1:0] == 2'd0)
                COLOUR_OUT <= SMILEY[{STATE_ENEMY6}];
        end
    end

    // Enemy 7 display logic
    else if (ADDRH >= enemy7_X && ADDRH < enemy7_X + EnemyXY &&
             ADDRV >= enemy7_Y && ADDRV < enemy7_Y + EnemyXY) begin
        if (enemy7_out[10] == 1) begin
            if (enemy7_out[3:2] == 2'd3 && enemy7_out[1:0] == 2'd3)
                COLOUR_OUT <= ENEMY_4B[{STATE_ENEMY7}];
            else if (enemy7_out[3:2] == 2'd3 && enemy7_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_4R[{STATE_ENEMY7}];
            else if (enemy7_out[3:2] == 2'd3 && enemy7_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_4G[{STATE_ENEMY7}];
            else if (enemy7_out[3:2] == 2'd3 && enemy7_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_4Y[{STATE_ENEMY7}];
            else if (enemy7_out[3:2] == 2'd2 && enemy7_out[1:0] == 2'd2)
                COLOUR_OUT <= ENEMY_3R[{STATE_ENEMY7}];
            else if (enemy7_out[3:2] == 2'd2 && enemy7_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_3G[{STATE_ENEMY7}];
            else if (enemy7_out[3:2] == 2'd2 && enemy7_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_3Y[{STATE_ENEMY7}];
            else if (enemy7_out[3:2] == 2'd1 && enemy7_out[1:0] == 2'd1)
                COLOUR_OUT <= ENEMY_2G[{STATE_ENEMY7}];
            else if (enemy7_out[3:2] == 2'd1 && enemy7_out[1:0] == 2'd0)
                COLOUR_OUT <= ENEMY_2Y[{STATE_ENEMY7}];
            else if (enemy7_out[3:2] == 2'd0 && enemy7_out[1:0] == 2'd0)
                COLOUR_OUT <= SMILEY[{STATE_ENEMY7}];
        end
    end
	 
	 else if (ADDRH >= X_Background && ADDRH < X_Background + BackgroundXY &&
             ADDRV >= Y_Background && ADDRV < Y_Background + BackgroundXY) begin
		 COLOUR_OUT <= BACKGROUND[{STATE_BACKGROUND}];
	end
end
endmodule




	
