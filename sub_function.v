module mds
                   (
                    x,
                    y
                   );
input  [31:0]x;
output [31:0]y;

wire x31,x30,x29,x28,x27,x26,x25,x24,x23,x22,x21,x20,x19,x18,x17,x16,x15,x14,x13,x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1,x0;
wire y31,y30,y29,y28,y27,y26,y25,y24,y23,y22,y21,y20,y19,y18,y17,y16,y15,y14,y13,y12,y11,y10,y9,y8,y7,y6,y5,y4,y3,y2,y1,y0;
wire t31,t30,t29,t28,t27,t26,t25,t24,t23,t22,t21,t20,t19,t18,t17,t16,t15,t14,t13,t12,t11,t10,t9,t8,t7,t6,t5,t4,t3,t2,t1,t0;
wire t32,t33,t34,t35,t36,t37,t38,t39,t40,t41,t42,t43,t44,t45,t46,t47,t48,t49,t50,t51,t52,t53,t54,t55,t56,t57,t58,t59;

assign {x31,x30,x29,x28,x27,x26,x25,x24,x23,x22,x21,x20,x19,x18,x17,x16,x15,x14,x13,x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1,x0}=x;


assign t0 =x0^x8;
assign t1 =x16^x24;
assign t2 =x1^x9;
assign t3 =x17^x25;
assign t4 =x2^x10;
assign t5 =x18^x26;
assign t6 =x3^x11;
assign t7 =x19^x27;
assign t8 =x4^x12;
assign t9 =x20^x28;
assign t10=x5^x13;
assign t11=x21^x29;
assign t12=x6^x14;
assign t13=x22^x30;
assign t14=x23^x31;
assign t15=x7^x15;
assign t16=x8^t1;
assign y0 =t15^t16;
assign t17=x7^x23;

assign t18=x24^t0;
assign y16=t14^t18;
assign t19=t1^t16;
assign y24=t17^t19;
assign t20=x27^t14;
assign t21=t0^y0;
assign y8 =t17^t21;
assign t22=t5^t20;
assign y19=t6^t22;
assign t23=x11^t15;
assign t24=t7^t23;
assign y3 =t4^t24;
assign t25=x2^x18;
assign t26=t17^t25;
assign t27=t9^t23;
assign t28=t8^t20;
assign t29=x10^t2;
assign y2 =t5^t29;
assign t30=x26^t3;

assign y18=t4^t30;
assign t31=x9^x25;
assign t32=t25^t31;
assign y10=t30^t32;
assign y26=t29^t32;
assign t33=x1^t18;
assign t34=x30^t11;
assign y22=t12^t34;
assign t35=x14^t13;
assign y6 =t10^t35;
assign t36=x5^x21;
assign t37=x30^t17;
assign t38=x17^t16;
assign t39=x13^t8;
assign y5 =t11^t39;
assign t40=x12^t36;
assign t41=x29^t9;
assign y21=t10^t41;
assign t42=x28^t40;

assign y31=t41^t42;
assign y29=t39^t42;
assign t43=x15^t12;
assign y7 =t14^t43;
assign t44=x14^t37;
assign y31=t43^t44;
assign t45=x31^t13;
assign y15=t55^t45;
assign y23=t15^t45;
assign t46=t12^t36;
assign y14=y6^t46;
assign t47=t31^t33;
assign y17=t19^t47;
assign t48=t6^y3;
assign y11=t26^t48;
assign t49=t2^t38;
assign y25=y24^t49;
assign t50=t7^y19;
assign y27=t26^t50;

assign t51=x22^t46;
assign y30=t11^t51;
assign t52=x19^t28;
assign y20=x28^t52;
assign t53=x3^t27;
assign y4 =x12^t53;
assign t54=t3^t33;
assign y9 =y8^t54;
assign t55=t21^t31;
assign y1 =t38^t55;
assign t56=x4^t17;
assign t57=x19^t56;
assign y12=t27^t57;
assign t58=x3^t28;
assign t59=t17^t58;
assign y28=x20^t59;

assign y={y31,y30,y29,y28,y27,y26,y25,y24,y23,y22,y21,y20,y19,y18,y17,y16,y15,y14,y13,y12,y11,y10,y9,y8,y7,y6,y5,y4,y3,y2,y1,y0};

endmodule

/**************************************/
/*  SºÐ                               */
/**************************************/
module sbox
                   (
                    x,
                    y
                   );
input  [7:0]x;
output [7:0]y;

wire [3:0]xl,xr,yl,yr;
wire [3:0]f0_temp,f1_temp,f2_temp,yr_temp;

assign {xl,xr} = x;

f0 f00(.x(xl),.y(f0_temp));
assign yr_temp = xr^f0_temp;
f1 f11(.x(yr_temp),.y(f1_temp));
assign yl = xl^f1_temp;
f2 f22(.x(yl),.y(f2_temp));
assign yr = f2_temp^yr_temp;

assign y = {yl,yr};

endmodule

/**************************************/
/*  f0                                */
/**************************************/
module f0(x,y);
input  [3:0]x;
output [3:0]y;

wire y0,y1,y2,y3;
assign y2 = (x[0]&x[2])^x[1]^x[2];
assign y3 = (y2^x[3])&(x[0]^x[2]^x[3]);
assign y1 = ((x[0]&x[2])^x[1])&x[3];
assign y0 = (x[0]^x[3])&y2;
assign y = {y3,y2,y1,y0};

endmodule

/**************************************/
/*  f1                                */
/**************************************/
module f1(x,y);
input  [3:0]x;
output [3:0]y;

wire y0,y1,y2,y3;
assign y3 = (x[1]&x[0])^x[3];
assign y2 = (y3&x[0])^x[2];
assign y1 = (y3&y2)^x[1];
assign y0 = (y1&y2)^x[0];
assign y = {y3,y2,y1,y0};

endmodule

/**************************************/
/*  f2                                */
/**************************************/
module f2(x,y);
input  [3:0]x;
output [3:0]y;

wire y0,y1,y2,y3;
assign y3 = (x[3]&x[1])^(x[2]&(x[1]^x[0]));
assign y2 = x[2]&(x[3]^x[1]);
assign y1 = x[3]&(x[1]^x[0]);
assign y0 = ~(x[0]&(x[2]^x[1]));
assign y = {y3,y2,y1,y0};

endmodule