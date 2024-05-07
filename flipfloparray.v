module flipfloparray(
    input [7:0] din,
    input [2:0] addr,
    input wr,
    input rd,
    input clk,
    input resetn,
    output  [7:0] dout,
    output  error,
    output [7:0] ff_status_bar
    );
    

reg error_flag;  
reg [7:0] temp;
reg [7:0] reg_file [0:7];
reg [7:0] valid_array; 

always @(posedge clk) begin
    if (resetn)
    begin    
        temp <= 0;
        error_flag <= 0;
        reg_file[0] <= 0;
        reg_file[1] <= 0;
        reg_file[2] <= 0;
        reg_file[3] <= 0;
        reg_file[4] <= 0;
        reg_file[5] <= 0;
        reg_file[6] <= 0;
        reg_file[7] <= 0;
        valid_array <= 0;

    end

    else begin
        if (rd & (~wr)) begin
            if (valid_array[addr] == 1 ) begin
                temp <= reg_file[addr];
                error_flag <= 0;
            end
            else begin
                error_flag <= 0;
                temp <= 0;
            end
        end
        else if ((~rd) & (~wr))begin
            temp <= temp;
            error_flag <= 0;
            end
        else if ((~rd) & wr) begin
            valid_array[addr] <= 1'b 1;
            reg_file[addr] <= din;
            error_flag <= 0;
        end
        else if (rd & wr) begin
            error_flag <= 1;
            temp <= 0;
        end
    end
end
assign dout = temp;
assign ff_status_bar = valid_array;
assign error = error_flag;
    
endmodule
