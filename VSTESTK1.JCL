//VSTESTK1 JOB 'JAY MOSELEY',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=A,         00010000
//             REGION=4096K                                             00020000
//*                                                                     00030000
//********************************************************************* 00040000
//*                            VSAM DATASET: VSTESTKS.CLUSTER (KSDS)    00050000
//*                                                                     00060000
//* DELETE AND THE DEFINE KSDS CLUSTER FOR TESTING                      00070000
//********************************************************************* 00080000
//*                                                                     00090000
//IDCAMS  EXEC PGM=IDCAMS,REGION=4096K                                  00100000
//SYSPRINT DD  SYSOUT=A                                                 00110000
//SYSIN    DD  *                                                        00120000
                                                                        00130000
  /* DELETE KSDS CLUSTER                                    */          00140000
                                                                        00150000
  DELETE VSTESTKS.CLUSTER CLUSTER PURGE                                 00160000
                                                                        00170000
  /* DEFINE KSDS CLUSTER                                    */          00180000
                                                                        00190000
  DEFINE CLUSTER (                                      -               00200000
         NAME ( VSTESTKS.CLUSTER                      ) -               00210000
         VOLUMES ( MVS804 )                             -               00220000
         RECORDSIZE ( 80 80   )                         -               00230000
         RECORDS( 50       )                            -               00240000
         KEYS ( 10 0 )                                  -               00250000
         INDEXED                                        -               00260000
                  )                                     -               00270000
         DATA (                                         -               00280000
         NAME ( VSTESTKS.DATA                         ) -               00290000
              )                                         -               00300000
         INDEX (                                        -               00310000
         NAME ( VSTESTKS.INDEX                        ) -               00320000
               )                                                        00330000
/*                                                                      00340000
//                                                                      00350000
