000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCLSRC                                             */
000400000000/* @@MEMBER: MONOQRYTMC                                       */
000500000000/* @@TYPE: CLP                                                */
000600000000/* @@TEXT: SQL Query Data to Selected Temp Table with RUNSQL  */
000700000000/*------------------------------------------------------------*/
000800000000             PGM        PARM(&SQLQUERY &OUTFILE &EMPTYERROR)
000900000000
001000000000             DCL        VAR(&EMPTYERROR) TYPE(*CHAR) LEN(4)
001100000000             DCL        VAR(&IFILE) TYPE(*CHAR) LEN(10) VALUE(QCUSTCDT)
001200000000             DCL        VAR(&ILIB) TYPE(*CHAR) LEN(10) VALUE(QIWS)
001300000000             DCL        VAR(&OUTFILE) TYPE(*CHAR) LEN(20)
001400000000             DCL        VAR(&TEMPFILE) TYPE(*CHAR) LEN(10) VALUE(CUST1)
001500000000             DCL        VAR(&TEMPLIB) TYPE(*CHAR) LEN(10)
001600000000             DCL        VAR(&SQL) TYPE(*CHAR) LEN(5000)
001700000000             DCL        VAR(&SQLQUERY) TYPE(*CHAR) LEN(5000)
001800000000             DCL        VAR(&RECORDS) TYPE(*DEC) LEN(10)
001900000000             DCL        VAR(&RECORDSC) TYPE(*CHAR) LEN(10)
002000000000             DCL        VAR(&COMPMSGTYP) TYPE(*CHAR) LEN(10) +
002100000000                          VALUE(*COMP)
002200000000
002300000000             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))
002400000000
002500000000/*----------------------------------------------------------------------------*/
002600000000/* Parse outfile parm */
002700000000/*----------------------------------------------------------------------------*/
002800000000             CHGVAR     VAR(&TEMPLIB) VALUE(%SST(&OUTFILE 11 10))
002900000000             CHGVAR     VAR(&TEMPFILE) VALUE(%SST(&OUTFILE 1 10))
003000000000
003100000000/*----------------------------------------------------------------------------*/
003200000000/* Create record count data area */
003300000000/*----------------------------------------------------------------------------*/
003400000000             CHKOBJ     OBJ(QTEMP/SQLQRYCNT) OBJTYPE(*DTAARA)
003500000000             MONMSG     MSGID(CPF0000) EXEC(DO)
003600000000             CRTDTAARA  DTAARA(QTEMP/SQLQRYCNT) TYPE(*DEC) LEN(10 0) +
003700000000                          TEXT('Query Result Record Count')
003800000000             ENDDO
003900000000             CHGDTAARA  DTAARA(QTEMP/SQLQRYCNT *ALL) VALUE(0)
004000000000
004100000000/*----------------------------------------------------------------------------*/
004200000000/* Create outfile info data area. Added in case we add a *GEN option */
004300000000/*----------------------------------------------------------------------------*/
004400000000             CHKOBJ     OBJ(QTEMP/SQLQRYFIL) OBJTYPE(*DTAARA)
004500000000             MONMSG     MSGID(CPF0000) EXEC(DO)
004600000000             CRTDTAARA  DTAARA(QTEMP/SQLQRYFIL) TYPE(*CHAR) LEN(10) +
004700000000                          TEXT('Query Result File Name')
004800000000             ENDDO
004900000000             CHGDTAARA  DTAARA(QTEMP/SQLQRYFIL *ALL) VALUE(' ')
005000000000
005100000000             CHKOBJ     OBJ(QTEMP/SQLQRYLIB) OBJTYPE(*DTAARA)
005200000000             MONMSG     MSGID(CPF0000) EXEC(DO)
005300000000             CRTDTAARA  DTAARA(QTEMP/SQLQRYLIB) TYPE(*CHAR) LEN(10) +
005400000000                          TEXT('Query Result Lib Name')
005500000000             ENDDO
005600000000             CHGDTAARA  DTAARA(QTEMP/SQLQRYLIB *ALL) VALUE(' ')
005700000000
005800000000/*----------------------------------------------------------------------------*/
005900000000/* Drop the temp table if it exists                */
006000000000/* Catch error. Create will fail if already found. */
006100000000/*----------------------------------------------------------------------------*/
006200000000             CHGVAR     VAR(&SQL) VALUE('DROP TABLE' |> &TEMPLIB |< +
006300000000                          '/' |< &TEMPFILE)
006400000000
006500000000             RUNSQL     SQL(&SQL) COMMIT(*NONE)
006600000000             MONMSG     MSGID(CPF0000)
006700000000
006800000000/*----------------------------------------------------------------------------*/
006900000000/* Create temp table from another table using SQL */
007000000000/*----------------------------------------------------------------------------*/
007100000000             CHGVAR     VAR(&SQL) VALUE('create table' |> &TEMPLIB +
007200000000                          |< '/' |< &TEMPFILE |> 'as (' |< +
007300000000                          &SQLQUERY |< ') with data')
007400000000             RUNSQL     SQL(&SQL) COMMIT(*NONE)
007500000000
007600000000/*----------------------------------------------------------------------------*/
007700000000/* Get record count */
007800000000/*----------------------------------------------------------------------------*/
007900000000             /* Check PF record count */
008000000000             RTVMBRD    FILE(&TEMPLIB/&TEMPFILE) MBR(*FIRST) +
008100000000                          NBRCURRCD(&RECORDS)
008200000000             CHGVAR     VAR(&RECORDSC) VALUE(&RECORDS)
008300000000             /* Save record count to data area */
008400000000             CHGDTAARA  DTAARA(QTEMP/SQLQRYCNT *ALL) VALUE(&RECORDS)
008500000000             /* Set temp file data areas on query success */
008600000000             CHGDTAARA  DTAARA(QTEMP/SQLQRYFIL *ALL) VALUE(&TEMPFILE)
008700000000             CHGDTAARA  DTAARA(QTEMP/SQLQRYLIB *ALL) VALUE(&TEMPLIB)
008800000000
008900000000/* If error on empty file, set to escape if no records */
009000000000             IF         COND(&EMPTYERROR *EQ *YES *AND &RECORDS *EQ +
009100000000                          0) THEN(DO)
009200000000             CHGVAR     VAR(&COMPMSGTYP) VALUE(*ESCAPE)
009300000000             ENDDO
009400000000             IF         COND(&EMPTYERROR *EQ *NO *AND &RECORDS *EQ +
009500000000                          0) THEN(DO)
009600000000             CHGVAR     VAR(&COMPMSGTYP) VALUE(*COMP)
009700000000             ENDDO
009800000000
009900000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Temp +
010000000000                          file' |> &TEMPLIB |< '/' |< &TEMPFILE |> +
010100000000                          'was created from query.' |> &RECORDSC |> +
010200000000                          'records') MSGTYPE(&COMPMSGTYP)
010300000000
010400000000             RETURN
010500000000ERRORS:
010600000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
010700000000                          occurred running SQL query commmands +
010800000000                          check the job log') MSGTYPE(*ESCAPE)
010900000000
011000000000             ENDPGM
