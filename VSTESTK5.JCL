//VSTESTK5 JOB 'JAY MOSELEY',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=A,         00010000
//             REGION=4096K                                             00020000
//*                                                                     00030000
//********************************************************************* 00040000
//* COBOL MODULE: KSDSRAND     VSAM DATASET: VSTESTKS.CLUSTER (KSDS)    00050000
//*                                                                     00060000
//* RANDOMLY ACCESS DATASET AND ADD, UPDATE, DELETE RECORDS             00070000
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
//SYSIN    DD  DSN=SYS2.VSAMIO.SOURCE(KSDSRAND),DISP=SHR                00200000
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
//SYSUDUMP DD  SYSOUT=A                                                 00340000
//KSDSF01  DD  DSN=VSTESTKS.CLUSTER,DISP=OLD                            00350000
//SYSIN    DD  *                                                        00360000
A 9532957501 JOHN J GLASSMAN      7663 SEASIDE AVENUE        NEWPORT BEACH   CA
A 1964475502 CAITLIN V BROCKTON   9540 PARKER COURT          KANSAS CITY     MO
A 9441505503 SUE P MOORE          640 JACKSON STREET         LOS ANGELES     CA
A 0045557001 LARRY E BENSON       4778 DESERT STREET         LA HABRA        CA
C 5500563505 CHRISTOPHER P BARBER 1640 GARRETT STREET        FREMONT         CA
C 9966129028 ZELDA H LOCKETT      314 ROSA LINDA COURT       MONTGOMERY      AL
C 9441505503 CLARA B ALEXANDER    8427 PECAN VALLEY STREET   BOISE           ID
D 3849060508 CINDY F EUBANKS      700 WILSHIRE PLACE         DOWNEY          CA
D 3129003066 ROY H TRUJILLO       298 GREEN VALLEY ROAD      CHARLOTTE       NC
/*                                                                      00460000
//                                                                      00470000
