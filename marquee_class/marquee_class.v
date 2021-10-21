module marquee_class(
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
		marquee <= 13'b0011111111110;
	else
		case (marquee)
		13'b0011111111110:   //msb = 0
		marquee <=       13'b0101111111101;
		13'b0101111111101:  
		marquee <=       13'b0110111111011;

		13'b0110111111011:  
		marquee <=       13'b0111011110111;
		13'b0111011110111:  
		marquee <=       13'b0111101101111;

		13'b0111101101111:  
		marquee <=       13'b0111110011111;
		13'b0111110011111:  
		marquee <=       13'b1111101101111;

		13'b1111101101111:   //msb = 1
		marquee <=       13'b1111011110111;
		13'b1111011110111:  
		marquee <=       13'b1110111111011;

		13'b1110111111011:  
		marquee <=       13'b1101111111101;
		13'b1101111111101:  
		marquee <=       13'b1011111111110;

		13'b1011111111110:  
		marquee <=       13'b0101111111101;
		default:
			marquee <= 13'b0011111111110;
	endcase

	end  //  begin always


	assign Q = marquee[11:0];

endmodule
