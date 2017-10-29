//VSTEST99 JOB 'JAY MOSELEY',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=A          00010000
//*                                                                     00020000
//********************************************************************* 00030000
//* DELETE DATASETS CREATED DURING TEST SUITE                         * 00040000
//********************************************************************* 00050000
//*                                                                     00060000
//IDCAMS  EXEC PGM=IDCAMS,REGION=1024K                                  00070000
//SYSPRINT DD  SYSOUT=A                                                 00080000
//SYSIN    DD  *                                                        00090000
    DELETE SYS2.VSAMTEST.DATA NONVSAM                                   00100000
    DELETE VSTESTES.CLUSTER CLUSTER PURGE                               00110000
    DELETE VSTESTRR.CLUSTER CLUSTER PURGE                               00120000
    DELETE VSTESTKS.CLUSTER CLUSTER PURGE                               00130000
    DELETE VSTESTK1.CLUSTER CLUSTER PURGE                               00140000
    DELETE VSTESTK2.CLUSTER CLUSTER PURGE                               00150000
    DELETE VSTESTK3.CLUSTER CLUSTER PURGE                               00160000
    DELETE VSTESTK4.CLUSTER CLUSTER PURGE                               00170000
/*                                                                      00180000
//                                                                      00190000
