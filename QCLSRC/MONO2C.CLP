/*------------------------------------------------------------*/
/* @@LIBRARY: GITTEST123                                      */
/* @@FILE: QCLSRC                                             */
/* @@MEMBER: MONO2C                                           */
/* @@TYPE: CLP                                                */
/* @@TEXT: Run .Net Console App via Mono - Single Cmd Line    */
/*------------------------------------------------------------*/
             PGM        PARM(&WORKDIR &EXEFILE &ARGS &MONOOPTPRE +
                          &MONOOPT &OUTFILE &MONOPATH &DSPSTDOUT +
                          &LOGSTDOUT &PRTSTDOUT &DLTSTDOUT)

             DCL        VAR(&MONOOPTPRE) TYPE(*CHAR) LEN(200)
             DCL        VAR(&MONOOPT) TYPE(*CHAR) LEN(200)
             DCL        VAR(&MONOPATH) TYPE(*CHAR) LEN(255)
             DCL        VAR(&OUTFILE) TYPE(*CHAR) LEN(20)
             DCL        VAR(&OFILE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&WORKDIR) TYPE(*CHAR) LEN(255)
             DCL        VAR(&EXEFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&EXEFULL) TYPE(*CHAR) LEN(255)
             DCL        VAR(&ARGS) TYPE(*CHAR) LEN(1024)
             DCL        VAR(&DSPSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&LOGSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PRTSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DLTSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&NULL) TYPE(*CHAR) LEN(2) VALUE(X'0000')
             DCL        VAR(&INSTRING) TYPE(*CHAR) LEN(256)
             DCL        VAR(&OUTSTRING) TYPE(*CHAR) LEN(256)
             DCL        VAR(&NBUSERENC) TYPE(*CHAR) LEN(256)
             DCL        VAR(&NBPASSENC) TYPE(*CHAR) LEN(256)
             DCL        VAR(&REPLACE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&MKDIRS) TYPE(*CHAR) LEN(4)
             DCL        VAR(&JAVARTN) TYPE(*DEC) LEN(5 0)
             DCL        VAR(&JAVARTNC) TYPE(*CHAR) LEN(5)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(200)
             DCL        VAR(&MSGDTA4) TYPE(*CHAR) LEN(4)
             DCL        VAR(&CPFID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&CMD) TYPE(*CHAR) LEN(9999)
             DCL        VAR(&DOMAIN) TYPE(*CHAR) LEN(100)
             DCL        VAR(&USER) TYPE(*CHAR) LEN(100)
             DCL        VAR(&USERID) TYPE(*CHAR) LEN(10) /* 1.09 */
             DCL        VAR(&PASSWORD) TYPE(*CHAR) LEN(100)
             DCL        VAR(&UNCPATH) TYPE(*CHAR) LEN(255)
             DCL        VAR(&INPUTFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&OUTPUTFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&STDOUTIFS) TYPE(*CHAR) LEN(255)
             DCL        VAR(&STDOUTFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&JOB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBNBR) TYPE(*CHAR) LEN(6)
             DCL        VAR(&TEMPDIR) TYPE(*CHAR) LEN(255) +
                          VALUE('/tmp')
             DCL        VAR(&MONOTEMP) TYPE(*CHAR) LEN(255) +
                          VALUE('/tmp/mono')
             DCL        VAR(&DSPSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DLTSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&RTNVAL) TYPE(*CHAR) LEN(6)
             DCL        VAR(&APIKEY) TYPE(*CHAR) LEN(6) VALUE('427891')
             DCL        VAR(&SMBPARMS) TYPE(*CHAR) LEN(100) /* 1.05 */
             DCL        VAR(&QSHRTN) TYPE(*DEC) LEN(5 0)
             DCL        VAR(&QSHRTNC) TYPE(*CHAR) LEN(5)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(200)
             DCL        VAR(&MSGDTA4) TYPE(*CHAR) LEN(4)
             DCL        VAR(&CPFID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&MONOEXE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&QDATE) TYPE(*CHAR) LEN(6)
             DCL        VAR(&QTIME) TYPE(*CHAR) LEN(9)

