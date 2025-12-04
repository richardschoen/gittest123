000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCMDSRC                                            */
000400000000/* @@MEMBER: MONOPATH                                         */
000500000000/* @@TYPE: CMD                                                */
000600000000/* @@TEXT: Set Path Path For Mono                             */
000700000000/*------------------------------------------------------------*/
000800000000             CMD        PROMPT('Set Pase Path For Mono')
000900000000             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
001000000000                          DFT(*DEFAULT) +
001100000000                          SPCVAL(('/QOpenSys/pkgs/bin' +
001200000000                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
001300000000                          '/opt/mono/bin') (*DEFAULT *DEFAULT)) +
001400000000                          CASE(*MIXED) PROMPT('Mono path')
