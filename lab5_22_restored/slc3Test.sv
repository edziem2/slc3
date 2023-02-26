module slc3Test();

timeunit 10ns;
timeprecision 1ns;

logic [9:0] SW;
logic Clk;
logic Run, Continue; // active low
logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic [9:0] LED;
logic [15:0] tb_MAR, tb_MDR, tb_PC, tb_IR;

slc3_testtop s(.*);

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

initial begin: TEST_VECTORS
Continue = 1'b0; // low activate
SW = 10'b0;
Run = 1'b0;

#6 Continue = 1'b1;

#4 Run = 1'b1;

#20 Continue = 1'b0;

#3 Continue = 1'b1;

#20 Continue = 1'b0;

#3 Continue = 1'b1;



//#10 Run = 1'b1;
//
//#3 Run = 1'b0;
//
//#10 Run = 1'b1;
//
//#3 Run = 1'b0;

end

endmodule
