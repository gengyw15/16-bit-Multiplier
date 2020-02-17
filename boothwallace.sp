.title 16multipliertest

.lib "g25.mod" tt
.option list POST nomod
.global vdd
.param wp=0.25u vsupply=2.5 vm='vsupply/2'

.include '33bit_adder.sp'
.vec 'test_last.vec'

.SUBCKT NOT A A_ M=1
mn A_ A 0 0 nmos l=0.25u w='0.25u*M'
mp A_ A Vdd Vdd pmos l=0.25u w='0.59u*M'
.ENDS


.subckt buf ain aout
XNOT1 ain ain_ NOT M=1
XNOT2 ain_ aout NOT M=5
.ends

*或非门  延时8.2e-11
.SUBCKT NOR2 A B out  
M0 	n1   A   vdd 	Vdd 	pmos 	w=1u l=0.25u
M1 	out  B   n1 	vdd		pmos 	w=1u l=0.25u
M2 	out  A   0 		0 		nmos 	w=0.25u l=0.25u
M3 	out  B   0 		0   	nmos 	w=0.25u l=0.25u   
.ENDS

.SUBCKT NOR3 A B C out 
M0 	n1   A   vdd 	Vdd 	pmos 	w=1.3u l=0.25u
M1 	n2   B   n1 	vdd		pmos 	w=1.3u l=0.25u
M2 	out  C   n2 	vdd		pmos 	w=1.3u l=0.25u
M3 	out  A   0 		0 		nmos 	w=0.25u l=0.25u
M4 	out  B   0 		0   	nmos 	w=0.25u l=0.25u   
M5 	out  C   0 		0   	nmos 	w=0.25u l=0.25u 
.ENDS

*进位产生信号 与门
.SUBCKT Generate A B And 
M0 	Delete 	A 	Vdd 	Vdd 	pmos 	w=0.42u l=0.25u
M1 	Delete 	B 	Vdd 	Vdd 	pmos 	w=0.42u l=0.25u
M2 	Delete	A 	n1 		0 		nmos 	w=0.25u l=0.25u
M3 	n1 	    B 	0 		0 		nmos 	w=0.25u l=0.25u
Xnot Delete And NOT     M=1
.ENDS


*进位传播信号 或门

.SUBCKT Propagate A B P
X_INV_A A Aa NOT
M0 	P  A   B 		Vdd 	pmos 	w=0.54u l=0.25u
M1 	P  Aa  B 		0 		nmos 	w=0.25u l=0.25u
M2 	P  Aa   A 		Vdd 	pmos 	w=0.54u l=0.25u   
.ENDS

*求和 异或门

.SUBCKT Sout Ci P S 
X_INV_A P   Pp      NOT
M0 	SS  Pp  Ci 		Vdd 	pmos 	w=0.505u l=0.25u
M1 	SS  P   Ci 		0 		nmos 	w=0.25u l=0.25u
M2 	SS  Ci   Pp 	Vdd 	pmos 	w=0.505u l=0.25u   
M3 	SS  Ci   P 		0 		nmos 	w=0.25u l=0.25u
X_INV_S SS   S      NOT     M=1
.ENDS

*同或门

.SUBCKT NXOR A B S 
X_INV_A B   Bp      NOT
M0 	S  Bp  A 		Vdd 	pmos 	w=0.505u l=0.25u
M1 	S  B   A 		0 		nmos 	w=0.25u l=0.25u
M2 	S  A   Bp 		Vdd 	pmos 	w=0.505u l=0.25u   
M3 	S  A   B 		0 		nmos 	w=0.25u l=0.25u
.ENDS

*求进位 G+PCi  经验证负载对尺寸和延时没有影响，经验证如果没有非门延时可以特稿一个数量级
.SUBCKT Cout G P Ci Co 
M0	n1 	G 	Vdd 	Vdd 	pmos		w=0.78u l=0.25u
M1	Cco P 	n1 		Vdd 	pmos		w=0.78u l=0.25u
M2  Cco Ci  n1 		Vdd		pmos		w=0.78u l=0.25u
M3	Cco G 	0		0		nmos		w=0.25u l=0.25u
M4	Cco P 	n2 		0		nmos 	    w=0.25u l=0.25u
M5	n2 	Ci 	0 		0 		nmos		w=0.25u l=0.25u
X_INV_C Cco Co NOT M=1
.ENDS

