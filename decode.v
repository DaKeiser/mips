//Takes input from fetch and parses it and assigns appropriate register values

module decode(instruction, clk, opcode, rs, rt, rd, immediate, shamt, funct, regDest, branch, memRead, memToReg, aluOP, memWrite, aluSrc, regWrite, endProgram);

input [31:0]instruction;
input clk;
output reg[5:0]opcode;
output reg[4:0]rs;
output reg[4:0]rt;
output reg[4:0]rd;
output reg[31:0]immediate;
output reg [4:0]shamt;
output reg [5:0]funct;
output reg regDest;
output reg branch;
output reg memRead;
output reg memToReg;
output reg [1:0]aluOP;
output reg memWrite;
output reg aluSrc;
output reg regWrite;
output reg endProgram;
reg [31:0]register[31:0];
// flags and temp variables
integer flagr=0; //1 if 'R' Type instructiom 0 if 'I' type instruction

initial begin
    rd = 5'b0;
    immediate = 31'b0;
    shamt = 5'b0;
    funct = 6'b0;
    $readmemb("registers.dat", register);
    regDest = 0;
    branch = 0;
    memRead = 0;
    memToReg = 0;
    aluOP = 2'b00;
    memWrite = 0;
    aluSrc = 0;
    regWrite = 0;
    endProgram = 0;
end


always @(posedge clk or instruction)
begin 
    //Parsing the input
    opcode = instruction[31:26];
    if(opcode == 6'b000000)
    begin 
        flagr = 1;
        rs = instruction[25:21];
        rt = instruction[20:16];
        rd = instruction[15:11];
        shamt = instruction[10:6];
        funct = instruction[5:0];
    end
    else
    begin
        flagr = 0;
        rs = instruction[25:21];
        rt = instruction[20:16];
        immediate = immediate + instruction[15:0];  // can be error
    end
    $display("%b", instruction);
    $display("%b, %b, %b, %b, %b, %b, %b", opcode, rs, rt, rd, shamt, funct, immediate);

    //Passing parsed input into CONTROL
    //R-Type instruction
    if(opcode == 6'b000000)
    begin
        regDest = 1;
        branch = 0;
        memRead = 0;
        memToReg = 0;
        aluOP = 2'b1x;
        memWrite = 0;
        aluSrc = 0;
        regWrite = 1;
    end
    //Store
    else if(opcode == 6'b101011)
    begin
        regDest = 0;
        branch = 0;
        memRead = 0;
        memToReg = 1'bx; //Dont care taken as 0
        aluOP = 2'b00;
        memWrite = 1;
        aluSrc = 0;
        regWrite = 0;
    end
    //Load 
    else if(opcode == 6'b100011)
    begin 
        regDest = 0;
        branch = 0;
        memRead = 1;
        memToReg = 1; //Dont care taken as 0
        aluOP = 2'b00;
        memWrite = 1;
        aluSrc = 1;
        regWrite = 1;        
    end
    //BEQ
    else if(opcode == 6'b000100)
    begin
        regDest = 0;
        branch = 1;
        memRead = 0;
        memToReg = 1'bx;
        aluOP = 2'b01;
        memWrite = 0;
        aluSrc = 1;
        regWrite = 0;
    end
    //BNE
    else if(opcode == 6'b000101)
    begin
        regDest = 0;
        branch = 1;
        memRead = 0;
        memToReg = 1'bx;
        aluOP = 2'b01;
        memWrite = 0;
        aluSrc = 1;
        regWrite = 0;
    end
    //END
    else if(opcode == 6'b111111)
    begin
        endProgram = 1;
    end
end
endmodule

//Testbench to check
module dc_tb;
    reg [31:0]instruction;
    wire [5:0]opcode;
    wire [4:0]rs;
    wire [4:0]rt;
    wire [4:0]rd;
    wire [31:0]immediate;
    wire [4:0]shamt;
    wire [5:0]funct;
    wire regDest;
    wire branch;
    wire memRead;
    wire memToReg;
    wire [1:0]aluOP;
    wire memWrite;
    wire aluSrc;
    wire regWrite;

    decode uut(instruction, clk, opcode, rs, rt, rd, immediate, shamt, funct, regDest, branch, memRead, memToReg, aluOP, memWrite, aluSrc, regWrite, endProgram);
    initial begin
        instruction = 32'b10001110000100100000000000000000;
    end
endmodule