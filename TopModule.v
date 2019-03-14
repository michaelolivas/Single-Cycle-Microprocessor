module TopModule(input mCLK, RST,
                 input MtoRFSel,
                 input DMWE,
                 input Branch,
                 input [2:0] ALUSel,
                 input ALUInSel,
                 input RFDSel,
                 input RFWE,
                 input Jump,
                 input PCSel,
                    output [5:0] op,
                    output [5:0] funct);
    wire PCRST, zero;
    wire [4:0] RFRA1, RFRA2, RFWA, rtd;
    wire [31:0] pc_next, pc_out, pcp;
    wire [31:0] inst;
    wire [31:0] PCAdderOut, PCBranch, outMux1;
    wire signed [31:0] ALUIn1, ALUIn2, aluOUT, ALUDM, DMdin, dmOUT, SImm, rfrd2, rfwd;
    wire [15:0] Imm;
    wire [4:0] rs, rd, rt, shamt;
    wire [25:0] Jaddr;
    wire [31:0] PCJump;

    assign op = inst[31:26];
    assign funct = inst[5:0];
    assign rd = inst[15:11];
    assign rs = inst[25:21];
    assign rt = inst[20:16];
    assign shamt = inst[10:6];
    assign Imm = inst[15:0];
    assign Jaddr = inst[25:0];
    assign PCJump = {pc_next[31:26], Jaddr};
    
    PC 
        PC0 (.PCnext(pcp), .clk(mCLK), .PCout(pc_out));
    PCAdder
        PCA0 (.PCin(pc_out), .rst(RST), .PCout(pc_next));
    InstructionMem 
        IM0 (.x(pc_out), .data(inst));
    SignExtend 
        SE0 (.a(Imm), .signImm(SImm));
    RegisterFile 
        RF0 (.clk(mCLK), .we(RFWE), .rst(RST), .RFRA1(rs), .RFRA2(rt), .RFWA(rtd), .RFWD(ALUDM), .RFRD1(ALUIn1), .RFRD2(DMdin));
    ALUnit 
        ALU0 (.SrcA(ALUIn1), .SrcB(ALUIn2), .SHAMT(shamt), .ALUControl(ALUSel), .ZeroFlag(zero), .ALUResult(aluOUT));
    DataMemory #(.xw(32), .dw(32)) 
        DM0 (.x(aluOUT), .WE(DMWE), .clk(mCLK), .dataIn(DMdin), .data(dmOUT));
    PCBranch #(.WL(32))
        PCB0 (.SImm(SImm), .PCAdder(pc_next), .PCBranch(PCBranch));
    AndGate
        A0 (.Branch(Branch), .Zero(zero), .PCSel(PCSel));
    mux21 #(.WL(32))
        M1 (.sel(PCSel), .a(PCBranch), .b(pc_next), .out(outMux1));
    mux21 #(.WL(32))
        jumpM2 (.sel(Jump), .a(PCJump), .b(outMux1), .out(pcp));
    mux21 #(.WL(5))
        rtdM3 (.sel(RFDSel), .a(rd), .b(rt), .out(rtd));
    mux21 #(.WL(32))
        aluM4 (.sel(ALUInSel), .a(SImm), .b(DMdin), .out(ALUIn2));
    mux21 #(.WL(32))
        dmoutM5 (.sel(MtoRFSel), .a(dmOUT), .b(aluOUT), .out(ALUDM));
endmodule
