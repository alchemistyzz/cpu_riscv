// file: param.v
`ifndef CPU_PARAM
`define CPU_PARAM

    // syntax: `define <macro name> <parameter>
    `define ADD     'b000
    `define SUB     'b001
    `define AND     'b010
    `define OR      'b011
    `define XOR     'b100
    `define SLL     'b101
    `define SRL     'b110
    `define SRA     'b111
    
    `define R_TYPE  'b0110011
    `define I_TYPE  'b0010011
    `define LW       'b0000011
    `define JALR     'b1100111
    `define SW       'b0100011
    `define B_TYPE   'b1100011
    `define LUI      'b0110111
    `define JAL      'b1101111
    
    `define PC4 'b00

    `define STATE_IDLE 'b0001
    `define STATE_WRIT 'b0010
    `define STATE_WORK 'b0100
    `define STATE_RETU 'b1000


`endif
