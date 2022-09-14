`timescale 1ns / 1ps


module NPC(
    input [31:0] pc,
    input [1:0] npc_op,
    input branch_tag,
    input [31:0]rs1,
    input [31:0] imm,
    output [31:0] npc

    );
    reg [31:0] npc_reg;
    always@(*)begin
    
        case(npc_op)
            2'd0:begin
                npc_reg=pc+32'd4;
            end
            2'd1:begin
                case(branch_tag)
                1'd0:npc_reg=pc+32'd4;
                1'd1:npc_reg=pc+imm;
                endcase
            end
            2'd2:begin
                npc_reg=pc+imm;
            end
            2'd3:begin
                npc_reg=rs1+imm;
            end
           
             
        endcase
    end
    assign npc=npc_reg;
endmodule
