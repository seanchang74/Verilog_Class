module matrix8xRotate (clk,reset,segout,scanout);

input clk,reset;
output reg[7:0] segout;
output reg[2:0] scanout;

reg[25:0] cnt_scan;//
reg[5:0] i=0;

reg clk1;
reg [7:0] q[0:44] ;

//------------------ clock running -----------------------
always@(posedge clk or negedge reset)
begin
	if(!reset) begin
		cnt_scan<=0;
	end
	else begin
		cnt_scan<=cnt_scan+1;
		if (cnt_scan == 8350000) begin
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
		q[0] = 8'b00000001;
		q[1] = 8'b11111101;
		q[2] = 8'b11101011;
		q[3] = 8'b11100111;
		q[4] = 8'b11101111;
		q[5] = 8'b11101111;
		q[6] = 8'b11011111;
		q[7] = 8'b10111111;
		
		q[8] = 8'b11111111;

		 q[9] = 8'b11111101;
		q[10] = 8'b11111101;
		q[11] = 8'b11111011;
		q[12] = 8'b11110011;
		q[13] = 8'b11101011;
		q[14] = 8'b10011011;
		q[15] = 8'b11111011;
		q[16] = 8'b11111011;
		
		q[17] = 8'b11111111;

		q[18] = 8'b11101111;
		q[19] = 8'b00000001;
		q[20] = 8'b01111101;
		q[21] = 8'b11111101;
		q[22] = 8'b11111101;
		q[23] = 8'b11111011;
		q[24] = 8'b11110111;
		q[25] = 8'b11001111;
		
		q[26] = 8'b11111111;
				
		q[27] = 8'b11111111;
		q[28] = 8'b10000011;
		q[29] = 8'b11101111;
		q[30] = 8'b11101111;
		q[31] = 8'b11101111;
		q[32] = 8'b00000001;
		q[33] = 8'b11111111;
		q[34] = 8'b11111111;

		q[35] = 8'b11111111;

		q[36] = 8'b11110111;
		q[37] = 8'b00000001;
		q[38] = 8'b11100111;
		q[39] = 8'b11010111;
		q[40] = 8'b10110111;
		q[41] = 8'b01110111;
		q[42] = 8'b11100111;
		q[43] = 8'b11111111;
			
	end
	else begin
		i = i + 1;
		if(i == 44)
		begin
			i = 0;
		end
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
			1: segout=q[(i+1) % 44];
			2: segout=q[(i+2) % 44];
			3: segout=q[(i+3) % 44];
			4: segout=q[(i+4) % 44];
			5: segout=q[(i+5) % 44];
			6: segout=q[(i+6) % 44];
			7: segout=q[(i+7) % 44];
		default:
			segout=8'b11111111;
		endcase
	end

endmodule