000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCMDSRC                                            */
000400000000/* @@MEMBER: MNDIRLIST                                        */
000500000000/* @@TYPE: CMD                                                */
000600000000/* @@TEXT: List IFS Directory Files                           */
000700000000/*------------------------------------------------------------*/
000800000000             CMD        PROMPT('List IFS Directory Files')
000900000000             PARM       KWD(IFSDIR) TYPE(*CHAR) LEN(255) RSTD(*NO) +
001000000000                          MAX(1) CASE(*MIXED) PROMPT('IFS directory +
001100000000                          to list')
001200000000             PARM       KWD(FILEFILTER) TYPE(*CHAR) LEN(100) +
001300000000                          RSTD(*NO) DFT('*.*') MAX(1) CASE(*MIXED) +
001400000000                          PROMPT('File filter')
001500000000             PARM       KWD(INCLSUBDIR) TYPE(*CHAR) LEN(5) +
001600000000                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
001700000000                          SPCVAL((*NO 'false') (*YES 'true')) +
001800000000                          MAX(1) CASE(*MIXED) PROMPT('Include +
001900000000                          subdirectories')
002000000000             PARM       KWD(OUTPUTFILE) TYPE(*CHAR) LEN(255) +
002100000000                          RSTD(*NO) MAX(1) CASE(*MIXED) +
002200000000                          PROMPT('Directory list output file')
002300000000             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(5) RSTD(*YES) +
002400000000                          DFT(*YES) VALUES(*NO *YES) SPCVAL((*NO +
002500000000                          'false') (*YES 'true')) MAX(1) +
002600000000                          CASE(*MIXED) PROMPT('Replace output file')
002700000000             PARM       KWD(THROTTLEMS) TYPE(*CHAR) LEN(5) RSTD(*NO) +
002800000000                          DFT('0') MAX(1) CASE(*MIXED) +
002900000000                          PROMPT('Sleep throttle in milliseconds')
003000000000             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
003100000000                          PROMPT('File to receive stdout output')
003200000000             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
003300000000                          DFT('/opt/mono/bin') +
003400000000                          SPCVAL(('/QOpenSys/pkgs/bin' +
003500000000                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
003600000000                          '/opt/mono/bin')) CASE(*MIXED) +
003700000000                          PROMPT('Mono bin path')
003800000000             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
003900000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
004000000000                          standard output result')
004100000000             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
004200000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Log +
004300000000                          standard output to job log')
004400000000             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
004500000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
004600000000                          standard output result')
004700000000             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
004800000000                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
004900000000                          standard output result')
005000000000 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(MONOSTDOUT) EXPR(*YES)
005100000000             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
005200000000                          PROMPT('Library')
