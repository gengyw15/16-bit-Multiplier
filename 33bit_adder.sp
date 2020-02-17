


*****************propagate*****************
*********input:A,B output:P************
.subckt PRO A B P                      
xpro1 A B P Sout
.ends PRO

*****************generate*****************
*********input:A,B output:G************
.subckt GEN A B G                     
xand1 A B G Generate
.ends GEN

*****************point_op*****************
*********input:G,P,G1,P1 output:GN, PN************
.subckt POP G P G1 P1 GN PN
Xgen1 G P G1 GN Cout
Xgen2 P P1 PN Generate
.ends POP

*****************function*****************
**********input:S310,S320,P,P'*****************
**********output:S32*******************
.subckt FUNC S310 S320 P P0 S32
Xf1 S320 P0 F1 Generate
Xf2 S310 P F2 Generate
Xf3 F1 F2 S32 Propagate
.ends FUNC


****************0-31trans****************
****************input:A0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31**************
****************input:B0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31**************
****************output:S0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32**************

.subckt ADD_33BIT A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15 A16 A17 A18 A19 A20 A21 A22 A23 A24 A25 A26 A27 A28 A29 A30 A31
+ B0 B1 B2 B3 B4 B5 B6 B7 B8 B9 B10 B11 B12 B13 B14 B15 B16 B17 B18 B19 B20 B21 B22 B23 B24 B25 B26 B27 B28 B29 B30 B31 
+ S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14 S15 S16 S17 S18 S19 S20 S21 S22 S23 S24 S25 S26 S27 S28 S29 S30 S31 S320 

Xpro0 A0 B0 P0 PRO
Xpro1 A1 B1 P1 PRO
Xpro2 A2 B2 P2 PRO
Xpro3 A3 B3 P3 PRO
Xpro4 A4 B4 P4 PRO
Xpro5 A5 B5 P5 PRO
Xpro6 A6 B6 P6 PRO
Xpro7 A7 B7 P7 PRO
Xpro8 A8 B8 P8 PRO
Xpro9 A9 B9 P9 PRO
Xpro10 A10 B10 P10 PRO
Xpro11 A11 B11 P11 PRO
Xpro12 A12 B12 P12 PRO
Xpro13 A13 B13 P13 PRO
Xpro14 A14 B14 P14 PRO
Xpro15 A15 B15 P15 PRO
Xpro16 A16 B16 P16 PRO
Xpro17 A17 B17 P17 PRO
Xpro18 A18 B18 P18 PRO
Xpro19 A19 B19 P19 PRO
Xpro20 A20 B20 P20 PRO
Xpro21 A21 B21 P21 PRO
Xpro22 A22 B22 P22 PRO
Xpro23 A23 B23 P23 PRO
Xpro24 A24 B24 P24 PRO
Xpro25 A25 B25 P25 PRO
Xpro26 A26 B26 P26 PRO
Xpro27 A27 B27 P27 PRO
Xpro28 A28 B28 P28 PRO
Xpro29 A29 B29 P29 PRO
Xpro30 A30 B30 P30 PRO
Xpro31 A31 B31 P31 PRO
Xpro32 A31 B31 P310 NXOR

