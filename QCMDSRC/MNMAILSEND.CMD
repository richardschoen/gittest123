000100000000/*------------------------------------------------------------*/
000200000000/* @@LIBRARY: GITTEST123                                      */
000300000000/* @@FILE: QCMDSRC                                            */
000400000000/* @@MEMBER: MNMAILSEND                                       */
000500000000/* @@TYPE: CMD                                                */
000600000000/* @@TEXT: Send Email Message using MailKit                   */
000700000000/*------------------------------------------------------------*/
000800000000             CMD        PROMPT('Send Email using Mailkit')
000900000000             PARM       KWD(FROMADDR) TYPE(*CHAR) LEN(255) RSTD(*NO) +
001000000000                          MAX(1) CASE(*MIXED) PROMPT('From email')
001100000000             PARM       KWD(TOADDR) TYPE(*CHAR) LEN(400) RSTD(*NO) +
001200000000                          MAX(1) CASE(*MIXED) PROMPT('To email')
001300000000             PARM       KWD(CCADDR) TYPE(*CHAR) LEN(400) RSTD(*NO) +
001400000000                          MAX(1) CASE(*MIXED) PROMPT('Cc email')
001500000000             PARM       KWD(BCCADDR) TYPE(*CHAR) LEN(400) RSTD(*NO) +
001600000000                          MAX(1) CASE(*MIXED) PROMPT('Bcc email')
001700000000             PARM       KWD(SUBJECT) TYPE(*CHAR) LEN(255) RSTD(*NO) +
001800000000                          MAX(1) CASE(*MIXED) PROMPT('Subject')
001900000000             PARM       KWD(BODYTEXT) TYPE(*CHAR) LEN(400) +
002000000000                          RSTD(*NO) MAX(1) CASE(*MIXED) +
002100000000                          PROMPT('Body text')
002200000000             PARM       KWD(BODYFILE) TYPE(*CHAR) LEN(255) +
002300000000                          RSTD(*NO) MAX(1) CASE(*MIXED) +
002400000000                          PROMPT('Body file')
002500000000             PARM       KWD(ATTACHMENT) TYPE(*CHAR) LEN(400) +
002600000000                          RSTD(*NO) MAX(1) CASE(*MIXED) +
002700000000                          PROMPT('Attachment files')
002800000000             PARM       KWD(SMTPHOST) TYPE(*CHAR) LEN(255) RSTD(*NO) +
002900000000                          MAX(1) CASE(*MIXED) PROMPT('SMTP host')
003000000000             PARM       KWD(SMTPPORT) TYPE(*CHAR) LEN(5) RSTD(*NO) +
003100000000                          DFT(25) MAX(1) CASE(*MIXED) PROMPT('SMTP +
003200000000                          port')
003300000000             PARM       KWD(SMTPAUTTYP) TYPE(*CHAR) LEN(30) +
003400000000                          RSTD(*NO) DFT('none') MAX(1) CASE(*MIXED) +
003500000000                          PROMPT('SMTP authentication type')
003600000000             PARM       KWD(SMTPUSEAUT) TYPE(*CHAR) LEN(5) +
003700000000                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
003800000000                          SPCVAL((*NO 'false') (*YES 'true')) +
003900000000                          MAX(1) CASE(*MIXED) PROMPT('SMTP use +
004000000000                          authentication')
004100000000             PARM       KWD(SMTPUSER) TYPE(*CHAR) LEN(100) RSTD(*NO) +
004200000000                          MAX(1) CASE(*MIXED) PROMPT('SMTP user')
004300000000             PARM       KWD(SMTPPASS) TYPE(*CHAR) LEN(100) RSTD(*NO) +
004400000000                          MAX(1) CASE(*MIXED) DSPINPUT(*NO) +
004500000000                          PROMPT('SMTP password')
004600000000             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
004700000000                          PROMPT('File to receive stdout output')
004800000000             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
004900000000                          DFT('/opt/mono/bin') +
005000000000                          SPCVAL(('/QOpenSys/pkgs/bin' +
005100000000                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
005200000000                          '/opt/mono/bin')) CASE(*MIXED) +
005300000000                          PROMPT('Mono bin path')
005400000000             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
005500000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
005600000000                          standard output result')
005700000000             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
005800000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Log +
005900000000                          standard output to job log')
006000000000             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
006100000000                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
006200000000                          standard output result')
006300000000             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
006400000000                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
006500000000                          standard output result')
006600000000 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(MONOSTDOUT) EXPR(*YES)
006700000000             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
006800000000                          PROMPT('Library')
