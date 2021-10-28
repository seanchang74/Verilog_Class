module sevenLed (clk,reset,segout,scanout);
input clk,reset;
output reg[7:0] segout;
output reg[2:0] scanout;

reg[25:0] cnt_scan;//
reg[3:0] sel;

reg clk1;
reg [5:0] q[0:3] ;

initial
begin
	q[0] = 6'b111110;
	q[1] = 6'b011111;
	q[2] = 6'b000001;
	q[3] = 6'b100000;
end

//------------------ clock running -----------------------
always@(posedge clk or negedge reset)
begin
	if(!reset) begin
		cnt_scan<=0;
	end
	else begin
		cnt_scan<=cnt_scan+1;
		if (cnt_scan == 12500000) begin
			cnt_scan <=0;
			clk1 = ~clk1;
		end
		end
end

//---------modify display digit ----------
	always @(posedge clk1 , negedge reset)
	begin

		if (reset == 0)
		begin
			q[0] = 6'b111110;
			q[1] = 6'b011111;
			q[2] = 6'b000001;
			q[3] = 6'b100000;
		end
		else begin

		q[0] <= q[0]<<1;
		q[0][0] <= q[0][5];
		
		q[1] <= q[1]>>1;
		q[1][5] <= q[1][0];

		q[2] <= q[2]<<1;
		q[2][0] <= q[2][5];
		
		q[3] <= q[3]>>1;
		q[3][5] <= q[3][0];

		end
	end
//-----------scan and display 7-SEG-------------

always@(posedge cnt_scan[15])
	scanout <= scanout + 1;

always@(scanout) //
begin
	case(scanout)
		3'b000:
			segout={2'b11,q[0]};
		3'b001:
			segout={2'b11,q[1]};
		3'b101:
			segout={2'b11,q[2]};
		3'b110:
			segout={2'b11,q[3]};
		default:
			segout=8'b11111111;
	endcase
end

endmodule
