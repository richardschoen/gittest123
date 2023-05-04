000200000000      *---------------------------------------------------------
000300000000      * Source information
000400000000      * @@LIBRARY: GITTEST123
000500000000      * @@FILE: QRPGLESRC
000600000000      * @@MEMBER: MONOSTDOUT
000700000000      * @@TYPE: RPGLE
000800000000      * @@TEXT: Read and parse stdout log....xxxz
000900000000      *---------------------------------------------------------
000100000000     /***************************************************************
000200000000      * Program: MONOSTDOUT
000300221222      * Author : Richard J Schoen........................
000400000000      * Desc . : This program will read the selected STDOUT log file and
000500000000      *          send back info to the caller for processing the
000600000000      *          selected log messages. MONOSTDOUT is created in QTEMP
000700000000      *          at runtime.
000800000000      *          Uses its own custom CPF message: NET9898 which
000900000000      *          stands for Mono/.Net message.
001000000000      *          This way .Net console messages can be picked out of
001100000000      *          the joblog if desired by CPF ID.
001200000000      ***************************************************************/
001300221212     H DFTACTGRP(*NO) ACTGRP(*NEW)
001400000000
001500000000     FMONOSTDOUTIF   F 1000        DISK    USROPN
001600000000      /include QSYSINC/QRPGLESRC,QUSEC
001700000000      //  SEND Program Message API
001800000000
001900000000     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
002000000000     D  szMsgID2                      7A   Const
002100000000     D  szMsgFile2                   20A   Const
002200000000     D  szMsgData2                 6000A   Const OPTIONS(*varsize)
002300000000     D  nMsgDataLen                  10I 0 Const
002400000000
002500000000      **  Message Type may be one of the following:
002600000000      **  *COMP    - Completion
002700000000      **  *DIAG    - Diagnostic
002800000000      **  *ESCAPE  - Escape
002900000000      **  *INFO    - Informational
003000000000      **  *INQ     - Inquiry.
003100000000      **             (Only used when ToPgmQ(*EXT) is specified).
003200000000      **  *NOTIFY  - Notify
003300000000      **  *RQS     - Request
003400000000      **  *STATUS  - Status
003500000000     D  szMsgType                    10A   Const
003600000000
003700000000      **  Call Stack Entry may be one of the following:
003800000000      **  *        - *SAME
003900000000      **  *EXT     - The external message queue
004000000000      **  *CTLBDY  - Control Boundary
004100000000      **  *PRV     - Program that called this procedure (*SAME)
004200000000      **  *PRVPGM  - Previous programo
004300000000     D  szCallStkEntry...
004400000000     D                               10A   Const
004500000000     D  nRelativeCallStkEntry...
004600000000     D                               10I 0 Const
004700000000     D  szRtnMsgKey                   4A
004800000000     D  apiErrorDS                         LikeDS(QUSEC)
004900000000     D                                     OPTIONS(*VARSIZE)
005000000000
005100000000      // TODO: Include the QMHSNDPM API Prototype here
005200000000
005300000000     D SndMsg          PR             4A
005400000000     D  szMsg                      1024A   Const Varying
005500000000     D  szMsgType                    10A   Const
005600000000     D                                     OPTIONS(*NOPASS)
005700000000     D  szToPgmQ                     10A   Const
005800000000     D                                     OPTIONS(*NOPASS)
005900000000
006000000000     IMONOSTDOUTAA  01
006100000000     I                                  1  400  LOGDATA
006200000000     I                                  1   40  LOG40
006300000000     I                                 13  112  LOGRTN
006400000000     I                                  1    5  PARM5
006500000000
006600000000     C     *ENTRY        PLIST
006700000000     C                   PARM                    EXEFILE         255
006800000000     C*                  PARM                    RTNP1           100
006900000000     C*                  PARM                    RTNP2           100
007000000000
007100000000      /free
007200000000
007300000000      /IF DEFINED(*CRTBNDRPG)
007400000000
007500000000       //  Read STDOUT log file now
007600000000       OPEN MONOSTDOUT;
007700000000
007800000000       // Stdout being message
007900000000       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
008000000000       SndMsg('Program:' + %trim(exefile):'*INFO':'*PRVPGM');
008100000000       SndMsg('Begin .Net Stdout':'*INFO':'*PRVPGM');
008200000000       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
008300000000
008400000000       // Loop thru STDOUT results
008500000000       READ MONOSTDOUT;
008600000000       DOW Not %EOF(MONOSTDOUT);
008700000000
008800000000         // Pick off the return parm values
008900000000         // and set the return fields.
009000000000        SndMsg(%TRIM(LogData):'*INFO':'*PRVPGM');
009100000000
009200000000        //IF PARM5 = 'PARM1';
009300000000        //    RTNP1 = LOGRTN;
009400000000        //ELSEIF PARM5 = 'PARM2';
009500000000        //    RTNP2 = LOGRTN;
009600000000        //ENDIF;
009700000000         READ MONOSTDOUT;
009800000000
009900000000       ENDDO;
010000000000
010100000000       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
010200000000       SndMsg('End .Net Stdout':'*INFO':'*PRVPGM');
010300000000       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
010400000000
010500000000       CLOSE MONOSTDOUT;
010600000000
010700000000       // All done, let's bail out
010800000000       *inlr = *on;
010900000000       return;
011000000000
011100000000      /end-free
011200000000      /ENDIF
011300000000
011400000000     P SndMsg          B                   Export
011500000000      *******************************************
011600000000      **  Send an impromptu message to a pgmq
011700000000      *******************************************
011800000000     D SndMsg          PI             4A
011900000000     D  msg                        1024A   Const Varying
012000000000     D  szMsgType                    10A   Const
012100000000     D                                     OPTIONS(*NOPASS)
012200000000     D  szToPgmQ                     10A   Const
012300000000     D                                     OPTIONS(*NOPASS)
012400000000
012500000000      *******************************************
012600000000      /include qsysinc/qrpglesrc,qusec
012700000000      *******************************************
012800000000      **  Local variables.
012900000000     D  msgType        S                   Like(szMsgType) Inz('*INFO')
013000000000     D  toPgmQ         S                   Like(szToPgmQ)  Inz('*')
013100000000
013200000000     D msgid           S              7A   Inz('NET9898')
013300000000     D msgf            DS            21
013400000000     D  MsgFile                      10A   Inz('MONOMSG')
013500000000     D  MsgLib                       10A   Inz('*LIBL')
013600000000     D
013700000000     D msgData         S           1024A
013800000000     D nDataLen        S             10I 0 Inz(0)
013900000000     D nRelInv         S             10I 0 Inz(1)
014000000000     D nIncInv         S             10I 0 Inz(1)
014100000000     D RtnMsgKey       S              4A
014200000000     D myAPIErrorDS    DS                  LikeDS(QUSEC)
014300000000
014400000000     C                   eval      myApiErrorDS = *ALLX'00'
014500000000
014600000000     C                   if        %Parms()>=2
014700000000     C                   eval      msgType = szMsgType
014800000000     C                   if        %subst(msgType:1:1)<>'*'
014900000000     C                   eval      msgType = '*' + %TrimL(msgType)
015000000000     C                   endif
015100000000     C                   endif
015200000000
015300000000     C                   if        %Parms()>= 3
015400000000     C                   if        szToPgmQ <> *BLANKS
015500000000     C                   eval      toPgmQ=  szToPgmQ
015600000000     C                   endif
015700000000     C                   if        toPgmQ = '*SAME'
015800000000     C                   eval      toPgmQ = '*'
015900000000     C                   endif
016000000000     C                   endif
016100000000
016200000000         // Status messages always go ToPgmQ(*EXT)
016300000000     C                   if        msgType = '*STATUS'
016400000000     C                   eval      toPgmQ = '*EXT'
016500000000     C                   endif
016600000000
016700000000     C                   if        msgType = '*'
016800000000     C                   eval      msgType = '*INFO'
016900000000     C                   endif
017000000000
017100000000        // Get the length of the message to be sent.
017200000000     C                   eval      msgData = %Trim(msg)
017300000000     C                   eval      nDataLen = %len(%Trim(msg))
017400000000
017500000000     C                   Select
017600000000      **  *SAME
017700000000     C                   when      toPgmQ  = ' '
017800000000     C                             or toPgmQ = '*SAME'
017900000000     C                             or toPgmQ = '*'
018000000000     C                   eval      toPgmQ = '*'
018100000000     C                   eval      nRelInv = 0
018200000000     C                   eval      nIncInv = 1
018300000000      **  *PRV, *PRVPRC or *PRVPROC
018400000000     C                   when      toPgmQ = '*PRVPRC'
018500000000     C                             or toPgmQ = '*PRVPROC'
018600000000     C                             or toPgmQ = '*PRV'
018700000000     C                   eval      toPgmQ = '*'
018800000000     C                   eval      nRelInv = 1
018900000000     C                   eval      nIncInv = 1
019000000000      **  *PRVPGM
019100000000     C                   When      toPgmQ = '*PRVPGM'
019200000000     C                   eval      toPgmQ = '*CTLBDY'
019300000000     C                   eval      nRelInv = 0
019400000000     C                   eval      nIncInv = 1
019500000000      **  *CTLBDY
019600000000     C                   when      toPgmQ = '*CTLBDY'
019700000000     C                   eval      nIncInv = 2
019800000000      **  *EXT
019900000000     C                   when      toPgmQ = '*EXT'
020000000000     C                   eval      nRelInv = 0
020100000000     C                   endsl
020200000000
020300000000      **  Since we're a relative invocation, and we are
020400000000      **  one-level deep, we need to bump up the relative
020500000000      **  invocation by the calculated increment.
020600000000     C                   eval      nRelInv = nRelInv + nIncInv
020700000000
020800000000     C                   callp(e)  QMHSNDPM(msgid   : msgf :
020900000000     C                                      msgData : nDataLen :
021000000000     C                                      msgType   :
021100000000     C                                      toPgmQ    :
021200000000     C                                      nRelInv   :
021300000000     C                                      rtnMsgKey :
021400000000     C                                      myAPIErrorDS)
021500000000
021600000000     C                   return    rtnMsgKey
021700221212     P SndMsg          E
021800000000