/*----------------------------------------------------------------------------*/
/* Global error monitor */
/*----------------------------------------------------------------------------*/
             MONMSG     MSGID(QSH0000) EXEC(GOTO CMDLBL(ERRORS))
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

/*----------------------------------------------------------------------------*/
/* If default mono path data area, retreive from data area */
/*----------------------------------------------------------------------------*/
             IF         COND(&MONOPATH *EQ *DEFAULT) THEN(DO)
             RTVDTAARA  DTAARA(MONOI/MONOPATH *ALL) RTNVAR(&MONOPATH)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Parse outfile */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&OLIB) VALUE(%SST(&OUTFILE 11 10))
             CHGVAR     VAR(&OFILE) VALUE(%SST(&OUTFILE 1 10))

/*----------------------------------------------------------------------------*/
/* Make sure MONOTEMP library and IFS directory created */
/*----------------------------------------------------------------------------*/
             CHKOBJ     OBJ(MONOTEMP) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTLIB     LIB(MONOTEMP) TEXT('Mono .Net Temp File +
                          Library') AUT(*ALL)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Make sure /tmp folder exists */
/*----------------------------------------------------------------------------*/
             MONOIFSCHK FILNAM('/tmp')
             /* EXISTS, DO NOTHING SPECIAL */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* DOES NOT EXIST. BAIL OUT */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             MKDIR      DIR('/tmp') DTAAUT(*RWX) OBJAUT(*ALL)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Make sure /tmp/mono exist for logs */
/*----------------------------------------------------------------------------*/
             MONOIFSCHK FILNAM('/tmp/mono')
             /* EXISTS, DO NOTHING SPECIAL */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* DOES NOT EXIST. BAIL OUT */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             MKDIR      DIR('/tmp/mono') DTAAUT(*RWX) OBJAUT(*ALL)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Make sure MONO executable exists */
/*----------------------------------------------------------------------------*/

             /* Set mono exe location */
             CHGVAR     VAR(&MONOEXE) VALUE(&MONOPATH |< '/mono')

             MONOIFSCHK FILNAM(&MONOEXE)
             /* EXISTS, DO NOTHING SPECIAL */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* DOES NOT EXIST. BAIL OUT */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('.Net +
                          mono executable' |< &MONOEXE |> 'does not +
                          exist') MSGTYPE(*ESCAPE)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Make sure exe directory exists */
/*----------------------------------------------------------------------------*/
             MONOIFSCHK FILNAM(&WORKDIR)
             /* EXISTS, DO NOTHING SPECIAL */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* DOES NOT EXIST. BAIL OUT */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('.Net +
                          program executable IFS directory' |> +
                          &WORKDIR |> 'does not exist') +
                          MSGTYPE(*ESCAPE)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Make sure exe exists           */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&EXEFULL) VALUE(&WORKDIR |< '/' |< +
                          &EXEFILE)
             MONOIFSCHK FILNAM(&EXEFULL)
             /* EXISTS, DO NOTHING SPECIAL */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* DOES NOT EXIST. BAIL OUT */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('.Net +
                          program executable file' |> &EXEFULL |> +
                          'does not exist') MSGTYPE(*ESCAPE)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Build path name for IFS STDOUT file */
/*----------------------------------------------------------------------------*/
             RTVJOBA    JOB(&JOB) USER(&USER) NBR(&JOBNBR)
             RTVSYSVAL  SYSVAL(QDATE) RTNVAR(&QDATE)
             RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&QTIME)
             CHGVAR     VAR(&STDOUTIFS) VALUE(&MONOTEMP |< +
                          '/MONOSTDOUT-' |< &USER |< '-' |< &JOB |< +
                          '-' |< &JOBNBR |< '-' |< &QDATE |< '-' |< +
                          &QTIME |< '.TXT')

/*----------------------------------------------------------------------------*/
/* Erase STDOUT if it exists */
/*----------------------------------------------------------------------------*/
             ERASE      OBJLNK(&STDOUTIFS)
             MONMSG     MSGID(CPF0000)

