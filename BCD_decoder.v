module BCD_decoder (input [3:0]bcd, output reg [6:0]HEX);
always @ (bcd) begin
  case (bcd)
  4'b0000:HEX[6:0] = 7'b1000000;
  4'b0001:HEX[6:0] = 7'b1111001;
  4'b0010:HEX[6:0] = 7'b0100100;
  4'b0011:HEX[6:0] = 7'b0110000;
  4'b0100:HEX[6:0] = 7'b0011001;
  4'b0101:HEX[6:0] = 7'b0010010;
  4'b0110:HEX[6:0] = 7'b0000010;
  4'b0111:HEX[6:0] = 7'b1111000;
  4'b1000:HEX[6:0] = 7'b0000000;
  4'b1001:HEX[6:0] = 7'b0011000;
    default: HEX[6:0] = 7'bx;
  endcase
end

endmodule //BCD_decoder