Xgen0 A0 B0 G0 GEN
Xgen1 A1 B1 G1 GEN
Xgen2 A2 B2 G2 GEN
Xgen3 A3 B3 G3 GEN
Xgen4 A4 B4 G4 GEN
Xgen5 A5 B5 G5 GEN
Xgen6 A6 B6 G6 GEN
Xgen7 A7 B7 G7 GEN
Xgen8 A8 B8 G8 GEN
Xgen9 A9 B9 G9 GEN
Xgen10 A10 B10 G10 GEN
Xgen11 A11 B11 G11 GEN
Xgen12 A12 B12 G12 GEN
Xgen13 A13 B13 G13 GEN
Xgen14 A14 B14 G14 GEN
Xgen15 A15 B15 G15 GEN
Xgen16 A16 B16 G16 GEN
Xgen17 A17 B17 G17 GEN
Xgen18 A18 B18 G18 GEN
Xgen19 A19 B19 G19 GEN
Xgen20 A20 B20 G20 GEN
Xgen21 A21 B21 G21 GEN
Xgen22 A22 B22 G22 GEN
Xgen23 A23 B23 G23 GEN
Xgen24 A24 B24 G24 GEN
Xgen25 A25 B25 G25 GEN
Xgen26 A26 B26 G26 GEN
Xgen27 A27 B27 G27 GEN
Xgen28 A28 B28 G28 GEN
Xgen29 A29 B29 G29 GEN
Xgen30 A30 B30 G30 GEN
Xgen31 A31 B31 G31 GEN



Xop1_1  G1  P1  G0  P0  G0_1   P0_1    POP
Xop1_2  G2  P2  G1  P1  G1_2   p1_2    POP
Xop1_3  G3  P3  G2  P2  G2_3   p2_3    POP
Xop1_4  G4  P4  G3  P3  G3_4   p3_4    POP
Xop1_5  G5  P5  G4  P4  G4_5   p4_5    POP
Xop1_6  G6  P6  G5  P5  G5_6   p5_6    POP
Xop1_7  G7  P7  G6  P6  G6_7   p6_7    POP
Xop1_8  G8  P8  G7  P7  G7_8   p7_8    POP
Xop1_9  G9  P9  G8  P8  G8_9   p8_9    POP
Xop1_10 G10 P10 G9   P9   G9_10   p9_10    POP
Xop1_11 G11 P11 G10 P10 G10_11 p10_11  POP
Xop1_12 G12 P12 G11 P11 G11_12 p11_12  POP
Xop1_13 G13 P13 G12 P12 G12_13 p12_13  POP
Xop1_14 G14 P14 G13 P13 G13_14 p13_14  POP
Xop1_15 G15 P15 G14 P14 G14_15 p14_15  POP
Xop1_16 G16 P16 G15 P15 G15_16 p15_16  POP
Xop1_17 G17 P17 G16 P16 G16_17 p16_17  POP
Xop1_18 G18 P18 G17 P17 G17_18 p17_18  POP
Xop1_19 G19 P19 G18 P18 G18_19 p18_19  POP
Xop1_20 G20 P20 G19 P19 G19_20 p19_20  POP
Xop1_21 G21 P21 G20 P20 G20_21 p20_21  POP
Xop1_22 G22 P22 G21 P21 G21_22 p21_22  POP
Xop1_23 G23 P23 G22 P22 G22_23 p22_23  POP
Xop1_24 G24 P24 G23 P23 G23_24 p23_24  POP
Xop1_25 G25 P25 G24 P24 G24_25 p24_25  POP
Xop1_26 G26 P26 G25 P25 G25_26 p25_26  POP
Xop1_27 G27 P27 G26 P26 G26_27 p26_27  POP
Xop1_28 G28 P28 G27 P27 G27_28 p27_28  POP
Xop1_29 G29 P29 G28 P28 G28_29 p28_29  POP
Xop1_30 G30 P30 G29 P29 G29_30 p29_30  POP
Xop1_31 G31 P31 G30 P30 G30_31 p30_31  POP

