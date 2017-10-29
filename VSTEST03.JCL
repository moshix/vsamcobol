//VSTEST03 JOB 'JAY MOSELEY',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=A,         00010000
//             REGION=4096K                                             00020000
//*                                                                     00030000
//********************************************************************* 00040000
//* COBOL MODULE: KSDSMULT     VSAM DATASET: VSTESTK1.CLUSTER (KSDS)    00050000
//*                                          VSTESTK2.CLUSTER (KSDS)    00060000
//*                                          VSTESTK3.CLUSTER (KSDS)    00070000
//*                                          VSTESTK4.CLUSTER (KSDS)    00080000
//*                                                                     00090000
//* ACCESSES 4 KSDS DATASETS SIMULTANEOUSLY                             00100000
//********************************************************************* 00110000
//*                                                                     00120000
//IDCAMS1 EXEC PGM=IDCAMS,REGION=4096K                                  00130000
//SYSPRINT DD  SYSOUT=A                                                 00140000
//SYSIN    DD  *                                                        00150000
                                                                        00160000
  /* DELETE EXISTING DEPARTMENT TABLE CLUSTER, COURSE TABLE             00170000
     CLUSTER, AND SECTION TABLE CLUSTER                      */         00180000
                                                                        00180000
  DELETE VSTESTK2.CLUSTER CLUSTER PURGE                                 00190000
                                                                        00190010
  DELETE VSTESTK3.CLUSTER CLUSTER PURGE                                 00190020
                                                                        00190030
  DELETE VSTESTK4.CLUSTER CLUSTER PURGE                                 00190040
                                                                        00200000
  /* IF NO CLUSTERS EXISTED TO DELETE, RESET CC             */          00210000
                                                                        00210010
  IF MAXCC = 8 THEN                                                     00210020
      DO                                                                00210030
          SET LASTCC = 0                                                00210040
          SET MAXCC = 0                                                 00210050
      END                                                               00210060
                                                                        00210070
  /* DEFINE KSDS CLUSTER FOR DEPARTMENT TABLE               */          00210080
                                                                        00220000
  DEFINE CLUSTER (                                      -               00230000
         NAME ( VSTESTK2.CLUSTER                      ) -               00240000
         VOLUMES ( MVS804 )                             -               00250000
         RECORDSIZE ( 32 32   )                         -               00260000
         RECORDS( 20 10    )                            -               00270000
         KEYS (  2 0 )                                  -               00280000
         INDEXED                                        -               00290000
                  )                                     -               00300000
         DATA (                                         -               00310000
         NAME ( VSTESTK2.DATA                         ) -               00320000
              )                                         -               00330000
         INDEX (                                        -               00340000
         NAME ( VSTESTK2.INDEX                        ) -               00350000
               )                                                        00360000
                                                                        00410000
  /* DEFINE KSDS CLUSTER FOR COURSE TABLE                   */          00420000
                                                                        00430000
  DEFINE CLUSTER (                                      -               00440000
         NAME ( VSTESTK3.CLUSTER                      ) -               00450000
         VOLUMES ( MVS804 )                             -               00460000
         RECORDSIZE ( 56 56   )                         -               00470000
         RECORDS( 120 10   )                            -               00480000
         KEYS (  5 0 )                                  -               00490000
         INDEXED                                        -               00500000
                  )                                     -               00510000
         DATA (                                         -               00520000
         NAME ( VSTESTK3.DATA                         ) -               00530000
              )                                         -               00540000
         INDEX (                                        -               00550000
         NAME ( VSTESTK3.INDEX                        ) -               00560000
               )                                                        00570000
                                                                        00620000
  /* DEFINE KSDS CLUSTER FOR SECTION TABLE                  */          00630000
                                                                        00640000
  DEFINE CLUSTER (                                      -               00650000
         NAME ( VSTESTK4.CLUSTER                      ) -               00660000
         VOLUMES ( MVS804 )                             -               00670000
         RECORDSIZE ( 17 17   )                         -               00680000
         RECORDS( 230 10   )                            -               00690000
         KEYS (  6 0 )                                  -               00700000
         INDEXED                                        -               00710000
                  )                                     -               00720000
         DATA (                                         -               00730000
         NAME ( VSTESTK4.DATA                         ) -               00740000
              )                                         -               00750000
         INDEX (                                        -               00760000
         NAME ( VSTESTK4.INDEX                        ) -               00770000
               )                                                        00780000
