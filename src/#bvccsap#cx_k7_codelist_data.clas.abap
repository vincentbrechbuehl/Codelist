class /BVCCSAP/CX_K7_CODELIST_DATA definition
  public
  inheriting from /BVCCSAP/CX_K7_CODELIST
  final
  create public .

public section.

  constants:
    begin of NOT_SAVED,
      msgid type symsgid value '/BVCCSAP/K7_5',
      msgno type symsgno value '001',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_SAVED .
  constants:
    begin of UPDATE_ERROR,
      msgid type symsgid value '/BVCCSAP/K7_5',
      msgno type symsgno value '025',
      attr1 type scx_attrname value 'MESSAGE_V1',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of UPDATE_ERROR .
  constants:
    begin of INSERT_ERROR,
      msgid type symsgid value '/BVCCSAP/K7_5',
      msgno type symsgno value '026',
      attr1 type scx_attrname value 'MESSAGE_V1',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of INSERT_ERROR .
  constants:
    begin of READ_ERROR,
      msgid type symsgid value '/BVCCSAP/K7_5',
      msgno type symsgno value '027',
      attr1 type scx_attrname value 'MESSAGE_V1',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of READ_ERROR .
  constants:
    begin of DELETE_ERROR,
      msgid type symsgid value '/BVCCSAP/K7_5',
      msgno type symsgno value '028',
      attr1 type scx_attrname value 'MESSAGE_V1',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of DELETE_ERROR .

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



CLASS /BVCCSAP/CX_K7_CODELIST_DATA IMPLEMENTATION.


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
