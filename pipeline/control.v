`timescale 1ns / 1ps
`include "param.v"


module control(
    input [2:0] fun3,
    input [6:0] fun7,
    input [6:0] opcode,
    output [1:0] npc_op_wire,
    output rf_we_wire,
    output [1:0] wd_sel_wire,
    output [2:0] sext_op_wire,
    output [2:0] alu_op_wire,
    output alub_sel_wire,
    output branch_wire,
    output dram_we_wire,
    output [1:0]B_wire

    );
    reg [1:0] npc_op;
    reg rf_we;
    reg [1:0] wd_sel;
    reg [2:0] sext_op;
    reg [2:0] alu_op;
    reg alub_sel;
    reg branch;
    reg dram_we;
    reg [1:0]B_wire_reg;
    assign npc_op_wire = npc_op;
    assign rf_we_wire = rf_we;
    assign wd_sel_wire = wd_sel;
    assign sext_op_wire = sext_op;
    assign alu_op_wire = alu_op;
    assign alub_sel_wire = alub_sel;
    assign branch_wire =branch;
    assign dram_we_wire = dram_we;   
    assign B_wire = B_wire_reg;
    always@(*)
    begin
        case(opcode)
           `R_TYPE:begin
                case(fun3)                
                    3'b000:begin
                        
                        case(fun7)
                            7'b0000000:begin//add
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'bx;
                                alu_op = `ADD;
                                alub_sel = 0;
                                branch = 0;
                                dram_we = 0;
                                B_wire_reg = 2'bxx;
                            end
                            
                            7'b0100000:begin//sub
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'bx;
                                alu_op = `SUB;
                                alub_sel = 0;
                                branch = 0;
                                dram_we = 0;
                                B_wire_reg = 2'bxx;
                            end
                            
                         endcase
                      end
                    
                    3'b001:begin//sll
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'bx;
                                alu_op = `SLL;
                                alub_sel = 0;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                    end
                    
                    3'b100:begin//xor
                             npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'bx;
                                alu_op = `XOR;
                                alub_sel = 0;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                    end
                    
                    3'b101:begin
                        case(fun7)
                            7'b0000000:begin//srl
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'bx;
                                alu_op = `SRL;
                                alub_sel = 0;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                                
                            end
                            7'b0100000:begin//sra
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'bx;
                                alu_op = `SRA;
                                alub_sel = 0;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                            end
                        endcase
                     end
                     
                     3'b110:begin//or
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'bx;
                                alu_op = `OR;
                                alub_sel = 0;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                     end
                     
                     3'b111:begin//and
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'bx;
                                alu_op = `AND;
                                alub_sel = 0;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                     end
                     
                     default:begin
                                npc_op = `PC4;
                                rf_we = 1'bx;
                                wd_sel = 2'bx;
                                sext_op = 3'bx;
                                alu_op = 3'bx;
                                alub_sel = 1'bx;
                                branch = 1'bx;
                                dram_we = 1'bx;
                                 B_wire_reg = 2'bxx;
                     end
              
      
                 endcase
            
            end
            `I_TYPE:begin
                case(fun3)
                    3'b000:begin//addi
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'b000;
                                alu_op = `ADD;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                    
                    end
                    
                    3'b001:begin//slli
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'b000;
                                alu_op = `SLL;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                        
                    end
                    
                    3'b100:begin//xori
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'b000;
                                alu_op = `XOR;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 0;    
                                 B_wire_reg = 2'bxx;                
                    end
                    
                    3'b101:begin
                        case(fun7)
                            7'b0000000:begin//srli
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'b000;
                                alu_op = `SRL;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                            end
                            
                            7'b0100000:begin//srai
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'b000;
                                alu_op = `SRA;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                            end
                        endcase
                    end
                    
                    3'b110:begin//ori
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'b000;
                                alu_op = `OR;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                    end
                    
                    3'b111:begin//andi
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b00;
                                sext_op = 3'b000;
                                alu_op = `AND;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
                    end    
                endcase   
            end
            
            `LW:begin//lw
                                npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b10;
                                sext_op = 3'b000;
                                alu_op = `ADD;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
             end
                
           `JALR:begin//jalr
                               npc_op = 2'b11;
                                rf_we = 1;
                                wd_sel = 2'b01;
                                sext_op = 3'b000;
                                alu_op = `ADD;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
            end     
            
            `SW:begin//sw
                                npc_op = `PC4;
                                rf_we = 0;
                                wd_sel = 2'bXX;
                                sext_op = 3'b001;
                                alu_op = `ADD;
                                alub_sel = 1;
                                branch = 0;
                                dram_we = 1;
                                 B_wire_reg = 2'bxx;
            end
            
            `B_TYPE:begin
                case(fun3)
                
                        3'b000:begin//beq
                                npc_op = 2'b01;
                                rf_we = 0;
                                wd_sel = 2'bxx;
                                sext_op = 3'b010;
                                alu_op = `SUB;
                                alub_sel = 0;
                                branch = 1;
                                dram_we = 0;
                                B_wire_reg=2'b00;
                        end
                        
                        3'b001:begin//bne
                                npc_op = 2'b01;
                                rf_we = 0;
                                wd_sel = 2'bxx;
                                sext_op = 3'b010;
                                alu_op = `SUB;
                                alub_sel = 0;
                                branch = 1;
                                dram_we = 0;
                                B_wire_reg = 2'b01;
                        end
                        
                        3'b100:begin//blt
                                npc_op = 2'b01;
                                rf_we = 0;
                                wd_sel = 2'bxx;
                                sext_op = 3'b010;
                                alu_op = `SUB;
                                alub_sel = 0;
                                branch = 1;
                                dram_we = 0;
                                B_wire_reg = 2'b10;
                        end
                        
                        3'b101:begin//bge
                                npc_op = 2'b01;
                                rf_we = 0;
                                wd_sel = 2'bxx;
                                sext_op = 3'b010;
                                alu_op = `SUB;
                                alub_sel = 0;
                                branch = 1;
                                dram_we = 0;
                                B_wire_reg = 2'b11;
                        end
                        
                endcase
            end
            `LUI:begin//lui
                               npc_op = `PC4;
                                rf_we = 1;
                                wd_sel = 2'b11;
                                sext_op = 3'b011;
                                alu_op = 3'bXXX;
                                alub_sel= 1'bx;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
            end
            `JAL:begin//jal
                                 npc_op = 2'b10;
                                rf_we = 1;
                                wd_sel = 2'b01;
                                sext_op = 3'b100;
                                alu_op = 3'bx;
                                alub_sel = 1'b1;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
            
            end
            default:begin
                                npc_op = `PC4;
                                rf_we = 1'bx;
                                wd_sel = 2'bx;
                                sext_op = 3'bx;
                                alu_op = 3'bx;
                                alub_sel = 1'bx;
                                branch = 0;
                                dram_we = 0;
                                 B_wire_reg = 2'bxx;
             end


        endcase
    end
    
    
    
    
endmodule