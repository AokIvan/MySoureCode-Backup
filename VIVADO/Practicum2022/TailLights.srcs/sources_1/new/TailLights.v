//////////////////////////////////////////////////////////
//                     TailLights                       //
// Author: AokIvan(https://github.com/aokivan)          //
//                                                      //
// Create Date: 2022/04/11                              //
//                                                      //
//        You may find details at the link below        //
//             https://blog.csdn.net/LWanTao            //
//////////////////////////////////////////////////////////
module TailLights#(parameter DELY=500000000)
(input [2:0] command,input clr,clk,clk_div,output reg [1:0] light);
reg [2:0] state,next_state;
parameter S0=3'd0,S1=3'd1,S2=3'd2,S3=3'd3,S4=3'd4;

Even_Divider d1(.clk(clk),.clr(clr),.clk_div(clk_div));

always @* begin if(clr) state<=S0;else state<=next_state;end

always @(state,command)
begin
case(state)
S0:case(command)
3'd1: next_state <= S1;
3'd2: next_state <= S2;
3'd3: next_state <= S3;
3'd4: next_state <= S4;
default:next_state <=S0;
endcase
S1:case(command)
3'd1: next_state <= S1;
default:next_state <=S0;
endcase
S2:case(command)
3'd2: next_state <= S2;
default:next_state <=S0;
endcase
S3:case(command)
3'd3: next_state <= S3;
default:next_state <=S0;
endcase
S4:case(command)
3'd4: next_state <= S4;
default:next_state <=S0;
endcase
default:next_state <=S0;
endcase 
end

always @(clk_div,state)
begin
case(state)//��0Ϊ��1Ϊ���������Ϊ��һλ���ҵ�Ϊ�ڶ�λ
S0:begin light=2'b00;end//������ʻ������
S1:begin light=2'b11;end//ɲ����˫�Ƴ���
S2:begin light[1]=~light[1];end//��ת����Ƽ��1s��˸
S3:begin light[0]=~light[0];end//��ת���ҵƼ��1s��˸
endcase 
end

always @(clk,state)
begin
case(state)//��0Ϊ��1Ϊ���������Ϊ��һλ���ҵ�Ϊ�ڶ�λ
S4:begin light=~light;end//˫����˫�Ƽ��0.5s��˸
endcase end endmodule