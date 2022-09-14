`timescale 1ns / 1ps


module idecode(
    input clk,
    input [4:0]raddr1,//rs1
    input [4:0]raddr2,//rs2
    input [4:0]waddr,//rd
    input we,//§Õ??????
    input [31:0]wdata,//§Õ????
    output [31:0]rdata1,//rs1??????
    output [31:0]rdata2//rs2??????
   
    );
    reg [31:0]reg_array[31:0];//???????
    always @(posedge clk)begin
        if(we)reg_array[waddr]<=wdata;
    end
    assign rdata1=(raddr1==5'b0)?32'b0:reg_array[raddr1];
    assign rdata2=(raddr2==5'b0)?32'b0:reg_array[raddr2];
    
    
endmodule