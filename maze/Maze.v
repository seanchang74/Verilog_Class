module Maze (clk,clk20,reset,left,right,up,down,segout,scanout);

input clk,clk20,reset,left,right,up,down;
output reg[7:0] segout;
output reg[2:0] scanout;

reg[25:0] cnt_scan;//
reg[15:0] cnt_clk2;//randnum

reg[2:0] x=0, y=0;
reg[2:0] posX,posY;
reg[63:0] q;
reg clk1;
//------------------ clock running -----------------------
always@(posedge clk )
begin
	cnt_scan<=cnt_scan+1;
	if (cnt_scan == 06250000) begin
		cnt_scan <=0;
		clk1 = ~clk1;
	end
end
//---------modify display digit ----------
	always @(posedge clk1 , negedge reset)
	begin
	
		if (reset == 0)
		begin
			x = 0;
			y = 0;
			posX = 0;
			posY = 0;

			q = 64'hdf51e794bfa9adf5;
			q[posX+8*posY] = 1'b0;
		end
		else begin
			if(left == 0)
			begin
				if(x !== 0)
				begin
					if(q[x-1+8*y] == 1'b1)
					begin					
					x = x-1;
					posX = x;
					q = 64'hdf51e794bfa9adf5;
					q[posX+8*posY] = 1'b0;
					end
				end
			end
			if(right == 0)
			begin
				if(x !== 7)
				begin
					if(q[x+1+8*y] == 1'b1)
					begin
					x = x+1;
					posX = x;
					q = 64'hdf51e794bfa9adf5;
					q[posX+8*posY] = 1'b0;
					end
				end
			end
			if(down == 0)
			begin
				if(y !== 7)
				begin
					if(q[x+8*y+8] == 1'b1)
					begin
					y = y+1;
					posY = y;
					q = 64'hdf51e794bfa9adf5;
					q[posX+8*posY] = 1'b0;
					end
				end
			end
			if(up == 0)
			begin
				if(y !== 0)
				begin
					if(q[x+8*y-8] == 1'b1)
					begin
					y = y-1;
					posY = y;
					q = 64'hdf51e794bfa9adf5;
					q[posX+8*posY] = 1'b0;
					end
				end
			end
			if(posX == 7 && posY == 7)
			begin
			x = 0;
			y = 0;
			posX = 0;
			posY = 0;

			q <= 64'hff80808083c7cfcf;
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
		7:
			segout=q[63:56];
		6:
			segout=q[55:48];
		5:
			segout=q[47:40];
		4:
			segout=q[39:32];
		3:
			segout=q[31:24];
		2:
			segout=q[23:16];
		1:
			segout=q[15:8];
		0:
			segout=q[7:0];
		default:
			segout=8'b11111111;
	endcase
end

endmodule