/*----------------------------------------------------------------------------*/
/* Create MONOSTDOUT data area in QTEMP if not found */
/* Then set the STDOUTIFS file name in the data area */
/*----------------------------------------------------------------------------*/
             CHKOBJ     OBJ(QTEMP/MONOSTDOUT) OBJTYPE(*DTAARA)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             CRTDTAARA  DTAARA(QTEMP/MONOSTDOUT) TYPE(*CHAR) +
                          LEN(255) TEXT('Mono Stdout IFS Temp File +
                          Name')
             ENDDO

             CHGDTAARA  DTAARA(QTEMP/MONOSTDOUT *ALL) VALUE(&STDOUTIFS)

/*----------------------------------------------------------------------------*/
/* Set the IFS path to store QShell output for  */
/* review if needed.                            */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&STDOUTFILE) VALUE('FILE=' |< &STDOUTIFS)

/*----------------------------------------------------------------------------*/
/* SET UP FOR MULTI-THREADING                   */
/*----------------------------------------------------------------------------*/
             ADDENVVAR  ENVVAR(QIBM_MULTI_THREADED) VALUE(Y) +
                          REPLACE(*YES)

/*----------------------------------------------------------------------------*/
/* SET THE QSHELL STDOUT IFS FILE LOCATION      */
/* ENVIRONMENT VARIABLE                         */
/*----------------------------------------------------------------------------*/
            ADDENVVAR  ENVVAR('QIBM_QSH_CMD_OUTPUT') +
                          VALUE(&STDOUTFILE) REPLACE(*YES)

/*----------------------------------------------------------------------------*/
/* SET UP PASE CLASSPATH                                     */
/* Note: Commented out. Set with MONODB2PTH command before calling.*/
/*----------------------------------------------------------------------------*/
/****        ADDENVVAR  ENVVAR(PASE_PATH) +
                          VALUE('/QOpenSys/usr/bin:/usr/ccs/bin:/QOpe+
                          nSys/usr/bin/X11:/usr/sbin:.:/usr/bin:/QOpe+
                          nSys/usr/local/bin:/usr/local/bin:/usr/loca+
                          /sbin:/opt/mono/bin') LEVEL(*JOB) +
                          REPLACE(*YES)     ****/

/*----------------------------------------------------------------------------*/
/* CREATE TEMPORARY PASE OUTPUT FILES                           */
/*----------------------------------------------------------------------------*/
             CRTPF      FILE(&OLIB/&OFILE) RCDLEN(1000) +
                          OPTION(*NOLIST *NOSRC) MAXMBRS(*NOMAX) +
                          SIZE(*NOMAX)
             MONMSG     MSGID(CPF0000)

             CRTPF      FILE(QTEMP/MONOSTDERR) RCDLEN(1000) +
                          OPTION(*NOLIST *NOSRC) MAXMBRS(*NOMAX) +
                          SIZE(*NOMAX)
             MONMSG     MSGID(CPF0000)

/*----------------------------------------------------------------------------*/
/* CLEAR TEMPORARY PASE OUTPUT FILES                           */
/*----------------------------------------------------------------------------*/
             CLRPFM     FILE(&OLIB/&OFILE)
             CLRPFM     FILE(QTEMP/MONOSTDERR)

/*----------------------------------------------------------------------------*/
/* ADD JOB LEVEL ENVIRONMENT VARIABLE FOR SHARED PASE LIBRARIES */
/* REPLACE THE ENVIRONMENT VARIABLE IF IT ALREADY EXISTS.       */
/* Note: Commented out. Set with MONODB2PTH command before calling.*/
/*----------------------------------------------------------------------------*/
/****        ADDENVVAR  ENVVAR(LIBPATH) +
                          VALUE('/QOpenSys/usr/local/lib') +
                          CCSID(*JOB) LEVEL(*JOB) REPLACE(*YES) ****/

