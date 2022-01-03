module guess_number(clk,clk20,reset,plus,subtract,sure,segout,scanout);

input clk,clk20,reset,plus,subtract,sure;
output reg[7:0] segout;
output reg[2:0] scanout;

reg [7:0] scanout1;

reg clk1;

reg[25:0] cnt_scan; //scan led
reg[15:0] cnt_clk2; //randnum
reg[3:1] sel; //store the position where number is selected
reg[3:0] display;

//initial number display 1234
//reg [3:0] q7 = 4'h1; //store number
//reg [3:0] q6 = 4'h2; //store number
//reg [3:0] q5 = 4'h3; //store number
//reg [3:0] q4 = 4'h4; //store number
reg [3:0] q[0:3];

//reg [3:0] a7 = 4'h0; //store answer
//reg [3:0] a6 = 4'h0; //store answer
//reg [3:0] a5 = 4'h0; //store answer
//reg [3:0] a4 = 4'h0; //store answer
reg [3:0] a[0:3];

reg [1:0] lista[0:9];//list

reg [2:0] q3 = 3'b000; //store 'A' number
reg [2:0] q1 = 3'b000; //store 'B' number

//------------------ clock running -----------------------
 always@(posedge clk )
begin
	cnt_scan<=cnt_scan+1;
	if (cnt_scan == 06250000) begin
		cnt_scan <=0;
		clk1 = ~clk1;
	end
end

always@(posedge clk20 )
begin
	cnt_clk2 <= cnt_clk2 + 1;
end

//------------------ modify display digit -----------------------
	always @(posedge clk1 , negedge reset)
	begin
	
		if(reset == 0)
		begin
		integer i = 0;
			for(i = 0; i<10; i=i+1)begin
				lista[i] <= 0;
			end
			i=0;
			sel = 0;
			// random answer
			a[0] = cnt_clk2[15:12]%10;
			lista[a[0]] = 1;
			
			a[1] = cnt_clk2[11:8]%10;
			if(lista[a[1]]==1)
				a[1]=(a[1]+1)%10;
			lista[a[1]] = 1;
			
			a[2] = cnt_clk2[7:4]%10;
			if(lista[a[2]]==1)
			begin
				a[2]=(a[2]+1)%10;
				if(lista[a[2]]==1)
					a[2]=(a[2]+1)%10;
			end
			lista[a[2]] = 1;
			
			a[3] = cnt_clk2[3:0]%10;
			while(lista[a[3]]==1&&i<3)
			begin
				a[3]=(a[3]+1)%10;
				i=i+1;
			end
			lista[a[3]] = 1;
			
			q[0] = 4'h1;
			q[1] = 4'h2;
			q[2] = 4'h3;
			q[3] = 4'h4;
			
			q1 = 0;
			q3 = 0;
		end
		else begin
		// press plus btn
		if (plus == 0)
			if(q[sel] != 4'h9)
				q[sel] <= q[sel] + 1;
			else begin
				q[sel] <= 4'h0;
			end
		// press subtract btn
		if (subtract == 0)
			if(q[sel] != 4'h0)
				q[sel] <= q[sel] - 1;
			else begin
				q[sel] <= 4'h9;
			end
		if (sure == 0)
			if(sel != 4'h4)
				sel <= sel +1;
			else begin
				//compare number to answer
				sel <= 0;
				q3 = 0;
				q1 = 0;
				if (q[0] == a[0])
					q3 = q3+1;
				else if(lista[q[0]] == 1)
					q1 = q1+1;
					
				if (q[1] == a[1])
					q3 = q3+1;
				else if(lista[q[1]] == 1)
					q1 = q1+1;
					
				if (q[2] == a[2])
					q3 = q3+1;
				else if(lista[q[2]] == 1)
					q1 = q1+1;
					
				if (q[3] == a[3])
					q3 = q3+1;
				else if(lista[q[3]] == 1)
					q1 = q1+1;				
			end
		end
	end
// scanout and display number on 7-led
//always@(posedge cnt_scan[15])
//	scanout <= scanout + 1;
//
//always@(scanout) //
//begin
//	case(scanout)
//		3'b000:
//			segout= -q1+1;
//		3'b001:
//			segout= -q1+1;
//        3'b010:
//			segout= -q3+1;
//		3'b011:
//			segout= -q3+1;
//		3'b100:
//			segout= -q[0]+1;
//		3'b101:
//			segout= -q[1]+1;
//		3'b110:
//			segout= -q[2]+1;
//		3'b111:
//			segout= -q[3]+1;
//		default:
//			segout=8'b11111111;
//	endcase
//end
always@(posedge cnt_scan[15])

	scanout <= scanout +1;
always@(scanout)
begin
	case(scanout)
		3'b000 :
			scanout1 = 8'b1111_1110;
		3'b001 :
			scanout1 = 8'b1111_1101;
		3'b010 :
			scanout1 = 8'b1111_1011;
		3'b011 :
			scanout1 = 8'b1111_0111;
		3'b100 :
			scanout1 = 8'b1110_1111;
		3'b101 :
			scanout1 = 8'b1101_1111;
		3'b110 :
			scanout1 = 8'b1011_1111;
		3'b111 :
			scanout1 = 8'b0111_1111;
		default :
			scanout1 = 8'b1111_1110;
	endcase
end

always@(scanout1) //
begin
	case(scanout1)
		8'b1111_1110:
			display= 4'hb;
		8'b1111_1101:
			display=q1;
		8'b1111_1011:
			display= 4'ha;
		8'b1111_0111:
			display=q3;
		8'b1110_1111:
			display=q[0];
		8'b1101_1111:
			display=q[1];
		8'b1011_1111:
			display=q[2];
		8'b0111_1111:
			display=q[3];
		default:
			display=4'hD;
	endcase

end

always@(display)
begin
//
	case(display)
		4'h0 :
			segout<= 8'd192; // seg_out <= B"11000000";
		4'h1 :
			segout<= 8'b11111001;
		4'h2 :
			segout<= 8'b10100100;
		4'h3 :
			segout<= 8'b10110000;
		4'h4 :
			segout<= 8'b10011001;
		4'h5 :
			segout<= 8'b10010010;
		4'h6 :
			segout<= 8'b10000010;
		4'h7 :
			segout<= 8'b11111000;
		4'h8 :
			segout<= 8'b10000000;
		4'h9 :
			segout<= 8'b10011000;
		4'ha :
			segout<= 8'b10001000; 
		4'hb :
			segout<= 8'b10000011;
		default :
			segout<= 8'b11111111;
	endcase
	
end

endmodule
	