/*------------------------------------------------------------*/
/* @@LIBRARY: GITTEST123                                      */
/* @@FILE: QCMDSRC                                            */
/* @@MEMBER: MNDIRLIST                                        */
/* @@TYPE: CMD                                                */
/* @@TEXT: List IFS Directory Files                           */
/*------------------------------------------------------------*/
             CMD        PROMPT('List IFS Directory Files')
             PARM       KWD(IFSDIR) TYPE(*CHAR) LEN(255) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('IFS directory +
                          to list')
             PARM       KWD(FILEFILTER) TYPE(*CHAR) LEN(100) +
                          RSTD(*NO) DFT('*.*') MAX(1) CASE(*MIXED) +
                          PROMPT('File filter')
             PARM       KWD(INCLSUBDIR) TYPE(*CHAR) LEN(5) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          SPCVAL((*NO 'false') (*YES 'true')) +
                          MAX(1) CASE(*MIXED) PROMPT('Include +
                          subdirectories')
             PARM       KWD(OUTPUTFILE) TYPE(*CHAR) LEN(255) +
                          RSTD(*NO) MAX(1) CASE(*MIXED) +
                          PROMPT('Directory list output file')
             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(5) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) SPCVAL((*NO +
                          'false') (*YES 'true')) MAX(1) +
                          CASE(*MIXED) PROMPT('Replace output file')
             PARM       KWD(THROTTLEMS) TYPE(*CHAR) LEN(5) RSTD(*NO) +
                          DFT('0') MAX(1) CASE(*MIXED) +
                          PROMPT('Sleep throttle in milliseconds')
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('File to receive stdout output')
             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
                          DFT('/opt/mono/bin') +
                          SPCVAL(('/QOpenSys/pkgs/bin' +
                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
                          '/opt/mono/bin')) CASE(*MIXED) +
                          PROMPT('Mono bin path')
             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
                          standard output result')
             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Log +
                          standard output to job log')
             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
                          standard output result')
             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
                          standard output result')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(MONOSTDOUT) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
