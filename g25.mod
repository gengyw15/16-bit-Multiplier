* **********************************************
*    PROCESS :  0.25um EE141          (2.5V)   *
*    SPICE MODEL     BSIM3 - V3.1              *
* **********************************************
*
******************************************************************************
*                                                                            * 
*       THIS MODEL LIB CONTAINS :                                            *  
*                                                                            *
*       1. MOSFET										     *
*         LIB TT                                                             *
*             SS                                                             *
*             FF                                                             *
*             SF                                                             *
*             FS                                                             *
*                                                                            *                                                                    *
******************************************************************************
*
*  You can use this model librarry by including the following library reference
*  in your SPICE file 
*
*     .lib 'lib_path/lib_name' model_name 
*
*  EX: .lib '<ModelFile>' TT   
*        
*             for typical N,PMOS
*      
*  MAKE SURE TO CHANGE ALL REFERENCES to <MODELFILE> in this file to the actual location
*  of the file on your computer.
*     
*  note:
*      corner_name
*       TT : typical model
*       SS : Slow NMOS Slow PMOS model
*       FF : Fast NMOS Fast PMOS model
*       SF : Slow NMOS Fast PMOS model
*       FS : Fast NMOS Slow PMOS model
*      
*
***************************************************************
*                                                             *
*              2.5V NORMAL DEVICES LIB                        *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT
.param toxp = 5.8e-9 toxn = 5.8e-9 
+dxl = 0 dxw = 0 
+dvthn = 0 dvthp = 0 
+cjn = 2.024128E-3    cjp = 1.931092e-3  
+cjswn = 2.751528E-10  cjswp = 2.232277e-10
+cgon =  3.11E-10 cgop = 2.68e-10  
+cjgaten = 2.135064E-10 cjgatep = 1.607088e-10
+hdifn = 3.1e-07 hdifp = 3.1e-7 
.lib 'g25.mod' MOS
.ENDL TT
**************** CORNER_LIB OF  SNSP   MODEL ****************************
.LIB SS
.param toxp = 6.1e-9 toxn = 6.1e-9 
+dxl = 2.5e-8 dxw = -3e-8 
+dvthn = 0.06 dvthp = -0.06
+cjn = 2.2265408E-3 cjp = 2.1242e-3  
+cjswn = 3.0266808E-10 cjswp = 2.4555e-10 
+cgon = 3.421E-10 cgop = 2.948e-10 
+cjgaten = 2.3485704E-10 cjgatep = 1.7678e-10
+hdifn = 3.1e-07 hdifp = 3.1e-7
.lib 'g25.mod' MOS
.ENDL SS
**************** CORNER_LIB OF  FNFP   MODEL ****************************
.LIB FF
.param toxp = 5.5e-9 toxn = 5.5e-9 
+dxl = -2.5e-8 dxw = 3e-8
+dvthn = -0.06 dvthp = 0.06 
+cjn = 1.8217152e-3 cjp = 1.738e-3  
+cjswn = 2.4763752e-10 cjswp = 2.009e-10 
+cgon = 2.799e-10 cgop = 2.412e-10 
+cjgaten = 1.9215576e-10 cjgatep = 1.4464e-10
+hdifn = 3.1e-07 hdifp = 3.1e-7 
.lib 'g25.mod' MOS
.ENDL FF
**************** CORNER_LIB OF  SNFP   MODEL ****************************
.LIB SF
.param toxp = 5.8e-9 toxn = 5.8e-9 
+dxl = 0 dxw = 0
+dvthn = 0.06 dvthp = 0.06
+cjn = 2.2265408E-3 cjp = 1.738e-3  
+cjswn = 3.0266808E-10 cjswp = 2.009e-10 
+cgon =  3.11E-10 cgop = 2.68e-10
+cjgaten = 2.3485704E-10 cjgatep = 1.4464e-10
+hdifp = 3.1e-7 hdifn = 3.1e-07
.lib 'g25.mod' MOS
.ENDL SF
**************** CORNER_LIB OF  FNSP   MODEL ****************************
.LIB FS
.param toxp = 5.8e-9 toxn = 5.8e-9 
+dxl = 0 dxw = 0
+dvthn = -0.06 dvthp = -0.06
+cjn = 1.8217152e-3 cjp = 2.1242e-3  
+cjswn = 2.4763752e-10 cjswp = 2.4555e-10 
+cgon =  3.11E-10 cgop = 2.68e-10 
+cjgaten = 1.9215576e-10 cjgatep = 1.7678e-10
+hdifp = 3.1e-7 hdifn = 3.1e-07
.lib 'g25.mod' MOS
.ENDL FS
***************************************************************************
*
.LIB MOS

