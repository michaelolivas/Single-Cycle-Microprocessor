module RegisterFile (input clk, we, rst,
                        input [4:0] RFRA1, RFRA2, RFWA, 
                            input signed [31:0] RFWD,
                                output reg signed [31:0] RFRD1, RFRD2);
                            
    reg [31:0] Registers [0:31];
    
	always@(posedge clk or posedge rst) begin
	   if (rst == 1'b1) begin
            Registers[0] = 0;
            Registers[1] = 0;
            Registers[2] = 0;
            Registers[3] = 0;
            Registers[4] = 0;
            Registers[5] = 32'h00000000;
            Registers[6] = 32'h00000000;
            Registers[7] = 32'h00000000;
            Registers[8] = 32'h00000000;
            Registers[9] = 32'h00000000;
            Registers[10] = 32'h00000000;
            Registers[11] = 32'h00000000;
            Registers[12] = 32'h00000000;
            Registers[13] = 32'h00000000;
            Registers[14] = 32'h00000000;
            Registers[15] = 32'h00000000;
            Registers[16] = 32'h00000000;
            Registers[17] = 32'h00000000;
            Registers[18] = 32'h00000000;
            Registers[19] = 32'h00000000;
            Registers[20] = 32'h00000000;
            Registers[21] = 32'h00000000;
            Registers[22] = 32'h00000000;
            Registers[23] = 32'h00000000;
            Registers[24] = 32'h00000000;
            Registers[25] = 32'h00000000;
            Registers[26] = 32'h00000000;
            Registers[27] = 32'h00000000;
            Registers[28] = 32'h00000000;
            Registers[29] = 32'h00000000;
            Registers[30] = 32'h00000000;
            Registers[31] = 32'h00000000;
       end
       else if (we == 1'b1) Registers[RFWA] = RFWD;
	end

    always @* begin
	   RFRD1 = Registers[RFRA1];
	   RFRD2 = Registers[RFRA2];
	end
endmodule