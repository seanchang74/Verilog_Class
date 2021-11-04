module matrix8xRotate_class (clk,reset,segout,scanout);

input clk,reset;
output reg[7:0] segout;
output reg[2:0] scanout;

reg[25:0] cnt_scan;//
reg[3:0] i=0;

reg clk1;
reg [7:0] q[0:15] ;

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
		q[0] = 8'b11111111;
		q[1] = 8'b10000001;
		q[2] = 8'b11101111;
		q[3] = 8'b10000001;
		q[4] = 8'b11101101;
		q[5] = 8'b11011101;
		q[6] = 8'b11011101;
		q[7] = 8'b00000000;

		q[8] = 8'b11111111;
		q[9] = 8'b11101111;
		q[10] = 8'b11101111;
		q[11] = 8'b00000000;
		q[12] = 8'b11011011;
		q[13] = 8'b10111101;
		q[14] = 8'b01111110;
		q[15] = 8'b01111110;

	end
	else begin
		i = i + 1;
	end
end
//-----------scan and display 7-SEG-------------
always@(cnt_scan[15:13])
begin
	scanout <= cnt_scan[15:13];
end

	always@(scanout) //
	begin
		case(scanout)
			0: segout=q[(i)];
			1: segout=q[(i+1) % 16];
			2: segout=q[(i+2) % 16];
			3: segout=q[(i+3) % 16];
			4: segout=q[(i+4) % 16];
			5: segout=q[(i+5) % 16];
			6: segout=q[(i+6) % 16];
			7: segout=q[(i+7) % 16];
		default:
			segout=8'b11111111;
		endcase
	end

endmodule