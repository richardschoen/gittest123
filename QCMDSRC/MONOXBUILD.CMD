000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCMDSRC                                            */
000400000000/* @@MEMBER: MONOXBUILD                                       */
000500000000/* @@TYPE: CMD                                                */
000600000000/* @@TEXT: Build .Net Solution (.SLN)                         */
000700000000/*------------------------------------------------------------*/
000800000000             CMD        PROMPT('Build .Net Solution (.SLN)')
000900000000             PARM       KWD(WORKDIR) TYPE(*CHAR) LEN(255) MIN(1) +
001000000000                          CASE(*MIXED) PROMPT('Program solution +
001100000000                          (SLN) dir')
001200000000             PARM       KWD(XBUILDCMD) TYPE(*CHAR) LEN(1024) +
001300000000                          DFT('xbuild /p:CscToolExe=mcs') +
001400000000                          CASE(*MIXED) PROMPT('xbuild command line')
001500000000             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
001600000000                          PROMPT('File to receive stdout output')
001700000000             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
001800000000                          DFT(*DEFAULT) +
001900000000                          SPCVAL(('/QOpenSys/pkgs/bin' +
002000000000                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
002100000000                          '/opt/mono/bin')) CASE(*MIXED) +
002200000000                          PROMPT('Mono bin path')
002300000000             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
002400000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
002500000000                          standard output result')
002600000000             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
002700000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Log +
002800000000                          standard output to job log')
002900000000             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
003000000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
003100000000                          standard output result')
003200000000             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
003300000000                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
003400000000                          standard output result')
003500000000 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(MONOSTDOUT) EXPR(*YES)
003600000000             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
003700000000                          PROMPT('Library')