***************************************************************
*                 NMOS DEVICES MODEL                          *
***************************************************************


.MODEL nmos          NMOS   (                    
+LMIN    = 2.4E-07        LMAX    = '5.1E-07-dxl'     
+LEVEL   = 49             TNOM    = 25             XL      = '3E-8 + dxl'
+XW      = '0 + dxw'      VERSION = 3.1            TOX     = toxn           
+CALCACM = 1              SFVTFLAG= 0              VFBFLAG = 1
+XJ      = 1E-07          NCH     = 2.354946E+17   LLN     = 1              
+LWN     = 1              WLN     = 1              WWN     = 1              
+LINT    = 1.76E-08       WINT    = 6.75E-09       MOBMOD  = 1              
+BINUNIT = 2              DWG     = 0              DWB     = 0              
+VTH0    = '0.4321336+dvthn' LVTH0   = 2.081814E-08   WVTH0   = -5.470342E-11
+PVTH0   = -6.721795E-16  K1      = 0.3281252      LK1     = 9.238362E-08   
+WK1     = 2.878255E-08   PK1     = -2.426481E-14  K2      = 0.0402824      
+LK2     = -3.208392E-08  WK2     = -1.154091E-08  PK2     = 9.192045E-15   
+K3      = 0              DVT0    = 0              DVT1    = 0              
+DVT2    = 0              DVT0W   = 0              DVT1W   = 0              
+DVT2W   = 0              NLX     = 0              W0      = 0              
+K3B     = 0              VSAT    = 7.586954E+04   LVSAT   = 3.094656E-03   
+WVSAT   = -1.747416E-03  PVSAT   = 8.820956E-10   UA      = 8.924498E-10   
+LUA     = -1.511745E-16  WUA     = -3.509821E-17  PUA     = -3.08778E-23   
+UB      = 8.928832E-21   LUB     = -1.655745E-27  WUB     = -2.03282E-27   
+PUB     = 3.4578E-34     UC      = -1.364265E-11  LUC     = 1.170473E-17   
+WUC     = -1.256705E-18  PUC     = -6.249644E-24  RDSW    = 447.8871       
+PRWB    = 0              PRWG    = 0              WR      = 0.99           
+U0      = 0.06005258     LU0     = -6.31976E-09   WU0     = -8.819531E-09  
+PU0     = 3.57209E-15    A0      = -1.468837      LA0     = 6.419548E-07   
+WA0     = 5.512414E-07   PA0     = -9.222928E-14  KETA    = -0.04922795    
+LKETA   = 2.360844E-08   WKETA   = 1.560385E-08   PKETA   = -5.98377E-15   
+A1      = 0.02659908     LA1     = -6.511454E-09  A2      = 1              
+AGS     = -4.01637       LAGS    = 1.090294E-06   WAGS    = 1.162021E-06   
+PAGS    = -3.108579E-13  B0      = 0              B1      = 0              
+VOFF    = -0.1829426     LVOFF   = 9.941631E-09   WVOFF   = 1.568082E-08   
+PVOFF   = -2.832958E-15  NFACTOR = 0.6790636      LNFACTOR= 3.454948E-08   
+WNFACTOR= 1.501016E-07   PNFACTOR= -2.955591E-14  CIT     = 2.218499E-04   
+LCIT    = -1.076934E-10  WCIT    = -3.286884E-10  PCIT    = 1.658928E-16   
+CDSC    = 0              CDSCB   = 0              CDSCD   = 0              
+ETA0    = 1.215578E-04   LETA0   = -1.037758E-11  WETA0   = -3.030225E-11  
+PETA0   = 1.529658E-17   ETAB    = 3.548681E-03   LETAB   = -1.791374E-09  
+WETAB   = -6.897268E-10  PETAB   = 3.481742E-16   DSUB    = 0              
+PCLM    = 3.583838       LPCLM   = -6.874146E-07  WPCLM   = 5.664574E-08   
+PPCLM   = -1.33176E-15   PDIBLC1 = 0              PDIBLC2 = 5.379674E-03   
+LPDIBLC2= 7.808481E-09   WPDIBLC2= 5.516945E-10   PPDIBLC2= -2.784957E-16  
+PDIBLCB = -0.1229374     LPDIBLCB= 4.956215E-08   WPDIBLCB= 3.299946E-08   
+PPDIBLCB= -9.624918E-15  DROUT   = 0              PSCBE1  = 4.472639E+08   
+LPSCBE1 = 28.64041       WPSCBE1 = 15.7154        PPSCBE1 = -7.933138E-06  
+PSCBE2  = 1.842585E-06   LPSCBE2 = 2.871008E-12   WPSCBE2 = 2.579183E-12   
+PPSCBE2 = -1.301972E-18  PVAG    = -2.015254E-03  LPVAG   = 1.017757E-09   
+WPVAG   = 3.07622E-10    PPVAG   = -1.55418E-16   DELTA   = -0.02862256    
+LDELTA  = 1.492454E-08   WDELTA  = -6.71663E-09   PDELTA  = 3.407521E-15   
+ALPHA0  = 0              BETA0   = 30             KT1     = -0.2579945     
+LKT1    = -1.664895E-08  WKT1    = -1.633463E-08  PKT1    = 3.755864E-15   
+KT2     = -0.05347481    LKT2    = 8.244731E-09   WKT2    = 1.13705E-09    
+PKT2    = -1.240924E-15  AT      = -1.132632E+04  LAT     = 6.469047E-03   
+WAT     = 6.829220E-04   PAT     = -4.154249E-10  UTE     = -2.309089      
+LUTE    = 1.662427E-07   WUTE    = 1.244801E-07   PUTE    = -5.627924E-14  
+UA1     = -3.461758E-10  LUA1    = 1.747495E-16   WUA1    = -1.42065E-16   
+PUA1    = 7.171442E-23   UB1     = 0              UC1     = -2.38157E-12   
+LUC1    = -2.895726E-18  WUC1    = -1.990052E-17  PUC1    = 1.004497E-23   
+KT1L    = 0              PRT     = -1E-18         CJ      = cjn
+MJ      = 0.4960069      PB      = 0.9173808      CJSW    = cjswn          
+MJSW    = 0.443145       PBSW    = 0.9173808      CJSWG   = cjgaten        
+MJSWG   = 0.443145       PBSWG   = 0.9173808      HDIF    = hdifn          
+RS      = 0              RD      = 0
+ACM     = 12             LDIF    = 1.2E-07        RSH     = 4.5            
+CTA     = 7.707813E-04   CTP     = 5.512283E-04   PTA     = 1.167715E-03   
+PTP     = 1.167715E-03   N       = 1              XTI     = 3              
+CGDO    = 'cgon'         CGSO    = 'cgon'         CAPMOD  = 0              
+NQSMOD  = 0              XPART   = 1              CF      = 0              
+TLEV    = 1              TLEVC   = 1              JS      = 1E-06          
+JSW     = 5E-11           )
*
***************************************************************
*                 PMOS DEVICES MODEL                          *
***************************************************************
      
