/*------------------------------------------------------------*/
/* @@LIBRARY: GITTEST123                                      */
/* @@FILE: QCMDSRC                                            */
/* @@MEMBER: MONOEXPLOG                                       */
/* @@TYPE: CMD                                                */
/* @@TEXT: Export Mono Qtemp Log to IFS in PC Format          */
/*------------------------------------------------------------*/
             CMD        PROMPT('Export Mono Stdout Log to IFS')
             PARM       KWD(TOFILE) TYPE(*CHAR) LEN(255) +
                          DFT('/tmp/mono/stdoutexport.txt') +
                          CASE(*MIXED) PROMPT('IFS output file')
