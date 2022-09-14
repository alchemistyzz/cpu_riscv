`timescale 1ns / 1ps

module light(
    input clk,
    input LED_en,
    input [31:0] wdata,
    output [23:0] lights_o
    );
    reg [23:0] lights_o_reg;
    always@(posedge clk)
    begin
        if(LED_en)begin
            lights_o_reg  = wdata[23:0]; 
        end
    end
    assign lights_o = lights_o_reg;
    
endmodule