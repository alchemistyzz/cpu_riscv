module led_display(
 input  wire       clk   ,
input  wire       rst_n   ,
input  wire      dig_en,
input  wire [31:0] wdata,
output reg [7:0] led_en,
	output reg      led_ca,
	output reg      led_cb,
    output reg      led_cc,
	output reg      led_cd,
	output reg      led_ce,
	output reg      led_cf,
	output reg      led_cg,
	output wire     led_dp 
    );
    reg [31:0] cnt;
    wire cnt_end = (cnt==32'd4999);//上板设置为19999
    wire cnt_inc = (cnt!=32'd4999);
    parameter led0 = 7'b1000000;//0
    parameter led1 = 7'b1111001;//1
    parameter led2 = 7'b0100100;//2
    parameter led3 = 7'b0110000;//3
    parameter led4 = 7'b0011001;//4
    parameter led5 = 7'b0010010;//5
    parameter led6 = 7'b0000010;//6
    parameter led7 = 7'b1111000;//7
    parameter led8 = 7'b0000000;//8
    parameter led9 = 7'b0011000;//9
    parameter led10= 7'b0001000;//a
    parameter led11= 7'b0000011;//b
    parameter led12= 7'b0100111;//c
    parameter led13= 7'b0100001;//d
    parameter led14= 7'b0000110;//e
    parameter led15= 7'b0001110;//f
    reg [6:0] led_cx ;
    reg [6:0]leda;
    reg [6:0]ledb;
    reg [6:0]ledc;
    reg [6:0]ledd;
    reg [6:0]lede;
    reg [6:0]ledf;
    reg [6:0]ledg;
    reg [6:0]ledh;
    reg [31:0]cal_result;
    assign led_dp=1;
always@(posedge clk)
begin
    if(dig_en)
    begin
        cal_result <= wdata;
    end
end
always @(posedge clk or negedge rst_n)//使能计数器
    begin
        if(~rst_n) 
            begin
            cnt<=0;
            led_en<=8'b1111_1110;
            end
        else if(cnt_end)
             begin
             led_en={led_en[6:0],led_en[7]};
             cnt<=0;                
             end  
        else if(cnt_inc)
             begin
             cnt<=cnt+1'b1;
             end
       
    end
always @(*)
begin
    case(cal_result[3:0])
    4'b0000:leda=led0;
    4'b0001:leda=led1;
    4'b0010:leda=led2;
    4'b0011:leda=led3;
    4'b0100:leda=led4;
    4'b0101:leda=led5;
    4'b0110:leda=led6;
    4'b0111:leda=led7;
    4'b1000:leda=led8;
    4'b1001:leda=led9;
    4'b1010:leda=led10;
    4'b1011:leda=led11;
    4'b1100:leda=led12;
    4'b1101:leda=led13;
    4'b1110:leda=led14;
    4'b1111:leda=led15;
    endcase
    
    case(cal_result[7:4])
    4'b0000:ledb=led0;
    4'b0001:ledb=led1;
    4'b0010:ledb=led2;
    4'b0011:ledb=led3;
    4'b0100:ledb=led4;
    4'b0101:ledb=led5;
    4'b0110:ledb=led6;
    4'b0111:ledb=led7;
    4'b1000:ledb=led8;
    4'b1001:ledb=led9;
    4'b1010:ledb=led10;
    4'b1011:ledb=led11;
    4'b1100:ledb=led12;
    4'b1101:ledb=led13;
    4'b1110:ledb=led14;
    4'b1111:ledb=led15;
    endcase
    
    case(cal_result[11:8])
    4'b0000:ledc=led0;
    4'b0001:ledc=led1;
    4'b0010:ledc=led2;
    4'b0011:ledc=led3;
    4'b0100:ledc=led4;
    4'b0101:ledc=led5;
    4'b0110:ledc=led6;
    4'b0111:ledc=led7;
    4'b1000:ledc=led8;
    4'b1001:ledc=led9;
    4'b1010:ledc=led10;
    4'b1011:ledc=led11;
    4'b1100:ledc=led12;
    4'b1101:ledc=led13;
    4'b1110:ledc=led14;
    4'b1111:ledc=led15;
    endcase
    
     case(cal_result[15:12])
    4'b0000:ledd=led0;
    4'b0001:ledd=led1;
    4'b0010:ledd=led2;
    4'b0011:ledd=led3;
    4'b0100:ledd=led4;
    4'b0101:ledd=led5;
    4'b0110:ledd=led6;
    4'b0111:ledd=led7;
    4'b1000:ledd=led8;
    4'b1001:ledd=led9;
    4'b1010:ledd=led10;
    4'b1011:ledd=led11;
    4'b1100:ledd=led12;
    4'b1101:ledd=led13;
    4'b1110:ledd=led14;
    4'b1111:ledd=led15;
    endcase
    
     case(cal_result[19:16])
    4'b0000:lede=led0;
    4'b0001:lede=led1;
    4'b0010:lede=led2;
    4'b0011:lede=led3;
    4'b0100:lede=led4;
    4'b0101:lede=led5;
    4'b0110:lede=led6;
    4'b0111:lede=led7;
    4'b1000:lede=led8;
    4'b1001:lede=led9;
    4'b1010:lede=led10;
    4'b1011:lede=led11;
    4'b1100:lede=led12;
    4'b1101:lede=led13;
    4'b1110:lede=led14;
    4'b1111:lede=led15;
    endcase
    
     case(cal_result[23:20])
    4'b0000:ledf=led0;
    4'b0001:ledf=led1;
    4'b0010:ledf=led2;
    4'b0011:ledf=led3;
    4'b0100:ledf=led4;
    4'b0101:ledf=led5;
    4'b0110:ledf=led6;
    4'b0111:ledf=led7;
    4'b1000:ledf=led8;
    4'b1001:ledf=led9;
    4'b1010:ledf=led10;
    4'b1011:ledf=led11;
    4'b1100:ledf=led12;
    4'b1101:ledf=led13;
    4'b1110:ledf=led14;
    4'b1111:ledf=led15;
    endcase
    
     case(cal_result[27:24])
    4'b0000:ledg=led0;
    4'b0001:ledg=led1;
    4'b0010:ledg=led2;
    4'b0011:ledg=led3;
    4'b0100:ledg=led4;
    4'b0101:ledg=led5;
    4'b0110:ledg=led6;
    4'b0111:ledg=led7;
    4'b1000:ledg=led8;
    4'b1001:ledg=led9;
    4'b1010:ledg=led10;
    4'b1011:ledg=led11;
    4'b1100:ledg=led12;
    4'b1101:ledg=led13;
    4'b1110:ledg=led14;
    4'b1111:ledg=led15;
    endcase
    
     case(cal_result[31:28])
    4'b0000:ledh=led0;
    4'b0001:ledh=led1;
    4'b0010:ledh=led2;
    4'b0011:ledh=led3;
    4'b0100:ledh=led4;
    4'b0101:ledh=led5;
    4'b0110:ledh=led6;
    4'b0111:ledh=led7;
    4'b1000:ledh=led8;
    4'b1001:ledh=led9;
    4'b1010:ledh=led10;
    4'b1011:ledh=led11;
    4'b1100:ledh=led12;
    4'b1101:ledh=led13;
    4'b1110:ledh=led14;
    4'b1111:ledh=led15;
    endcase
end
always @(posedge clk )
begin  
        case(led_en)
        8'b1111_1110:   led_cx=leda;
        8'b1111_1101:   led_cx=ledb;                
        8'b1111_1011:   led_cx=ledc;
        8'b1111_0111:   led_cx=ledd;
        8'b1110_1111:   led_cx=lede;   
        8'b1101_1111:   led_cx=ledf;
        8'b1011_1111:   led_cx=ledg;
        8'b0111_1111:   led_cx=ledh;  
        endcase

       led_cg=led_cx[6];
       led_cf=led_cx[5];
       led_ce=led_cx[4];
       led_cd=led_cx[3];
       led_cc=led_cx[2];
       led_cb=led_cx[1];
       led_ca=led_cx[0];
                
end
endmodule  


