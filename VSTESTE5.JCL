//VSTESTE5 JOB 'JAY MOSELEY',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=A,         00010000
//             REGION=4096K                                             00020000
//*                                                                     00030000
//********************************************************************* 00040000
//* COBOL MODULE: ESDSADDT     VSAM DATASET: VSTESTES.CLUSTER (ESDS)    00050000
//*                                                                     00060000
//* SEQUENTIALLY ADDS (APPENDS) RECORDS ONTO ENTRY SEQUENCED DATASET    00070000
//********************************************************************* 00080000
//*                                                                     00090000
//COB     EXEC PGM=IKFCBL00,REGION=1024K,                               00100000
//             PARM='LOAD,LIST,DMAP,BUF=8192,LIB'                       00110000
//SYSLIB   DD  DSN=SYS2.VSAMIO.SOURCE,DISP=SHR                          00120000
//SYSPRINT DD  SYSOUT=A                                                 00130000
//SYSUT1   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         00140000
//SYSUT2   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         00150000
//SYSUT3   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         00160000
//SYSUT4   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         00170000
//SYSLIN   DD  DSN=&LOADSET,DISP=(MOD,PASS),UNIT=SYSDA,                 00180000
//             SPACE=(80,(500,100))                                     00190000
//SYSIN    DD  DSN=SYS2.VSAMIO.SOURCE(ESDSADDT),DISP=SHR                00200000
//*                                                                     00210000
//LKED    EXEC PGM=IEWL,REGION=1024K,COND=(5,LT),                       00220000
//             PARM='LIST,XREF,LET'                                     00230000
//SYSLIN   DD  DSN=*.COB.SYSLIN,DISP=(OLD,PASS)                         00240000
//         DD  DSN=SYS2.VSAMIO.OBJECT(VSAMIO),DISP=SHR                  00250000
//SYSLMOD  DD  DSN=&GODATA(RUN),DISP=(NEW,PASS),UNIT=SYSDA,             00260000
//             SPACE=(1024,(50,20,1))                                   00270000
//SYSLIB   DD  DSN=SYS1.COBLIB,DISP=SHR                                 00280000
//SYSUT1   DD  UNIT=SYSDA,SPACE=(1024,(50,20))                          00290000
//SYSPRINT DD  SYSOUT=A                                                 00300000
//*                                                                     00310000
//GO      EXEC PGM=*.LKED.SYSLMOD,REGION=1024K,COND=(5,LT,LKED)         00320000
//SYSOUT   DD  SYSOUT=A                                                 00330000
//SYSIN    DD  *                                                        00340000
9532957501 JOHN J GLASSMAN      7663 SEASIDE AVENUE        NEWPORT BEACH   CA
1964475502 CAITLIN V BROCKTON   9540 PARKER COURT          KANSAS CITY     MO
9441505503 SUE P MOORE          640 JACKSON STREET         LOS ANGELES     CA
2153945504 LARRY E BENSON       4778 DESERT STREET         LA HABRA        CA
5500563505 CHRISTOPHER P BARBER 1640 GARRETT STREET        FREMONT         CA
9470427506 ZELDA H LOCKETT      314 ROSA LINDA COURT       MONTGOMERY      AL
9271987507 CLARA B ALEXANDER    8427 PECAN VALLEY STREET   BOISE           ID
3849060508 CINDY F EUBANKS      700 WILSHIRE PLACE         DOWNEY          CA
3461449509 ROY H TRUJILLO       298 GREEN VALLEY ROAD      CHARLOTTE       NC
3432742510 KIMBERLY J BLUME     444 BARNABY AVENUE         DETROIT         MI
5611032521 LUCY P LOCKETT       822 GREEN VALLEY STREET    SANTA FE        NM
7652057522 HOWARD F GLASSMAN    417 WESTRIDGE AVENUE       SALINA          KS
1847006523 ROY J PARKER         869 LINCOLN STREET         ALBANY          NY
6041532524 CAITLIN N NEWBURY    2389 SEAVIEW COURT         BATON ROUGE     LA
3036844525 PETER L LABROIE      943 PECAN VALLEY ROAD      DETROIT         MI
/*                                                                      00500000
//SYSUDUMP DD  SYSOUT=A                                                 00510000
//ESDSF01  DD  DSN=VSTESTES.CLUSTER,DISP=OLD                            00520000
//                                                                      00530000