*多路选择器 二路
.SUBCKT MUX2 C0 C1 Ci Co 
X_INV1 Ci Cci NOT M=1
M0 	C1 	Cci	Co 	Vdd 	pmos 	w=1.1u l=0.25u
M1	C1 	Ci 	Co	0 		nmos 	w=0.25u l=0.25u
M2	C0 	Ci 	Co 	Vdd 	pmos 	w=1.1u l=0.25u
M3	C0 	Cci Co 	0 		nmos 	w=0.25u l=0.25u
.ENDS

*半加器
.SUBCKT H_adder A B S Co
X_Sout  A   B   S   Sout
X_Gen   A   B   Co  Generate
.ENDS

*全加器
.SUBCKT F_adder A B Ci S Co
X_Gen A B G Generate
X_Pro A B P  Sout
X_Sout Ci P S Sout
X_Cout G P Ci Co Cout 
.ENDS

.subckt BOOTHCODE  a2i1 a2i a2i0 yj_ yj_1_ ppj  
xanor1 a2i a2i0 a1_x NXOR
xanor2 a2i1 a2i c NXOR
xaor1 a2i a2i0 a2_x Sout
x2nor1 yj_ a1_x 1 NOR2 *booth decoder
xnor3 c yj_1_ a2_x 2 NOR3
x2nor2 1 2 3 NOR2
xnot 3 ppj NOT
.ends

************Sign Extension**************
**** input:A,B,C,Y:x2i1,x2i,x2i0,ymsb **
*********     output:Sgn    ************ $$部分积中符号扩展位
.subckt Gsgn A B C Y Sgn  M=1           
xnot1 A A_ NOT 
xnot2 Y Y_ NOT
xgen1 B C 3 Generate 
xnor2 A_ 3 sel1 NOR2

xnor3 B C 4 NOR2
xnor4 A 4 sel2 NOR2
xmux1 0 Y sel2 5 MUX2
xmux2 5 Y_ sel1 Sgn MUX2
.ends

************ Cp generate **************
****    input:A,B,C:x2i1,x2i,x2i0****
*********     output:Cp    ************$$取反加一中1的产生
.subckt CPG A B C Cp M=1 
xnot A A_ NOT              
xgen1 B C 3 Generate
xnor1 A_ 3 Cp NOR2
.ends

****** Booth Partial Product Generate  ******
*****      input:x2i1 x2i x2i0 Y       ******
************     output:pp4y    **************
.subckt PPG y15 y14 y13 y12 y11 y10 y9 y8 y7 y6 y5 y4 y3 y2 y1 y0
+ x2i1 x2i x2i0
+ pp4y15 pp4y14 pp4y13 pp4y12 pp4y11 pp4y10 pp4y9 pp4y8 pp4y7 pp4y6 pp4y5 pp4y4 pp4y3 pp4y2 pp4y1 pp4y0
xxnor00 0 x2i1 y_0_ NXOR
xxnor0 y0 x2i1 y0_ NXOR
xxnor1 y1 x2i1 y1_ NXOR
xxnor2 y2 x2i1 y2_ NXOR
xxnor3 y3 x2i1 y3_ NXOR
xxnor4 y4 x2i1 y4_ NXOR
xxnor5 y5 x2i1 y5_ NXOR
xxnor6 y6 x2i1 y6_ NXOR
xxnor7 y7 x2i1 y7_ NXOR
xxnor8 y8 x2i1 y8_ NXOR
xxnor9 y9 x2i1 y9_ NXOR
xxnor10 y10 x2i1 y10_ NXOR
xxnor11 y11 x2i1 y11_ NXOR
xxnor12 y12 x2i1 y12_ NXOR
xxnor13 y13 x2i1 y13_ NXOR
xxnor14 y14 x2i1 y14_ NXOR
xxnor15 y15 x2i1 y15_ NXOR
xboothcode0 x2i1 x2i x2i0 y0_ y_0_ pp4y0 BOOTHCODE
xboothcode1 x2i1 x2i x2i0 y1_ y0_ pp4y1 BOOTHCODE
xboothcode2 x2i1 x2i x2i0 y2_ y1_ pp4y2 BOOTHCODE
xboothcode3 x2i1 x2i x2i0 y3_ y2_ pp4y3 BOOTHCODE
xboothcode4 x2i1 x2i x2i0 y4_ y3_ pp4y4 BOOTHCODE
xboothcode5 x2i1 x2i x2i0 y5_ y4_ pp4y5 BOOTHCODE
xboothcode6 x2i1 x2i x2i0 y6_ y5_ pp4y6 BOOTHCODE
xboothcode7 x2i1 x2i x2i0 y7_ y6_ pp4y7 BOOTHCODE
xboothcode8 x2i1 x2i x2i0 y8_ y7_ pp4y8 BOOTHCODE
xboothcode9 x2i1 x2i x2i0 y9_ y8_ pp4y9 BOOTHCODE
xboothcode10 x2i1 x2i x2i0 y10_ y9_ pp4y10 BOOTHCODE
xboothcode11 x2i1 x2i x2i0 y11_ y10_ pp4y11 BOOTHCODE
xboothcode12 x2i1 x2i x2i0 y12_ y11_ pp4y12 BOOTHCODE
xboothcode13 x2i1 x2i x2i0 y13_ y12_ pp4y13 BOOTHCODE
xboothcode14 x2i1 x2i x2i0 y14_ y13_ pp4y14 BOOTHCODE
xboothcode15 x2i1 x2i x2i0 y15_ y14_ pp4y15 BOOTHCODE
.ends