Xop2_2  G1_2   P1_2   G0     P0     G0_2   P0_2    POP
Xop2_3  G2_3   P2_3   G0_1   P0_1   G0_3   p0_3    POP
Xop2_4  G3_4   P3_4   G1_2   P1_2   G1_4   p1_4    POP
Xop2_5  G4_5   P4_5   G2_3   P2_3   G2_5   p2_5    POP
Xop2_6  G5_6   P5_6   G3_4   P3_4   G3_6   p3_6    POP
Xop2_7  G6_7   P6_7   G4_5   P4_5   G4_7   p4_7    POP
Xop2_8  G7_8   P7_8   G5_6   P5_6   G5_8   p5_8    POP
Xop2_9  G8_9   P8_9   G6_7   P6_7   G6_9   p6_9    POP
Xop2_10 G9_10  P9_10  G7_8   P7_8   G7_10  p7_10   POP
Xop2_11 G10_11 P10_11 G8_9   P8_9   G8_11  p8_11   POP
Xop2_12 G11_12 P11_12 G9_10  P9_10  G9_12  p9_12   POP
Xop2_13 G12_13 P12_13 G10_11 P10_11 G10_13 p10_13  POP
Xop2_14 G13_14 P13_14 G11_12 P11_12 G11_14 p11_14  POP
Xop2_15 G14_15 P14_15 G12_13 P12_13 G12_15 p12_15  POP
Xop2_16 G15_16 P15_16 G13_14 P13_14 G13_16 p13_16  POP
Xop2_17 G16_17 P16_17 G14_15 P14_15 G14_17 p14_17  POP
Xop2_18 G17_18 P17_18 G15_16 P15_16 G15_18 p15_18  POP
Xop2_19 G18_19 P18_19 G16_17 P16_17 G16_19 p16_19  POP
Xop2_20 G19_20 P19_20 G17_18 P17_18 G17_20 p17_20  POP
Xop2_21 G20_21 P20_21 G18_19 P18_19 G18_21 p18_21  POP
Xop2_22 G21_22 P21_22 G19_20 P19_20 G19_22 p19_22  POP
Xop2_23 G22_23 P22_23 G20_21 P20_21 G20_23 p20_23  POP
Xop2_24 G23_24 P23_24 G21_22 P21_22 G21_24 p21_24  POP
Xop2_25 G24_25 P24_25 G22_23 P22_23 G22_25 p22_25  POP
Xop2_26 G25_26 P25_26 G23_24 P23_24 G23_26 p23_26  POP
Xop2_27 G26_27 P26_27 G24_25 P24_25 G24_27 p24_27  POP
Xop2_28 G27_28 P27_28 G25_26 P25_26 G25_28 p25_28  POP
Xop2_29 G28_29 P28_29 G26_27 P26_27 G26_29 p26_29  POP
Xop2_30 G29_30 P29_30 G27_28 P27_28 G27_30 p27_30  POP
Xop2_31 G30_31 P30_31 G28_29 P28_29 G28_31 p28_31  POP

Xop3_4  G1_4   P1_4   G0     P0     G0_4   P0_4    POP
Xop3_5  G2_5   P2_5   G0_1   P0_1   G0_5   P0_5    POP
Xop3_6  G3_6   P3_6   G0_2   P0_2   G0_6   P0_6    POP
Xop3_7  G4_7   P4_7   G0_3   P0_3   G0_7   P0_7    POP
Xop3_8  G5_8   P5_8   G1_4   P1_4   G1_8   p1_8    POP
Xop3_9  G6_9   P6_9   G2_5   P2_5   G2_9   p2_9    POP
Xop3_10  G7_10  P7_10  G3_6   P3_6   G3_10  p3_10   POP
Xop3_11  G8_11  P8_11  G4_7   P4_7   G4_11  p4_11   POP
Xop3_12  G9_12  P9_12  G5_8   P5_8   G5_12  p5_12   POP
Xop3_13 G10_13 P10_13 G6_9   P6_9   G6_13  p6_13   POP
Xop3_14 G11_14 P11_14 G7_10  P7_10  G7_14  p7_14   POP
Xop3_15 G12_15 P12_15 G8_11  P8_11  G8_15  p8_15   POP
Xop3_16 G13_16 P13_16 G9_12  P9_12  G9_16  p9_16   POP
Xop3_17 G14_17 P14_17 G10_13 P10_13 G10_17 p10_17  POP
Xop3_18 G15_18 P15_18 G11_14 P11_14 G11_18 p11_18  POP
Xop3_19 G16_19 P16_19 G12_15 P12_15 G12_19 p12_19  POP
Xop3_20 G17_20 P17_20 G13_16 P13_16 G13_20 p13_20  POP
Xop3_21 G18_21 P18_21 G14_17 P14_17 G14_21 p14_21  POP
Xop3_22 G19_22 P19_22 G15_18 P15_18 G15_22 p15_22  POP
Xop3_23 G20_23 P20_23 G16_19 P16_19 G16_23 p16_23  POP
Xop3_24 G21_24 P21_24 G17_20 P17_20 G17_24 p17_24  POP
Xop3_25 G22_25 P22_25 G18_21 P18_21 G18_25 p18_25   POP
Xop3_26 G23_26 P23_26 G19_22 P19_22 G19_26 p19_26   POP
Xop3_27 G24_27 P24_27 G20_23 P20_23 G20_27 p20_27  POP
Xop3_28 G25_28 P25_28 G21_24 P21_24 G21_28 p21_28  POP
Xop3_29 G26_29 P26_29 G22_25 P22_25 G22_29 p22_29  POP
Xop3_30 G27_30 P27_30 G23_26 P23_26 G23_30 p23_30  POP
Xop3_31 G28_31 P28_31 G24_27 P24_27 G24_31 p24_31  POP