/*                                                                      00790000
//*                                                                     00800000
//********************************************************************* 00810000
//* PREPARE DEPARTMENT TABLE DATA FOR LOADING INTO KSDS DATASET         00820000
//********************************************************************* 00830000
//*                                                                     00840000
//IEBDG1  EXEC PGM=IEBDG,REGION=512K                                    00850000
//SYSPRINT DD  DUMMY                                                    00860000
//SYSIN    DD  *                                                        00870000
  DSD OUTPUT=(DEPTWRK),INPUT=(DEPTSEQ)                                  00880000
  FD NAME=FLD1,LENGTH=32,STARTLOC=1,FROMLOC=1,INPUT=DEPTSEQ             00890000
  CREATE NAME=(FLD1),INPUT=DEPTSEQ                                      00900000
  END                                                                   00910000
/*                                                                      00920000
//DEPTSEQ  DD  *                                                        00930000
01ART
02BUSINESS
03BIOLOGY
04CHEMESTRY
05ECONOMICS
06ACCOUNTING
07FINANCE
08EDUCATION
09ENGLISH
10PHYSICAL EDUCATION
11HISTORY
12MATHEMATICS
13COMPUTER SCIENCE
14PHYSICS
/*                                                                      00950000
//DEPTWRK  DD  UNIT=SYSDA,DISP=(,PASS),SPACE=(TRK,(10,10)),             00960000
//             DCB=(RECFM=FB,LRECL=32,BLKSIZE=320)                      00970000
//*                                                                     00980000
//********************************************************************* 00990000
//* PREPARE COURSE TABLE DATA FOR LOADING INTO KSDS DATASET             01000000
//********************************************************************* 01010000
//*                                                                     01020000
//IEBDG2  EXEC PGM=IEBDG,REGION=512K                                    01030000
//SYSPRINT DD  DUMMY                                                    01040000
//SYSIN    DD  *                                                        01050000
  DSD OUTPUT=(CRSEWRK),INPUT=(CRSESEQ)                                  01060000
  FD NAME=FLD1,LENGTH=56,STARTLOC=1,FROMLOC=1,INPUT=CRSESEQ             01070000
  CREATE NAME=(FLD1),INPUT=CRSESEQ                                      01080000
  END                                                                   01090000
/*                                                                      01100000
//CRSESEQ  DD  *                                                        01110000
01100ART APPRECIATION                                  3
01150SCULPTURE I                                       3
01201INTRODUCTION TO THE HISTORY OF WESTERN ART I      3
01202INTRODUCTION TO THE HISTORY OF WESTERN ART II     3
01284INTERIOR DESIGN: COLOR AND LIGHT                  3
01285HISTORY OF ARCHITECTURE AND INTERIOR DESIGN       3
01302MEDIEVAL ART                                      3
01307ART HISTORY TRAVEL                                6
01370PAINTING III                                      3
01450SCULPTURE IV                                      3
02200INTRODUCTION TO BUSINESS                          3
02210BUSINESS COMMUNICATION                            3
02231MANAGEMENT                                        3
02241INTRODUCTION TO MARKETING                         3
02242CONSUMER BEHAVIOR                                 3
02341INTERNATIONAL BUSINESS                            3
02342MARKETING RESEARCH                                3
03100GENERAL BIOLOGY                                   4
03200INTRODUCTION TO HUMAN GENETICS                    4
03201CELL BIOLOGY                                      4
03210HUMAN ANATOMY                                     4
03250HORTICULTURAL BOTANY                              4
03260INTRODUCTION TO HUMAN BIOLOGY                     4
03305COMPARATIVE CHORDATE ANATOMY                      4
03312MICROBIOLOGY                                      4
03408MOLECULAR BIOLOGY OF THE CELL                     4
03420HISTOLOGY                                         4
04150CONCEPTS OF CHEMISTRY                             4
04160INTRODUCTION TO GEOLOGY                           4
04201GENERAL COLLEGE CHEMISTRY                         4
04251QUANTITATIVE ANALYSIS                             4
04303ORGANIC CHEMISTRY                                 4
04311ENVIRONMENTAL CHEMISTRY                           4
04315PHYSICAL CHEMISTRY                                4
04402ADVANCED ORGANIC CHEMISTRY                        4
04410INSTRUMENTAL ANALYSIS                             4
04415BIOCHEMISTRY                                      4
05150ECONOMIC CONCEPTS                                 3
05201MICROECONOMICS                                    3
05202MACROECONOMICS                                    3
05394QUANTITATIVE METHODS                              3
06211ACCOUNTING PRINCIPLES I                           3
06212ACCOUNTING PRINCIPLES II                          3
06380ACCOUNTING SYSTEMS                                3
06409TAX ACCOUNTING                                    3
06451COST ACCOUNTING                                   3
07200PERSONAL FINANCE                                  3
07321MONEY AND FINANCIAL INSTITUTIONS                  3
07324BUSINESS AND THE PUBLIC SECTOR                    3
08301THE TEACHING OF READING                           3
08303MATHEMATICS FOR THE ELEMENTARY CHILD              3
08309LITERATURE FOR THE CHILD                          3
08403METHODS AND MATERIALS FOR THE PRESCHOOL           3
08405PRESCHOOL CURRICULUM                              3
08412STUDENT TEACHING                                  3
09101COMPOSITION                                       3
09102INTRODUCTION TO LITERARY TYPES                    3
09150STUDIES IN FILM                                   3
09201MAJOR BRITISH WRITERS                             3
09203SURVEY OF AMERICAN LITERATURE                     3
09294INTRODUCTION TO JOURNALISM                        3
09304TOPICS IN MEDIEVAL LITERATURE                     3
09315ADOLESCENT LITERATURE                             3
09320SHAKESPEARE                                       3
09392CREATIVE POETRY WRITING                           3
10110BEGINNING DANCE                                   1
10120BEGINNING INDIVIDUAL SPORT                        1
10140SWIMMING                                          1
10150FITNESS                                           1
10180FIRST AID AND PERSONAL SAFETY                     2
10195ATHLETIC TRAINING                                 3
10197CURRENT HEALTH TOPICS                             3
10245LIFEGUARD TRAINING                                1
10393HEALTH AND PHYSICAL EDUCATION FOR TEACHERS        3
11201AMERICAN HISTORY                                  3
11210WOMEN IN AMERICAN HISTORY                         3
11306AFRICAN-AMERICAN HISTORY                          3
11375THE VIETNAM EXPERIENCE                            3
11408THE COLONIAL AND REVOLUTIONARY ERA                3
11421THE ERA OF THE CIVIL WAR                          3
11455AMERICAN FOREIGN POLICY                           3
12100INTRODUCTION TO MODERN MATHEMATICS                3
12105COLLEGE ALGEBRA                                   3
12110ELEMENTARY FUNCTIONS                              3
12115INTRODUCTION TO CALCULUS                          3
12203THEORY OF NUMBERS                                 3
12205DISCRETE MATHEMATICS                              3
12210CALCULUS AND ANALYTICAL GEOMETRY                  3
12323PROBABILITY AND STATISTICS                        3
12330INTRODUCTION TO NUMERICAL ANALYSIS                3
12401MULTIVARIABLE CALCULUS                            3
12410DIFFERENTIAL EQUATIONS                            3
12413ALGEBRAIC STRUCTURES                              3
13101COMPUTER LITERACY                                 3
13201INTRODUCTION TO COMPUTING                         3
13202DATA STRUCTURES                                   3
13290SOFTWARE WORKSHOP                                 1
13305DATABASE DESIGN AND FILE STRUCTURES               3
13309COBOL                                             3
13310COMPUTER ORGANIZATON                              3
13315ASSEMBLER                                         3
13350PRINCIPLES OF PROGRAMMING LANGUAGES               3
13390SOFTWARE WORKSHOP                                 1
13410OPERATING SYSTEMS AND ARCHITECTURE                3
13420SOFTWARE ENGINEERING                              3
13440ALGORITHM ANALYSIS                                3
13490SOFTWARE WORKSHOP                                 1
14140CONCEPTS OF PHYSICS                               4
14143ASTRONOMY                                         4
14241ELEMENTS OF PHYSICS I                             4
14242ELEMENTS OF PHYSICS II                            4
14251ESSENTIALS OF PHYSICS I                           4
14252ESSENTIALS OF PHYSICS II                          4
14431ANALYTICAL MECHANICS                              4
/*                                                                      01130000
//CRSEWRK  DD  UNIT=SYSDA,DISP=(,PASS),SPACE=(TRK,(10,10)),             01140000
//             DCB=(RECFM=FB,LRECL=56,BLKSIZE=5600)                     01150000
//*                                                                     01160000
//********************************************************************* 01170000
//* PREPARE SECTION TABLE DATA FOR LOADING INTO KSDS DATASET            01180000
//********************************************************************* 01190000
//*                                                                     01200000
//IEBDG3  EXEC PGM=IEBDG,REGION=512K                                    01210000
//SYSPRINT DD  DUMMY                                                    01220000
//SYSIN    DD  *                                                        01230000
  DSD OUTPUT=(SECTWRK),INPUT=(SECTSEQ)                                  01240000
  FD NAME=FLD1,LENGTH=17,STARTLOC=1,FROMLOC=1,INPUT=SECTSEQ             01250000
  CREATE NAME=(FLD1),INPUT=SECTSEQ                                      01260000
  END                                                                   01270000
/*                                                                      01280000
//SECTSEQ  DD  *                                                        01290000
011001MWF  8:00AM
011002TTH  8:00AM
011003MWF  9:00AM
011501TTH  9:30AM
012011MWF 10:00AM
012012TTH 11:00AM
012013MWF 11:00AM
012021TTH 12:30PM
012022MWF 12:00PM
012841TTH  2:00PM
012851MWF  1:00PM
013021MWF  2:00PM
013071TBA  0:00
013701MWF  8:00AM
013702TTH  8:00AM
013703MWF  9:00AM
013704TTH  9:30AM
014501MWF 10:00AM
014502TTH 11:00AM
014503MWF 11:00AM
022001MWF  8:00AM
022002TTH  8:00AM
022101MWF  9:00AM
022102TTH  9:30AM
022311MWF 10:00AM
022411MWF 12:00PM
022412TTH  2:00PM
022413MWF  1:00PM
022421TTH 11:00AM
023411MWF 11:00AM
023421TTH 12:30PM
031001MWF  8:00AM
031002TTH  8:00AM
031003MWF  9:00AM
031004TTH  9:30AM
032001MWF 10:00AM
032002TTH 11:00AM
032011MWF 11:00AM
032101TTH 12:30PM
032102MWF 12:00PM
032501TTH  2:00PM
032601MWF  1:00PM
032602MWF  2:00PM
033051MWF  8:00AM
033121TTH  8:00AM
034081MWF  9:00AM
034201TTH  9:30AM
041501MWF  8:00AM
041502TTH  8:00AM
041503MWF  9:00AM
041504TTH  9:30AM
041601MWF 10:00AM
041602TTH 11:00AM
042011MWF 11:00AM
042012TTH 12:30PM
042511MWF 12:00PM
042512TTH  2:00PM
043031MWF  1:00PM
043111MWF  2:00PM
043151MWF  8:00AM
044021TTH  8:00AM
044101MWF  9:00AM
044151TTH  9:30AM
051501MWF  8:00AM
051502TTH  8:00AM
051503MWF  9:00AM
051504TTH  9:30AM
052011MWF 10:00AM
052012TTH 11:00AM
052013MWF 11:00AM
052021TTH 12:30PM
052022MWF 12:00PM
052023TTH  2:00PM
053941MWF  1:00PM
062111MWF  8:00AM
062112TTH  8:00AM
062113MWF  9:00AM
062121TTH  9:30AM
062122MWF 10:00AM
062123TTH 11:00AM
063801MWF 11:00AM
064091TTH 12:30PM
064511MWF 12:00PM
072001MWF  8:00AM
073211TTH  8:00AM
073241MWF  9:00AM
083011MWF  8:00AM
083012TTH  8:00AM
083013MWF  9:00AM
083031TTH  9:30AM
083032MWF 10:00AM
083033TTH 11:00AM
083091MWF 11:00AM
083092TTH 12:30PM
084031MWF 12:00PM
084032TTH  2:00PM
084051MWF  1:00PM
084121MO   8:00AM
084122TU   8:00AM
084123WE   8:00AM
084124TH   8:00AM
084125FR   8:00AM
091011MWF  8:00AM
091012TTH  8:00AM
091021MWF  9:00AM
091022TTH  9:30AM
091023MWF 10:00AM
091501TTH 11:00AM
091502MWF 11:00AM
092011TTH 12:30PM
092031MWF 12:00PM
092032TTH  2:00PM
092033MWF  1:00PM
092941MWF  2:00PM
092942MWF  8:00AM
092943TTH  8:00AM
093041MWF  9:00AM
093151TTH  9:30AM
093201MWF 10:00AM
093202TTH 11:00AM
093921MWF 11:00AM
101101MWF  8:00AM
101102TTH  8:00AM
101103MWF  9:00AM
101104TTH  9:30AM
101105MWF 10:00AM
101201TTH 11:00AM
101202MWF 11:00AM
101203TTH 12:30PM
101204MWF 12:00PM
101205TTH  2:00PM
101401MWF  1:00PM
101402MWF  2:00PM
101403MWF  8:00AM
101404TTH  8:00AM
101501MWF  9:00AM
101502TTH  9:30AM
101503MWF 10:00AM
101504TTH 11:00AM
101505MWF 11:00AM
101801TTH 12:30PM
101802MWF 12:00PM
101803TTH  2:00PM
101951MWF  1:00PM
101952MWF  2:00PM
101971MWF  8:00AM
101972TTH  8:00AM
102451MWF  9:00AM
103931TTH  9:30AM
103932MWF 10:00AM
103933TTH 11:00AM
112011MWF  8:00AM
112012TTH  8:00AM
112013MWF  9:00AM
112014TTH  9:30AM
112101MWF 10:00AM
112102TTH 11:00AM
112103MWF 11:00AM
113061TTH 12:30PM
113062MWF 12:00PM
113751TTH  2:00PM
114081MWF  1:00PM
114211MWF  2:00PM
114551MWF  8:00AM
121001MWF  8:00AM
121002TTH  8:00AM
121003MWF  9:00AM
121051TTH  9:30AM
121052MWF 10:00AM
121053TTH 11:00AM
121054MWF 11:00AM
121101TTH 12:30PM
121102MWF 12:00PM
121151TTH  2:00PM
121152MWF  1:00PM
122031MWF  2:00PM
122032MWF  8:00AM
122051TTH  8:00AM
122101MWF  9:00AM
122102TTH  9:30AM
123231MWF 10:00AM
123232TTH 11:00AM
123301MWF 11:00AM
124011TTH 12:30PM
124101MWF 12:00PM
124131TTH  2:00PM
131011MWF  8:00AM
131012TTH  8:00AM
132011MWF  9:00AM
132012TTH  9:30AM
132013MWF 10:00AM
132021TTH 11:00AM
132901MO   3:00PM
132902TU   3:00PM
132903WE   3:00PM
132904TH   3:00PM
132905FR   3:00PM
133051MWF 11:00AM
133052TTH 12:30PM
133091MWF 12:00PM
133101TTH  2:00PM
133151MWF  1:00PM
133501MWF  2:00PM
133901MO   3:00PM
133902TU   3:00PM
133903WE   3:00PM
133904TH   3:00PM
133905FR   3:00PM
134101MWF  8:00AM
134201TTH  8:00AM
134401MWF  9:00AM
134901MO   3:00PM
134902TU   3:00PM
134903WE   3:00PM
134904TH   3:00PM
134905FR   3:00PM
141401MWF  8:00AM
141402TTH  8:00AM
141403MWF  9:00AM
141431TTH  9:30AM
141432MWF 10:00AM
142411TTH 11:00AM
142412MWF 11:00AM
142421TTH 12:30PM
142511MWF 12:00PM
142512TTH  2:00PM
142521MWF  1:00PM
144311MWF  2:00PM
/*                                                                      01310000
//SECTWRK  DD  UNIT=SYSDA,DISP=(,PASS),SPACE=(TRK,(10,10)),             01320000
//             DCB=(RECFM=FB,LRECL=17,BLKSIZE=340)                      01330000
//*                                                                     01340000
//********************************************************************* 01350000
//* LOAD VSAM TABLE DATASETS                                            01360000
//********************************************************************* 01370000
//*                                                                     01380000
//IDCAMS2 EXEC PGM=IDCAMS,REGION=4096K                                  01390000
//DEPTWRK  DD  DSN=*.IEBDG1.DEPTWRK,DISP=(OLD,DELETE)                   01400000
//CRSEWRK  DD  DSN=*.IEBDG2.CRSEWRK,DISP=(OLD,DELETE)                   01410000
//SECTWRK  DD  DSN=*.IEBDG3.SECTWRK,DISP=(OLD,DELETE)                   01420000
//SYSPRINT DD  SYSOUT=A                                                 01430000
//SYSIN    DD  *                                                        01440000
  REPRO INFILE(DEPTWRK) OUTDATASET(VSTESTK2.CLUSTER)                    01450000
  REPRO INFILE(CRSEWRK) OUTDATASET(VSTESTK3.CLUSTER)                    01460000
  REPRO INFILE(SECTWRK) OUTDATASET(VSTESTK4.CLUSTER)                    01470000
/*                                                                      01480000
//*                                                                     01490000
//********************************************************************* 01500000
//* ACCESS ALL 4 VSAM DATASETS SIMULTANEOUSLY TO PRINT REPORT           01510000
//********************************************************************* 01520000
//*                                                                     01530000
//COB     EXEC PGM=IKFCBL00,REGION=1024K,                               01540000
//             PARM='LOAD,LIST,DMAP,BUF=8192,LIB'                       01550000
//SYSLIB   DD  DSN=SYS2.VSAMIO.SOURCE,DISP=SHR                          01560000
//SYSPRINT DD  SYSOUT=A                                                 01570000
//SYSUT1   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         01580000
//SYSUT2   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         01590000
//SYSUT3   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         01600000
//SYSUT4   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         01610000
//SYSLIN   DD  DISP=(,PASS),UNIT=SYSDA,SPACE=(80,(500,100))             01620000
//SYSIN    DD  DSN=SYS2.VSAMIO.SOURCE(KSDSMULT),DISP=SHR                01630000
//*                                                                     01640000
//LKED    EXEC PGM=IEWL,REGION=1024K,COND=(5,LT),                       01650000
//             PARM='LIST,XREF,LET'                                     01660000
//SYSLIN   DD  DSN=*.COB.SYSLIN,DISP=(OLD,DELETE)                       01670000
//         DD  DSN=SYS2.VSAMIO.OBJECT(VSAMIO),DISP=SHR                  01680000
//SYSLMOD  DD  DSN=&GODATA2(RUN),DISP=(NEW,PASS),UNIT=SYSDA,            01690000
//             SPACE=(1024,(50,20,1))                                   01700000
//SYSLIB   DD  DSN=SYS1.COBLIB,DISP=SHR                                 01710000
//SYSUT1   DD  UNIT=SYSDA,SPACE=(1024,(50,20))                          01720000
//SYSPRINT DD  SYSOUT=A                                                 01730000
//*                                                                     01740000
//GO      EXEC PGM=*.LKED.SYSLMOD,REGION=1024K,COND=(5,LT)              01750000
//SYSOUT   DD  SYSOUT=A                                                 01760000
//SYSUDUMP DD  SYSOUT=A                                                 01770000
//STMASTR  DD  DSN=VSTESTK1.CLUSTER,DISP=SHR                            01780000
//DEPTTBL  DD  DSN=VSTESTK2.CLUSTER,DISP=SHR                            01790000
//CRSETBL  DD  DSN=VSTESTK3.CLUSTER,DISP=SHR                            01800000
//SECTTBL  DD  DSN=VSTESTK4.CLUSTER,DISP=SHR                            01810000
//SYSPRINT DD  SYSOUT=A                                                 01820000
//                                                                      01830000