*********  Partial Product Generate  *********
*********          input:X Y        **********
************     output:ppXY    **************

vd vdd 0 2.5


******  first row of the partial product *****
Xppg0 a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
+ x1 x0 0
+ pp0a15 pp0a14 pp0a13 pp0a12 pp0a11 pp0a10 pp0a9 pp0a8 pp0a7 pp0a6 pp0a5 pp0a4 pp0a3 
+ pp0a2 pp0a1 pp0a00
+ PPG
Xgsgn0 x1 x0 0 a15 S0 Gsgn
Xcpg0 x1 x0 0 C11 CPG
Xnotc0 C11 pp0a00 pp0a0 C1 H_adder


******  second row of the partial product *****
Xppg1 a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
+ x3 x2 x1
+ pp1a15 pp1a14 pp1a13 pp1a12 pp1a11 pp1a10 pp1a9 pp1a8 pp1a7 pp1a6 pp1a5 pp1a4 pp1a3 
+ pp1a2 pp1a1 pp1a00
+ PPG
Xgsgn1 x3 x2 x1 a15 S1 Gsgn
Xcpg1 x3 x2 x1 C22 CPG
Xnotc1 C22 pp1a00 pp1a0 C2 H_ADDER

******  third row of the partial product *****
Xppg2 a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
+ x5 x4 x3
+ pp2a15 pp2a14 pp2a13 pp2a12 pp2a11 pp2a10 pp2a9 pp2a8 pp2a7 pp2a6 pp2a5 pp2a4 pp2a3 
+ pp2a2 pp2a1 pp2a00
+ PPG
Xgsgn2 x5 x4 x3 a15 S2 Gsgn
Xcpg2 x5 x4 x3 C33 CPG
Xnotc2 C33 pp2a00 pp2a0 C3 H_ADDER

******  forth row of the partial product *****
Xppg3 a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
+ x7 x6 x5
+ pp3a15 pp3a14 pp3a13 pp3a12 pp3a11 pp3a10 pp3a9 pp3a8 pp3a7 pp3a6 pp3a5 pp3a4 pp3a3 
+ pp3a2 pp3a1 pp3a00
+ PPG
Xgsgn3 x7 x6 x5 a15 S3 Gsgn
Xcpg3 x7 x6 x5 C44 CPG
Xnotc3 C44 pp3a00 pp3a0 C4 H_ADDER

******  fifth row of the partial product *****
Xppg4 a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
+ x9 x8 x7
+ pp4a15 pp4a14 pp4a13 pp4a12 pp4a11 pp4a10 pp4a9 pp4a8 pp4a7 pp4a6 pp4a5 pp4a4 pp4a3 
+ pp4a2 pp4a1 pp4a00
+ PPG
Xgsgn4 x9 x8 x7 a15 S4 Gsgn
Xcpg4 x9 x8 x7 C55 CPG
Xnotc4 C55 pp4a00 pp4a0 C5 H_ADDER

