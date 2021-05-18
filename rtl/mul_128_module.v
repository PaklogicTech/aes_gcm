module mul_128_module (
input [127:0] A,
input [127:0] B,
output [255:0] mul_128
);
wire [127:0] d0 ,d1 ,d2 ,d7;
mul_64_module mul_641 ((A [63:0]) ,( B [63:0]) ,( d0 ));
mul_64_module mul_642 ((A [63:0]^ A [127:64]) ,( B [63:0]^ B [127:64]) ,( d1 ));
mul_64_module mul_643 (A [127:64] , B [127:64] ,( d2 ));
assign d7 = d1^d2^d0;
assign mul_128 [255:0] = {d2 [127:64] ,(( d2 [63:0])^( d7 [127:64])) ,(( d0 [127:64])^( d7 [63:0])) , d0 [63:0]};
endmodule


module mul_64_module (
input [63:0]A,
input [63:0]B,
output [127:0] mul_64
);
wire [63:0] d0 ,d1 ,d2 ,d7;
mul_32_module u12 ((A [31:0]) ,( B [31:0]) ,( d0 ));
mul_32_module u13 ((A [31:0]^ A [63:32]) ,( B [31:0]^ B [63:32]) ,( d1 ));
mul_32_module u14 ((A [63:32]) ,( B [63:32]) ,( d2 ));
assign d7=d2^d1^d0;
assign mul_64 [127:0]={ d2 [63:32] ,( d2 [31:0]^ d7 [63:32]) ,( d0 [63:32]^ d7 [31:0]) , d0 [31:0]};
endmodule


module mul_32_module (
input [31:0]A,
input [31:0]B,
output [63:0] mul_32
);
wire [31:0] d0 ,d1 ,d2 ,d7;
mul_16_module u9 ((A [15:0]) ,( B [15:0]) ,( d0 ));
mul_16_module u10 ((A [15:0]^ A [31:16]) ,( B [15:0]^ B [31:16]) ,( d1 ));
mul_16_module u11 ((A [31:16]) ,( B [31:16]) ,( d2 ));
assign d7=d2^d1^d0;
assign mul_32 [63:0]={ d2 [31:16] ,( d2 [15:0]^ d7 [31:16]) ,( d0 [31:16]^ d7 [15:0]) , d0 [15:0]};
endmodule


module mul_16_module (
input [15:0]A,
input [15:0]B,
output [31:0] mul_16
);
wire [15:0] d0 ,d1 ,d2 ,d7;
mul_8_module u6 ((A [7:0]) ,( B [7:0]) ,( d0 ));
mul_8_module u7 ((A [7:0]^ A [15:8]) ,( B [7:0]^ B [15:8]) ,( d1 ));
mul_8_module u8 ((A [15:8]) ,( B [15:8]) ,( d2 ));
assign d7=d2^d1^d0;
assign mul_16 [31:0]={ d2 [15:8] ,( d2 [7:0]^ d7 [15:8]) ,( d0 [15:8]^ d7 [7:0]) , d0 [7:0]};
endmodule



module mul_8_module (
input [7:0]A,
input [7:0]B,
output [15:0] mul_8
);
wire [7:0] d0 ,d1 ,d2 ,d7;
mul_4_module u3 ((A [3:0]) ,( B [3:0]) ,( d0 ));
mul_4_module u4 ((A [3:0]^ A [7:4]) ,( B [3:0]^ B [7:4]) ,( d1 ));
mul_4_module u5 ((A [7:4]) ,( B [7:4]) ,( d2 ));
assign d7=d2^d1^d0;
assign mul_8 [15:0]={ d2 [7:4] ,( d2 [3:0]^ d7 [7:4]) ,( d0 [7:4]^ d7 [3:0]) , d0 [3:0]};
endmodule


module mul_4_module (
input [3:0]A,
input [3:0]B,
output [7:0] mul_4
);
wire [3:0] d0 ,d1 ,d2 ,d7;
mul_2_module u0 ((A [1:0]) ,( B [1:0]) ,( d0 ));
mul_2_module u1 ((A [1:0]^ A [3:2]) ,( B [1:0]^ B [3:2]) ,( d1 ));
mul_2_module u2 ((A [3:2]) ,( B [3:2]) ,( d2 ));
assign d7=d2^d1^d0;
assign mul_4 [7:0]={ d2 [3:2] ,( d2 [1:0]^ d7 [3:2]) ,( d0 [3:2]^ d7 [1:0]) , d0 [1:0]};
endmodule


module mul_2_module (
input [1:0] A,
input [1:0] B,
output [3:0] mul_2
);
assign mul_2 [0]= A [0]& B [0];
assign mul_2 [2]= A [1]& B [1];
assign mul_2 [3:0]={ A [1]& B[1] ,(A [0]^ A [1])&( B [0]^ B [1])^ mul_2 [0]^ mul_2 [2] ,A [0]& B [0]};
endmodule