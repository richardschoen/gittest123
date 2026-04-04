/*------------------------------------------------------------*/
/* @@LIBRARY: GITTEST123                                      */
/* @@FILE: QCMDSRC                                            */
/* @@MEMBER: MONOPATH                                         */
/* @@TYPE: CMD                                                */
/* @@TEXT: Set Path Path For Mono                             */
/*------------------------------------------------------------*/
             CMD        PROMPT('Set Pase Path For Mono')
             PARM       KWD(MONOPATH) TYPE(*CHAR) LEN(255) +
                          DFT(*DEFAULT) +
                          SPCVAL(('/QOpenSys/pkgs/bin' +
                          '/QOpenSys/pkgs/bin') ('/opt/mono/bin' +
                          '/opt/mono/bin') (*DEFAULT *DEFAULT)) +
                          CASE(*MIXED) PROMPT('Mono path')
