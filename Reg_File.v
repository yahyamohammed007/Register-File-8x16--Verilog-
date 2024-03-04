module Reg_File #(parameter ADDR_Width = 4, MEM_WIDTH = 16, MEM_DEPTH = 8)(
    input [MEM_WIDTH - 1 : 0]  WrData,
    input [ADDR_Width - 1 : 0] Address,
    input WrEn, RdEn,
    input CLK, RST,
    output reg [MEM_WIDTH - 1 : 0] RdData
);

// Memory Declration 
reg [MEM_WIDTH - 1 : 0] Memory [MEM_DEPTH - 1 : 0];
integer i;

always @(posedge CLK or negedge RST)
begin
    if(!RST)
        begin
            for(i = 0; i <= 7; i = i + 1)
                    Memory[i] <= 'b0;
            RdData <= 'b0;
        end

    // Write Operation
    else if (WrEn && !RdEn)
            Memory[Address] <= WrData;

    // Read Operation
    else if (RdEn && !WrEn)
            RdData <= Memory[Address];

    // Allowing Only 1 Operation otherwise Zero O/P
    else
            RdData <= 'b0;
end

endmodule