******  sixth row of the partial product *****
Xppg5 a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
+ x11 x10 x9
+ pp5a15 pp5a14 pp5a13 pp5a12 pp5a11 pp5a10 pp5a9 pp5a8 pp5a7 pp5a6 pp5a5 pp5a4 pp5a3 
+ pp5a2 pp5a1 pp5a00
+ PPG
Xgsgn5 x11 x10 x9 a15 S5 Gsgn
Xcpg5 x11 x10 x9 C66 CPG
Xnotc5 C66 pp5a00 pp5a0 C6 H_ADDER

******  seventh row of the partial product *****
Xppg6 a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
+ x13 x12 x11
+ pp6a15 pp6a14 pp6a13 pp6a12 pp6a11 pp6a10 pp6a9 pp6a8 pp6a7 pp6a6 pp6a5 pp6a4 pp6a3 
+ pp6a2 pp6a1 pp6a00
+ PPG
Xgsgn6 x13 x12 x11 a15 S6 Gsgn
Xcpg6 x13 x12 x11 C77 CPG
Xnotc6 C77 pp6a00 pp6a0 C7 H_ADDER

******  eighth row of the partial product *****
Xppg7 a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
+ x15 x14 x13
+ pp7a15 pp7a14 pp7a13 pp7a12 pp7a11 pp7a10 pp7a9 pp7a8 pp7a7 pp7a6 pp7a5 pp7a4 pp7a3 
+ pp7a2 pp7a1 pp7a00
+ PPG
Xgsgn7 x15 x14 x13 a15 S7 Gsgn
Xcpg7 x15 x14 x13 C88 CPG
Xnotc7 C88 pp7a00 pp7a0 C8 H_ADDER

xnots0 S0 S0_ NOT
xnots1 S1 S1_ NOT
xnots2 S2 S2_ NOT
xnots3 S3 S3_ NOT
xnots4 S4 S4_ NOT
xnots5 S5 S5_ NOT
xnots6 S6 S6_ NOT
xnots7 S7 S7_ NOT
xnotb b31 b31_ NOT

****** Compress 3-2 layer 0 *******
X0_0    pp6a1       c7          s0_13_0     c0_13_0       H_adder
X0_1    pp7a1       c8          s0_15_1     c0_15_1       H_adder
X0_2    pp6a4       pp7a2       s0_16_1     c0_16_1       H_adder   
X0_3    pp6a5       pp7a3       s0_17_1     c0_17_1       H_adder
X0_4    pp6a6       pp7a4       s0_18_1     c0_18_1       H_adder
X0_5    pp5a4       pp6a2       pp7a0       s0_14_0       c0_14_0       F_adder
X0_6    pp4a7       pp5a5       pp6a3       s0_15_0       c0_15_0       F_adder
X0_7    pp3a10      pp4a8       pp5a6       s0_16_0       c0_16_0       F_adder
X0_8    pp3a11      pp4a9       pp5a7       s0_17_0       c0_17_0       F_adder
X0_9    pp3a12      pp4a10      pp5a8       s0_18_0       c0_18_0       F_adder
X0_10   pp5a9       pp6a7       pp7a5       s0_19_0       c0_19_0       F_adder

****** Compress 3-2 layer 1 *******

