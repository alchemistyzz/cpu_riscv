`timescale 1ns / 1ps

module minRV(
    input  rst_n,
    input  clk,
    input [31:0] instruction,//??IROM?????????
    input [31:0]rd_data_from_DRAM,//??DRAM????§Õ????????????
    output [31:0] pc,//????pc???
    output dram_we_wire,//??DRAM??§Õ???
    output [31:0] addra,
    output [31:0] data_wr
    );
    wire [31:0] npc;
    
    wire [2:0] fun3;
    wire [6:0] fun7;
    wire [6:0] opCODE; 
    wire [1:0] npc_op_wire;
    wire rf_we_wire;
    wire [1:0] wd_sel_wire;
    wire [2:0] sext_op_wire;
    wire [2:0] alu_op_wire;
    wire alub_sel_wire;
    wire branch_wire;
    
    wire [4:0] rR1;
    wire [4:0] rR2;
    wire [4:0] wR;
    wire [31:0]imm;
   wire [31:0]imm_wire_I;
   wire [31:0]imm_wire_J;
   wire [31:0]imm_wire_U;
   wire [31:0]imm_wire_S;
   wire [31:0]imm_wire_B;
   wire branch_tag;
   wire branch_alu_wire;
   wire [31:0] rdata2;
   wire [1:0]  B_wire;
   
    wire [31:0] rdata1;
    wire [31:0] rdata2_from_RF;
    wire [31:0] pc4;
    

    //pc????
    IF_pc u_IF_pc(
    .clk(clk),
    .rst_n(rst_n),
    .npc(npc),
    .pc(pc),
    .pc4(pc4)
    );
    
    assign branch_tag =branch_alu_wire&branch_wire;
    //npc????
    NPC u_NPC(
    .pc(pc),
    .rs1(rdata1),
    .npc_op(npc_op_wire),
    .branch_tag(branch_tag),
    .imm(imm),
    .npc(npc)
    );

    
    //to CTRL  
   //to idecode
    //?????
    ifetch u_ifetch(
    .inst_i(instruction),
    .rR1(rR1),
    .rR2(rR2),
    .wR(wR),
    .fun3(fun3),
    .fun7(fun7),
    .opCODE(opCODE)
    );
   
   //?????? 
    control u_control(
    .fun3(fun3),
    .fun7(fun7),
    .opcode(opCODE),
    .npc_op_wire(npc_op_wire),
    .rf_we_wire(rf_we_wire),
    .wd_sel_wire(wd_sel_wire),
    .sext_op_wire(sext_op_wire),
    .alu_op_wire(alu_op_wire),
    .alub_sel_wire(alub_sel_wire),
    .branch_wire(branch_wire),
    .dram_we_wire(dram_we_wire),
    .B_wire(B_wire)
    );
    //wD???¡¤?????
    wire [31:0] wD;
    wire [31:0] result_from_alu;
    mux4_32b u_mux4_32b(
    .in0(result_from_alu),
    .in1(pc4),
    .in2(rd_data_from_DRAM),
    .in3(imm),
    .sel(wd_sel_wire),
    .out(wD)
    );
    
    //RF???????
   idecode u_idecode(
   .clk(clk),
   .raddr1(rR1),
   .raddr2(rR2),
   .waddr(wR),
   .we(rf_we_wire),
   .wdata(wD),//wD
   .rdata1(rdata1),
   .rdata2(rdata2_from_RF)
   );
    //SEXT????????????
   
  
   SEXT u_SEXT(
   .instruction(instruction),
   .imm_wire_I(imm_wire_I),
   .imm_wire_B(imm_wire_B),
   .imm_wire_J(imm_wire_J),
   .imm_wire_U(imm_wire_U),
   .imm_wire_S(imm_wire_S)
   );
   //??¡¤?????????????????

   mux5_32b u_mux5_32b(
   .in0(imm_wire_I),
   .in1(imm_wire_S),
   .in2(imm_wire_B),
   .in3(imm_wire_U),
   .in4(imm_wire_J),
   .sel(sext_op_wire),
   .out(imm)
   );
   
   
  
   //???????rs2???????????imm?????¡¤?????
   mux2_32b u_mux2_32b(
   .in0(rdata2_from_RF),
   .in1(imm),
   .sel(alub_sel_wire),
   .out(rdata2)
   );
   

   
   //????ALU???
   execute u_execute(
   .A(rdata1),
   .B(rdata2),
   .B_wire(B_wire),
   .branch(branch_wire),
   .alu_op(alu_op_wire),
   .branch_alu_wire(branch_alu_wire),
   .result_wire(result_from_alu)
   );
   
   assign data_wr = rdata2_from_RF ;
   assign addra = result_from_alu[31:0] ;


endmodule
