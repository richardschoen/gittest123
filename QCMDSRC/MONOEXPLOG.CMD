000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCMDSRC                                            */
000400000000/* @@MEMBER: MONOEXPLOG                                       */
000500000000/* @@TYPE: CMD                                                */
000600000000/* @@TEXT: Export Mono Qtemp Log to IFS in PC Format          */
000700000000/*------------------------------------------------------------*/
000800000000             CMD        PROMPT('Export Mono Stdout Log to IFS')
000900000000             PARM       KWD(TOFILE) TYPE(*CHAR) LEN(255) +
001000000000                          DFT('/tmp/mono/stdoutexport.txt') +
001100000000                          CASE(*MIXED) PROMPT('IFS output file')