X1_0    pp4a1       c5          s1_9_0      c1_9_0        H_adder 
X1_1    pp5a1       c6          s1_11_1     c1_11_1       H_adder
X1_2    pp6a9       pp7a7       s1_21_1     c1_21_1       H_adder
X1_3    pp6a11      pp7a9       s1_23_0     c1_23_0       H_adder
X1_4    pp3a4       pp4a2       pp5a0       s1_10_0       c1_10_0       F_adder
X1_5    pp2a7       pp3a5       pp4a3       s1_11_0       c1_11_0       F_adder
X1_6    pp1a10      pp2a8       pp3a6       s1_12_0       c1_12_0       F_adder
X1_7    pp4a4       pp5a2       pp6a0       s1_12_1       c1_12_1       F_adder 
X1_8    pp1a11      pp2a9       pp3a7       s1_13_0       c1_13_0       F_adder
X1_9    pp4a5       pp5a3       s0_13_0     s1_13_1       c1_13_1       F_adder
X1_10   pp1a12      pp2a10      pp3a8       s1_14_0       c1_14_0       F_adder
X1_11   pp4a6       c0_13_0     s0_14_0     s1_14_1       c1_14_1       F_adder
X1_12   pp1a13      pp2a11      pp3a9       s1_15_0       c1_15_0       F_adder
X1_13   c0_14_0     s0_15_0     s0_15_1     s1_15_1       c1_15_1       F_adder
X1_14   pp1a14      pp2a12      c0_15_0     s1_16_0       c1_16_0       F_adder     
X1_15   c0_15_1     s0_16_0     s0_16_1     s1_16_1       c1_16_1       F_adder   
X1_16   pp1a15      pp2a13      c0_16_0     s1_17_0       c1_17_0       F_adder
X1_17   c0_16_1     s0_17_0     s0_17_1     s1_17_1       c1_17_1       F_adder
X1_18   S1_         pp2a14      c0_17_0     s1_18_0       c1_18_0       F_adder
X1_19   c0_17_1     s0_18_0     s0_18_1     s1_18_1       c1_18_1       F_adder
X1_20   pp2a15      pp3a13      pp4a11      s1_19_0       c1_19_0       F_adder 
X1_21   c0_18_0     c0_18_1     s0_19_0     s1_19_1       c1_19_1       F_adder
X1_22   pp3a14      pp4a12      pp5a10      s1_20_0       c1_20_0       F_adder
X1_23   pp6a8       pp7a6       c0_19_0     s1_20_1       c1_20_1       F_adder
X1_24   pp3a15      pp4a13      pp5a11      s1_21_0       c1_21_0       F_adder
X1_25   pp5a12      pp6a10      pp7a8       s1_22_0       c1_22_0       F_adder

****** Compress 3-2 layer 2 *******
X2_0    pp2a1       c3          s2_5_0      c2_5_0        H_adder
X2_1    pp3a1       c4          s2_7_1      c2_7_1        H_adder
X2_2    pp6a13      pp7a11      s2_25_1     c2_25_1       H_adder
X2_3    pp6a15      pp7a13      s2_27_0     c2_27_0       H_adder
X2_4    pp1a4       pp2a2       pp3a0       s2_6_0        c2_6_0        F_adder
X2_5    pp0a7       pp1a5       pp2a3       s2_7_0        c2_7_0        F_adder 
X2_6    b8          pp0a8       pp1a6       s2_8_0        c2_8_0        F_adder       
X2_7    pp2a4       pp3a2       pp4a0       s2_8_1        c2_8_1        F_adder
X2_8    b9          pp0a9       pp1a7       s2_9_0        c2_9_0        F_adder          
X2_9    pp2a5       pp3a3       s1_9_0      s2_9_1        c2_9_1        F_adder 
X2_10   b10         pp0a10      pp1a8       s2_10_0       c2_10_0       F_adder
X2_11   pp2a6       c1_9_0      s1_10_0     s2_10_1       c2_10_1       F_adder
X2_12   b11         pp0a11      pp1a9       s2_11_0       c2_11_0       F_adder
X2_13   c1_10_0     s1_11_0     s1_11_1     s2_11_1       c2_11_1       F_adder
X2_14   b12         pp0a12      c1_11_0     s2_12_0       c2_12_0       F_adder
X2_15   c1_11_1     s1_12_0     s1_12_1     s2_12_1       c2_12_1       F_adder
X2_16   b13         pp0a13      c1_12_0     s2_13_0       c2_13_0       F_adder
X2_17   c1_12_1     s1_13_0     s1_13_1     s2_13_1       c2_13_1       F_adder
X2_18   b14         pp0a14      c1_13_0     s2_14_0       c2_14_0       F_adder
X2_19   c1_13_1     s1_14_0     s1_14_1     s2_14_1       c2_14_1       F_adder
X2_20   b15         pp0a15      c1_14_0     s2_15_0       c2_15_0       F_adder
X2_21   c1_14_1     s1_15_0     s1_15_1     s2_15_1       c2_15_1       F_adder
X2_22   b16         s0          c1_15_0     s2_16_0       c2_16_0       F_adder          
X2_23   c1_15_1     s1_16_0     s1_16_1     s2_16_1       c2_16_1       F_adder
X2_24   b17         s0          c1_16_0     s2_17_0       c2_17_0       F_adder  
X2_25   c1_16_1     s1_17_0     s1_17_1     s2_17_1       c2_17_1       F_adder
X2_26   b18         s0_         c1_17_0     s2_18_0       c2_18_0       F_adder    
X2_27   c1_17_1     s1_18_0     s1_18_1     s2_18_1       c2_18_1       F_adder
X2_28   b19         vdd         c1_18_0     s2_19_0       c2_19_0       F_adder
X2_29   c1_18_1     s1_19_0     s1_19_1     s2_19_1       c2_19_1       F_adder
X2_30   b20         s2_         c1_19_0     s2_20_0       c2_20_0       F_adder 
X2_31   c1_19_1     s1_20_0     s1_20_1     s2_20_1       c2_20_1       F_adder
X2_32   b21         vdd         c1_20_0     s2_21_0       c2_21_0       F_adder 
X2_33   c1_20_1     s1_21_0     s1_21_1     s2_21_1       c2_21_1       F_adder
X2_34   b22         s3_         pp4a14      s2_22_0       c2_22_0       F_adder 
X2_35   c1_21_0     c1_21_1     s1_22_0     s2_22_1       c2_22_1       F_adder
X2_36   b23         vdd         pp4a15      s2_23_0       c2_23_0       F_adder
X2_37   pp5a13      c1_22_0     s1_23_0     s2_23_1       c2_23_1       F_adder
X2_38   b24         s4_         pp5a14      s2_24_0       c2_24_0       F_adder
X2_39   pp6a12      pp7a10      c1_23_0     s2_24_1       c2_24_1       F_adder
X2_40   b25         vdd         pp5a15      s2_25_0       c2_25_0       F_adder
X2_41   s5_         pp6a14      pp7a12      s2_26_0       c2_26_0       F_adder

