`timescale 1ns / 1ps

module mux4_32b_(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [1:0] sel,
    output [31:0] out
    );
    assign out = (sel==3'd0)?in0:
                  (sel==3'd1)?in1:
                  (sel==3'd2)?in2:
                  in3;
                     
endmodule

