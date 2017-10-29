# vsamcobol is a repository of an assembler module and installation and resting jobs to allow MVT Cobol in MVS 3.8 with TK4 to work with VSAM

All programs and data are by Jay Moseley and not by moshix!!!
refer to:  http://www.jaymoseley.com/hercules/vsam_io/vscobol.htm

Installing the Routine
----------------------

Either clone this repository, or download and uncompress this archive with the command:

tar xvzf vsioinst.tgz 

(on Linux) or use WinZip or ZipNAll on Windows.

The VSIOINST.JCL jobstream consists of three steps - 

the first step uses IDCAMS to delete the two target Partitioned Datasets which will be created during the final two steps

the second step uses IEBUPDTE to place the Assembler source for VSAMIO, the COBOL copy books for the command and dataset parameter interface blocks, and the COBOL source for the test/demonstration programs into a source Partitioned Dataset

the third step uses the Assembler to assemble VSAMIO into an object Partitioned Dataset, from which it can then be link-edited with any COBOL programs from which it is called.

The names of the two Partitioned Datasets which will be created and catalogued are currently set in the jobstream as:

SYS2.VSAMIO.SOURCE
SYS2.VSAMIO.OBJECT

You may change these names as you prefer.  You most definitely will need to change the VOL=SER and probably the UNIT= for the two datasets.  They are currently set to UNIT=3380 and VOL=SER=MVS801. for TK$ change to volume PUB001 and unit 3375

Submit the jobstream to MVS.  You should expect a non-zero return code from the first step, since the datasets being deleted should not exist on your system.  You must receive zero return codes from the second and third steps.  If you do, installation is complete.

If you want to take a look at the assembled VSIOF001 from my system, here is a link to it:  VSAMIO Assembly.

VSAMIO is not reentrant.  Since the MVT COBOL compiler cannot compile dynamic calls, the routine must be statically linked into every load module.  Therefore, I did not make the effort to make it reentrant.

Executing the Test/Example Programs

I have attempted to test the functions in the routine using all possible combinations of organization, access method, and access mode with a series of COBOL programs.  The test programs are very simple, using only DISPLAY statements to convey information about the program execution, as I was mostly interested in the functionality of the Assembler routine.  Along with the creation of version two, I added a couple of more complex COBOL programs, the first to load a variable length indexed dataset and the second which processes four indexed datasets simultaneously.

During the installation process described above, the source for these COBOL programs are added into the source Partitioned Dataset.  You may use them as examples to see how to set up the parameter block for the various combinations of organization, access, and open mode.

If you want to execute the suite of test programs I used, refer to the remaining jobs in this repository. 

Here is a cross-reference of the jobstreams contained in that archive, the COBOL test program they use, and function of the jobstream and/or program:


Jobstream       COBOL PROGRAM  FUNCTION
---------       -------------- ----------



VSTEST01.JCL    n/a             Creates a sequential dataset of 100 instream card images used in subsequent jobstreams.  DSN=SYS2.VSAMTEST.DATA, UNIT=3350, VOL=SER=PUB001

VSTESTE1.JCL    n/a           Uses IDCAMS to delete and then define an empty Entry Sequenced cluster.  DSN=VSTESTES.CLUSTER, VOL=SER=MVS803, suballocated out of existing space

VSTESTE2.JCL    ESDSLOAD       Reads images from non-VSAM dataset and writes them into VSAM Entry Sequenced cluster.

VSTESTE3.JCL    ESDSREAD    Reads images from VSAM Entry Sequenced cluster and displays them on SYSOUT.

VSTESTE4.JCL    ESDSUPDT    Reads images sequentially from VSAM Entry Sequenced cluster and selectively updates records.

VSTESTE5.JCL    ESDSADDT    Reads images from SYSIN and appends to VSAM Entry Sequenced cluster.

VSTESTR1.JCL    n/a        Uses IDCAMS to delete and then define an empty Numbered cluster.  DSN=VSTESTRR.CLUSTER, VOL=SER=MVS803, suballocated out of existing space

VSTESTR2.JCL    RRDSLODS    Reads images from non-VSAM dataset and writes them into VSAM Numbered cluster, generating sequential relative record numbers ranging from 1 through 100.

VSTESTR3.JCL    RRDSREAD    Reads images from VSAM Numbered cluster and displays them on SYSOUT.

VSTESTR4.JCL    RRDSLODR    Reads images from non-VSAM dataset and writes them into VSAM Numbered cluster, deriving relative record number from portion of data record, leaving embedded empty record slots.  (Note, you will need to rerun VSTESTR1.JCL prior to this job if you have already run VSTESTR2.JCL.)

VSTESTR5.JCL    RRDSUPDT    Reads images sequentially from VSAM Numbered cluster and selectively updates and deletes records.

VSTESTR6.JCL    RRDSRAND    Randomly updates VSAM Numbered cluster - adds, updates, and deletes images, using data from SYSIN.

VSTESTR7.JCL    RRDSSSEQ    Issues START against VSAM Numbered cluster, using both Key Equal and Key Greater Than or Equal options, then reads sequentially forward from started position.

VSTESTK1.JCL    n/a Uses IDCAMS to delete and then define an empty Indexed cluster.  DSN=VSTESTKS.CLUSTER, VOL=SER=MVS803, suballocated out of existing space

VSTESTK2.JCL    KSDSLOAD    Reads images from non-VSAM dataset and writes them into VSAM Indexed cluster.

VSTESTK3.JCL    KSDSREAD    Reads images from VSAM Indexed cluster and displays them on SYSOUT.

VSTESTK4.JCL    KSDSUPDT    Reads images sequentially from VSAM Indexed cluster and selectively updates and deletes records.

VSTESTK5.JCL    KSDSRAND    Randomly updates VSAM Indexed cluster - adds, updates, and deletes images, using data from SYSIN.

VSTESTK6.JCL    KSDSSSEQ    Issues START against VSAM Indexed cluster, using both Key Equal and Key Greater Than or Equal options, then reads sequentially forward from started position.

LISTCATE.JCL    n/a Uses IDCAMS to list catalog entry for Entry Sequenced cluster: VSTESTES.CLUSTER.

LISTCATR.JCL    n/a Uses IDCAMS to list catalog entry for Numbered cluster: VSTESTRR.CLUSTER.

LISTCATK.JCL    n/a Uses IDCAMS to list catalog entry for Indexed cluster: VSTESTKS.CLUSTER.

PRINTE.JCL  n/a Uses IDCAMS to print contents for Entry Sequenced cluster:  VSTESTES.CLUSTER.

PRINTR.JCL  n/a Uses IDCAMS to print contents for Numbered cluster:  VSTESTRR.CLUSTER.

PRINTK.JCL  n/a Uses IDCAMS to print contents for Indexed cluster:  VSTESTKS.CLUSTER.

VSTEST02.JCL    KSDSLVAR    Reads card images from SYSIN and loads a variable length, indexed cluster: VSTESTK1.CLUSTER.  This dataset is required by KSDSMULT described below.

VSTEST03.JCL    KSDSMULT    Sequentially reads a variable length, indexed cluster - VSTESTK1.CLUSTER - and randomly reads corresponding records from three fixed length indexed clusters - VSTESTK2.CLUSTER, VSTESTK3.CLUSTER, VSTESTK4.CLUSTER - to produce a report.

VSTEST99.JCL    n/a Uses IDCAMS to delete all test datasets (Non-VSAM and VSAM) created in this test suite.




All programs and data are by Jay Moseley and not by moshix!!! 
refer to:  http://www.jaymoseley.com/hercules/vsam_io/vscobol.htm
