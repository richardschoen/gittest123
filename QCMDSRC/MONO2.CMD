/*------------------------------------------------------------*/
/* @@LIBRARY: GITTEST123                                      */
/* @@FILE: QCMDSRC                                            */
/* @@MEMBER: MONO2                                            */
/* @@TYPE: CMD                                                */
/* @@TEXT: Run .Net Console App via Mono - Single Cmd Line    */
/*------------------------------------------------------------*/
             CMD        PROMPT('Run .Net Console Application')
             PARM       KWD(WORKDIR) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('Program exe directory')
             PARM       KWD(EXEFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('Program exe +
                          file name')
             PARM       KWD(ARGS) TYPE(*CHAR) LEN(1024) RSTD(*NO) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Program +
                          command line arguments')
             PARM       KWD(MONOOPTPRE) TYPE(*CHAR) LEN(200) +
                          RSTD(*NO) MAX(1) CASE(*MIXED) +
                          PROMPT('Command options before mono')
             PARM       KWD(MONOOPT) TYPE(*CHAR) LEN(200) RSTD(*NO) +
                          DFT('-O=-all') MAX(1) CASE(*MIXED) +
                          PROMPT('Command options after mono')
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('File to receive stdout output')
             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
                          DFT(*DEFAULT) +
                          SPCVAL(('/QOpenSys/pkgs/bin' +
                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
                          '/opt/mono/bin') (*DEFAULT *DEFAULT)) +
                          CASE(*MIXED) PROMPT('Mono path')
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
