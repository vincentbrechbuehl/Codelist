class /BVCCSAP/CL_K7_CODELIST_ASS definition
  public
  inheriting from CL_WD_COMPONENT_ASSISTANCE
  final
  create public .

public section.

  constants GC_LOAD_TYPE_DELTA type STRING value 'Delta' ##NO_TEXT.
  constants GC_LOAD_TYPE_INITIAL type STRING value 'Initial' ##NO_TEXT.
  data MO_CODELIST_DATA type ref to /BVCCSAP/CL_K7_CODELIST_DATA .
  data MO_TRANSPORT_HNDL type ref to /BVCCSAP/CL_K7_TRANSPORT_HNDL .
  constants GC_REC_STATE_CHECKED type /BVCCSAP/K7_REC_STATE value 'checked' ##NO_TEXT.
  constants GC_REC_STATE_NOT_USED type /BVCCSAP/K7_REC_STATE value 'not used' ##NO_TEXT.
  constants GC_CODELIST_TYPE_IC type /BVCCSAP/K7_CODELIST_TYPE value 'IC' ##NO_TEXT.
  constants GC_CODELIST_TYPE_SC type /BVCCSAP/K7_CODELIST_TYPE value 'SC' ##NO_TEXT.
  constants GC_CODELIST_TYPE_RTC type /BVCCSAP/K7_CODELIST_TYPE value 'RTC' ##NO_TEXT.
  constants GC_CODELIST_TYPE_EC type /BVCCSAP/K7_CODELIST_TYPE value 'EC' ##NO_TEXT.
  constants GC_CODELIST_TYPE_EVC type /BVCCSAP/K7_CODELIST_TYPE value 'EVC' ##NO_TEXT.
  constants GC_SYSTEMID_SAP type /BVCCSAP/K7_SYSTEMID value '010' ##NO_TEXT.
  constants GC_INSERT type /BVCCSAP/K7_IUD value 'I' ##NO_TEXT.
  constants GC_UPDATE type /BVCCSAP/K7_IUD value 'U' ##NO_TEXT.
  constants GC_DELETE type /BVCCSAP/K7_IUD value 'D' ##NO_TEXT.

  class-methods CREATE_BAPIRET2
    importing
      !IV_MSGID type CLIKE
      !IV_MSGNO type CLIKE
      !IV_MSGTY type SYMSGTY optional
      !IV_PARAM1 type CLIKE optional
      !IV_PARAM2 type CLIKE optional
      !IV_PARAM3 type CLIKE optional
      !IV_PARAM4 type CLIKE optional
      !IV_LOG_NO type CLIKE optional
      !IV_LOG_MSG_NO type CLIKE optional
      !IV_PARAMETER type CLIKE optional
      !IV_ROW type CLIKE optional
      !IV_FIELD type CLIKE optional
    returning
      value(RS_RETURN) type BAPIRET2 .
protected section.
private section.
ENDCLASS.



CLASS /BVCCSAP/CL_K7_CODELIST_ASS IMPLEMENTATION.


  METHOD create_bapiret2.

    DATA: lv_msgid TYPE sy-msgid.
    DATA: lv_msgno TYPE sy-msgno.
    DATA: lv_msgty TYPE sy-msgty.
    DATA: lv_msgv1 TYPE sy-msgv1.
    DATA: lv_msgv2 TYPE sy-msgv2.
    DATA: lv_msgv3 TYPE sy-msgv3.
    DATA: lv_msgv4 TYPE sy-msgv4.
    DATA: lv_log_no	TYPE bapireturn-log_no.
    DATA: lv_log_msg_no	TYPE bapireturn-log_msg_no.
    DATA: lv_parameter TYPE bapiret2-parameter.
    DATA: lv_row TYPE bapiret2-row.
    DATA: lv_field TYPE bapiret2-field.


* Typenumwandlung
    lv_msgid = iv_msgid.
    lv_msgno = iv_msgno.
    lv_msgty = iv_msgty.
    lv_msgv1 = iv_param1.
    lv_msgv2 = iv_param2.
    lv_msgv3 = iv_param3.
    lv_msgv4 = iv_param4.
    lv_log_no  = iv_log_no .
    lv_log_msg_no  = iv_log_msg_no .
    lv_parameter = iv_parameter.
    lv_row = iv_row.
    lv_field = iv_field.


    CLEAR rs_return.
    CALL FUNCTION 'BALW_BAPIRETURN_GET2'
      EXPORTING
        type       = lv_msgty
        cl         = lv_msgid
        number     = lv_msgno
        field      = lv_field
        row        = lv_row
        parameter  = lv_parameter
        par1       = lv_msgv1
        par2       = lv_msgv2
        par3       = lv_msgv3
        par4       = lv_msgv4
        log_msg_no = lv_log_msg_no
        log_no     = lv_log_no
      IMPORTING
        return     = rs_return.
  ENDMETHOD.
ENDCLASS.
