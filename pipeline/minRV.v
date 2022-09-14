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
    wire [31:0] wD;
    wire [31:0] result_from_alu;
    
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
    wire [4:0] rd;
    reg [31:0] pc_IF_to_ID_reg;
    reg [2:0]  fun3_IF_to_ID_reg;
    reg [2:0]  fun7_IF_to_ID_reg;
    reg [6:0] opCODE_IF_to_ID_reg;
    reg  [31:0] pc4_IF_to_ID_reg;
    reg [31:0] instruction_IF_to_ID_reg;
    reg [4:0] rR1_IF_to_ID_reg;
    reg [4:0] rR2_IF_to_ID_reg;
    reg [4:0] wR_IF_to_ID_reg;
    reg [1:0]NPC_op_reg_IF_to_ID;
    always@(posedge clk or negedge rst_n)
    begin
    if(~rst_n)begin
        pc_IF_to_ID_reg <= 32'b0;
        fun3_IF_to_ID_reg <= 3'b000;
        fun7_IF_to_ID_reg <= 3'b000;
        opCODE_IF_to_ID_reg <= 7'b0;
        pc4_IF_to_ID_reg <= 32'b0;
        instruction_IF_to_ID_reg <= 32'b0;
        rR1_IF_to_ID_reg <= 5'b0;
        rR2_IF_to_ID_reg <= 5'b0;
        wR_IF_to_ID_reg <= 5'b0;
        NPC_op_reg_IF_to_ID <=2'b0;
        end
    else begin
        pc_IF_to_ID_reg <= pc;
        fun3_IF_to_ID_reg <= fun3;
        fun7_IF_to_ID_reg <= fun7;
        opCODE_IF_to_ID_reg <= opCODE;
        pc4_IF_to_ID_reg <= pc4;
        instruction_IF_to_ID_reg <= instruction;
        rR1_IF_to_ID_reg <= rR1;
        rR2_IF_to_ID_reg <= rR2;
        wR_IF_to_ID_reg <= wR;
        NPC_op_reg_IF_to_ID <=npc_op_wire;
        end
    end
    
    reg [1:0] npc_op_wire_reg_ID_to_ALU;
    reg rf_we_wire_reg_ID_to_ALU;
    reg [1:0] wd_sel_wire_reg_ID_to_ALU;
//    reg [2:0] sext_op_wire_reg_ID_to_ALU;
    reg [2:0] alu_op_wire_reg_ID_to_ALU;
//    reg alub_sel_wire_reg_ID_to_ALU;
    reg branch_wire_reg_ID_to_ALU;
    reg [31:0] imm_reg_ID_to_ALU;
    reg [31:0] rdata1_reg_ID_to_ALU;
    reg [31:0] rdata2_reg_ID_to_ALU;
//    reg [31:0] rdata2_reg_ID_to_ALU;
    reg [31:0] rdata2_from_RF_reg_ID_to_ALU;
    reg [1:0]  B_wire_reg_ID_to_ALU;
    reg dram_we_wire_reg_ID_to_ALU;
    reg [31:0] pc4_from_alu_reg_ID_to_ALU;
    reg [4:0] wR_ID_to_ALU_reg;
    reg [1:0]NPC_op_reg_ID_to_ALU;
    reg [31:0] pc_ID_to_ALU_reg;
   always @(posedge clk or negedge rst_n)begin
   if(~rst_n)begin
        npc_op_wire_reg_ID_to_ALU <= 0;//
        rf_we_wire_reg_ID_to_ALU <=  0;
        wd_sel_wire_reg_ID_to_ALU <=  0;
//        sext_op_wire_reg_ID_to_ALU <= sext_op_wire;
        alu_op_wire_reg_ID_to_ALU <= 0;
//        alub_sel_wire_reg_ID_to_ALU <= alub_sel_wire;
        branch_wire_reg_ID_to_ALU <= 0;
        imm_reg_ID_to_ALU <= 0;
//        rdata2_reg_ID_to_ALU <= rdata2;
        rdata2_from_RF_reg_ID_to_ALU <= 0;
        rdata1_reg_ID_to_ALU <= 0;
        rdata2_reg_ID_to_ALU <= 0;
        B_wire_reg_ID_to_ALU <= 0; 
        dram_we_wire_reg_ID_to_ALU<=0;
        pc4_from_alu_reg_ID_to_ALU<=0;
        wR_ID_to_ALU_reg<=0;
        NPC_op_reg_ID_to_ALU<=0;
        pc_ID_to_ALU_reg<=0;
   end
        npc_op_wire_reg_ID_to_ALU <= npc_op_wire;//
        rf_we_wire_reg_ID_to_ALU <=  rf_we_wire;
        wd_sel_wire_reg_ID_to_ALU <=  wd_sel_wire;
