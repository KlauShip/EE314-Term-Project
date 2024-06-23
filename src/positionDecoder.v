module positionDecoder(
  input wire [10:0] enemy0_out,
  input wire [10:0] enemy1_out,
  input wire [10:0] enemy2_out,
  input wire [10:0] enemy3_out,
  input wire [10:0] enemy4_out,
  input wire [10:0] enemy5_out,
  input wire [10:0] enemy6_out,
  input wire [10:0] enemy7_out,
  output reg [8:0] enemy0_X,
  output reg [8:0] enemy1_X,
  output reg [8:0] enemy2_X,
  output reg [8:0] enemy3_X,
  output reg [8:0] enemy4_X,
  output reg [8:0] enemy5_X,
  output reg [8:0] enemy6_X,
  output reg [8:0] enemy7_X,
  output reg [8:0] enemy0_Y,
  output reg [8:0] enemy1_Y,
  output reg [8:0] enemy2_Y,
  output reg [8:0] enemy3_Y,
  output reg [8:0] enemy4_Y,
  output reg [8:0] enemy5_Y,
  output reg [8:0] enemy6_Y,
  output reg [8:0] enemy7_Y
);

  reg [8:0] tra_x[0:15][0:3];
  reg [8:0] tra_y[0:15][0:3];

  initial begin
    // Initialize tra_x
    tra_x[0][0] = 460; tra_x[0][1] = 420; tra_x[0][2] = 378; tra_x[0][3] = 335;
    tra_x[1][0] = 465; tra_x[1][1] = 423; tra_x[1][2] = 372; tra_x[1][3] = 327;
    tra_x[2][0] = 465; tra_x[2][1] = 404; tra_x[2][2] = 357; tra_x[2][3] = 305;
    tra_x[3][0] = 353; tra_x[3][1] = 328; tra_x[3][2] = 305; tra_x[3][3] = 279;
    tra_x[4][0] = 240; tra_x[4][1] = 240; tra_x[4][2] = 240; tra_x[4][3] = 240;
    tra_x[5][0] = 128; tra_x[5][1] = 152; tra_x[5][2] = 175; tra_x[5][3] = 200;
    tra_x[6][0] = 20; tra_x[6][1] = 73; tra_x[6][2] = 122; tra_x[6][3] = 177;
    tra_x[7][0] = 16; tra_x[7][1] = 57; tra_x[7][2] = 107; tra_x[7][3] = 155;
    tra_x[8][0] = 16; tra_x[8][1] = 59; tra_x[8][2] = 106; tra_x[8][3] = 144;
    tra_x[9][0] = 13; tra_x[9][1] = 56; tra_x[9][2] = 100; tra_x[9][3] = 147;
    tra_x[10][0] = 17; tra_x[10][1] = 71; tra_x[10][2] = 117; tra_x[10][3] = 166;
    tra_x[11][0] = 128; tra_x[11][1] = 146; tra_x[11][2] = 171; tra_x[11][3] = 192;
    tra_x[12][0] = 240; tra_x[12][1] = 240; tra_x[12][2] = 240; tra_x[12][3] = 240;
    tra_x[13][0] = 355; tra_x[13][1] = 334; tra_x[13][2] = 313; tra_x[13][3] = 284;
    tra_x[14][0] = 440; tra_x[14][1] = 396; tra_x[14][2] = 349; tra_x[14][3] = 311;
    tra_x[15][0] = 467; tra_x[15][1] = 419; tra_x[15][2] = 374; tra_x[15][3] = 326;

    // Initialize tra_y
    tra_y[0][0] = 240; tra_y[0][1] = 240; tra_y[0][2] = 240; tra_y[0][3] = 240;
    tra_y[1][0] = 127; tra_y[1][1] = 148; tra_y[1][2] = 176; tra_y[1][3] = 204;
    tra_y[2][0] = 17; tra_y[2][1] = 79; tra_y[2][2] = 130; tra_y[2][3] = 175;
    tra_y[3][0] = 17; tra_y[3][1] = 67; tra_y[3][2] = 106; tra_y[3][3] = 157;
    tra_y[4][0] = 14; tra_y[4][1] = 49; tra_y[4][2] = 98; tra_y[4][3] = 143;
    tra_y[5][0] = 13; tra_y[5][1] = 63; tra_y[5][2] = 107; tra_y[5][3] = 153;
    tra_y[6][0] = 21; tra_y[6][1] = 70; tra_y[6][2] = 124; tra_y[6][3] = 167;
    tra_y[7][0] = 125; tra_y[7][1] = 147; tra_y[7][2] = 173; tra_y[7][3] = 196;
    tra_y[8][0] = 240; tra_y[8][1] = 240; tra_y[8][2] = 240; tra_y[8][3] = 240;
    tra_y[9][0] = 347; tra_y[9][1] = 333; tra_y[9][2] = 304; tra_y[9][3] = 283;
    tra_y[10][0] = 461; tra_y[10][1] = 411; tra_y[10][2] = 361; tra_y[10][3] = 316;
    tra_y[11][0] = 464; tra_y[11][1] = 427; tra_y[11][2] = 381; tra_y[11][3] = 340;
    tra_y[12][0] = 470; tra_y[12][1] = 433; tra_y[12][2] = 301; tra_y[12][3] = 355;
    tra_y[13][0] = 472; tra_y[13][1] = 431; tra_y[13][2] = 387; tra_y[13][3] = 336;
    tra_y[14][0] = 439; tra_y[14][1] = 397; tra_y[14][2] = 354; tra_y[14][3] = 312;
    tra_y[15][0] = 349; tra_y[15][1] = 330; tra_y[15][2] = 301; tra_y[15][3] = 279;
  end

  always @* begin
    // Determine positions for enemy0
    enemy0_X = tra_x[enemy0_out[7:4]][enemy0_out[9:8]];
    enemy0_Y = tra_y[enemy0_out[7:4]][enemy0_out[9:8]];

    // Determine positions for enemy1
    enemy1_X = tra_x[enemy1_out[7:4]][enemy1_out[9:8]];
    enemy1_Y = tra_y[enemy1_out[7:4]][enemy1_out[9:8]];

    // Determine positions for enemy2
    enemy2_X = tra_x[enemy2_out[7:4]][enemy2_out[9:8]];
    enemy2_Y = tra_y[enemy2_out[7:4]][enemy2_out[9:8]];

    // Determine positions for enemy3
    enemy3_X = tra_x[enemy3_out[7:4]][enemy3_out[9:8]];
    enemy3_Y = tra_y[enemy3_out[7:4]][enemy3_out[9:8]];

    // Determine positions for enemy4
    enemy4_X = tra_x[enemy4_out[7:4]][enemy4_out[9:8]];
    enemy4_Y = tra_y[enemy4_out[7:4]][enemy4_out[9:8]];

    // Determine positions for enemy5
    enemy5_X = tra_x[enemy5_out[7:4]][enemy5_out[9:8]];
    enemy5_Y = tra_y[enemy5_out[7:4]][enemy5_out[9:8]];

    // Determine positions for enemy6
    enemy6_X = tra_x[enemy6_out[7:4]][enemy6_out[9:8]];
    enemy6_Y = tra_y[enemy6_out[7:4]][enemy6_out[9:8]];

    // Determine positions for enemy7
    enemy7_X = tra_x[enemy7_out[7:4]][enemy7_out[9:8]];
    enemy7_Y = tra_y[enemy7_out[7:4]][enemy7_out[9:8]];
  end

endmodule
