module tb_FDivider();
reg clkin,rst_n;
wire clkout;
FDivider i1(.clkin(clkin),.clkout(clkout),.rst_n(rst_n));
always #20 clkin=~clkin; //��Ϊclkinÿ20ns��תһ�Σ�������Ϊ40ns����F(clkin)=25Mhz

initial begin
clkin = 0;rst_n = 0;
#50;rst_n = 1;
end

endmodule