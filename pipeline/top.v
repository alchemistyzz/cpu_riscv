`timescale 1ns / 1ps

module top (
    input  wire clk_i,
    input  wire rst_i,
    input [23:0]switch_i,
    output [23:0] lights_o,
    output wire led0_en_o,
    output wire led1_en_o,
    output wire led2_en_o,
    output wire led3_en_o,
    output wire led4_en_o,
    output wire led5_en_o,
    output wire led6_en_o,
    output wire led7_en_o,
    output wire led_ca_o,
    output wire led_cb_o,
    output wire led_cc_o,
    output wire led_cd_o,
    output wire led_ce_o,
    output wire led_cf_o,
    output wire led_cg_o,
    output wire led_dp_o
);
    wire [7:0]led_en;
    assign led0_en_o = led_en[0];
    assign led1_en_o = led_en[1];
    assign led2_en_o = led_en[2];
    assign led3_en_o = led_en[3];
    assign led4_en_o = led_en[4];
    assign led5_en_o = led_en[5];
    assign led6_en_o = led_en[6];
    assign led7_en_o = led_en[7];
    
    wire rst_n = !rst_i;
    wire [31:0] instruction;
    wire [31:0] pc;
    wire [31:0] rd_data;
    wire [31:0] addra;
    wire  dram_we_wire;
    wire [31:0] wdata;
   
    
    wire locked; 
    wire clk;

    cpuclk u_cpuclk(
        .clk_in1 (clk_i),
        .locked (locked),
        .clk_out1(clk)
     );

    minRV u_minRV(
    .clk (clk_i),
    .rst_n (rst_n),
    //from IROM
    .instruction(instruction),
    //toIROM
    .pc(pc),
    //from DRAM
    .rd_data_from_DRAM(rd_data),
    //to DRAM
    .addra(addra),
    .dram_we_wire(dram_we_wire),
    .data_wr(wdata)
    );
    
    dram_interface u_dram_interface(
    .clk(clk_i),
    .rst_n(rst_n),
    .addra(addra),
    .rdata(rd_data),
    .switch(switch_i),
    .dram_we_wire(dram_we_wire),
    .wdata(wdata),
//    .lights_o(lights_o),
   .led_en(led_en),
   .led_ca(led_ca_o),
   .led_cb(led_cb_o),
   .led_cc(led_cc_o),
   .led_cd(led_cd_o),
   .led_ce(led_ce_o),
   .led_cf(led_cf_o),
   .led_cg(led_cg_o),
   .led_dp(led_dp_o)

    );
    //IROM
   prgrom u_prgrom(
        .a      (pc[15:2]),   // input wire [13:0] a
        .spo    (instruction)   // output wire [31:0] spo
    );
    assign lights_o = switch_i; 
    
endmodule