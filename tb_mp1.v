`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2019 01:31:20 AM
// Design Name: 
// Module Name: tb_mp1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_mp1;
   reg CLK, RST;

   MP1_top T1(.MCLK(CLK),.RST(RST));
   
   initial CLK = 0;
   initial RST = 0;
   
   always begin
        #5 CLK = 1;
        #5 CLK = 0;
   end
   initial begin
       RST = 1;
       #5; RST = 0;
   end
   initial begin
       repeat(45)
       @(posedge CLK);

       $finish;
   end
endmodule