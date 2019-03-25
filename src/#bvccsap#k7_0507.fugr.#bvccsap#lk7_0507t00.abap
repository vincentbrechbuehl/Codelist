*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 29.09.2017 at 14:35:34
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /BVCCSAP/K7_0507................................*
DATA:  BEGIN OF STATUS_/BVCCSAP/K7_0507              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/BVCCSAP/K7_0507              .
CONTROLS: TCTRL_/BVCCSAP/K7_0507
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */BVCCSAP/K7_0507              .
TABLES: /BVCCSAP/K7_0507               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