.MODEL pmos PMOS (                               LEVEL   = 49                 
+VERSION = 3.1            LMIN    = 2.4E-7         LMAX    = '5.0E-7-dxl'       
+XL      = '3e-8+dxl'     
+XW      = '0+dxw'        TNOM    = 25             TOX     = toxp          
+CALCACM = 1              SFVTFLAG= 0              VFBFLAG = 1
+XJ      = 1E-7           NCH     = 4.1589E17          
+LLN     = 1              LWN     = 1              WLN     = 1                  
+WWN     = 1              LINT    = 1.2365E-8      WINT    = 7.8E-9             
+MOBMOD  = 1              BINUNIT = 2              DWG     = 0                  
+DWB     = 0              VTH0    = 'dvthp-0.6236538' LVTH0   = 2.649834E-8
+WVTH0   = 3.214189E-8    PVTH0   = -3.22268E-15   K1      = 0.4198155          
+LK1     = 5.770498E-8    WK1     = 5.577151E-8    PK1     = -2.81684E-14       
+K2      = 0.0429467      LK2     = -2.296405E-8   WK2     = -1.355302E-8       
+PK2     = 6.848271E-15   K3      = 0              DVT0    = 0                  
+DVT1    = 0              DVT2    = 0              DVT0W   = 0                  
+DVT1W   = 0              DVT2W   = 0              NLX     = 0                  
+W0      = 0              K3B     = 0              VSAT    = 1.443912E5         
+LVSAT   = -7.688012E-4   WVSAT   = -6.083648E-3   PVSAT   = 2.186471E-10       
+UA      = 1.846811E-9    LUA     = -3.27694E-16   WUA     = -2.82106E-16       
+PUA     = 7.180233E-23   UB      = -7.84535E-19   LUB     = 4.772849E-25       
+WUB     = 2.599205E-25   PUB     = -1.46530E-31   UC      = -1.75560E-10       
+LUC     = 3.360832E-17   WUC     = 1.504425E-17   PUC     = -1.30556E-23       
+RDSW    = 1.03E3         PRWB    = 0              PRWG    = 0                  
+WR      = 1              U0      = 0.0136443      LU0     = -7.22084E-10       
+WU0     = -1.088554E-9   PU0     = 2.730854E-16   A0      = 0.1071803          
+LA0     = 4.64252E-7     WA0     = 5.383179E-7    PA0     = -1.32033E-13       
+KETA    = -4.943762E-3   LKETA   = -3.565304E-9   WKETA   = -5.226247E-9       
+PKETA   = 2.640665E-15   A1      = 0              A2      = 0.4                
+AGS     = 0.1664005      LAGS    = 1.19106E-7     WAGS    = 5.29237E-8         
+PAGS    = -2.67304E-14   B0      = 0              B1      = 0                  
+VOFF    = -0.0592623     LVOFF   = -1.96686E-8    WVOFF   = -1.486398E-8       
+PVOFF   = 7.510321E-15   NFACTOR = 0.8588103      LNFACTOR= -1.158881E-7       
+WNFACTOR= 1.210664E-8    PNFACTOR= -6.11712E-15   CIT     = 6.439495E-5        
+LCIT    = 2.916437E-10   WCIT    = -3.11284E-11   PCIT    = 1.572825E-17       
+CDSC    = 0              CDSCB   = 0              CDSCD   = 0                  
+ETA0    = -3.819468E-3   LETA0   = 2.155422E-9    WETA0   = 8.235612E-10       
+PETA0   = -4.16037E-16   ETAB    = 1.334637E-3    LETAB   = -7.93631E-10       
+WETAB   = 5.284657E-11   PETAB   = -2.68353E-17   DSUB    = 0                  
+PCLM    = 0.1098002      LPCLM   = 6.874263E-7    WPCLM   = 6.724724E-7        
+PPCLM   = -1.97766E-13   PDIBLC1 = 0              PDIBLC2 = 5.801323E-3        
+LPDIBLC2= -1.81964E-9    WPDIBLC2= -5.853396E-9   PPDIBLC2= 2.957545E-15       
+PDIBLCB = 0.1921199      DROUT   = 0              PSCBE1  = 7.19E8             
+PSCBE2  = 1E-20          PVAG    = 0              DELTA   = 0.01               
+ALPHA0  = 0              BETA0   = 30             KT1     = -0.3248987         
+LKT1    = -1.160393E-8   WKT1    = 4.153356E-8    PKT1    = -4.62347E-15       
+KT2     = -0.0367632     AT      = 1E4            UTE     = -1.04              
+UA1     = 3.992421E-10   UB1     = -9.23294E-19   LUB1    = -5.28718E-26       
+WUB1    = -6.13069E-26   PUB1    = 1.503674E-32   UC1     = -1.00699E-12       
+KT1L    = 0              PRT     = 0              CJ      = cjp                
+MJ      = 0.4812153      PB      = 0.9134669      CJSW    = cjswp              
+MJSW    = 0.3237595      PBSW    = 0.9134669      CJSWG   = cjgatep            
+MJSWG   = 0.3237595      PBSWG   = 0.9134669      HDIF    = hdifp              
+LDIF    = 1.2E-7         ACM     = 12             RS      = 0                  
+RD      = 0              RSH     = 3.5            CTA     = 8.3043E-4          
+CTP     = 4.30175E-4     PTA     = 1.3004E-3      PTP     = 1.3004E-3          
+CGDO    = cgop           CGSO    = cgop                         
+CAPMOD  = 0              NQSMOD  = 0              XPART   = 1              
+CF      = 0              N       = 1              XTI     = 3
+TLEV    = 1              TLEVC   = 1              JS      = 3E-7           
+JSW     = 5E-12           )  
*
.ENDL MOS
                                                  
