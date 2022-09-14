`timescale 1ns / 1ps

module ifetch(
     //from inst_rom
    input   [31:0]   inst_i,
    // to ex
    output  wire [4:0] rR1,
    output  wire [4:0] rR2,
    output  wire [4:0] wR,
    //to CTRL
    output wire [2:0] fun3,
    output wire [6:0] fun7,
    output wire [6:0] opCODE 
         
    );
    assign rR1 = inst_i[19:15];
    assign rR2 = inst_i[24:20];
    assign wR = inst_i[11:7];
    assign fun3 = inst_i[14:12];
    assign fun7 = inst_i[31:25];
    assign opCODE = inst_i[6:0];
 
    

endmodule
