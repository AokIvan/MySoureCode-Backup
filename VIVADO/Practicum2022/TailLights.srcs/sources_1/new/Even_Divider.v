//////////////////////////////////////////////////////////////////
//                        Even_Divider                          //
// Author: AokIvan(https://github.com/aokivan)                  //
//                                                              //
// Create Date: 2022/04/11                                      //
//                                                              //
// Project Requirements: The divider can be customized          //
//                                                              //
//            You may find details at the link below            //
//                 https://blog.csdn.net/LWanTao                //
//////////////////////////////////////////////////////////////////
module Even_Divider#(parameter NUM_DIV = 2)
   (input clk,
    input clr,
    output reg clk_div
   );    
    reg [3:0]cnt;
    
always @(posedge clk or posedge clr)
    if(clr) begin
        cnt     <= 4'd0;
        clk_div <= 1'b0;
    end
    else if(cnt < NUM_DIV / 2 - 1) begin    //��clk���ڵļ�����δ�ﵽ�����÷�Ƶ����һ�룬�ʲ���ת��Ƶclk������ԭ��
        cnt     <= cnt + 1'b1;
        clk_div    <= clk_div;  
    end
    else begin
        cnt     <= 4'd0;
        clk_div <= ~clk_div;                //��Ϊcnt=NUM_DIV/2-1,����clk���ڵļ����ﵽ�����÷�Ƶ����һ�룬�ʷ�ת��Ƶclk
    end
endmodule