Xop4_8  G1_8   P1_8   G0     P0    G0_8   P0_8   POP
Xop4_9  G2_9   P2_9   G0_1   P0_1  G0_9   P0_9   POP
Xop4_10  G3_10  P3_10  G0_2   P0_2  G0_10  P0_10  POP
Xop4_11  G4_11  P4_11  G0_3   P0_3  G0_11  P0_11  POP
Xop4_12  G5_12  P5_12  G0_4   P0_4  G0_12  P0_12  POP
Xop4_13  G6_13  P6_13  G0_5   P0_5  G0_13  P0_13  POP
Xop4_14  G7_14  P7_14  G0_6   P0_6  G0_14  P0_14  POP
Xop4_15  G8_15  P8_15  G0_7   P0_7  G0_15  P0_15  POP
Xop4_16  G9_16  P9_16  G1_8   P1_8  G1_16  p1_16  POP
Xop4_17 G10_17 P10_17 G2_9   P2_9  G2_17  p2_17  POP
Xop4_18 G11_18 P11_18 G3_10  P3_10 G3_18  p3_18  POP
Xop4_19 G12_19 P12_19 G4_11  P4_11 G4_19  p4_19  POP
Xop4_20 G13_20 P13_20 G5_12  P5_12 G5_20  p5_20  POP
Xop4_21 G14_21 P14_21 G6_13  P6_13 G6_21  p6_21  POP
Xop4_22 G15_22 P15_22 G7_14  P7_14 G7_22  p7_22  POP
Xop4_23 G16_23 P16_23 G8_15  P8_15 G8_23  p8_23  POP
Xop4_24 G17_24 P17_24 G9_16  P9_16 G9_24  p9_24  POP
Xop4_25 G18_25 P18_25 G10_17  P10_17 G10_25  P10_25  POP
Xop4_26 G19_26 P19_26 G11_18  P11_18 G11_26  p11_26  POP
Xop4_27 G20_27 P20_27 G12_19  P12_19 G12_27  p12_27  POP
Xop4_28 G21_28 P21_28 G13_20  P13_20 G13_28  p13_28  POP
Xop4_29 G22_29 P22_29 G14_21  P14_21 G14_29  p14_29  POP
Xop4_30 G23_30 P23_30 G15_22  P15_22 G15_30  p15_30  POP
Xop4_31 G24_31 P24_31 G16_23  P16_23 G16_31  p16_31  POP

