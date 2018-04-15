module top_module (MAX10_CLK1_50, KEY, HEX0, HEX1, HEX2, HEX3, LEDR, SW);
input [1:0] KEY;
input MAX10_CLK1_50;
input [0]SW;
output [6:0] HEX0, HEX1, HEX2, HEX3;
output reg [9:0] LEDR;

reg [2:0]y,Y;
reg LFSR_EN, LFSR_R, DC_L, DC_EN, BCD_EN, BCD_R;
parameter [2:0] Idle = 3'000, LSFR = 3'001, DC = 3'010, BCDC = 3'011, Stop = 3'100, HS = 3'101;
wire clk;
wire [11:0]LFSR_out, DC_out;
wire [3:0]BCD3, BCD2, BCD1, BCD0;
reg [3:0]high_score;

initial begin
  high_score = 4'b1;
end

Clock_divider c1(MAX10_CLK1_50, clk);
LFSR l1(LFSR_EN, MAX10_CLK1_50, LFSR_R, LFSR_out);
Down_Counter d1(BCD_EN, clk, LFSR_out, DC_L, LFSR_out);
BCD_counter bc1(clk, BCD_R, BCD_EN, BCD3, BCD2, BCD1, BCD0);
BCD_decoder bd1(BCD3, HEX3);
BCD_decoder bd2(BCD2, HEX2);
BCD_decoder bd3(BCD1, HEX1);
BCD_decoder bd4(BCD0, HEX0);


always @ ( KEY[0] or SW[0]) begin
  case (y)
    Idle: begin
            LFSR_R = 0;
            LFSR_EN = 0;
            DC_EN = 0;
            DC_L = 0;
            BCD_EN = 0;
            BCD_R = 0;
            if (KEY[0])
              Y = LFSR;
            else begin
              if (SW[0])
                Y = HS;
              else
                Y = Idle;
            end
          end
    LSFR: begin
            LFSR_EN = 1;
            if (KEY[0]) begin
              Y = LFSR;
            end
            else
              Y = DC;

          end
    DC: begin
          LFSR_EN = 0;
          DC_L = 1;
          if (KEY[0]) begin
            Y = DC;
            DC_EN = 0;
          end
          else begin
            Y = BCDC;
            DC_L = 0;
            DC_EN = 1;
          end
        end
    BCDC: begin
            if (DCout == 0) begin
              DC_EN = 0;
              LEDR = 10'b1;
              BCD_EN = 1;
              if (KEY[0])
                Y = Stop;
              else
                Y = BCDC;
            end
          end
   Stop: begin
           LEDR = 10'b0;
           BCD_EN = 0;
           if (SW[0])
              Y = HS;
           else
              Y = Stop;
         end
    default: Idle;
  endcase
end

always @ ( posedge KEY[1], posedge clk) begin
  if (KEY[1]) begin
    y <= Idle;
    LFSR_R = 1;
    BCD_R = 1;
  end
  else
    y <= Y;
end


endmodule //top_module
