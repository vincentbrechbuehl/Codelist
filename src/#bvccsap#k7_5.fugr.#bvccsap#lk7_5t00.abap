*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 02.10.2017 at 18:23:49
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /BVCCSAP/K7_0500................................*
DATA:  BEGIN OF STATUS_/BVCCSAP/K7_0500              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/BVCCSAP/K7_0500              .
CONTROLS: TCTRL_/BVCCSAP/K7_0500
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: /BVCCSAP/K7_0501................................*
DATA:  BEGIN OF STATUS_/BVCCSAP/K7_0501              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/BVCCSAP/K7_0501              .
CONTROLS: TCTRL_/BVCCSAP/K7_0501
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: /BVCCSAP/K7_0502................................*
DATA:  BEGIN OF STATUS_/BVCCSAP/K7_0502              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/BVCCSAP/K7_0502              .
CONTROLS: TCTRL_/BVCCSAP/K7_0502
            TYPE TABLEVIEW USING SCREEN '0003'.
*.........table declarations:.................................*
TABLES: */BVCCSAP/K7_0500              .
TABLES: */BVCCSAP/K7_0501              .
TABLES: */BVCCSAP/K7_0502              .
TABLES: */BVCCSAP/K7_500T              .
TABLES: */BVCCSAP/K7_501T              .
TABLES: */BVCCSAP/K7_502T              .
TABLES: /BVCCSAP/K7_0500               .
TABLES: /BVCCSAP/K7_0501               .
TABLES: /BVCCSAP/K7_0502               .
TABLES: /BVCCSAP/K7_500T               .
TABLES: /BVCCSAP/K7_501T               .
TABLES: /BVCCSAP/K7_502T               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
