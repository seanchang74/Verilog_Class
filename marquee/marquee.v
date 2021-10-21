module marquee(
reset,
clk,
Q
);

input reset, clk;
output [11:0] Q;

reg [26:0] cnt;
reg clk1 = 1'b0;

reg [12:0] marquee ;

	always @(posedge clk)
	begin
		cnt <= cnt + 1;
		if (cnt == 12500000)
		begin
			cnt <= 0;
			clk1 <= ~clk1;
		end
	end

	always @(posedge clk1, negedge reset)
	begin
	if (reset == 0)
		marquee <= 13'b0101111101111;
	else
		case (marquee)
		13'b0101111101111:   //msb = 0
		marquee <=       13'b0010111010111;
		
		13'b0010111010111:  
		marquee <=       13'b0111101111101;
		13'b0111101111101:  
		marquee <=       13'b0111010111010;
		
		13'b0111010111010:  
		marquee <=       13'b0010010010010;
		13'b0010010010010:  
		marquee <=       13'b0101101101101;
		
		13'b0101101101101:  
		marquee <=       13'b1111101111101;
		13'b1111101111101:   
		marquee <=       13'b1111010111010;

		13'b1111010111010:   
		marquee <=       13'b1101111101111;
		13'b1101111101111:   
		marquee <=       13'b1010111010111;
		
		default:
			marquee <= 13'b0101111101111;
	endcase

	end  //  begin always


	assign Q = marquee[11:0];

endmodule