Xop5_16  G1_16  P1_16  G0   P0   G0_16 P0_16  POP
Xop5_17  G2_17  P2_17  G0_1 P0_1 G0_17 P0_17  POP
Xop5_18  G3_18  P3_18  G0_2 P0_2 G0_18 p0_18  POP
Xop5_19  G4_19  P4_19  G0_3 P0_3 G0_19 p0_19  POP
Xop5_20  G5_20  P5_20  G0_4 P0_4 G0_20 p0_20  POP
Xop5_21  G6_21  P6_21  G0_5 P0_5 G0_21 p0_21  POP
Xop5_22  G7_22  P7_22  G0_6 P0_6 G0_22 p0_22  POP
Xop5_23  G8_23  P8_23  G0_7 P0_7 G0_23 p0_23  POP
Xop5_24  G9_24  P9_24  G0_8 P0_8 G0_24 p0_24  POP
Xop5_25  G10_25  P10_25  G0_9 P0_9 G0_25 p0_25  POP
Xop5_26  G11_26  P11_26  G0_10 P0_10 G0_26 P0_26  POP
Xop5_27  G12_27  P12_27  G0_11 P0_11 G0_27 P0_27  POP
Xop5_28  G13_28  P13_28  G0_12 P0_12 G0_28 p0_28  POP
Xop5_29  G14_29  P14_29  G0_13 P0_13 G0_29 p0_29  POP
Xop5_30  G15_30  P15_30  G0_14 P0_14 G0_30 p0_30  POP
Xop5_31  G16_31  P16_31  G0_15 P0_15 G0_31 p0_31  POP


XFA0  A0  B0  0   S0  0 F_ADDER
XFA1  A1  B1  G0  S1  0 F_ADDER
XFA2  A2  B2  G0_1  S2  0 F_ADDER
XFA3  A3  B3  G0_2  S3  0 F_ADDER
XFA4  A4  B4  G0_3  S4  0 F_ADDER
XFA5  A5  B5  G0_4  S5  0 F_ADDER
XFA6  A6  B6  G0_5  S6  0 F_ADDER
XFA7  A7  B7  G0_6  S7  0 F_ADDER
XFA8  A8  B8  G0_7  S8  0 F_ADDER
XFA9  A9  B9  G0_8  S9  0 F_ADDER
XFA10 A10 B10 G0_9  S10 0 F_ADDER
XFA11 A11 B11 G0_10 S11 0 F_ADDER
XFA12 A12 B12 G0_11 S12 0 F_ADDER
XFA13 A13 B13 G0_12 S13 0 F_ADDER
XFA14 A14 B14 G0_13 S14 0 F_ADDER
XFA15 A15 B15 G0_14 S15 0 F_ADDER
XFA16 A16 B16 G0_15 S16 0 F_ADDER
XFA17 A17 B17 G0_16 S17 0 F_ADDER
XFA18 A18 B18 G0_17 S18 0 F_ADDER
XFA19 A19 B19 G0_18 S19 0 F_ADDER
XFA20 A20 B20 G0_19 S20 0 F_ADDER
XFA21 A21 B21 G0_20 S21 0 F_ADDER
XFA22 A22 B22 G0_21 S22 0 F_ADDER
XFA23 A23 B23 G0_22 S23 0 F_ADDER
XFA24 A24 B24 G0_23 S24 0 F_ADDER
XFA25 A25 B25 G0_24 S25 0 F_ADDER
XFA26 A26 B26 G0_25 S26 0 F_ADDER
XFA27 A27 B27 G0_26 S27 0 F_ADDER
XFA28 A28 B28 G0_27 S28 0 F_ADDER
XFA29 A29 B29 G0_28 S29 0 F_ADDER
XFA30 A30 B30 G0_29 S30 0 F_ADDER
XFA31 A31 B31 G0_30 S31 0 F_ADDER
XFA32 0 VDD G0_31 S320 0 F_ADDER

****Xp31 P31 P310 NOT
*****Xs32 S31 S320 P31 P310 S32 FUNC

.ends ADD_33BIT
