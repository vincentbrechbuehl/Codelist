*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/BVCCSAP/K7_0510
*   generation date: 03.10.2017 at 13:31:58
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/BVCCSAP/K7_0510   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
