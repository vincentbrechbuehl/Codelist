*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 28.11.2017 at 14:55:04
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /BVCCSAP/K7_0505................................*
DATA:  BEGIN OF STATUS_/BVCCSAP/K7_0505              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/BVCCSAP/K7_0505              .
CONTROLS: TCTRL_/BVCCSAP/K7_0505
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */BVCCSAP/K7_0505              .
TABLES: */BVCCSAP/K7_505T              .
TABLES: /BVCCSAP/K7_0505               .
TABLES: /BVCCSAP/K7_505T               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
