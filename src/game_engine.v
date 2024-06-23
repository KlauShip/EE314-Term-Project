module game_engine(
    input wire clk,               
    input wire reset,
    input wire button_shoot,
    input wire button_cw,
    input wire button_ccw,
    input wire switch0,
    input wire switch1,
    output wire [3:0] ship_pose,
    output reg [10:0] enemy0_out,
    output reg [10:0] enemy1_out,
    output reg [10:0] enemy2_out,
    output reg [10:0] enemy3_out,
    output reg [10:0] enemy4_out,
    output reg [10:0] enemy5_out,
    output reg [10:0] enemy6_out,
    output reg [10:0] enemy7_out,
    output reg [4:0] score,   
    output reg shoot_mode,
    output reg game_over
);

parameter END_SCORE = 20;  // Parameter to define the end score of the game
parameter MOVE_DIV_FACTOR = 200_000_000; // Enemy move period
parameter SLOW_GEN_DIV_FACTOR = 200_000_000; // Slow mode enemy generation period
parameter FAST_GEN_DIV_FACTOR = 100_000_000; // Fast mode enemy generation period

reg [27:0] GEN_DIV_FACTOR; // Dynamic generation factor
reg [27:0] enemy_gen_counter;   
reg [27:0] enemy_move_counter;
reg [10:0] enemies_out [0:7]; // Unpacked array for internal use
reg [3:0] enemy_count;
reg [1:0] enemy_generated; // Flag to indicate if an enemy has been generated in this cycle

wire shoot_exist; 
wire [1:0] random_type1;
wire [3:0] random_path1;
wire [3:0] possible_adddr [0:4]; // For shoot_mode to detect 3 or 5 projectile

integer i; // For block variable
integer j; // For block variable

random_2bit type_generator1(
    .clk(clk), 
    .reset(reset), 
    .random_number(random_type1)
);

random_4bit path_generator1(
    .clk(clk), 
    .reset(reset), 
    .random_number(random_path1)
);

// Detect button_shoot push
shoot_detector shoot_detector(
    .clk(clk), 
    .reset(reset),
    .button_shoot(button_shoot),
    .shoot_exist(shoot_exist)
);

// Detect button_cw & button_ccw push and assign ship position
ship_controller ship_controller1(
    .clk(clk), 
    .rst(reset),
    .button_cw(button_cw),
    .button_ccw(button_ccw),
    .ship_pose(ship_pose)
); 

// According to ship pose, find [i+2,i--2] projectile addresses
check_projectile check_projectile_inst (
    .clk(clk),
    .ship_pose(ship_pose),
    .addr0(possible_adddr[0]),
    .addr1(possible_adddr[1]),
    .addr2(possible_adddr[2]),
    .addr3(possible_adddr[3]),
    .addr4(possible_adddr[4])
);

initial begin
    for (i = 0; i < 8; i = i + 1) begin
        enemies_out[i] <= 11'b0; // Initialize all enemies to 0
    end
    game_over <= 1;
end

// Assign internal array to output wires
always @(*) begin
    enemy0_out = enemies_out[0];
    enemy1_out = enemies_out[1];
    enemy2_out = enemies_out[2];
    enemy3_out = enemies_out[3];
    enemy4_out = enemies_out[4];
    enemy5_out = enemies_out[5];
    enemy6_out = enemies_out[6];
    enemy7_out = enemies_out[7];
end

