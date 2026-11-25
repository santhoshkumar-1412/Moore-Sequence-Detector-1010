`timescale 1ns/1ps
module seq_det_1010_tb;
wire y;
reg x,clk,rst;
seq_det_1010 dut (.y(y),.x(x),.clk(clk),.rst(rst));
initial
begin
    clk=0;
    forever #5 clk=~clk;
end
initial
begin
    $fsdbDumpfile("seq_det_1010.fsdb");
    $fsdbDumpvars(0,seq_det_1010_tb);
    $dumpfile("seq_det_1010.vcd");
    $dumpvars(0,seq_det_1010_tb);
end
initial
begin
rst=1;
x=0;
#10;
rst=0;
#10 x=1;
#10 x=0;
#10 x=1;
#10 x=0;
#10 x=1;
#10 x=0;
#10 x=0;
#10 x=1;
#10 x=0;
#10 x=1;
#10 x=0;
#20 $finish;
end
initial
begin
    $monitor("Time=%0t RESET=%b CLK=%b INPUT=%b OUTPUT=%b STATE=%b",$time,rst,clk,x,y,dut.state);
end														
endmodule
