`timescale 1ns / 1ps

module bo(
    input clk,
    input rst_n,
    input bo_en,
    input [23:0] switch,
    output [31:0]rdata
    );
    reg [31:0] bo_rdata;
always @(posedge clk)begin
    if(bo_en)begin  
      bo_rdata <= {{(8'b0000_0000)},switch};
      end
end
assign rdata=bo_rdata;
   
endmodule
