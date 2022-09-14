`timescale 1ns / 1ps
`include "param.v"

module IF_pc(
    input clk,
    input rst_n,
    input [31:0] npc,
    output [31:0] pc,
    output [31:0] pc4
    
    );
    
    reg [31:0]pc_reg;
    always@(posedge clk or negedge rst_n )begin
    if(~rst_n)begin
        pc_reg <= -4;
  
    end
    else begin
        begin
            pc_reg = npc;   
        end
      end
    end
    assign pc=pc_reg;
    assign pc4=pc+4;
    
endmodule