****** Compress 3-2 layer 3 *******
X3_0    pp1a1       c2          s3_3_0      c3_3_0        H_adder
X3_1    vdd         pp7a15      s3_29_0     c3_29_0       H_adder
X3_2    pp0a4       pp1a2       pp2a0       s3_4_0        c3_4_0        F_adder         
X3_3    pp0a5       pp1a3       s2_5_0      s3_5_0        c3_5_0        F_adder         
X3_4    pp0a6       c2_5_0      s2_6_0      s3_6_0        c3_6_0        F_adder         
X3_5    c2_6_0      s2_7_0      s2_7_1      s3_7_0        c3_7_0        F_adder         
X3_6    c2_7_1      s2_8_0      s2_8_1      s3_8_0        c3_8_0        F_adder        
X3_7    c2_8_1      s2_9_0      s2_9_1      s3_9_0        c3_9_0        F_adder        
X3_8    c2_9_1      s2_10_0     s2_10_1     s3_10_0       c3_10_0       F_adder        
X3_9    c2_10_1     s2_11_0     s2_11_1     s3_11_0       c3_11_0       F_adder        
X3_10   c2_11_1     s2_12_0     s2_12_1     s3_12_0       c3_12_0       F_adder        
X3_11   c2_12_1     s2_13_0     s2_13_1     s3_13_0       c3_13_0       F_adder        
X3_12   c2_13_1     s2_14_0     s2_14_1     s3_14_0       c3_14_0       F_adder        
X3_13   c2_14_1     s2_15_0     s2_15_1     s3_15_0       c3_15_0       F_adder        
X3_14   c2_15_1     s2_16_0     s2_16_1     s3_16_0       c3_16_0       F_adder        
X3_15   c2_16_1     s2_17_0     s2_17_1     s3_17_0       c3_17_0       F_adder        
X3_16   c2_17_1     s2_18_0     s2_18_1     s3_18_0       c3_18_0       F_adder        
X3_17   c2_18_1     s2_19_0     s2_19_1     s3_19_0       c3_19_0       F_adder        
X3_18   c2_19_1     s2_20_0     s2_20_1     s3_20_0       c3_20_0       F_adder        
X3_19   c2_20_1     s2_21_0     s2_21_1     s3_21_0       c3_21_0       F_adder        
X3_20   c2_21_1     s2_22_0     s2_22_1     s3_22_0       c3_22_0       F_adder        
X3_21   c2_22_1     s2_23_0     s2_23_1     s3_23_0       c3_23_0       F_adder        
X3_22   c2_23_1     s2_24_0     s2_24_1     s3_24_0       c3_24_0       F_adder        
X3_23   c2_24_1     s2_25_0     s2_25_1     s3_25_0       c3_25_0       F_adder        
X3_24   c2_25_0     c2_25_1     s2_26_0     s3_26_0       c3_26_0       F_adder        
X3_25   vdd         c2_26_0     s2_27_0     s3_27_0       c3_27_0       F_adder         
X3_26   pp7a14         s6_      c2_27_0     s3_28_0       c3_28_0       F_adder