/*----------------------------------------------------------------------------*/
/* SET Mono, Yum, UnixODBC and DB2 Connect Paths                              */
/* This command call supercedes all the above ADDENVVAR calls.                */
/*----------------------------------------------------------------------------*/
             /* As of V1.04 - MONODB2PTH or MONOPATH called external */
             /* MONODB2PTH MONOPATH(&MONOPATH) */

/*----------------------------------------------------------------------------*/
/* Build mono PASE command call */
/*----------------------------------------------------------------------------*/
          /* CHGCURDIR  DIR(&WORKDIR) - CHGDIR NOW HAPPENS IN CMD */
             CHGVAR     VAR(&CMD) VALUE('cd' |> &WORKDIR |> '&&' |> +
                          'PATH=' |< &MONOPATH |< ':$PATH' |> '&&' +
                          |> 'export PATH' |> '&&' |> &MONOOPTPRE +
                          |> 'mono' |> &MONOOPT |> &EXEFILE |> &ARGS)

/*----------------------------------------------------------------------------*/
/* Run .Net program via MONO now                                              */
/* Instead of calling via QP2SHELL, we use QSH because it                     */
/* can automatically handle the multi-threading needed by .Net                */
/*----------------------------------------------------------------------------*/

             /* Call the qsh command */
             QSH        CMD(&CMD)

             /* READ AND PROCESS THE QSHELL RESPONSE */
             /* TO DETERMINE PROGRAM EXIT CODE  */
 NEXTCOMP:   RCVMSG     PGMQ(*SAME) MSGTYPE(*COMP) RMV(*NO) +
                          MSGDTA(&MSGDTA) MSGID(&CPFID)
             /* IF MSGID IS BLANK, WE DIDN'T GET QSH0005 */
             /* LIKE WE WERE SUPPSED TO.                 */
             IF         COND(&CPFID *EQ '       ') THEN(DO)
             CHGVAR     VAR(&QSHRTN) VALUE(9999)
             CHGVAR     VAR(&QSHRTNC) VALUE(&QSHRTN)
             GOTO       CMDLBL(DONECOMP) /* DONE WITH MSG LOOP */
             ENDDO
             /* QSH0005 IS THE RETURN RESPONSE FROM THE PGM */
             IF         COND(&CPFID *EQ 'QSH0005') THEN(DO)
             CHGVAR     VAR(&MSGDTA4) VALUE(%SST(&MSGDTA 1 4))
             CHGVAR     VAR(&QSHRTN) VALUE(%BIN(&MSGDTA4))
             CHGVAR     VAR(&QSHRTNC) VALUE(&QSHRTN)
             GOTO       CMDLBL(DONECOMP) /* DONE WITH MSG LOOP */
             ENDDO
             GOTO       CMDLBL(NEXTCOMP) /* GET NEXT MSG UNTIL QSH */
