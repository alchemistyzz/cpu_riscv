`timescale 1ns / 1ps

module execute(
    input [31:0] A,
    input [31:0] B,
    input [2:0] alu_op,
    input [1:0] B_wire,
    input branch,
    output  branch_alu_wire,
    output  [31:0] result_wire
    );   
    reg branch_alu;
    reg [31:0] result;
    assign result_wire = result;
    assign branch_alu_wire = branch_alu;
    always@(*)begin
        case(alu_op)
            `ADD:begin
                result=A+B;
             end
             
             `SUB:begin
                result=A-B;
             end
             
             `AND:begin
                result=A&B;
              end
             
             `OR:begin
                result=A|B;
              end
              `XOR:begin
                result=A^B;
              end
              
              `SLL:begin
                result=A<<B[4:0];
               end
               
               `SRL:begin
                result=A>>B[4:0];
               end
               
               `SRA:begin
                result=$signed($signed(A)>>>B[4:0]);
               end
             
        endcase
        if(branch)begin
          case(B_wire)
            2'b00:begin//beq
              if(A==B)branch_alu=1;
              else branch_alu=0;
            end
            2'b01:begin//bne
              if(A==B)branch_alu=0;
              else branch_alu=1;
             end
             2'b10:begin// blt
                if(A[31]&&B[31]&&A<B)branch_alu=1;
                else if(A[31]&&~B[31])branch_alu=1;
                else if(~A[31]&&~B[31]&&A<B)branch_alu=1;
                else branch_alu=0;
             end
             2'b11:begin// bge
                if(A==B)branch_alu=1;
                else if(A[31]&&B[31]&&A>B)branch_alu=1;
                else if(~A[31]&&B[31]) branch_alu=1;
                else if(~A[31]&&~B[31]&&A>B) branch_alu=1;
                else branch_alu=0;
              end
            endcase
        end
        else branch_alu=0;
    end
endmodule