****** Compress 3-2 layer 4 *******
X4_0    pp0a1       c1          s4_1_0      c4_1_0        H_adder
X4_1    b2          pp0a2       pp1a0       s4_2_0        c4_2_0        F_adder
X4_2    b3          pp0a3       s3_3_0      s4_3_0        c4_3_0        F_adder 
X4_3    b4          c3_3_0      s3_4_0      s4_4_0        c4_4_0        F_adder   
X4_4    b5          c3_4_0      s3_5_0      s4_5_0        c4_5_0        F_adder   
X4_5    b6          c3_5_0      s3_6_0      s4_6_0        c4_6_0        F_adder   
X4_6    b7          c3_6_0      s3_7_0      s4_7_0        c4_7_0        F_adder   
X4_7    c2_7_0      c3_7_0      s3_8_0      s4_8_0        c4_8_0        F_adder      
X4_8    c2_8_0      c3_8_0      s3_9_0      s4_9_0        c4_9_0        F_adder      
X4_9    c2_9_0      c3_9_0      s3_10_0     s4_10_0       c4_10_0       F_adder      
X4_10   c2_10_0     c3_10_0     s3_11_0     s4_11_0       c4_11_0       F_adder 
X4_11   c2_11_0     c3_11_0     s3_12_0     s4_12_0       c4_12_0       F_adder 
X4_12   c2_12_0     c3_12_0     s3_13_0     s4_13_0       c4_13_0       F_adder 
X4_13   c2_13_0     c3_13_0     s3_14_0     s4_14_0       c4_14_0       F_adder 
X4_14   c2_14_0     c3_14_0     s3_15_0     s4_15_0       c4_15_0       F_adder 
X4_15   c2_15_0     c3_15_0     s3_16_0     s4_16_0       c4_16_0       F_adder 
X4_16   c2_16_0     c3_16_0     s3_17_0     s4_17_0       c4_17_0       F_adder 
X4_17   c2_17_0     c3_17_0     s3_18_0     s4_18_0       c4_18_0       F_adder 
X4_18   c2_18_0     c3_18_0     s3_19_0     s4_19_0       c4_19_0       F_adder 
X4_19   c2_19_0     c3_19_0     s3_20_0     s4_20_0       c4_20_0       F_adder 
X4_20   c2_20_0     c3_20_0     s3_21_0     s4_21_0       c4_21_0       F_adder 
X4_21   c2_21_0     c3_21_0     s3_22_0     s4_22_0       c4_22_0       F_adder 
X4_22   c2_22_0     c3_22_0     s3_23_0     s4_23_0       c4_23_0       F_adder 
X4_23   c2_23_0     c3_23_0     s3_24_0     s4_24_0       c4_24_0       F_adder 
X4_24   c2_24_0     c3_24_0     s3_25_0     s4_25_0       c4_25_0       F_adder 
X4_25   b26         c3_25_0     s3_26_0     s4_26_0       c4_26_0       F_adder 
X4_26   b27         c3_26_0     s3_27_0     s4_27_0       c4_27_0       F_adder 
X4_27   b28         c3_27_0     s3_28_0     s4_28_0       c4_28_0       F_adder 
X4_28   b29         c3_28_0     s3_29_0     s4_29_0       c4_29_0       F_adder          
X4_29   b30         s7_         c3_29_0     s4_30_0       c4_30_0       F_adder