DONECOMP:

             /* IF ENABLED, PRINT STDOUT RESULTS */
             CPYFRMSTMF FROMSTMF(&STDOUTIFS) TOMBR('/QSYS.LIB/' |< +
                          &OLIB |< '.LIB/' |< &OFILE |< '.FILE/' |< +
                          &OFILE |< '.MBR') MBROPT(*REPLACE) +
                          CVTDTA(*AUTO) ENDLINFMT(*LF) +
                          STMFCODPAG(*STMF)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Error +
                          occurred while copying STDOUT log to +
                          spool file. Check the joblog') +
                          MSGTYPE(*ESCAPE)
             ENDDO

             IF         COND(&PRTSTDOUT *EQ *YES) THEN(DO)

             /* PRINT STDOUT LOG NOW */
             OVRPRTF    FILE(QSYSPRT) TOFILE(QSYSPRT) PAGESIZE(198) +
                          PRTTXT('.Net MONO STDOUT Log') HOLD(*YES) +
                          USRDTA(MONOSTDOUT) USRDFNDTA(&EXEFILE) +
                          SPLFNAME(MONOSTDOUT)
             CPYF       FROMFILE(&OLIB/&OFILE) TOFILE(QSYSPRT)
             DLTOVR     FILE(QSYSPRT)

             ENDDO

             /* IF ENABLED, DISPLAY STDOUT RESULTS */
             IF         COND(&DSPSTDOUT *EQ *YES) THEN(DO)
             EDTF       STMF(&STDOUTIFS)
             MONMSG     MSGID(CPF0000)
             ENDDO

             /* IF ENABLED, Erase stdout result file */
             IF         COND(&DLTSTDOUT *EQ *YES) THEN(DO)
             ERASE      OBJLNK(&STDOUTIFS)
             MONMSG     MSGID(CPF0000)
             CHGDTAARA  DTAARA(QTEMP/MONOSTDOUT *ALL) VALUE(' ')
             ENDDO

             /* Write STDOUT results PF to job log */
             IF         COND(&LOGSTDOUT *EQ *YES) THEN(DO)
             OVRDBF     FILE(MONOSTDOUT) TOFILE(&OLIB/&OFILE)
             CALL       PGM(MONOSTDOUT) PARM(&EXEFILE)
             DLTOVR     FILE(MONOSTDOUT)
             ENDDO

             IF         COND(&QSHRTN *NE 0) THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Error' +
                          |> &QSHRTNC |> 'occurred while running +
                          .Net program' |> &EXEFILE |> 'Check the +
                          joblog') MSGTYPE(*ESCAPE)
             ENDDO

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('.Net +
                          program' |> &EXEFILE |> 'call completed +
                          normally') MSGTYPE(*COMP)

             RETURN
/*----------------------------------------------------------------------------*/
/* HANDLE ERRORS     */
/*----------------------------------------------------------------------------*/
ERRORS:

             /* IF ENABLED, PRINT STDOUT RESULTS */
             CPYFRMSTMF FROMSTMF(&STDOUTIFS) TOMBR('/QSYS.LIB/' |< +
                          &OLIB |< '.LIB/' |< &OFILE |< '.FILE/' |< +
                          &OFILE |< '.MBR') MBROPT(*REPLACE) +
                          CVTDTA(*AUTO) ENDLINFMT(*LF) +
                          STMFCODPAG(*STMF)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred while copying STDOUT log to +
                          spool file. Check the joblog') +
                          MSGTYPE(*ESCAPE)
             ENDDO

             IF         COND(&PRTSTDOUT *EQ *YES) THEN(DO)

             /* PRINT STDOUT LOG NOW */
             OVRPRTF    FILE(QSYSPRT) TOFILE(QSYSPRT) PAGESIZE(198) +
                          PRTTXT('.Net MONO STDOUT Log') HOLD(*YES) +
                          USRDTA(MONOSTDOUT) USRDFNDTA(&EXEFILE) +
                          SPLFNAME(MONOSTDOUT)
             CPYF       FROMFILE(&OLIB/&OFILE) TOFILE(QSYSPRT)
             MONMSG     MSGID(CPF0000) /* prevent loop on error */
             DLTOVR     FILE(QSYSPRT)

             ENDDO

             /* IF ENABLED, DISPLAY STDOUT RESULTS */
             IF         COND(&DSPSTDOUT *EQ *YES) THEN(DO)
             EDTF       STMF(&STDOUTIFS)
             MONMSG     MSGID(CPF0000)
             ENDDO

             /* IF ENABLED, Erase stdout result file */
             IF         COND(&DLTSTDOUT *EQ *YES) THEN(DO)
             ERASE      OBJLNK(&STDOUTIFS)
             MONMSG     MSGID(CPF0000)
             CHGDTAARA  DTAARA(QTEMP/MONOSTDOUT *ALL) VALUE(' ')
             ENDDO

             /* Write STDOUT results PF to job log */
             IF         COND(&LOGSTDOUT *EQ *YES) THEN(DO)
             OVRDBF     FILE(MONOSTDOUT) TOFILE(&OLIB/&OFILE)
             CALL       PGM(MONOSTDOUT) PARM(&EXEFILE)
             MONMSG     MSGID(CPF0000) /* prevent loop on error */
             DLTOVR     FILE(MONOSTDOUT)
             ENDDO

             /* Send error escape message */
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred while calling .Net program. +
                          Check the joblog') MSGTYPE(*ESCAPE)

