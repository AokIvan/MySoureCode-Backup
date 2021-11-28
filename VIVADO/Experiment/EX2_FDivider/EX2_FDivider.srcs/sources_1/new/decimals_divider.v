module decimals_divider //С����Ƶ�Ļ���˼���ǣ����ʱ����һ��ʱ���ڵ�ƽ��Ƶ�ʴﵽ��ƵҪ�󼴿ɡ����ǿ��ǵ���λ����������Ҫ�Է�Ƶϵ���仯�ķ�Ƶ�߼�����ƽ��������
  #(parameter SOURCE_NUM = 76 ,parameter DEST_NUM = 10)//ǰ��ΪԴclk��������������Ϊ��Ƶ���clk������������
   (input rstn ,input clkin,output clkout);
   parameter SOURCE_DIV = SOURCE_NUM/DEST_NUM; //ȡԴclk��������ڷ�Ƶ����������ڵ��������������������
   parameter DEST_DIV   = SOURCE_DIV + 1;      //��Ƶ���ڷֱ�Ϊ(SOURCE_DIV+1)��(DEST_DIV+2)  
   parameter DIFF_ACC   = SOURCE_NUM - SOURCE_DIV*DEST_NUM;//��������Ƶ���ڵĴ������������
   reg [3:0] cnt_end_r ;  //�ɱ��Ƶ����
   reg [3:0] main_cnt ;   //��������
   reg clkout_r ; //ʱ��������ߵ�ƽ������Ϊ1
   assign clkout = clkout_r ;
   always @(posedge clkin or negedge rstn) begin
      if (!rstn) begin main_cnt    <= 'b0 ; clkout_r  <= 1'b0 ;end
      else if (main_cnt == cnt_end_r) begin main_cnt    <= 'b0 ; clkout_r  <= 1'b1 ;end
      else begin main_cnt <= main_cnt + 1'b1 ; clkout_r  <= 1'b0 ;end end
   wire diff_cnt_en = (main_cnt == cnt_end_r) ;    //��ֵ�ۼ���ʹ�ܿ���
   reg [4:0] diff_cnt_r ;   
   wire [4:0] diff_cnt = (diff_cnt_r >= DEST_NUM) ? (diff_cnt_r -10 + DIFF_ACC) : (diff_cnt_r + DIFF_ACC) ;  //��ֵ�ۼ����߼�                             
   always @(posedge clkin or negedge rstn) begin
      if (!rstn) begin diff_cnt_r <= 0 ;end       
      else if (diff_cnt_en) begin diff_cnt_r <= diff_cnt ;end end   
   always @(posedge clkin or negedge rstn) begin    //��Ƶ���ڱ����Ŀ����߼�
      if (!rstn) begin cnt_end_r <= SOURCE_DIV-1 ;end   
      else if (diff_cnt >= 10) begin cnt_end_r <= DEST_DIV-1 ;end   //��ֵ�ۼ������ʱ���޸ķ�Ƶ����  
      else begin cnt_end_r <= SOURCE_DIV-1 ;end end 
endmodule