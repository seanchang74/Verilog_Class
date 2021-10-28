module sevenLed(clk,reset,segout,scanout);

input clk,reset;
output reg[7:0] segout;
output reg[2:0] scanout;

reg[25:0] cnt_scan;//
reg[3:0] sel;

reg clk1;
reg [6:0] q[0:8] ;

initial
begin
	 q[0] = 7'b1111111;
	 q[1] = 7'b1111111;
	 q[2] = 7'b1111111;
	 q[3] = 7'b1111111;
	 q[4] = 7'b1111111;
	 q[5] = 7'b1111111;
	 q[6] = 7'b1111111;
	 q[7] = 7'b0111111;
end

//------------------ clock running -----------------------
always@(posedge clk or negedge reset)
begin
	if(!reset) begin
		cnt_scan<=0;
	end
	else begin
		cnt_scan<=cnt_scan+1;
		if (cnt_scan == 6250000) begin
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
			c1 = 0;
			q[0] = 7'b1111111;
			q[1] = 7'b1111111;
			q[2] = 7'b1111111;
			q[3] = 7'b1111111;
			q[4] = 7'b1111111;
			q[5] = 7'b1111111;
			q[6] = 7'b1111111;
			q[7] = 7'b0111111;			 
		end
		
		else begin
		integer c1 = 0;
			if(c1<8)
			begin
				q[6] <= q[7];
				q[5] <= q[6];
				q[4] <= q[5];
				q[3] <= q[4];
				q[2] <= q[3];
				q[1] <= q[2];
				q[0] <= q[1];
				q[7] <= q[0];
				c1 = c1+1;
			end
			if(c1 == 8)
			begin
				q[7] <= 7'b1111111;
				q[0] <= 7'b1110110;
				c1=c1+1;
			end
			if(q[0] == 7'b1110110 | (c1 > 9 & c1 < 17) )
			begin		
				q[1] <= q[0];
				q[2] <= q[1];
				q[3] <= q[2];
				q[4] <= q[3];
				q[5] <= q[4];
				q[6] <= q[5];
				q[7] <= q[6];
				q[0] <= q[7];
				c1=c1+1;
			end
			if(c1 == 17)
			begin
				q[0] <= 7'b1111111;
				q[7] <= 7'b1000000;
				c1=c1+1;	
			end
			if(q[7] == 7'b1000000 | (c1 > 18 & c1 < 26) )
			begin
				q[6] <= q[7];
				q[5] <= q[6];
				q[4] <= q[5];
				q[3] <= q[4];
				q[2] <= q[3];
				q[1] <= q[2];
				q[0] <= q[1];
				q[7] <= q[0];
				c1 = c1+1;
			end
			if(c1 == 26)
			begin
				q[0] <= 7'b0000000;
				q[7] <= 7'b1111111;
				c1=c1+1;	
			end
			if(q[0] == 7'b0000000 | (c1 > 27 & c1 < 35) )
			begin		
				q[1] <= q[0];
				q[2] <= q[1];
				q[3] <= q[2];
				q[4] <= q[3];
				q[5] <= q[4];
				q[6] <= q[5];
				q[7] <= q[6];
				q[0] <= q[7];
				c1=c1+1;
			end
			if(c1==35)
			begin
				c1 = 0;
				q[0] = 7'b1111111;
				q[1] = 7'b1111111;
				q[2] = 7'b1111111;
				q[3] = 7'b1111111;
				q[4] = 7'b1111111;
				q[5] = 7'b1111111;
				q[6] = 7'b1111111;
				q[7] = 7'b0111111;		
			end
			
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
        3'b010:
			segout={2'b11,q[2]};
		3'b011:
			segout={2'b11,q[3]};
		3'b100:
			segout={2'b11,q[4]};
		3'b101:
			segout={2'b11,q[5]};
		3'b110:
			segout={2'b11,q[6]};
		3'b111:
			segout={2'b11,q[7]};
		default:
			segout=8'b11111111;
	endcase
end

endmodule
