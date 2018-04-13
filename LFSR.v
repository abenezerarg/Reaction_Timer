module LFSR (input E, input clk, input reset, output reg [3:0]out);
wire linear_feedback;

 assign linear_feedback = (out[3]^out[2]);

 always @ (posedge clk ) begin
   if (reset)
      out <= 4'0;
    else if (E)
      out = {out[2], out[1], out[0], linear_feedback};
 end

endmodule //LFSR
