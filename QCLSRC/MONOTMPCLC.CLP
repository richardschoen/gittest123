000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCLSRC                                             */
000400000000/* @@MEMBER: MONOTMPCLC                                       */
000500000000/* @@TYPE: CLP                                                */
000600000000/* @@TEXT: Clear Mono Temp Stdout Log Directory               */
000700000000/*------------------------------------------------------------*/
000800000000             PGM        PARM(&MONOTMPDIR)
000900000000
001000000000             DCL        VAR(&MONOTMPDIR) TYPE(*CHAR) LEN(255)
001100000000             DCL        VAR(&MONOWORK) TYPE(*CHAR) LEN(255)
001200000000
001300000000             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))
001400000000
001500000000
001600000000             CHGVAR     VAR(&MONOWORK) VALUE(&MONOTMPDIR |< '/*')
001700000000             ERASE      OBJLNK(&MONOWORK)
001800000000
001900000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Mono +
002000000000                          temp stdout log directory' |> &MONOTMPDIR +
002100000000                          |> 'cleared') MSGTYPE(*COMP)
002200000000
002300000000             RETURN
002400000000/*----------------------------------------------------------------------------*/
002500000000/* HANDLE ERRORS     */
002600000000/*----------------------------------------------------------------------------*/
002700000000ERRORS:
002800000000
002900000000             /* Send error escape message */
003000000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
003100000000                          occurred while clearing mono stdout temp +
003200000000                          log directory. Check the joblog') +
003300000000                          MSGTYPE(*ESCAPE)
003400000000