// Set GEN_DIV_FACTOR based on switch1
always @(*) begin
    if (switch1 == 1'b0) begin
        GEN_DIV_FACTOR = SLOW_GEN_DIV_FACTOR;
    end else begin
        GEN_DIV_FACTOR = FAST_GEN_DIV_FACTOR;
    end
end

always @(posedge clk or negedge reset) begin
    if (~reset) begin  // Game restart
        for (i = 0; i < 8; i = i + 1) begin
            enemies_out[i] <= 11'b0;
        end
        enemy_count <= 4'b0000;
        enemy_gen_counter <= 0;
        enemy_move_counter <= 0;
        game_over <= 0;
        score <= 0;
    end else begin
        if (switch0) begin
            shoot_mode <= 1;
        end else begin
            shoot_mode <= 0;
        end 
            
        // Game flow state
        if (game_over != 1) begin
            // Enemy generation
            if (enemy_count < 2) begin
                enemy_generated = 1'b0; // Reset the flag
                // Generate up to 2 new enemies
                for (i = 0; i < 8 && (enemy_generated < 2); i = i + 1) begin
                    if (enemies_out[i][10] == 1'b0) begin
                        if (enemy_generated == 0) begin
                            enemies_out[i] <= {1'b1, 2'b00, random_path1, random_type1, random_type1};
                            enemy_count = enemy_count + 1;
                        end else begin
                            enemies_out[i] <= {1'b1, 2'b00, 4'b0100, 2'b01, 2'b01};
                            enemy_count = enemy_count + 1;
                        end
                        enemy_generated = enemy_generated + 1;
                    end
                end
            end else if (enemy_count < 8) begin
                if (enemy_gen_counter == (GEN_DIV_FACTOR - 1)) begin 
                    // Generate 1 new enemy in a period
                    enemy_generated = 1'b0;
                    for (i = 0; i < 8 && enemy_generated == 0; i = i + 1) begin
                        if (enemies_out[i][10] == 1'b0) begin
                            enemies_out[i] <= {1'b1, 2'b00, random_path1, random_type1, random_type1};
                            enemy_generated = 1'b1;
                            enemy_count = enemy_count + 1;
                        end
                    end
                    enemy_gen_counter = 0;
                end else begin 
                    enemy_gen_counter <= enemy_gen_counter + 1;
                end
            end
            
            // Enemy movement
            if (enemy_move_counter == MOVE_DIV_FACTOR - 1) begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (enemies_out[i][10] == 1'b1) begin
                        if (enemies_out[i][9:8] == 2'b11) begin
                            game_over <= 1;
                        end else begin
                            enemies_out[i][9:8] <= enemies_out[i][9:8] + 1;
                        end
                    end
                end
                enemy_move_counter <= 0;
            end else begin
                enemy_move_counter <= enemy_move_counter + 1;
            end    
            
            // Shoot detection
            if (shoot_exist == 1) begin
                if (switch0 == 0) begin // Shoot mode-1 check 5 angles
                    for (i = 0; i < 8; i = i + 1) begin
                        if (enemies_out[i][10] == 1'b1) begin
                            for (j = 0; j < 5; j = j + 1) begin
                                if (possible_adddr[j] == enemies_out[i][7:4]) begin // There is enemy in the trajectory
                                    if (enemies_out[i][1:0] == 0) begin
                                        enemies_out[i] <= 11'b0; // If health level 0 disappear
                                        score <= score + enemies_out[i][3:2] + 1;
                                        if (score >= END_SCORE) begin
                                            game_over <= 1;
                                        end
                                    end else begin
                                        enemies_out[i][1:0] <= enemies_out[i][1:0] - 1; // Health level -1
                                    end
                                end
                            end
                        end
                    end
                    enemy_count = 0;
                    for (i = 0; i < 8; i = i + 1) begin
                        if (enemies_out[i][10] == 1'b1) begin
                            enemy_count = enemy_count + 1;
                        end
                    end
                end else if (switch0 == 1) begin // Shoot mode-2 check 3 angles
                    for (i = 0; i < 8; i = i + 1) begin
                        if (enemies_out[i][10] == 1'b1) begin
                            for (j = 0; j < 3; j = j + 1) begin
                                if (possible_adddr[j] == enemies_out[i][7:4]) begin // There is enemy in the trajectory
                                    if (enemies_out[i][1:0] == 0) begin
                                        enemies_out[i] <= 11'b0; // If health level 0 disappear
                                        score <= score + enemies_out[i][3:2] + 1;
                                        if (score >= END_SCORE - 1) begin
                                            game_over <= 1;
                                        end
                                    end else begin
                                        enemies_out[i][1:0] <= enemies_out[i][1:0] - 1; // Health level -1
                                    end
                                end
                            end
                        end
                    end
                    enemy_count = 0;
                    for (i = 0; i < 8; i = i + 1) begin
                        if (enemies_out[i][10] == 1'b1) begin
                            enemy_count = enemy_count + 1;
                        end
                    end
                end
            end
        end
        // Game over state
        else begin   
            for (i = 0; i < 8; i = i + 1) begin
                enemies_out[i] <= 11'b0;
            end
            enemy_count <= 4'b0000;
            enemy_gen_counter <= 0;
            enemy_move_counter <= 0;
        end
    end
end

endmodule