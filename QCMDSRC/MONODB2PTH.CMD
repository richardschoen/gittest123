/*------------------------------------------------------------*/
/* @@LIBRARY: GITTEST123                                      */
/* @@FILE: QCMDSRC                                            */
/* @@MEMBER: MONODB2PTH                                       */
/* @@TYPE: CMD                                                */
/* @@TEXT: Set Yum,unixODBC and DB2 Connect ODBC Driver Paths */
/*------------------------------------------------------------*/
             CMD        PROMPT('Set Yum,unixODBC,DB2 Conn-Path')
             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
                          DFT(*DEFAULT) +
                          SPCVAL(('/QOpenSys/pkgs/bin' +
                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
                          '/opt/mono/bin') (*DEFAULT *DEFAULT)) +
                          CASE(*MIXED) PROMPT('Mono path')
