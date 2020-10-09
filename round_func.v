module round_func
	                 (
	                  clk,
	                  rst,
	                  start,
	                  init, 

	                  k,
	                  p,
	                  y
	                 );

input  clk;
input  rst;
input  start;
input  [31:0]init;
input  [23:0]k;
input  [23:0]p;
output [23:0]y;

reg [31:0]b0,b1,b2,b3;
reg [31:0]a,s;
reg move_en;

wire [31:0]b0_temp,b1_temp,b2_temp,b3_temp;
wire [31:0]s_temp0,s_temp1,s_temp2,s_temp3;

always @(posedge clk or posedge rst)
  if(rst) move_en <= 1'b0;
  else if(start) move_en <= 1'b1;
  else move_en <= move_en;

always @(posedge clk or posedge rst)
  if(rst) b3 <= init;
  else if(move_en) b3 <= {b3_temp[30:0],b3_temp[31]};
  else b3 <= b3;

always @(posedge clk or posedge rst)
  if(rst) b2 <= init;
  else if(move_en) b2 <= {b2_temp[24:0],b2_temp[31:25]};
  else b2 <= b2;

always @(posedge clk or posedge rst)
  if(rst) b1 <= init;
  else if(move_en) b1 <= {b1_temp[26:0],b1_temp[31:27]};
  else b1 <= b1;

always @(posedge clk or posedge rst)
  if(rst) b0 <= init;
  else if(move_en) b0 <= {b0_temp[28:0],b0_temp[31:29]};
  else b0 <= b0;

assign b3_temp={b0[31:24],b0[23:16]^a[7:0],b0[15:8]^s[7:0],b0[7:0]};
assign b2_temp={b3[31:16],b3[15:8]^a[31:24],b3[7:0]^s[31:24]};
assign b1_temp={b2[31:24]^s[23:16],b2[23:8],b2[7:0]^a[23:16]};
assign b0_temp={b1[31:24]^a[15:8],b1[23:16]^s[15:8],b1[15:0]};

always @(posedge clk or posedge rst)
  if(rst) a <= init;
  else if(move_en) a <= a^{b3[23:16],b2[15:8],b1[7:0],b0[31:24]};
  else a <= a;

always @(posedge clk or posedge rst)
  if(rst) s <= init;
  else if(move_en) s <= s_temp3;
  else s <= s;

assign s_temp0=s^{b3[31:24]^8'hff,k^p};

sbox s0(.x(s_temp0[31:24]),.y(s_temp1[31:24]));
sbox s1(.x(s_temp0[23:16]),.y(s_temp1[23:16]));
sbox s2(.x(s_temp0[15:8 ]),.y(s_temp1[15:8 ]));
sbox s3(.x(s_temp0[7 :0 ]),.y(s_temp1[7 :0 ]));

mds mds0(.x(s_temp1),.y(s_temp2));

sbox s00(.x(s_temp2[31:24]),.y(s_temp3[31:24]));
sbox s11(.x(s_temp2[23:16]),.y(s_temp3[23:16]));
sbox s22(.x(s_temp2[15:8 ]),.y(s_temp3[15:8 ]));
sbox s33(.x(s_temp2[7 :0 ]),.y(s_temp3[7 :0 ]));

assign y={a[31:24]^s[31:24]^s[23:16],a[23:16]^s[15:8]^s[7:0],a[15:8]^a[7:0]^s[7:0]};

endmodule