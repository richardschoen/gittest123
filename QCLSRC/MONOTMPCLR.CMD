000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCLSRC                                             */
000400000000/* @@MEMBER: MONOTMPCLR                                       */
000500000000/* @@TYPE: CMD                                                */
000600000000/* @@TEXT: Clear Mono Temp Stdout Log Directory               */
000700000000/*------------------------------------------------------------*/
000800000000             CMD        PROMPT('Clean Mono Temp Stdout Dir')
000900000000             PARM       KWD(MONOTMPDIR) TYPE(*CHAR) LEN(255) +
001000000000                          DFT('/tmp/mono') MIN(0) CASE(*MIXED) +
001100000000                          PROMPT('Mono temp stdout directory')
