*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 28.11.2017 at 15:39:28
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /BVCCSAP/K7_0503................................*
DATA:  BEGIN OF STATUS_/BVCCSAP/K7_0503              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/BVCCSAP/K7_0503              .
CONTROLS: TCTRL_/BVCCSAP/K7_0503
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */BVCCSAP/K7_0503              .
TABLES: */BVCCSAP/K7_503T              .
TABLES: /BVCCSAP/K7_0503               .
TABLES: /BVCCSAP/K7_503T               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
