module vga (
    input wire clk, reset 
    output wire hsync, vsync, valid
    output wire [9:0] x_pos, y_pos
);

// https://caxapa.ru/thumbs/361638/DMTv1r11.pdf

localparam H_RES = 640;
localparam V_RES = 480;
localparam HOR_R_BORDER = 16;
localparam HOR_L_BORDER = 48;
localparam VER_T_BORDER = 10;
localparam VER_B_BORDER = 32;
localparam HOR_SYNC_PX = 96;
localparam VER_SYNC_PX = 2;

always @(posedge clk) begin 
    if (x < 799) x <= x + 10'd1;
    else x <= 10'd0;
    if (y < 524) y <= y + 10'd1;
    else y <= 10'd0;
end

assign valid = (x_pos < H_RES) && (y_pos < V_RES);

// 640 px, then right border (16), then hsync (96), then left border (48)
assign hsync = (x_pos >= H_RES + HOR_R_BORDER) && 
    (x_pos < H_RES + HOR_R_BORDER + HOR_L_BORDER + HOR_SYNC_PX); 

// 480 px, then bottom border (32), then vsync (2), then top border (10)
assign vsync = (y_pos >= V_RES + VER_B_BORDER) && 
    (y_pos < V_RES + VER_B_BORDER + VER_T_BORDER + VER_SYNC_PX);