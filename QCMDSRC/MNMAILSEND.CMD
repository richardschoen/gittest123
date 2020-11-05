/*------------------------------------------------------------*/
/* @@LIBRARY: GITTEST123                                      */
/* @@FILE: QCMDSRC                                            */
/* @@MEMBER: MNMAILSEND                                       */
/* @@TYPE: CMD                                                */
/* @@TEXT: Send Email Message using MailKit                   */
/*------------------------------------------------------------*/
             CMD        PROMPT('Send Email using Mailkit')
             PARM       KWD(FROMADDR) TYPE(*CHAR) LEN(255) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('From email')
             PARM       KWD(TOADDR) TYPE(*CHAR) LEN(400) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('To email')
             PARM       KWD(CCADDR) TYPE(*CHAR) LEN(400) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('Cc email')
             PARM       KWD(BCCADDR) TYPE(*CHAR) LEN(400) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('Bcc email')
             PARM       KWD(SUBJECT) TYPE(*CHAR) LEN(255) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('Subject')
             PARM       KWD(BODYTEXT) TYPE(*CHAR) LEN(400) +
                          RSTD(*NO) MAX(1) CASE(*MIXED) +
                          PROMPT('Body text')
             PARM       KWD(BODYFILE) TYPE(*CHAR) LEN(255) +
                          RSTD(*NO) MAX(1) CASE(*MIXED) +
                          PROMPT('Body file')
             PARM       KWD(ATTACHMENT) TYPE(*CHAR) LEN(400) +
                          RSTD(*NO) MAX(1) CASE(*MIXED) +
                          PROMPT('Attachment files')
             PARM       KWD(SMTPHOST) TYPE(*CHAR) LEN(255) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('SMTP host')
             PARM       KWD(SMTPPORT) TYPE(*CHAR) LEN(5) RSTD(*NO) +
                          DFT(25) MAX(1) CASE(*MIXED) PROMPT('SMTP +
                          port')
             PARM       KWD(SMTPAUTTYP) TYPE(*CHAR) LEN(30) +
                          RSTD(*NO) DFT('none') MAX(1) CASE(*MIXED) +
                          PROMPT('SMTP authentication type')
             PARM       KWD(SMTPUSEAUT) TYPE(*CHAR) LEN(5) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          SPCVAL((*NO 'false') (*YES 'true')) +
                          MAX(1) CASE(*MIXED) PROMPT('SMTP use +
                          authentication')
             PARM       KWD(SMTPUSER) TYPE(*CHAR) LEN(100) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('SMTP user')
             PARM       KWD(SMTPPASS) TYPE(*CHAR) LEN(100) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) DSPINPUT(*NO) +
                          PROMPT('SMTP password')
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('File to receive stdout output')
             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
                          DFT('/opt/mono/bin') +
                          SPCVAL(('/QOpenSys/pkgs/bin' +
                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
                          '/opt/mono/bin')) CASE(*MIXED) +
                          PROMPT('Mono bin path')
             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
                          standard output result')
             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Log +
                          standard output to job log')
             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
                          standard output result')
             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
                          standard output result')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(MONOSTDOUT) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
