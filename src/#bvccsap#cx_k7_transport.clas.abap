class /BVCCSAP/CX_K7_TRANSPORT definition
  public
  inheriting from /BVCCSAP/CX_K7_CODELIST
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MESSAGE_ID type SYMSGID optional
      !MESSAGE_NUMBER type SYMSGNO optional
      !MESSAGE_TYPE type SYMSGTY optional
      !MESSAGE_V1 type SYMSGV optional
      !MESSAGE_V2 type SYMSGV optional
      !MESSAGE_V3 type SYMSGV optional
      !MESSAGE_V4 type SYMSGV optional .
protected section.
private section.
ENDCLASS.



CLASS /BVCCSAP/CX_K7_TRANSPORT IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
MESSAGE_ID = MESSAGE_ID
MESSAGE_NUMBER = MESSAGE_NUMBER
MESSAGE_TYPE = MESSAGE_TYPE
MESSAGE_V1 = MESSAGE_V1
MESSAGE_V2 = MESSAGE_V2
MESSAGE_V3 = MESSAGE_V3
MESSAGE_V4 = MESSAGE_V4
.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
