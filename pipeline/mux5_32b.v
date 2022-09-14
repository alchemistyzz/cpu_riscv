`timescale 1ns / 1ps

module mux5_32b(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [2:0] sel,
    output [31:0] out
    );
    assign out = (sel==3'd0)?in0:
                  (sel==3'd1)?in1:
                  (sel==3'd2)?in2:
                  (sel==3'd3)?in3:
                  (sel==3'd4)?in4:
                     32'b0;
endmodule
