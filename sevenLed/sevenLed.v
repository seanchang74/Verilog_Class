module sevenLed (
reset, 
clk,
seg_out,
scan_out
);
input reset,clk;
output reg [7:0] seg_out;
output [7:0] scan_out;

reg clk1;
reg [3:0] q;
reg [7:0] ring_counter;
//generate scan_clock
reg [25:0] cnt;
reg scan_clk = 1'b0;
	
	always @(posedge clk)
	begin
		cnt <= cnt + 1;
		if(cnt == 125000)
			scan_clk <= ~scan_clk;
		else if(cnt == 12500000)
		begin
			cnt <= 0;
			clk1 <= ~clk1;
		end
	end
	// clock running
	always @(posedge scan_clk, negedge reset)
	begin
		if(reset == 0)
			q <= 4'h0;
		else if(clk == 1)
			if(q != 4'h9)
				q<=q+1;
			else
				q<=4'h0;
	end
	//scan and display 7-SEG
	always@(posedge scan_clk, negedge reset)
	begin
		if(reset == 0)
			ring_counter <= 8'b11111110;
		//else if(scan_clk == 1)
				ring_counter[0] <= ring_counter[7];
				ring_counter[7:1] <= ring_counter[6:0];
		case(q)
			4'h0:
				seg_out <= 8'd192;
			4'h1:
				seg_out <= 8'b11111001;
			4'h2:
				seg_out <= 8'b10100100;
			4'h3:
				seg_out <= 8'b10110000;
			4'h4:
				seg_out <= 8'b10011001;
			4'h5:
				seg_out <= 8'b10010010;
			4'h6:
				seg_out <= 8'b10000010;
			4'h7:
				seg_out <= 8'b11111000;
			4'h8:
				seg_out <= 8'b10000000;
			4'h9:
				seg_out <= 8'b10011000;
			default:
				seg_out <= 8'b11111111;
		endcase
		
	end
	
	assign scan_out = ring_counter;
endmodule
