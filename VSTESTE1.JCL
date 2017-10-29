//VSTESTE1 JOB 'JAY MOSELEY',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=A,         00010000
//             REGION=4096K                                             00020000
//*                                                                     00030000
//********************************************************************* 00040000
//*                            VSAM DATASET: VSTESTES.CLUSTER (ESDS)    00050000
//*                                                                     00060000
//* DELETE AND THE DEFINE ESDS CLUSTER FOR TESTING                      00070000
//********************************************************************* 00080000
//*                                                                     00090000
//IDCAMS  EXEC PGM=IDCAMS,REGION=4096K                                  00100000
//SYSPRINT DD  SYSOUT=A                                                 00110000
//SYSIN    DD  *                                                        00120000
                                                                        00130000
  /* DELETE ESDS CLUSTER                                    */          00140000
                                                                        00150000
  DELETE VSTESTES.CLUSTER CLUSTER PURGE                                 00160000
                                                                        00170000
  /* DEFINE ESDS CLUSTER                                    */          00180000
                                                                        00190000
  DEFINE CLUSTER (                                      -               00200000
         NAME ( VSTESTES.CLUSTER                      ) -               00210000
         VOLUMES ( MVS804 )                             -               00220000
         RECORDSIZE ( 80 80   )                         -               00230000
         RECORDS( 50       )                            -               00240000
         NONINDEXED                                     -               00250000
                  )                                     -               00260000
         DATA (                                         -               00270000
         NAME ( VSTESTES.DATA                         ) -               00280000
               )                                                        00290000
/*                                                                      00300000
//                                                                      00310000
