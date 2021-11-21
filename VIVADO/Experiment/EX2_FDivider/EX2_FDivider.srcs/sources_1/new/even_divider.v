module even_divider#(parameter NUM_DIV = 6)
   (input clk,
    input rst_n,
    output reg clk_div
   );    
    reg [3:0]cnt;
    
always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        cnt     <= 4'd0;
        clk_div    <= 1'b0;
    end
    else if(cnt < NUM_DIV / 2 - 1) begin
        cnt     <= cnt + 1'b1;
        clk_div    <= clk_div;
    end
    else begin
        cnt     <= 4'd0;
        clk_div    <= ~clk_div;
    end
endmodule