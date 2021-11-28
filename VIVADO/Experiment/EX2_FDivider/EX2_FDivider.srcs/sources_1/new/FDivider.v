//////////////////////////////////////////////////////////////////////////////
//                              Frequency Divider                           //
// Author: AokIvan(https://github.com/aokivan)                              //
//                                                                          //
// Create Date: 2021/11/18                                                  //
//                                                                          //
// Project Requirements: Crossover frequency number should be adjustable    //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////
module FDivider#(parameter subMOD=6,MOD=1) 
//subMODΪԴclk��������MODΪ��Ƶ���clk������������
//���ض�����Ϊ10�ļ�ΪС��������Ϊ1�ļ�Ϊż����������
            (clkin,clkout,rst_n); //��Ϊclkinÿ20ns��תһ�Σ�������Ϊ40ns����F(clkin)=25Mhz
input clkin,rst_n;
output clkout;
//ԭ��Ϊ���ж�����ķ������ĸ��ѡ���Եؽ���ģ������
if((MOD==1)&&(subMOD%2==1)) //����Ƶ���clk����������Ϊ1�ҳ���2��1�����������Ƶ��
odd_divider #(.NUM_DIV (subMOD/MOD)) 
u1(.clk (clkin),.clk_div (clkout),.rst_n (rst_n));
else if((MOD==1)&&(subMOD%2==0)) //����Ƶ���clk����������Ϊ1�ҳ���2��0�����ż����Ƶ��
even_divider #(.NUM_DIV (subMOD/MOD)) 
u1(.clk (clkin),.clk_div (clkout),.rst_n (rst_n));
else if(MOD==10)//����Ƶ���clk����������Ϊ10�����С����Ƶ��
decimals_divider #(.SOURCE_NUM (subMOD),.DEST_NUM (MOD)) 
u1(.clkin (clkin),.clkout (clkout),.rstn (rst_n));
endmodule