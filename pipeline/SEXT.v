`timescale 1ns / 1ps
module SEXT(
    input [31:0]instruction,
    output [31:0]imm_wire_I,
    output [31:0]imm_wire_B,
    output [31:0]imm_wire_J,
    output [31:0]imm_wire_U,
    output [31:0]imm_wire_S
    );
    assign imm_wire_I = {{(32-12){instruction[31]}},instruction[31:20]};
    assign imm_wire_B = {{(32-12){instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
    assign imm_wire_U = {{instruction[31:12]},12'b0};
    assign imm_wire_S = {{(32-12){instruction[31]}},instruction[31:25],instruction[11:7]};
    assign imm_wire_J = {{(32-21){instruction[31]}},instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0};
    
endmodule