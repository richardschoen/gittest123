000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCMDSRC                                            */
000400000000/* @@MEMBER: MONO2                                            */
000500000000/* @@TYPE: CMD                                                */
000600000000/* @@TEXT: Run .Net Console App via Mono - Single Cmd Line    */
000700000000/*------------------------------------------------------------*/
000800000000             CMD        PROMPT('Run .Net Console Application')
000900000000             PARM       KWD(WORKDIR) TYPE(*CHAR) LEN(255) MIN(1) +
001000000000                          CASE(*MIXED) PROMPT('Program exe directory')
001100000000             PARM       KWD(EXEFILE) TYPE(*CHAR) LEN(255) MIN(1) +
001200000000                          CASE(*MIXED) PROMPT('Program exe +
001300000000                          file name')
001400000000             PARM       KWD(ARGS) TYPE(*CHAR) LEN(1024) RSTD(*NO) +
001500000000                          EXPR(*YES) CASE(*MIXED) PROMPT('Program +
001600000000                          command line arguments')
001700000000             PARM       KWD(MONOOPTPRE) TYPE(*CHAR) LEN(200) +
001800000000                          RSTD(*NO) MAX(1) CASE(*MIXED) +
001900000000                          PROMPT('Command options before mono')
002000000000             PARM       KWD(MONOOPT) TYPE(*CHAR) LEN(200) RSTD(*NO) +
002100000000                          DFT('-O=-all') MAX(1) CASE(*MIXED) +
002200000000                          PROMPT('Command options after mono')
002300000000             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
002400000000                          PROMPT('File to receive stdout output')
002500000000             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
002600000000                          DFT(*DEFAULT) +
002700000000                          SPCVAL(('/QOpenSys/pkgs/bin' +
002800000000                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
002900000000                          '/opt/mono/bin') (*DEFAULT *DEFAULT)) +
003000000000                          CASE(*MIXED) PROMPT('Mono path')
003100000000             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
003200000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
003300000000                          standard output result')
003400000000             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
003500000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Log +
003600000000                          standard output to job log')
003700000000             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
003800000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
003900000000                          standard output result')
004000000000             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
004100000000                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
004200000000                          standard output result')
004300000000 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(MONOSTDOUT) EXPR(*YES)
004400000000             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
004500000000                          PROMPT('Library')
