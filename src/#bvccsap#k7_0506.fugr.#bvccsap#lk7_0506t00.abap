*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 13.09.2017 at 08:30:36
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /BVCCSAP/K7_0506................................*
DATA:  BEGIN OF STATUS_/BVCCSAP/K7_0506              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/BVCCSAP/K7_0506              .
CONTROLS: TCTRL_/BVCCSAP/K7_0506
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */BVCCSAP/K7_0506              .
TABLES: /BVCCSAP/K7_0506               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
