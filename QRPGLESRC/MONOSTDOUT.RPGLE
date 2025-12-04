000100000000      *---------------------------------------------------------
000200000000      * Source information
000300000000      * @@LIBRARY: GITTEST123
000400000000      * @@FILE: QRPGLESRC
000500000000      * @@MEMBER: MONOSTDOUT
000600000000      * @@TYPE: RPGLE
000700000000      * @@TEXT: Read and parse stdout log
000800000000      *---------------------------------------------------------
000900000000      *---------------------------------------------------------
001000000000      * Program: MONOSTDOUT
001100000000      * Author : Richard J Schoen...This is a test..from this iFS.......
001200000000      * Desc . : This program will read the selected STDOUT log file and
001300000000      *          send back info to the caller for processing the
001400000000      *          selected log messages. MONOSTDOUT is created in QTEMP
001500000000      *          at runtime.
001600000000      *          Uses its own custom CPF message: NET9898 which
001700000000      *          stands for Mono/.Net message.
001800000000      *          This way .Net console messages can be picked out of
001900000000      *          the joblog if desired by CPF Message ID.
002000000000      *          This is a new comment.
002100000000      *          This is another new comment.
002200000000      *          This is another new comment.
002300000000      *          This is another new comment.
002400000000      *          This is another new comment...
002500000000      *          This is another new comment - 11/6/2025........
002600000000      ***************************************************************/
002700000000     H DFTACTGRP(*NO) ACTGRP(*NEW)
002800000000
002900000000     FMONOSTDOUTIF   F 1000        DISK    USROPN
003000000000      /include QSYSINC/QRPGLESRC,QUSEC
003100000000      //  SEND Program Message API
003200000000
003300000000     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
003400000000     D  szMsgID2                      7A   Const
003500000000     D  szMsgFile2                   20A   Const
003600000000     D  szMsgData2                 6000A   Const OPTIONS(*varsize)
003700000000     D  nMsgDataLen                  10I 0 Const
003800000000      ** New comment
003900000000      **  Message Type may be one of the following:
004000000000      **  *COMP    - Completion
004100000000      **  *DIAG    - Diagnostic
004200000000      **  *ESCAPE  - Escape
004300000000      **  *INFO    - Informational
004400000000      **  *INQ     - Inquiry.
004500000000      **             (Only used when ToPgmQ(*EXT) is specified).
004600000000      **  *NOTIFY  - Notify
004700000000      **  *RQS     - Request
004800000000      **  *STATUS  - Status
004900000000     D  szMsgType                    10A   Const
005000000000
005100000000      **  Call Stack Entry may be one of the following:
005200000000      **  *        - *SAME
005300000000      **  *EXT     - The external message queue
005400000000      **  *CTLBDY  - Control Boundary
005500000000      **  *PRV     - Program that called this procedure (*SAME)
005600000000      **  *PRVPGM  - Previous programo
005700000000     D  szCallStkEntry...
005800000000     D                               10A   Const
005900000000     D  nRelativeCallStkEntry...
006000000000     D                               10I 0 Const
006100000000     D  szRtnMsgKey                   4A
006200000000     D  apiErrorDS                         LikeDS(QUSEC)
006300000000     D                                     OPTIONS(*VARSIZE)
006400000000
006500000000      // TODO: Include the QMHSNDPM API Prototype here
006600000000
006700000000     D SndMsg          PR             4A
006800000000     D  szMsg                      1024A   Const Varying
006900000000     D  szMsgType                    10A   Const
007000000000     D                                     OPTIONS(*NOPASS)
007100000000     D  szToPgmQ                     10A   Const
007200000000     D                                     OPTIONS(*NOPASS)
007300000000
007400000000     IMONOSTDOUTAA  01
007500000000     I                                  1  400  LOGDATA
007600000000     I                                  1   40  LOG40
007700000000     I                                 13  112  LOGRTN
007800000000     I                                  1    5  PARM5
007900000000
008000000000     C     *ENTRY        PLIST
008100000000     C                   PARM                    EXEFILE         255
008200000000     C*                  PARM                    RTNP1           100
008300000000     C*                  PARM                    RTNP2           100
008400000000
008500000000      /free
008600000000
008700000000      /IF DEFINED(*CRTBNDRPG)
008800000000
008900000000       //  Read STDOUT log file now
009000000000       OPEN MONOSTDOUT;
009100000000
009200000000       // Stdout being message
009300000000       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
009400000000       SndMsg('Program:' + %trim(exefile):'*INFO':'*PRVPGM');
009500000000       SndMsg('Begin .Net Stdout':'*INFO':'*PRVPGM');
009600000000       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
009700000000
009800000000       // Loop thru STDOUT results
009900000000       READ MONOSTDOUT;
010000000000       DOW Not %EOF(MONOSTDOUT);
010100000000
010200000000         // Pick off the return parm values
010300000000         // and set the return fields.
010400000000        SndMsg(%TRIM(LogData):'*INFO':'*PRVPGM');
010500000000
010600000000        //IF PARM5 = 'PARM1';
010700000000        //    RTNP1 = LOGRTN;
010800000000        //ELSEIF PARM5 = 'PARM2';
010900000000        //    RTNP2 = LOGRTN;
011000000000        //ENDIF;
011100000000         READ MONOSTDOUT;
011200000000
011300000000       ENDDO;
011400000000
011500000000       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
011600000000       SndMsg('End .Net Stdout':'*INFO':'*PRVPGM');
011700000000       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
011800000000
011900000000       CLOSE MONOSTDOUT;
012000000000
012100000000       // All done, let's bail out
012200000000       *inlr = *on;
012300000000       return;
012400000000
012500000000      /end-free
012600000000      /ENDIF
012700000000
012800000000     P SndMsg          B                   Export
012900000000      *******************************************
013000000000      **  Send an impromptu message to a pgmq
013100000000      *******************************************
013200000000     D SndMsg          PI             4A
013300000000     D  msg                        1024A   Const Varying
013400000000     D  szMsgType                    10A   Const
013500000000     D                                     OPTIONS(*NOPASS)
013600000000     D  szToPgmQ                     10A   Const
013700000000     D                                     OPTIONS(*NOPASS)
013800000000
013900000000      *******************************************
014000000000      /include qsysinc/qrpglesrc,qusec
014100000000      *******************************************
014200000000      **  Local variables.
014300000000     D  msgType        S                   Like(szMsgType) Inz('*INFO')
014400000000     D  toPgmQ         S                   Like(szToPgmQ)  Inz('*')
014500000000
014600000000     D msgid           S              7A   Inz('NET9898')
014700000000     D msgf            DS            21
014800000000     D  MsgFile                      10A   Inz('MONOMSG')
014900000000     D  MsgLib                       10A   Inz('*LIBL')
015000000000     D
015100000000     D msgData         S           1024A
015200000000     D nDataLen        S             10I 0 Inz(0)
015300000000     D nRelInv         S             10I 0 Inz(1)
015400000000     D nIncInv         S             10I 0 Inz(1)
015500000000     D RtnMsgKey       S              4A
015600000000     D myAPIErrorDS    DS                  LikeDS(QUSEC)
015700000000
015800000000     C                   eval      myApiErrorDS = *ALLX'00'
015900000000
016000000000     C                   if        %Parms()>=2
016100000000     C                   eval      msgType = szMsgType
016200000000     C                   if        %subst(msgType:1:1)<>'*'
016300000000     C                   eval      msgType = '*' + %TrimL(msgType)
016400000000     C                   endif
016500000000     C                   endif
016600000000
016700000000     C                   if        %Parms()>= 3
016800000000     C                   if        szToPgmQ <> *BLANKS
016900000000     C                   eval      toPgmQ=  szToPgmQ
017000000000     C                   endif
017100000000     C                   if        toPgmQ = '*SAME'
017200000000     C                   eval      toPgmQ = '*'
017300000000     C                   endif
017400000000     C                   endif
017500000000
017600000000         // Status messages always go ToPgmQ(*EXT)
017700000000     C                   if        msgType = '*STATUS'
017800000000     C                   eval      toPgmQ = '*EXT'
017900000000     C                   endif
018000000000
018100000000     C                   if        msgType = '*'
018200000000     C                   eval      msgType = '*INFO'
018300000000     C                   endif
018400000000
018500000000        // Get the length of the message to be sent.
018600000000     C                   eval      msgData = %Trim(msg)
018700000000     C                   eval      nDataLen = %len(%Trim(msg))
018800000000
018900000000     C                   Select
019000000000      **  *SAME
019100000000     C                   when      toPgmQ  = ' '
019200000000     C                             or toPgmQ = '*SAME'
019300000000     C                             or toPgmQ = '*'
019400000000     C                   eval      toPgmQ = '*'
019500000000     C                   eval      nRelInv = 0
019600000000     C                   eval      nIncInv = 1
019700000000      **  *PRV, *PRVPRC or *PRVPROC
019800000000     C                   when      toPgmQ = '*PRVPRC'
019900000000     C                             or toPgmQ = '*PRVPROC'
020000000000     C                             or toPgmQ = '*PRV'
020100000000     C                   eval      toPgmQ = '*'
020200000000     C                   eval      nRelInv = 1
020300000000     C                   eval      nIncInv = 1
020400000000      **  *PRVPGM
020500000000     C                   When      toPgmQ = '*PRVPGM'
020600000000     C                   eval      toPgmQ = '*CTLBDY'
020700000000     C                   eval      nRelInv = 0
020800000000     C                   eval      nIncInv = 1
020900000000      **  *CTLBDY
021000000000     C                   when      toPgmQ = '*CTLBDY'
021100000000     C                   eval      nIncInv = 2
021200000000      **  *EXT
021300000000     C                   when      toPgmQ = '*EXT'
021400000000     C                   eval      nRelInv = 0
021500000000     C                   endsl
021600000000
021700000000      **  Since we're a relative invocation, and we are
021800000000      **  one-level deep, we need to bump up the relative
021900000000      **  invocation by the calculated increment.
022000000000     C                   eval      nRelInv = nRelInv + nIncInv
022100000000
022200000000     C                   callp(e)  QMHSNDPM(msgid   : msgf :
022300000000     C                                      msgData : nDataLen :
022400000000     C                                      msgType   :
022500000000     C                                      toPgmQ    :
022600000000     C                                      nRelInv   :
022700000000     C                                      rtnMsgKey :
022800000000     C                                      myAPIErrorDS)
022900000000
023000000000     C                   return    rtnMsgKey
023100000000     P SndMsg          E
023200000000
