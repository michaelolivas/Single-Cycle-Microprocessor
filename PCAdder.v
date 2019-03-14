module PCAdder( input [31:0] PCin,
                input rst,
                output reg [31:0] PCout);
                
    always @*
        if(rst) PCout = 0;
        else PCout = PCin + 1;
endmodule