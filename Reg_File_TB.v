module Reg_File_TB#(parameter ADDR_Width = 4, MEM_WIDTH = 16, MEM_DEPTH = 8)();
reg [MEM_WIDTH - 1 : 0] WrData_tb;
reg [ADDR_Width - 1 : 0] Address_tb;
reg WrEn_tb;
reg RdEn_tb;
reg CLK_tb;
reg RST_tb;
wire [MEM_WIDTH - 1 : 0] RdData_tb;

Reg_File #(.ADDR_Width(ADDR_Width), .MEM_WIDTH(MEM_WIDTH), .MEM_DEPTH(MEM_DEPTH)) M0 (
    .WrData(WrData_tb),
    .Address(Address_tb),
    .WrEn(WrEn_tb),
    .RdEn(RdEn_tb),
    .CLK(CLK_tb),
    .RST(RST_tb),
    .RdData(RdData_tb)
);

always #5 CLK_tb = ~CLK_tb;

initial begin
    $dumpfile("Reg_File.vcd");
    $dumpvars;
    // Starting time zero & RST
    CLK_tb = 1'b0;
    RST_tb = 1'b0;
    WrData_tb = 'b0;
    Address_tb = 'b0;
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b0;

    #10
    RST_tb = 1'b1;

    // Write Operation
    #10
    WrData_tb = 'd13;
    Address_tb = 'd2;
    WrEn_tb = 1'b1;
   // $display("Test Case 1 Data_in = %d", WrData_tb);

    #10
    WrData_tb = 'd8;
    Address_tb = 'd6;
    WrEn_tb = 1'b1;
   // display("Test Case 2 Data_in = %d", WrData_tb);

    // Case 1 Validation 
    #10
    WrEn_tb = 1'b0;
    Address_tb = 'd2;
    RdEn_tb = 1'b1;
    #10
    if (RdData_tb == 'd13)
        $display("Test Case 1 passed");
    else
        $display("Test Case 1 Failed");

    // Case 2 Validation
    #10
    Address_tb = 'd6;
    RdEn_tb = 1'b1;
    #10
    if (RdData_tb == 'd8)
        $display("Test Case 2 passed");
    else
        $display("Test Case 2 Failed");

    // Case 3 -- 2 Enables in the same time
    #10
    RdEn_tb = 1'b1;
    WrEn_tb = 1'b1;
    Address_tb = 'd3;
    #10
    if(RdData_tb == 'b0)
        $display("Test Case 3 passed");
    else
        $display("Test Case 3 Failed");

    #10
    RST_tb = 1'b0;
    #20
    $stop;
end
endmodule