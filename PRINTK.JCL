//PRINTK   JOB 'JAY MOSELEY',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=A          00010000
//*                                                                     00020000
//********************************************************************* 00030000
//* PRINT CONTENTS OF CLUSTER VSTESTKS.CLUSTER                        * 00040000
//********************************************************************* 00050000
//*                                                                     00060000
//IDCAMS   EXEC PGM=IDCAMS,REGION=4096K                                 00070000
//DD1      DD  DSN=VSTESTKS.CLUSTER,DISP=SHR                            00080000
//SYSPRINT DD  SYSOUT=A                                                 00090000
//SYSIN    DD  *                                                        00100000
  PRINT INFILE(DD1) DUMP                                                00110000
/*                                                                      00120000
//                                                                      00130000
