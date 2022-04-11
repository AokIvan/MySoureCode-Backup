//////////////////////////////////////////////////////////
//                         SEG                          //
// Author: AokIvan(https://github.com/aokivan)          //
//                                                      //
// Create Date: 2021/11/21                              //
//                                                      //
//        You may find details at the link below        //
//             https://blog.csdn.net/LWanTao            //
//////////////////////////////////////////////////////////module SEG(clk,clr,din,seg,sel);
input clk;input clr;input [5:0] din;output reg[3:0] sel; //λѡ
output reg[7:0] seg; //��ѡ
reg [7:0] seg_data; //�ñ����洢��������ֱܷ���ʾ����ֵ
reg selcnt; //λѡ������
reg [3:0] disp_data; //�ñ����洢�����������ʾ��ֵ
reg [3:0] shiwei;reg [3:0] gewei;//�洢��λ��ʮλ��BCD��
reg [5:0] fdin;//din���м�����Ϸ�ƣ������ˣ�
always @(din) begin fdin <= din;end//��fdin��din����һ�𣬴���din���뵹��ʱ
always@ (negedge clk or posedge clr)//�����齫���뵹��ʱ�Ӷ�����תΪBCD��
begin if (clr) begin shiwei  <= 0;gewei   <= 0;end
      else if(~clk) begin shiwei  <= fdin/10  ;gewei   <= fdin%10  ;end end
always@ (posedge clk or posedge clr)//���
begin if (clr) seg_data <= 0;
      else if(clk) seg_data <={shiwei,gewei};end
always@(posedge clk or posedge  clr)//�����λѡ������
begin if (clr) selcnt <= 1'd0;
      else if (clk) selcnt <= ~selcnt;end
always@(*)//�����λѡ��ʾ
begin
 if(clr) disp_data <= 4'd0;
 else  begin case(selcnt) //�����λѡ������&�����������ʾ�����л�
        1'd0    :  begin   sel = 4'h7;  disp_data = seg_data[7:4]; end
        1'd1    :  begin   sel = 4'hb;  disp_data = seg_data[3:0] ; end  
        default :  disp_data = 4'd0;endcase end end
always@(*)begin   //����ܶ�ѡ��ʾ,��������ʾ��ֵת��Ϊ������ܶ����ı���
    if(clr) seg <= 8'hff;else begin case(disp_data)
            4'd0		:	seg	 = 	8'hc0;	
			4'd1		:	seg	 = 	8'hf9;
			4'd2		:	seg	 = 	8'ha4;
			4'd3		:	seg	 = 	8'hb0;
			4'd4		:	seg	 = 	8'h99;
			4'd5		:	seg	 = 	8'h92;
			4'd6		:	seg	 = 	8'h82;
			4'd7		:	seg	 = 	8'hf8;
			4'd8		:	seg	 = 	8'h80;
			4'd9		:	seg	 = 	8'h90;
            default : seg = 8'hff; endcase end end endmodule