module Clock_divider (input clk, output reg clkout);
reg [16:0]counter;

initial begin
  counter = 0;
end

always @ (posedge clk) begin
  counter = counter + 1;
  if (counter == 50000)begin
    clkout = ~clkout;
    counter = 0;
  end
end
endmodule //Clock_divider
