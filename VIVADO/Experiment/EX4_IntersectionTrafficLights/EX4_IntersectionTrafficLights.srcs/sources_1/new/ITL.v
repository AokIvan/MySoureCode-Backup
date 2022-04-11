//////////////////////////////////////////////////////////
//                         ITL                          //
// Author: AokIvan(https://github.com/aokivan)          //
//                                                      //
// Create Date: 2021/11/21                              //
//                                                      //
//        You may find details at the link below        //
//             https://blog.csdn.net/LWanTao            //
//////////////////////////////////////////////////////////
module ITL#(parameter DELY = 30,S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,
S4=3'b100,S5=3'b101,S6=3'b110,S7=3'b111)//һ��ȫ�ֱ���ͳһ���ʱ�����&�˸�״̬
(input clk,clr,output reg green1,yellow1,left1,red1,green2,yellow2,left2,red2,
output reg [5:0] count,output [3:0] sel,output [7:0] seg);
reg [2:0] state,next_state;//��̬���̬
always @(posedge clk, posedge clr)
begin 
if(clr) begin state<=S0;end
else if(clk)begin state<=next_state;end end//��clk������Ϊ�ź��л�״̬
always @(state)
begin
case(state)//ͨ����ȫ�ֱ���DELYӰ�����ʱ�ź���ʵ��"����ʱ��"
S0:begin if(clk) begin #(DELY*100);next_state=S1;end end
S1:begin if(clk) begin #(DELY*5);next_state=S2;end end
S2:begin if(clk) begin #(DELY*200/6);next_state=S3;end end
S3:begin if(clk) begin #(DELY*5);next_state=S4;end end
S4:begin if(clk) begin #(DELY*400/6);next_state=S5;end end
S5:begin if(clk) begin #(DELY*5);next_state=S6;end end
S6:begin if(clk) begin #(DELY*200/6);next_state=S7;end end
S7:begin if(clk) begin #(DELY*5);next_state=S0;end end
default : next_state<=S0;
endcase end
always @(state)
begin
case(state)//���ݲ�ͬ��״̬���Ʋ�ͬ�ĵ���ʱ����
S0: begin{green1,yellow1,left1,red1,green2,yellow2,left2,red2}= 8'b10000001;count <= 6'd60;end
S1: begin{green1,yellow1,left1,red1,green2,yellow2,left2,red2}= 8'b01000001;count <= 6'd3; end
S2: begin{green1,yellow1,left1,red1,green2,yellow2,left2,red2}= 8'b00100001;count <= 6'd20;end
S3: begin{green1,yellow1,left1,red1,green2,yellow2,left2,red2}= 8'b01000001;count <= 6'd3;end
S4: begin{green1,yellow1,left1,red1,green2,yellow2,left2,red2}= 8'b00011000;count <= 6'd40;end
S5: begin{green1,yellow1,left1,red1,green2,yellow2,left2,red2}= 8'b00010100;count <= 6'd3;end
S6: begin{green1,yellow1,left1,red1,green2,yellow2,left2,red2}= 8'b00010010;count <= 6'd20;end
S7: begin{green1,yellow1,left1,red1,green2,yellow2,left2,red2}= 8'b00010100;count <= 6'd3;end
endcase end
always @(clk,clr)//����ʱ��飬����ʱ��������һ��case������
begin
if(clr) count <= 60;
else if(clk) count <= count - 6'd1;
end
SEG i1(.clk(clk),.clr(clr),.din(count),.seg(seg),.sel(sel));
endmodule