X_ADDER pp0a0 s4_1_0 s4_2_0 s4_3_0 s4_4_0 s4_5_0 s4_6_0 s4_7_0 s4_8_0 s4_9_0 s4_10_0 s4_11_0 s4_12_0 s4_13_0 s4_14_0 s4_15_0 s4_16_0 s4_17_0 s4_18_0 s4_19_0 s4_20_0 s4_21_0 s4_22_0 s4_23_0 s4_24_0 s4_25_0 s4_26_0 s4_27_0 s4_28_0 s4_29_0 s4_30_0 c4_30_0
+ b0 b1 c4_1_0 c4_2_0 c4_3_0 c4_4_0 c4_5_0 c4_6_0 c4_7_0 c4_8_0 c4_9_0 c4_10_0 c4_11_0 c4_12_0 c4_13_0 c4_14_0 c4_15_0 c4_16_0 c4_17_0 c4_18_0 c4_19_0 c4_20_0 c4_21_0 c4_22_0 c4_23_0 c4_24_0 c4_25_0 c4_26_0 c4_27_0 c4_28_0 c4_29_0 b31_ 
+ Sout0 Sout1 Sout2 Sout3 Sout4 Sout5 Sout6 Sout7 Sout8 Sout9 Sout10 Sout11 Sout12 Sout13 Sout14 Sout15 Sout16 Sout17 Sout18 Sout19 Sout20 Sout21 Sout22 Sout23 Sout24 Sout25 Sout26 Sout27 Sout28 Sout29 Sout30 Sout31 Sout32 ADD_33BIT

xbuf0 sout0 f0 BUF
xbuf1 sout1 f1 BUF
xbuf2 sout2 f2 BUF
xbuf3 sout3 f3 BUF
xbuf4 sout4 f4 BUF
xbuf5 sout5 f5 BUF
xbuf6 sout6 f6 BUF
xbuf7 sout7 f7 BUF
xbuf8 sout8 f8 BUF
xbuf9 sout9 f9 BUF
xbuf10 sout10 f10 BUF
xbuf11 sout11 f11 BUF
xbuf12 sout12 f12 BUF
xbuf13 sout13 f13 BUF
xbuf14 sout14 f14 BUF
xbuf15 sout15 f15 BUF
xbuf16 sout16 f16 BUF
xbuf17 sout17 f17 BUF
xbuf18 sout18 f18 BUF
xbuf19 sout19 f19 BUF
xbuf20 sout20 f20 BUF
xbuf21 sout21 f21 BUF
xbuf22 sout22 f22 BUF
xbuf23 sout23 f23 BUF
xbuf24 sout24 f24 BUF
xbuf25 sout25 f25 BUF
xbuf26 sout26 f26 BUF
xbuf27 sout27 f27 BUF
xbuf28 sout28 f28 BUF
xbuf29 sout29 f29 BUF
xbuf30 sout30 f30 BUF
xbuf31 sout31 f31 BUF
xbuf32 sout32 f32 BUF

CL0    f0    0    30f
CL1    f1    0    30f
CL2    f2    0    30f
CL3    f3    0    30f
CL4    f4    0    30f
CL5    f5    0    30f
CL6    f6    0    30f
CL7    f7    0    30f
CL8    f8    0    30f
CL9    f9    0    30f
CL10    f10    0    30f
CL11    f11    0    30f
CL12    f12    0    30f
CL13    f13    0    30f
CL14    f14    0    30f
CL15    f15    0    30f
CL16    f16    0    30f
CL17    f17    0    30f
CL18    f18    0    30f
CL19    f19    0    30f
CL20    f20    0    30f
CL21    f21    0    30f
CL22    f22    0    30f
CL23    f23    0    30f
CL24    f24    0    30f
CL25    f25    0    30f
CL26    f26    0    30f
CL27    f27    0    30f
CL28    f28    0    30f
CL29    f29    0    30f
CL30    f30    0    30f
CL31    f31    0    30f
CL32    f32    0    30f


.tran 0.1n 80n

.meas tran tpf trig v(a15) val=vm fall=2 targ v(f21) val=vm fall=5
.meas tran tpe trig v(a15) val=vm rise=2 targ v(f20) val=vm rise=6
.meas tran tpd trig v(a14) val=vm fall=2 targ v(f18) val=vm fall=5
.meas tran tpc trig v(a15) val=vm fall=1 targ v(f18) val=vm rise=5
.meas tran tpb trig v(a14) val=vm fall=1 targ v(f18) val=vm fall=4
.meas tran tpa trig v(a15) val=vm rise=1 targ v(f20) val=vm fall=1
.meas pwr avg p(vd) from=0n to=15n

.end
