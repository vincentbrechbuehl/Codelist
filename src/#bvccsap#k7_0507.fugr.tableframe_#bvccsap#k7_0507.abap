*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/BVCCSAP/K7_0507
*   generation date: 29.09.2017 at 14:35:34
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/BVCCSAP/K7_0507   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
