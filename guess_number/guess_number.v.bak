module guess_number(clk,clk20,reset,plus,subtract,sure,segout,scanout);

input clk,clk20,reset,plus,subtract;
output[7:0] segout;
output[2:0] scanout;

reg[25:0] cnt_scan; //scan led
reg[15:0] cnt_clk2; //randnum
reg[3:1] sel; //store the position where number is selected

//initial number display 1234
reg [3:0] q7 = 4'h1; //store number
reg [3:0] q6 = 4'h2; //store number
reg [3:0] q5 = 4'h3; //store number
reg [3:0] q4 = 4'h4; //store number

reg [3:0] a7 = 4'h0; //store answer
reg [3:0] a6 = 4'h0; //store answer
reg [3:0] a5 = 4'h0; //store answer
reg [3:0] a4 = 4'h0; //store answer

reg [9:0] lista = 10'b0000000000;//list

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
			lista = 10'b0000000000;
			sel = 7;
			// random answer
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
				sel <= sel -1;
			else begin
				//compare number to answer
				sel <= 4'h7;
			end
		end
	end
// scanout
// display number on 7-led
	