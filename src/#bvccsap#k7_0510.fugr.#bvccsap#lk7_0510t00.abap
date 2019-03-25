*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03.10.2017 at 13:31:58
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /BVCCSAP/K7_0510................................*
DATA:  BEGIN OF STATUS_/BVCCSAP/K7_0510              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/BVCCSAP/K7_0510              .
CONTROLS: TCTRL_/BVCCSAP/K7_0510
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */BVCCSAP/K7_0510              .
TABLES: */BVCCSAP/K7_510T              .
TABLES: /BVCCSAP/K7_0510               .
TABLES: /BVCCSAP/K7_510T               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