//        sext_op_wire_reg_ID_to_ALU <= sext_op_wire;
        alu_op_wire_reg_ID_to_ALU <= alu_op_wire;
//        alub_sel_wire_reg_ID_to_ALU <= alub_sel_wire;
        branch_wire_reg_ID_to_ALU <= branch_wire;
        imm_reg_ID_to_ALU <= imm;
//        rdata2_reg_ID_to_ALU <= rdata2;
        rdata2_from_RF_reg_ID_to_ALU <= rdata2_from_RF;
        rdata1_reg_ID_to_ALU <= rdata1;
        rdata2_reg_ID_to_ALU <= rdata2;
        B_wire_reg_ID_to_ALU <= B_wire; 
        dram_we_wire_reg_ID_to_ALU<=dram_we_wire;
        pc4_from_alu_reg_ID_to_ALU<=pc4_IF_to_ID_reg;
        wR_ID_to_ALU_reg<=wR_IF_to_ID_reg;
        NPC_op_reg_ID_to_ALU<=NPC_op_reg_IF_to_ID;
        pc_ID_to_ALU_reg<=pc_IF_to_ID_reg;
   end
   
   reg branch_tag_reg_ALU_to_MEM;
   reg [31:0] result_from_alu_reg_ALU_to_MEM;
   reg [31:0] rdata2_from_RF_reg_ALU_to_MEM;
   reg dram_we_wire_reg_ALU_to_MEM;
   reg [1:0] wd_sel_wire_reg_ALU_to_MEM;
   reg [31:0] pc4_from_alu_reg_ALU_to_MEM;
   reg [31:0] imm_reg_ALU_to_MEM;
   reg [4:0] wR_ALU_to_MEM_reg;
   reg rf_we_wire_reg_ALU_to_MEM;
   reg [1:0]NPC_op_reg_ALU_to_MEM;
   reg [31:0] rdata1_reg_ALU_to_MEM;
   reg [31:0] pc_ALU_to_MEM_reg;
   always@(posedge clk or negedge rst_n)
   begin
    if(~rst_n)
    begin
        branch_tag_reg_ALU_to_MEM<=0;
        result_from_alu_reg_ALU_to_MEM <= 0;
        rdata2_from_RF_reg_ALU_to_MEM <= 0;
        dram_we_wire_reg_ALU_to_MEM<=0;
        wd_sel_wire_reg_ALU_to_MEM<=0;
        pc4_from_alu_reg_ALU_to_MEM<=0;
        imm_reg_ALU_to_MEM<=0;
        wR_ALU_to_MEM_reg<=0;
        rf_we_wire_reg_ID_to_ALU<=0;
        NPC_op_reg_ALU_to_MEM<=0;
        rdata1_reg_ALU_to_MEM <= 0;
        pc_ALU_to_MEM_reg<=0;
    end
    else begin
        branch_tag_reg_ALU_to_MEM<=branch_tag;
        result_from_alu_reg_ALU_to_MEM <= result_from_alu;
        rdata2_from_RF_reg_ALU_to_MEM <= rdata2_from_RF_reg_ID_to_ALU;
        dram_we_wire_reg_ALU_to_MEM<=dram_we_wire_reg_ID_to_ALU;
        wd_sel_wire_reg_ALU_to_MEM<=wd_sel_wire_reg_ID_to_ALU;
        pc4_from_alu_reg_ALU_to_MEM<=pc4_from_alu_reg_ID_to_ALU;
        imm_reg_ALU_to_MEM<=imm_reg_ID_to_ALU;
        wR_ALU_to_MEM_reg<=wR_ID_to_ALU_reg;
        rf_we_wire_reg_ID_to_ALU<=rf_we_wire_reg_ALU_to_MEM;
        NPC_op_reg_ALU_to_MEM<=NPC_op_reg_ID_to_ALU;
        rdata1_reg_ALU_to_MEM <= rdata1_reg_ID_to_ALU;
        pc_ALU_to_MEM_reg<=pc_ID_to_ALU_reg;
        end
   end
   
   reg [31:0] result_from_alu_reg_MEM_to_WB;
   reg [31:0] pc4_from_alu_reg_MEM_to_WB;
   reg [31:0] rd_data_from_DRAM_MEM_to_WB;
   reg [31:0] imm_reg_MEM_to_WB;
   reg [31:0] wR_MEM_to_WB_reg;
   reg  rf_we_wire_reg_MEM_to_WB;
   reg  branch_tag_reg_MEM_to_WB;
   reg [1:0]NPC_op_reg_MEM_to_WB;
   reg [31:0]rdata1_reg_MEM_to_WB;
   reg [31:0] pc_MEM_to_WB_reg;
   
   always@(posedge clk or negedge rst_n)begin
   if(~rst_n)
    begin
        result_from_alu_reg_MEM_to_WB<=0;
        pc4_from_alu_reg_MEM_to_WB<=0;
        rd_data_from_DRAM_MEM_to_WB<=0;
        imm_reg_MEM_to_WB<=0;
        wR_MEM_to_WB_reg<=0;
        rf_we_wire_reg_MEM_to_WB<=0;
        branch_tag_reg_MEM_to_WB<=0;
        NPC_op_reg_MEM_to_WB<=0;
        rdata1_reg_MEM_to_WB<=0;
        pc_MEM_to_WB_reg<=0;
        end
     else begin
         result_from_alu_reg_MEM_to_WB<=result_from_alu_reg_ALU_to_MEM;
        pc4_from_alu_reg_MEM_to_WB<=pc4_from_alu_reg_ALU_to_MEM;
        rd_data_from_DRAM_MEM_to_WB<=rd_data_from_DRAM;
        imm_reg_MEM_to_WB<=imm_reg_ALU_to_MEM;
        wR_MEM_to_WB_reg<=wR_ALU_to_MEM_reg;
        rf_we_wire_reg_MEM_to_WB<=rf_we_wire_reg_ALU_to_MEM;
        branch_tag_reg_MEM_to_WB<=branch_tag_reg_ALU_to_MEM;
        NPC_op_reg_MEM_to_WB<=NPC_op_reg_ALU_to_MEM;
        rdata1_reg_MEM_to_WB<=rdata1_reg_ALU_to_MEM;
        pc_MEM_to_WB_reg<=pc_ALU_to_MEM_reg;
     end
   end
   
   assign data_wr = rdata2_from_RF_reg_ALU_to_MEM ;
   assign addra = result_from_alu_reg_ALU_to_MEM ;
   assign dram_we_wire = dram_we_wire_reg_ALU_to_MEM;
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
    .pc_reg(pc_MEM_to_WB_reg),
    .rs1(rdata1_reg_MEM_to_WB),
    .npc_op(NPC_op_reg_MEM_to_WB),
    .branch_tag(branch_tag_reg_MEM_to_WB),
    .imm(imm_reg_MEM_to_WB),
    .npc(npc)
    );

    
    //to CTRL  
   //to idecode
    //?????
    ifetch u_ifetch(
    .inst_i(instruction_IF_to_ID_reg),
    .rR1(rR1),
    .rR2(rR2),
    .wR(wR),
    .fun3(fun3),
    .fun7(fun7),
    .opCODE(opCODE)
    );

   
   //?????? 
    control u_control(
    .fun3(fun3_IF_to_ID_reg),
    .fun7(fun7_IF_to_ID_reg),
    .opcode(opCODE_IF_to_ID_reg),
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
 
    mux4_32b_ u_mux4_32b_(
    .in0(result_from_alu_reg_MEM_to_WB),
    .in1(pc4_from_alu_reg_MEM_to_WB),
    .in2(rd_data_from_DRAM_MEM_to_WB),
    .in3(imm_reg_MEM_to_WB),
    .sel(wd_sel_wire_reg_ALU_to_MEM),
    .out(wD)
    );
    
    //RF???????
   idecode u_idecode(
   .clk(clk),
   .raddr1(rR1_IF_to_ID_reg),
   .raddr2(rR2_IF_to_ID_reg),
   .waddr(wR_MEM_to_WB_reg),
   .we(rf_we_wire_reg_MEM_to_WB),
   .wdata(wD),//wD
   .rdata1(rdata1),
   .rdata2(rdata2_from_RF)
   );
    //SEXT????????????
   
  
//   SEXT u_SEXT(
//   .instruction(instruction_IF_to_ID_reg),
//   .imm_wire_I(imm_wire_I),
//   .imm_wire_B(imm_wire_B),
//   .imm_wire_J(imm_wire_J),
//   .imm_wire_U(imm_wire_U),
//   .imm_wire_S(imm_wire_S)
//   );
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
   .A(rdata1_reg_ID_to_ALU),
   .B(rdata2_reg_ID_to_ALU),
   .B_wire(B_wire_reg_ID_to_ALU),
   .branch(branch_wire_reg_ID_to_ALU),
   .alu_op(alu_op_wire_reg_ID_to_ALU),
   .branch_alu_wire(branch_alu_wire),
   .result_wire(result_from_alu)
   );

   
 


endmodule
