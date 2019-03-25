*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/BVCCSAP/K7_0505
*   generation date: 28.11.2017 at 14:55:02
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/BVCCSAP/K7_0505   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
