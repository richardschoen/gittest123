000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCLSRC                                             */
000400000000/* @@MEMBER: MONO2C                                           */
000500000000/* @@TYPE: CLP                                                */
000600000000/* @@TEXT: Run .Net Console App via Mono - Single Cmd Line    */
000700000000/*------------------------------------------------------------*/
000800000000             PGM        PARM(&WORKDIR &EXEFILE &ARGS &MONOOPTPRE &MONOOPT +
000900000000                          /* This is a comment   */
001000000000                          &OUTFILE &MONOPATH &DSPSTDOUT &LOGSTDOUT +
001100000000                          &PRTSTDOUT &DLTSTDOUT)
001200000000
001300000000             DCL        VAR(&MONOOPTPRE) TYPE(*CHAR) LEN(200)
001400000000             DCL        VAR(&MONOOPT) TYPE(*CHAR) LEN(200)
001500000000             DCL        VAR(&MONOPATH) TYPE(*CHAR) LEN(255)
001600000000             DCL        VAR(&OUTFILE) TYPE(*CHAR) LEN(20)
001700000000             DCL        VAR(&OFILE) TYPE(*CHAR) LEN(10)
001800000000             DCL        VAR(&OLIB) TYPE(*CHAR) LEN(10)
001900000000             DCL        VAR(&WORKDIR) TYPE(*CHAR) LEN(255)
002000000000             DCL        VAR(&EXEFILE) TYPE(*CHAR) LEN(255)
002100000000             DCL        VAR(&EXEFULL) TYPE(*CHAR) LEN(255)
002200000000             DCL        VAR(&ARGS) TYPE(*CHAR) LEN(1024)
002300000000             DCL        VAR(&DSPSTDOUT) TYPE(*CHAR) LEN(4)
002400000000             DCL        VAR(&LOGSTDOUT) TYPE(*CHAR) LEN(4)
002500000000             DCL        VAR(&PRTSTDOUT) TYPE(*CHAR) LEN(4)
002600000000             DCL        VAR(&DLTSTDOUT) TYPE(*CHAR) LEN(4)
002700000000             DCL        VAR(&NULL) TYPE(*CHAR) LEN(2) VALUE(X'0000')
002800000000             DCL        VAR(&INSTRING) TYPE(*CHAR) LEN(256)
002900000000             DCL        VAR(&OUTSTRING) TYPE(*CHAR) LEN(256)
003000000000             DCL        VAR(&NBUSERENC) TYPE(*CHAR) LEN(256)
003100000000             DCL        VAR(&NBPASSENC) TYPE(*CHAR) LEN(256)
003200000000             DCL        VAR(&REPLACE) TYPE(*CHAR) LEN(4)
003300000000             DCL        VAR(&MKDIRS) TYPE(*CHAR) LEN(4)
003400000000             DCL        VAR(&JAVARTN) TYPE(*DEC) LEN(5 0)
003500000000             DCL        VAR(&JAVARTNC) TYPE(*CHAR) LEN(5)
003600000000             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(200)
003700000000             DCL        VAR(&MSGDTA4) TYPE(*CHAR) LEN(4)
003800000000             DCL        VAR(&CPFID) TYPE(*CHAR) LEN(7)
003900000000             DCL        VAR(&CMD) TYPE(*CHAR) LEN(9999)
004000000000             DCL        VAR(&DOMAIN) TYPE(*CHAR) LEN(100)
004100000000             DCL        VAR(&USER) TYPE(*CHAR) LEN(100)
004200000000             DCL        VAR(&USERID) TYPE(*CHAR) LEN(10) /* 1.09 */
004300000000             DCL        VAR(&PASSWORD) TYPE(*CHAR) LEN(100)
004400000000             DCL        VAR(&UNCPATH) TYPE(*CHAR) LEN(255)
004500000000             DCL        VAR(&INPUTFILE) TYPE(*CHAR) LEN(255)
004600000000             DCL        VAR(&OUTPUTFILE) TYPE(*CHAR) LEN(255)
004700000000             DCL        VAR(&STDOUTIFS) TYPE(*CHAR) LEN(255)
004800000000             DCL        VAR(&STDOUTFILE) TYPE(*CHAR) LEN(255)
004900000000             DCL        VAR(&JOB) TYPE(*CHAR) LEN(10)
005000000000             DCL        VAR(&JOBNBR) TYPE(*CHAR) LEN(6)
005100000000             DCL        VAR(&TEMPDIR) TYPE(*CHAR) LEN(255) +
005200000000                          VALUE('/tmp')
005300000000             DCL        VAR(&MONOTEMP) TYPE(*CHAR) LEN(255) +
005400000000                          VALUE('/tmp/mono')
005500000000             DCL        VAR(&DSPSTDOUT) TYPE(*CHAR) LEN(4)
005600000000             DCL        VAR(&DLTSTDOUT) TYPE(*CHAR) LEN(4)
005700000000             DCL        VAR(&RTNVAL) TYPE(*CHAR) LEN(6)
005800000000             DCL        VAR(&APIKEY) TYPE(*CHAR) LEN(6) VALUE('427891')
005900000000             DCL        VAR(&SMBPARMS) TYPE(*CHAR) LEN(100) /* 1.05 */
006000000000             DCL        VAR(&QSHRTN) TYPE(*DEC) LEN(5 0)
006100000000             DCL        VAR(&QSHRTNC) TYPE(*CHAR) LEN(5)
006200000000             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(200)
006300000000             DCL        VAR(&MSGDTA4) TYPE(*CHAR) LEN(4)
006400000000             DCL        VAR(&CPFID) TYPE(*CHAR) LEN(7)
006500000000             DCL        VAR(&MONOEXE) TYPE(*CHAR) LEN(255)
006600000000             DCL        VAR(&QDATE) TYPE(*CHAR) LEN(6)
006700000000             DCL        VAR(&QTIME) TYPE(*CHAR) LEN(9)
006800000000
006900000000/*----------------------------------------------------------------------------*/
007000000000/* Global error monitor */
007100000000/*----------------------------------------------------------------------------*/
007200000000             MONMSG     MSGID(QSH0000) EXEC(GOTO CMDLBL(ERRORS))
007300000000             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))
007400000000
007500000000/*----------------------------------------------------------------------------*/
007600000000/* If default mono path data area, retreive from data area */
007700000000/*----------------------------------------------------------------------------*/
007800000000             IF         COND(&MONOPATH *EQ *DEFAULT) THEN(DO)
007900000000             RTVDTAARA  DTAARA(MONOI/MONOPATH *ALL) RTNVAR(&MONOPATH)
008000000000             ENDDO
008100000000
008200000000/*----------------------------------------------------------------------------*/
008300000000/* Parse outfile */
008400000000/*----------------------------------------------------------------------------*/
008500000000             CHGVAR     VAR(&OLIB) VALUE(%SST(&OUTFILE 11 10))
008600000000             CHGVAR     VAR(&OFILE) VALUE(%SST(&OUTFILE 1 10))
008700000000
008800000000/*----------------------------------------------------------------------------*/
008900000000/* Make sure MONOTEMP library and IFS directory created */
009000000000/*----------------------------------------------------------------------------*/
009100000000             CHKOBJ     OBJ(MONOTEMP) OBJTYPE(*LIB)
009200000000             MONMSG     MSGID(CPF9801) EXEC(DO)
009300000000             CRTLIB     LIB(MONOTEMP) TEXT('Mono .Net Temp File +
009400000000                          Library') AUT(*ALL)
009500000000             ENDDO
009600000000
009700000000/*----------------------------------------------------------------------------*/
009800000000/* Make sure /tmp folder exists */
009900000000/*----------------------------------------------------------------------------*/
010000000000             MONOIFSCHK FILNAM('/tmp')
010100000000             /* EXISTS, DO NOTHING SPECIAL */
010200000000             MONMSG     MSGID(CPF9897) EXEC(DO)
010300000000             ENDDO
010400000000
010500000000             /* DOES NOT EXIST. BAIL OUT */
010600000000             MONMSG     MSGID(CPF9898) EXEC(DO)
010700000000             MKDIR      DIR('/tmp') DTAAUT(*RWX) OBJAUT(*ALL)
010800000000             ENDDO
010900000000
011000000000/*----------------------------------------------------------------------------*/
011100000000/* Make sure /tmp/mono exist for logs */
011200000000/*----------------------------------------------------------------------------*/
011300000000             MONOIFSCHK FILNAM('/tmp/mono')
011400000000             /* EXISTS, DO NOTHING SPECIAL */
011500000000             MONMSG     MSGID(CPF9897) EXEC(DO)
011600000000             ENDDO
011700000000
011800000000             /* DOES NOT EXIST. BAIL OUT */
011900000000             MONMSG     MSGID(CPF9898) EXEC(DO)
012000000000             MKDIR      DIR('/tmp/mono') DTAAUT(*RWX) OBJAUT(*ALL)
012100000000             ENDDO
012200000000
012300000000/*----------------------------------------------------------------------------*/
012400000000/* Make sure MONO executable exists */
012500000000/*----------------------------------------------------------------------------*/
012600000000
012700000000             /* Set mono exe location */
012800000000             CHGVAR     VAR(&MONOEXE) VALUE(&MONOPATH |< '/mono')
012900000000
013000000000             MONOIFSCHK FILNAM(&MONOEXE)
013100000000             /* EXISTS, DO NOTHING SPECIAL */
013200000000             MONMSG     MSGID(CPF9897) EXEC(DO)
013300000000             ENDDO
013400000000
013500000000             /* DOES NOT EXIST. BAIL OUT */
013600000000             MONMSG     MSGID(CPF9898) EXEC(DO)
013700000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('.Net +
013800000000                          mono executable' |< &MONOEXE |> 'does not +
013900000000                          exist') MSGTYPE(*ESCAPE)
014000000000             ENDDO
014100000000
014200000000/*----------------------------------------------------------------------------*/
014300000000/* Make sure exe directory exists */
014400000000/*----------------------------------------------------------------------------*/
014500000000             MONOIFSCHK FILNAM(&WORKDIR)
014600000000             /* EXISTS, DO NOTHING SPECIAL */
014700000000             MONMSG     MSGID(CPF9897) EXEC(DO)
014800000000             ENDDO
014900000000
015000000000             /* DOES NOT EXIST. BAIL OUT */
015100000000             MONMSG     MSGID(CPF9898) EXEC(DO)
015200000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('.Net +
015300000000                          program executable IFS directory' |> +
015400000000                          &WORKDIR |> 'does not exist') +
015500000000                          MSGTYPE(*ESCAPE)
015600000000             ENDDO
015700000000
015800000000/*----------------------------------------------------------------------------*/
015900000000/* Make sure exe exists           */
016000000000/*----------------------------------------------------------------------------*/
016100000000             CHGVAR     VAR(&EXEFULL) VALUE(&WORKDIR |< '/' |< +
016200000000                          &EXEFILE)
016300000000             MONOIFSCHK FILNAM(&EXEFULL)
016400000000             /* EXISTS, DO NOTHING SPECIAL */
016500000000             MONMSG     MSGID(CPF9897) EXEC(DO)
016600000000             ENDDO
016700000000
016800000000             /* DOES NOT EXIST. BAIL OUT */
016900000000             MONMSG     MSGID(CPF9898) EXEC(DO)
017000000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('.Net +
017100000000                          program executable file' |> &EXEFULL |> +
017200000000                          'does not exist') MSGTYPE(*ESCAPE)
017300000000             ENDDO
017400000000
017500000000/*----------------------------------------------------------------------------*/
017600000000/* Build path name for IFS STDOUT file */
017700000000/*----------------------------------------------------------------------------*/
017800000000             RTVJOBA    JOB(&JOB) USER(&USER) NBR(&JOBNBR)
017900000000             RTVSYSVAL  SYSVAL(QDATE) RTNVAR(&QDATE)
018000000000             RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&QTIME)
018100000000             CHGVAR     VAR(&STDOUTIFS) VALUE(&MONOTEMP |< +
018200000000                          '/MONOSTDOUT-' |< &USER |< '-' |< &JOB |< +
018300000000                          '-' |< &JOBNBR |< '-' |< &QDATE |< '-' |< +
018400000000                          &QTIME |< '.TXT')
018500000000
018600000000/*----------------------------------------------------------------------------*/
018700000000/* Erase STDOUT if it exists */
018800000000/*----------------------------------------------------------------------------*/
018900000000             ERASE      OBJLNK(&STDOUTIFS)
019000000000             MONMSG     MSGID(CPF0000)
019100000000
019200000000/*----------------------------------------------------------------------------*/
019300000000/* Create MONOSTDOUT data area in QTEMP if not found */
019400000000/* Then set the STDOUTIFS file name in the data area */
019500000000/*----------------------------------------------------------------------------*/
019600000000             CHKOBJ     OBJ(QTEMP/MONOSTDOUT) OBJTYPE(*DTAARA)
019700000000             MONMSG     MSGID(CPF0000) EXEC(DO)
019800000000             CRTDTAARA  DTAARA(QTEMP/MONOSTDOUT) TYPE(*CHAR) +
019900000000                          LEN(255) TEXT('Mono Stdout IFS Temp File +
020000000000                          Name')
020100000000             ENDDO
020200000000
020300000000             CHGDTAARA  DTAARA(QTEMP/MONOSTDOUT *ALL) VALUE(&STDOUTIFS)
020400000000
020500000000/*----------------------------------------------------------------------------*/
020600000000/* Set the IFS path to store QShell output for  */
020700000000/* review if needed.                            */
020800000000/*----------------------------------------------------------------------------*/
020900000000             CHGVAR     VAR(&STDOUTFILE) VALUE('FILE=' |< &STDOUTIFS)
021000000000
021100000000/*----------------------------------------------------------------------------*/
021200000000/* SET UP FOR MULTI-THREADING                   */
021300000000/*----------------------------------------------------------------------------*/
021400000000             ADDENVVAR  ENVVAR(QIBM_MULTI_THREADED) VALUE(Y) +
021500000000                          REPLACE(*YES)
021600000000
021700000000/*----------------------------------------------------------------------------*/
021800000000/* SET THE QSHELL STDOUT IFS FILE LOCATION      */
021900000000/* ENVIRONMENT VARIABLE                         */
022000000000/*----------------------------------------------------------------------------*/
022100000000            ADDENVVAR  ENVVAR('QIBM_QSH_CMD_OUTPUT') +
022200000000                          VALUE(&STDOUTFILE) REPLACE(*YES)
022300000000
022400000000/*----------------------------------------------------------------------------*/
022500000000/* SET UP PASE CLASSPATH                                     */
022600000000/* Note: Commented out. Set with MONODB2PTH command before calling.*/
022700000000/*----------------------------------------------------------------------------*/
022800000000/****        ADDENVVAR  ENVVAR(PASE_PATH) +
022900000000                          VALUE('/QOpenSys/usr/bin:/usr/ccs/bin:/QOpe+
023000000000                          nSys/usr/bin/X11:/usr/sbin:.:/usr/bin:/QOpe+
023100000000                          nSys/usr/local/bin:/usr/local/bin:/usr/loca+
023200000000                          /sbin:/opt/mono/bin') LEVEL(*JOB) +
023300000000                          REPLACE(*YES)     ****/
023400000000
023500000000/*----------------------------------------------------------------------------*/
023600000000/* CREATE TEMPORARY PASE OUTPUT FILES                           */
023700000000/*----------------------------------------------------------------------------*/
023800000000             CRTPF      FILE(&OLIB/&OFILE) RCDLEN(1000) +
023900000000                          OPTION(*NOLIST *NOSRC) MAXMBRS(*NOMAX) +
024000000000                          SIZE(*NOMAX)
024100000000             MONMSG     MSGID(CPF0000)
024200000000
024300000000             CRTPF      FILE(QTEMP/MONOSTDERR) RCDLEN(1000) +
024400000000                          OPTION(*NOLIST *NOSRC) MAXMBRS(*NOMAX) +
024500000000                          SIZE(*NOMAX)
024600000000             MONMSG     MSGID(CPF0000)
024700000000
024800000000/*----------------------------------------------------------------------------*/
024900000000/* CLEAR TEMPORARY PASE OUTPUT FILES                           */
025000000000/*----------------------------------------------------------------------------*/
025100000000             CLRPFM     FILE(&OLIB/&OFILE)
025200000000             CLRPFM     FILE(QTEMP/MONOSTDERR)
025300000000
025400000000/*----------------------------------------------------------------------------*/
025500000000/* ADD JOB LEVEL ENVIRONMENT VARIABLE FOR SHARED PASE LIBRARIES */
025600000000/* REPLACE THE ENVIRONMENT VARIABLE IF IT ALREADY EXISTS.       */
025700000000/* Note: Commented out. Set with MONODB2PTH command before calling.*/
025800000000/*----------------------------------------------------------------------------*/
025900000000/****        ADDENVVAR  ENVVAR(LIBPATH) +
026000000000                          VALUE('/QOpenSys/usr/local/lib') +
026100000000                          CCSID(*JOB) LEVEL(*JOB) REPLACE(*YES) ****/
026200000000
026300000000/*----------------------------------------------------------------------------*/
026400000000/* SET Mono, Yum, UnixODBC and DB2 Connect Paths                              */
026500000000/* This command call supercedes all the above ADDENVVAR calls.                */
026600000000/*----------------------------------------------------------------------------*/
026700000000             /* As of V1.04 - MONODB2PTH or MONOPATH called external */
026800000000             /* MONODB2PTH MONOPATH(&MONOPATH) */
026900000000
027000000000/*----------------------------------------------------------------------------*/
027100000000/* Build mono PASE command call */
027200000000/*----------------------------------------------------------------------------*/
027300000000          /* CHGCURDIR  DIR(&WORKDIR) - CHGDIR NOW HAPPENS IN CMD */
027400000000             CHGVAR     VAR(&CMD) VALUE('cd' |> &WORKDIR |> '&&' |> +
027500000000                          'PATH=' |< &MONOPATH |< ':$PATH' |> '&&' +
027600000000                          |> 'export PATH' |> '&&' |> &MONOOPTPRE +
027700000000                          |> 'mono' |> &MONOOPT |> &EXEFILE |> &ARGS)
027800000000
027900000000/*----------------------------------------------------------------------------*/
028000000000/* Run .Net program via MONO now                                              */
028100000000/* Instead of calling via QP2SHELL, we use QSH because it                     */
028200000000/* can automatically handle the multi-threading needed by .Net                */
028300000000/*----------------------------------------------------------------------------*/
028400000000
028500000000             /* Call the qsh command */
028600000000             QSH        CMD(&CMD)
028700000000
028800000000             /* READ AND PROCESS THE QSHELL RESPONSE */
028900000000             /* TO DETERMINE PROGRAM EXIT CODE  */
029000000000 NEXTCOMP:   RCVMSG     PGMQ(*SAME) MSGTYPE(*COMP) RMV(*NO) +
029100000000                          MSGDTA(&MSGDTA) MSGID(&CPFID)
029200000000             /* IF MSGID IS BLANK, WE DIDN'T GET QSH0005 */
029300000000             /* LIKE WE WERE SUPPSED TO.                 */
029400000000             IF         COND(&CPFID *EQ '       ') THEN(DO)
029500000000             CHGVAR     VAR(&QSHRTN) VALUE(9999)
029600000000             CHGVAR     VAR(&QSHRTNC) VALUE(&QSHRTN)
029700000000             GOTO       CMDLBL(DONECOMP) /* DONE WITH MSG LOOP */
029800000000             ENDDO
029900000000             /* QSH0005 IS THE RETURN RESPONSE FROM THE PGM */
030000000000             IF         COND(&CPFID *EQ 'QSH0005') THEN(DO)
030100000000             CHGVAR     VAR(&MSGDTA4) VALUE(%SST(&MSGDTA 1 4))
030200000000             CHGVAR     VAR(&QSHRTN) VALUE(%BIN(&MSGDTA4))
030300000000             CHGVAR     VAR(&QSHRTNC) VALUE(&QSHRTN)
030400000000             GOTO       CMDLBL(DONECOMP) /* DONE WITH MSG LOOP */
030500000000             ENDDO
030600000000             GOTO       CMDLBL(NEXTCOMP) /* GET NEXT MSG UNTIL QSH */
030700000000DONECOMP:
030800000000
030900000000             /* IF ENABLED, PRINT STDOUT RESULTS */
031000000000             CPYFRMSTMF FROMSTMF(&STDOUTIFS) TOMBR('/QSYS.LIB/' |< +
031100000000                          &OLIB |< '.LIB/' |< &OFILE |< '.FILE/' |< +
031200000000                          &OFILE |< '.MBR') MBROPT(*REPLACE) +
031300000000                          CVTDTA(*AUTO) ENDLINFMT(*LF) +
031400000000                          STMFCODPAG(*STMF)
031500000000             MONMSG     MSGID(CPF0000) EXEC(DO)
031600000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Error +
031700000000                          occurred while copying STDOUT log to +
031800000000                          spool file. Check the joblog') +
031900000000                          MSGTYPE(*ESCAPE)
032000000000             ENDDO
032100000000
032200000000             IF         COND(&PRTSTDOUT *EQ *YES) THEN(DO)
032300000000
032400000000             /* PRINT STDOUT LOG NOW */
032500000000             OVRPRTF    FILE(QSYSPRT) TOFILE(QSYSPRT) PAGESIZE(198) +
032600000000                          PRTTXT('.Net MONO STDOUT Log') HOLD(*YES) +
032700000000                          USRDTA(MONOSTDOUT) USRDFNDTA(&EXEFILE) +
032800000000                          SPLFNAME(MONOSTDOUT)
032900000000             CPYF       FROMFILE(&OLIB/&OFILE) TOFILE(QSYSPRT)
033000000000             DLTOVR     FILE(QSYSPRT)
033100000000
033200000000             ENDDO
033300000000
033400000000             /* IF ENABLED, DISPLAY STDOUT RESULTS */
033500000000             IF         COND(&DSPSTDOUT *EQ *YES) THEN(DO)
033600000000             EDTF       STMF(&STDOUTIFS)
033700000000             MONMSG     MSGID(CPF0000)
033800000000             ENDDO
033900000000
034000000000             /* IF ENABLED, Erase stdout result file */
034100000000             IF         COND(&DLTSTDOUT *EQ *YES) THEN(DO)
034200000000             ERASE      OBJLNK(&STDOUTIFS)
034300000000             MONMSG     MSGID(CPF0000)
034400000000             CHGDTAARA  DTAARA(QTEMP/MONOSTDOUT *ALL) VALUE(' ')
034500000000             ENDDO
034600000000
034700000000             /* Write STDOUT results PF to job log */
034800000000             IF         COND(&LOGSTDOUT *EQ *YES) THEN(DO)
034900000000             OVRDBF     FILE(MONOSTDOUT) TOFILE(&OLIB/&OFILE)
035000000000             CALL       PGM(MONOSTDOUT) PARM(&EXEFILE)
035100000000             DLTOVR     FILE(MONOSTDOUT)
035200000000             ENDDO
035300000000
035400000000             IF         COND(&QSHRTN *NE 0) THEN(DO)
035500000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Error' +
035600000000                          |> &QSHRTNC |> 'occurred while running +
035700000000                          .Net program' |> &EXEFILE |> 'Check the +
035800000000                          joblog') MSGTYPE(*ESCAPE)
035900000000             ENDDO
036000000000
036100000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('.Net +
036200000000                          program' |> &EXEFILE |> 'call completed +
036300000000                          normally') MSGTYPE(*COMP)
036400000000
036500000000             RETURN
036600000000/*----------------------------------------------------------------------------*/
036700000000/* HANDLE ERRORS     */
036800000000/*----------------------------------------------------------------------------*/
036900000000ERRORS:
037000000000
037100000000             /* IF ENABLED, PRINT STDOUT RESULTS */
037200000000             CPYFRMSTMF FROMSTMF(&STDOUTIFS) TOMBR('/QSYS.LIB/' |< +
037300000000                          &OLIB |< '.LIB/' |< &OFILE |< '.FILE/' |< +
037400000000                          &OFILE |< '.MBR') MBROPT(*REPLACE) +
037500000000                          CVTDTA(*AUTO) ENDLINFMT(*LF) +
037600000000                          STMFCODPAG(*STMF)
037700000000             MONMSG     MSGID(CPF0000) EXEC(DO)
037800000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
037900000000                          occurred while copying STDOUT log to +
038000000000                          spool file. Check the joblog') +
038100000000                          MSGTYPE(*ESCAPE)
038200000000             ENDDO
038300000000
038400000000             IF         COND(&PRTSTDOUT *EQ *YES) THEN(DO)
038500000000
038600000000             /* PRINT STDOUT LOG NOW */
038700000000             OVRPRTF    FILE(QSYSPRT) TOFILE(QSYSPRT) PAGESIZE(198) +
038800000000                          PRTTXT('.Net MONO STDOUT Log') HOLD(*YES) +
038900000000                          USRDTA(MONOSTDOUT) USRDFNDTA(&EXEFILE) +
039000000000                          SPLFNAME(MONOSTDOUT)
039100000000             CPYF       FROMFILE(&OLIB/&OFILE) TOFILE(QSYSPRT)
039200000000             MONMSG     MSGID(CPF0000) /* prevent loop on error */
039300000000             DLTOVR     FILE(QSYSPRT)
039400000000
039500000000             ENDDO
039600000000
039700000000             /* IF ENABLED, DISPLAY STDOUT RESULTS */
039800000000             IF         COND(&DSPSTDOUT *EQ *YES) THEN(DO)
039900000000             EDTF       STMF(&STDOUTIFS)
040000000000             MONMSG     MSGID(CPF0000)
040100000000             ENDDO
040200000000
040300000000             /* IF ENABLED, Erase stdout result file */
040400000000             IF         COND(&DLTSTDOUT *EQ *YES) THEN(DO)
040500000000             ERASE      OBJLNK(&STDOUTIFS)
040600000000             MONMSG     MSGID(CPF0000)
040700000000             CHGDTAARA  DTAARA(QTEMP/MONOSTDOUT *ALL) VALUE(' ')
040800000000             ENDDO
040900000000
041000000000             /* Write STDOUT results PF to job log */
041100000000             IF         COND(&LOGSTDOUT *EQ *YES) THEN(DO)
041200000000             OVRDBF     FILE(MONOSTDOUT) TOFILE(&OLIB/&OFILE)
041300000000             CALL       PGM(MONOSTDOUT) PARM(&EXEFILE)
041400000000             MONMSG     MSGID(CPF0000) /* prevent loop on error */
041500000000             DLTOVR     FILE(MONOSTDOUT)
041600000000             ENDDO
041700000000
041800000000             /* Send error escape message */
041900000000             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
042000000000                          occurred while calling .Net program. +
042100000000                          Check the joblog') MSGTYPE(*ESCAPE)
042200000000
