`timescale 1ns / 1ps

module flipfloparray_tb();

    reg [7:0] din;
    reg [2:0] addr;
    reg wr, rd;
    reg clk;
    reg resetn;
    wire  [7:0] dout;
    wire  error;
    wire [7:0] ff_status_bar;
    
    flipfloparray uut(din, addr, wr, rd, clk, resetn, dout, error, ff_status_bar);
    
    always #5 clk = ~clk;
    
    initial begin
    resetn = 1'b 1;   
    clk = 1'b 0;
    wr = 1'b 1;
    rd = 1'b 0;
    #15;
    resetn = 1'b 0;
    addr = 3'b 000;
    din = 8'b 11110000;
    #10;
    addr = 3'b 001;
    din = 8'b 10101010;
    #10;
    addr = 3'b 010;
    din = 8'b 00001111;
    #5;
    rd = 1'b 1;
    wr = 1'b 0;  
    addr = 3'b 010;
    #15;
    
    addr = 3'b 001;
    wr = 1'b 1;
    #20;
    $finish; 
        
        end 
endmodule
