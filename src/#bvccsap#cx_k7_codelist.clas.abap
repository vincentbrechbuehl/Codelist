class /BVCCSAP/CX_K7_CODELIST definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  data MESSAGE_ID type SYMSGID .
  data MESSAGE_NUMBER type SYMSGNO .
  data MESSAGE_TYPE type SYMSGTY .
  data MESSAGE_V1 type SYMSGV .
  data MESSAGE_V2 type SYMSGV .
  data MESSAGE_V3 type SYMSGV .
  data MESSAGE_V4 type SYMSGV .

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
  methods GET_MESSAGE .
protected section.
private section.
ENDCLASS.



CLASS /BVCCSAP/CX_K7_CODELIST IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MESSAGE_ID = MESSAGE_ID .
me->MESSAGE_NUMBER = MESSAGE_NUMBER .
me->MESSAGE_TYPE = MESSAGE_TYPE .
me->MESSAGE_V1 = MESSAGE_V1 .
me->MESSAGE_V2 = MESSAGE_V2 .
me->MESSAGE_V3 = MESSAGE_V3 .
me->MESSAGE_V4 = MESSAGE_V4 .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.


  method GET_MESSAGE.
  endmethod.
ENDCLASS.
