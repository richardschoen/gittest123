000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCLSRC                                             */
000400000000/* @@MEMBER: MNDIRLISTC                                       */
000500000000/* @@TYPE: CLLE                                               */
000600000000/* @@TEXT: List IFS DIrectory Files                           */
000700000000/*------------------------------------------------------------*/
000800000000             PGM        PARM(&IFSDIR &FILEFILTER &INCLSUBDIR +
000900000000                          &OUTPUTFILE &REPLACE &THROTTLEMS &OUTFILE +
001000000000                          &MONOPATH &DSPSTDOUT &LOGSTDOUT +
001100000000                          &PRTSTDOUT &DLTSTDOUT)
001200000000
001300000000             DCL        VAR(&IFSDIR) TYPE(*CHAR) LEN(255)
001400000000             DCL        VAR(&FILEFILTER) TYPE(*CHAR) LEN(100)
001500000000             DCL        VAR(&INCLSUBDIR) TYPE(*CHAR) LEN(5)
001600000000             DCL        VAR(&OUTPUTFILE) TYPE(*CHAR) LEN(255)
001700000000             DCL        VAR(&REPLACE) TYPE(*CHAR) LEN(5)
001800000000             DCL        VAR(&THROTTLEMS) TYPE(*CHAR) LEN(5)
001900000000             DCL        VAR(&MONOPATH) TYPE(*CHAR) LEN(255)
002000000000             DCL        VAR(&OUTFILE) TYPE(*CHAR) LEN(20)
002100000000             DCL        VAR(&OFILE) TYPE(*CHAR) LEN(10)
002200000000             DCL        VAR(&OLIB) TYPE(*CHAR) LEN(10)
002300000000             DCL        VAR(&WORKDIR) TYPE(*CHAR) LEN(255)
002400000000             DCL        VAR(&EXEFILE) TYPE(*CHAR) LEN(255)
002500000000             DCL        VAR(&EXEFULL) TYPE(*CHAR) LEN(255)
002600000000             DCL        VAR(&DSPSTDOUT) TYPE(*CHAR) LEN(4)
002700000000             DCL        VAR(&LOGSTDOUT) TYPE(*CHAR) LEN(4)
002800000000             DCL        VAR(&PRTSTDOUT) TYPE(*CHAR) LEN(4)
002900000000             DCL        VAR(&DLTSTDOUT) TYPE(*CHAR) LEN(4)
003000000000             DCL        VAR(&DSPSTDOUT) TYPE(*CHAR) LEN(4)
003100000000             DCL        VAR(&DLTSTDOUT) TYPE(*CHAR) LEN(4)
003200000000             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))
003300000000
003400000000/**---------------------------------------------------------------------------*/
003500000000/* Parse outfile parm   */
003600000000/*----------------------------------------------------------------------------*/
003700000000             CHGVAR     VAR(&OLIB) VALUE(%SST(&OUTFILE 11 10))
003800000000             CHGVAR     VAR(&OFILE) VALUE(%SST(&OUTFILE 1 10))
003900000000
004000000000/*----------------------------------------------------------------------------*/
004100000000/* Set work directory and program name to call */
004200000000/*----------------------------------------------------------------------------*/
004300000000             CHGVAR     VAR(&WORKDIR) +
004400000000                          VALUE('/MonoOniSamples/MonoDirList/MonoDirL+
004500000000                          ist/bin/Debug')
004600000000             CHGVAR     VAR(&EXEFILE) VALUE('MonoDirList.exe')
004700000000
004800000000/*----------------------------------------------------------------------------*/
004900000000/* Delete temp list PF                           */
005000000000/*----------------------------------------------------------------------------*/
005100000000             DLTF       FILE(MONOTEMP/MONODIRLST)
005200000000             MONMSG     MSGID(CPF0000)
005300000000
005400000000/*----------------------------------------------------------------------------*/
005500000000/* Call .Net program to perform document checkin */
005600000000/*----------------------------------------------------------------------------*/
005700000000             MONO       WORKDIR(&WORKDIR) EXEFILE(&EXEFILE) +
005800000000                          ARGS(&IFSDIR &FILEFILTER &INCLSUBDIR +
005900000000                          &OUTPUTFILE &REPLACE &THROTTLEMS) +
006000000000                          OUTFILE(&OLIB/&OFILE) MONOPATH(&MONOPATH) +
006100000000                          DSPSTDOUT(&DSPSTDOUT) +
006200000000                          LOGSTDOUT(&LOGSTDOUT) +
006300000000                          PRTSTDOUT(&PRTSTDOUT) DLTSTDOUT(&DLTSTDOUT)
006400000000
006500000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
006600000000                          MSGDTA('Directory list ran successfully +
006700000000                          to output file MONOTEMP/MONODIRLST') +
006800000000                          MSGTYPE(*COMP)
006900000000
007000000000             RETURN
007100000000
007200000000/*----------------------------------------------------------------------------*/
007300000000/* HANDLE ERRORS     */
007400000000/*----------------------------------------------------------------------------*/
007500000000ERRORS:
007600000000
007700000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Error +
007800000000                          occurred during directory list process. +
007900000000                          Please check the joblog') MSGTYPE(*ESCAPE)
008000000000
008100000000             ENDPGM
