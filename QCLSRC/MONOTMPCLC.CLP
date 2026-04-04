/*------------------------------------------------------------*/
/* @@LIBRARY: GITTEST123                                      */
/* @@FILE: QCLSRC                                             */
/* @@MEMBER: MONOTMPCLC                                       */
/* @@TYPE: CLP                                                */
/* @@TEXT: Clear Mono Temp Stdout Log Directory               */
/*------------------------------------------------------------*/
             PGM        PARM(&MONOTMPDIR)

             DCL        VAR(&MONOTMPDIR) TYPE(*CHAR) LEN(255)
             DCL        VAR(&MONOWORK) TYPE(*CHAR) LEN(255)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))


             CHGVAR     VAR(&MONOWORK) VALUE(&MONOTMPDIR |< '/*')
             ERASE      OBJLNK(&MONOWORK)

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Mono +
                          temp stdout log directory' |> &MONOTMPDIR +
                          |> 'cleared') MSGTYPE(*COMP)

             RETURN
/*----------------------------------------------------------------------------*/
/* HANDLE ERRORS     */
/*----------------------------------------------------------------------------*/
ERRORS:

             /* Send error escape message */
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred while clearing mono stdout temp +
                          log directory. Check the joblog') +
                          MSGTYPE(*ESCAPE)

