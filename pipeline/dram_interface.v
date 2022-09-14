`timescale 1ns / 1ps
module dram_interface(
    input clk,
    input rst_n,
    input [31:0]addra,
    output [31:0]rdata,
    input dram_we_wire,
    input [31:0] wdata,
    input [23:0] switch,
    output [7:0] led_en,
    output wire led_ca,
    output wire led_cb,
    output wire led_cc,
    output wire led_cd,
    output wire led_ce,
    output wire led_cf,
    output wire led_cg,
    output wire led_dp
//    output wire [23:0] lights_o
    );
    wire [31:0] waddr_tmp = addra - 16'h4000;
    wire dram_en ;
    wire dig_en;
    wire LED_en;
    wire keyboard_en;
    wire bo_en;
    wire button_en;
    wire [31:0]rdata_dram;
    wire [31:0]rdata_keyboard;
    wire [31:0]rdata_bo;
    wire dram_wen;
    wire dig_wen;
    wire LED_wen;
    wire dram_ren;
    wire keyboard_ren;
    wire button_ren;
    
    assign dram_en=(addra<=32'h001FFFFF)?1:0;
    assign dig_en=(addra>=32'hFFFFF000&&addra<32'hFFFFF010)?1:0;
    assign keyboard_en=(addra>=32'hFFFFF010&&addra<32'hFFFFF060)?1:0;
    assign LED_en=(addra>=32'hFFFFF060&&addra<32'hFFFFF070)?1:0;
    assign bo_en=(addra>=32'hFFFFF070)?1:0;

    
    assign dram_wen=dram_en&&dram_we_wire;
    assign dig_wen=dig_en&&dram_we_wire;
    assign LED_wen=LED_en&&dram_we_wire;
    assign dram_ren=dram_en;
    assign keyboard_ren=keyboard_ren; 
    
    //DRAM
    dram u_dram (
    .clk    (clk),            // input wire clka
    .a      (waddr_tmp[15:2]),     // input wire [13:0] addra
    .spo   (rdata_dram),        // output wire [31:0] douta
    .we     (dram_wen),          // input wire [0:0] wea
    .d      (wdata)         // input wire [31:0] dina
    );
    
    
   //led ˝¬Îπ‹œ‘ æ
    led_display u_led_display(
   .clk(clk),
   .rst_n(rst_n),
   .dig_en(dig_wen),
   .wdata(wdata),
   .led_en(led_en),
   .led_ca(led_ca),
   .led_cb(led_cb),
   .led_cc(led_cc),
   .led_cd(led_cd),
   .led_ce(led_ce),
   .led_cf(led_cf),
   .led_cg(led_cg),
   .led_dp(led_dp)
   );
   
//   light u_light(
//   .clk(clk),
//   .LED_en(LED_wen),
//   .wdata(wdata),
//   .lights_o(lights_o)
//   );
   
   bo u_bo(
   .clk(clk),
   .rst_n(rst_n),
   .bo_en(bo_en),
   .switch(switch),
   .rdata(rdata_bo)
   );
   
   
   assign rdata=(bo_en)?rdata_bo:rdata_dram;
   
   
   
   
endmodule
