module LFSR (input E, input clk, input reset, output reg [11:0]out);
wire linear_feedback;
parameter n = 12;


 assign linear_feedback = (out[n - 1]^out[n - 2]);

 always @ (posedge clk) begin
   if (reset)
      out <= 12'b101010101010;
    else
      if (E)
        out <= {out[10], out[9], out[8], out[7], out[6], out[5],
          out[4], out[3], out[2], out[1], out[0], linear_feedback};
 end
   
endmodule //LFSR

module Down_Counter(input E, input clk, input [11:0]D, input load, output reg [11:0]out);
always @ (posedge clk) begin
  if (load) begin
    out <= D;
  end
  else begin
    if(E) begin
      out <= out - 1;
    end
  end
end
endmodule// Down_Counter
