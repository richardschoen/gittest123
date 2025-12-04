000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCLSRC                                             */
000400000000/* @@MEMBER: A#                                               */
000500000000/* @@TYPE: CMD                                                */
000600000000/* @@TEXT: End NGINX Web Server                               */
000700000000/*------------------------------------------------------------*/
000800000000A#           CMD        PROMPT('End NGINX Web Server')
000900000000             PARM       KWD(NGINXBIN) TYPE(*CHAR) LEN(255) +
001000000000                          DFT('/QopenSys/pkgs/bin/nginx') +
001100000000                          CASE(*MIXED) PROMPT('NGINX runtime binary')
001200000000             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
001300000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
001400000000                          standard output result')
001500000000             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
001600000000                          DFT(*YES) VALUES(*NO *YES) PROMPT('Log +
001700000000                          standard output to job log')
001800000000             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
001900000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
002000000000                          standard output result')
002100000000             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
002200000000                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
002300000000                          standard output result')
002400000000 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(MONOSTDOUT) EXPR(*YES)
002500000000             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
002600000000                          PROMPT('Library')
