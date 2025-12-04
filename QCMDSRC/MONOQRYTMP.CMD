000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCMDSRC                                            */
000400000000/* @@MEMBER: MONOQRYTMP                                       */
000500000000/* @@TYPE: CMD                                                */
000600000000/* @@TEXT: SQL Query Data to Selected Temp Table with RUNSQL  */
000700000000/*------------------------------------------------------------*/
000800000000             CMD        PROMPT('SQL Query Data to Temp Table')
000900000000             PARM       KWD(SQL) TYPE(*CHAR) LEN(5000) MIN(1) +
001000000000                          EXPR(*YES) CASE(*MIXED) PROMPT('SQL query')
001100000000             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
001200000000                          PROMPT('Temp file to receive results')
001300000000             PARM       KWD(EMPTYERROR) TYPE(*CHAR) LEN(4) +
001400000000                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
001500000000                          MIN(0) MAX(1) PROMPT('Escape error if no +
001600000000                          result data')
001700000000 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(SQLTMP0001) EXPR(*YES)
001800000000             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
001900000000                          PROMPT('Library')
