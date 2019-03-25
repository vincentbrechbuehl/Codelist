class /BVCCSAP/CL_K7_E2_PUBLISHER definition
  public
  inheriting from /BVCCSAP/CL_IM_K7_1_GFER_MSG
  final
  create public .

public section.

  data MV_XML type XSTRING read-only .
  constants GC_BUSCASE_IC type CHAR40 value 'Codes_InfoCarriers' ##NO_TEXT.
  constants GC_BUSCASE_SC type CHAR40 value 'Codes_StandardCodes' ##NO_TEXT.
  constants GC_BUSCASE_EC type CHAR40 value 'Codes_ErrorCodes' ##NO_TEXT.
  constants GC_BUSCASE_MP type CHAR40 value 'Codes_Municipal' ##NO_TEXT.
  constants GC_BUSCASE_HMP type CHAR40 value 'Codes_HistoryMunicipality' ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !IO_CODELIST_DATA type ref to /BVCCSAP/CL_K7_CODELIST_DATA
    raising
      /BVCCSAP/CX_K7_E2_PUBLISH .
  methods PUBLISH
    importing
      !IV_ENV_ID type /BVCCSAP/K7_ENV_ID
    raising
      /BVCCSAP/CX_K7_E2_PUBLISH .
protected section.
private section.

  types:
    ts_xml(1024) TYPE x .
  types:
    tt_xml TYPE STANDARD TABLE OF ts_xml WITH KEY table_line .

  data MT_INFO_CARRIER type /BVCCSAP/K7_INFOCARR_EXT_TTYP .
  data MT_CODEID type /BVCCSAP/K7_CODEID_TT .
  data MT_ERROR_CODE type /BVCCSAP/K7_ERROR_CODE_TT .
  data MS_CH_TOPOL_DATA type /BVCCSAP/K7_CH_TOPOL_DATA_TS .
  data MO_CODELIST_DATA type ref to /BVCCSAP/CL_K7_CODELIST_DATA .

  methods TRANSFORM_IC
    raising
      /BVCCSAP/CX_K7_E2_PUBLISH .
  methods SAVE_XML_LOCAL
    importing
      !IV_XML type XSTRING .
  methods GET_SIGNAL_DATA
    importing
      !IV_SOURCE type /BVCCSAP/K7_SOURCE
    exporting
      !ET_EVENTDATA type /BVCCSAP/K7_EVENTDATA_TTYP
    raising
      /BVCCSAP/CX_K7_E2_PUBLISH .
  methods GENERATE_PAYLOAD_XML_STRING
    importing
      !IV_GZMAIN_XML_STRING type /BVCCSAP/K7_XML_STRING
      !IV_FORMULAR_XML_STRING type /BVCCSAP/K7_XML_STRING
    exporting
      !EV_PAYLOAD_XML_STRING type /BVCCSAP/K7_XML_STRING .
  methods TRANSFORM_EC .
  methods TRANSFORM_SC .
  methods TRANSFORM_HMP .
  methods TRANSFORM_MP .
  methods SEND_XML_TO_E2
    importing
      !IV_BUSCASE type CHAR40
      !IV_ENV_ID type /BVCCSAP/K7_ENV_ID
    raising
      /BVCCSAP/CX_K7_E2_PUBLISH .
ENDCLASS.



CLASS /BVCCSAP/CL_K7_E2_PUBLISHER IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).
    me->mo_codelist_data = io_codelist_data.

  ENDMETHOD.


 METHOD generate_payload_xml_string.
   CLEAR ev_payload_xml_string.

   "-- Payload-xml-string zusammensetzen
   CONCATENATE "ev_payload_xml_string
               '<input>'
               iv_gzmain_xml_string
               '</input>'
   INTO ev_payload_xml_string SEPARATED BY space.
 ENDMETHOD.


  METHOD get_signal_data.
    CONSTANTS: lc_status TYPE /bvccsap/k7_sendstatus VALUE '01'.

    CLEAR: et_eventdata.

    SELECT *                                "#EC CI_NOFIELD unterdrückt
    FROM /bvccsap/k7_0018
    INTO TABLE et_eventdata
    WHERE status = lc_status AND
          source = iv_source.

    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
        EXPORTING
          MESSAGE_TYPE = 'E'
          textid  = /bvccsap/cx_k7_e2_publish=>read_error.
    ENDIF.
  ENDMETHOD.


  METHOD publish.
    DATA lv_msgv1 TYPE sy-msgv1.

    CASE mo_codelist_data->mv_codelist_type.
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ic.
        transform_ic(  ).
        send_xml_to_e2( iv_buscase = gc_buscase_ic
                        iv_env_id = iv_env_id ).
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_sc.
        transform_sc( ).
        send_xml_to_e2( iv_buscase = gc_buscase_sc
                        iv_env_id = iv_env_id ).
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_rtc.
        transform_hmp(  ).
        send_xml_to_e2( iv_buscase = gc_buscase_hmp
                        iv_env_id = iv_env_id ).
        transform_mp(  ).
        send_xml_to_e2( iv_buscase = gc_buscase_mp
                        iv_env_id = iv_env_id ).
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ec.
        transform_ec( ).
        send_xml_to_e2( iv_buscase = gc_buscase_ec
                        iv_env_id = iv_env_id ).
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_evc.
      WHEN OTHERS.

        lv_msgv1 = mo_codelist_data->mv_codelist_type.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
          EXPORTING
            message_id     = '/BVCCSAP/K7_5'
            message_number = '018'
            message_type   = 'E'
            message_v1     = lv_msgv1.
    ENDCASE.


  ENDMETHOD.


  METHOD save_xml_local.
    CONSTANTS lc_uml_x_length TYPE  i VALUE 1024.
    CONSTANTS null TYPE x VALUE '00'.
    DATA lt_xml TYPE tt_xml.
    DATA lv_xml TYPE xstring.
    DATA: lv_lines  TYPE i,
          lv_length TYPE i.

    cl_uml_utilities=>convert_xstring_to_xtab( EXPORTING i_xstring = IV_XML CHANGING e_xtab = lt_xml ).


    DESCRIBE TABLE lt_xml LINES lv_lines.
    READ TABLE lt_xml INTO lv_xml INDEX lV_lines.
    SHIFT lv_xml: RIGHT DELETING TRAILING null IN BYTE MODE,
             LEFT  DELETING LEADING null IN BYTE MODE.
    lv_length = ( lv_lines - 1 ) * lc_uml_x_length + xstrlen( lv_xml ).
    ME->MV_XML = iv_xml.
  ENDMETHOD.


  METHOD send_xml_to_e2.
    DATA:
      lt_eventdata           TYPE TABLE OF /bvccsap/k7_0018,
      ls_gzmain_gfer         TYPE /bvccsap/k7_gzmain_gfer,
      lv_gzmain_xml_str      TYPE /bvccsap/k7_xml_string,
      lv_payload_xml_str     TYPE /bvccsap/k7_xml_string,
      ls_request             TYPE /bvccsap/zxi_mt_gdc_sap_reque3,
      lv_error               TYPE boolean,
      lv_error_occured       TYPE boolean,
      lv_formular_xml_string TYPE string.
    DATA lv_msgv1 TYPE sy-msgv1.
    IF iv_buscase IS INITIAL.
      lv_msgv1 = '<' && iv_buscase && '>'.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_number = '102'
          message_type   = 'E'
          message_v1     = lv_msgv1.
    ENDIF.
    IF mv_xml IS INITIAL.
      lv_msgv1 = '<' && iv_buscase && '>'.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_number = '103'
          message_type   = 'E'
          message_v1     = lv_msgv1.
    ENDIF.
    " GDC-Daten ermitteln
    CLEAR: ls_request.
    DATA lv_env TYPE /bvccsap/k7_env_txt.
    lv_env = iv_env_id.
    get_gdc_data( EXPORTING iv_env           = lv_env
                            iv_buscase       = iv_buscase
                            iv_infocarrierid = ''
                  CHANGING  cs_request       = ls_request ).
    IF ls_request-mt_gdc_sap_request-message_id IS INITIAL.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_number = '100'
          message_type   = 'E'.
    ENDIF.

    " Payload-XML-String erstellen
    CLEAR: lv_payload_xml_str.
    DATA lv_xml_string TYPE /bvccsap/k7_xml_string.
    DATA lv_string  TYPE  string.
    CALL FUNCTION 'ECATT_CONV_XSTRING_TO_STRING'
      EXPORTING
        im_xstring  = mv_xml
        im_encoding = 'UTF-8'
      IMPORTING
        ex_string   = lv_string.
    lv_xml_string = lv_string.
    generate_payload_xml_string( EXPORTING iv_gzmain_xml_string   = lv_xml_string
                                           iv_formular_xml_string = lv_formular_xml_string
                                 IMPORTING ev_payload_xml_string  = lv_payload_xml_str ).

    " Nachricht versenden
    ls_request-mt_gdc_sap_request-payload_any-version = '1.0'.
    ls_request-mt_gdc_sap_request-payload_any-content = lv_payload_xml_str.

    lv_string = lv_payload_xml_str.
    CALL FUNCTION 'ECATT_CONV_STRING_TO_XSTRING'
      EXPORTING
        im_string   = lv_string
        im_encoding = 'UTF-8'
      IMPORTING
        ex_xstring  = mv_xml.

    CLEAR: lv_error.

*    CALL METHOD me->send_msg_to_e2_sync
*      EXPORTING
*        is_output_data = ls_request
*      IMPORTING
*        ev_error       = lv_error.

    IF lv_error IS NOT INITIAL.

      RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
        EXPORTING
          message_id     = 'SWF_BAM'
          message_number = '000'
          message_type   = 'E'
          message_v1     = 'CODELIST_OUT'.
    ENDIF.
  ENDMETHOD.


  METHOD transform_ec.
    FIELD-SYMBOLS <xstr> TYPE xstring.
    DATA lr_xstr TYPE REF TO xstring.
    CREATE DATA lr_xstr.
    ASSIGN lr_xstr->* TO <xstr>.
    mo_codelist_data->get_table_data( IMPORTING et_table_data = mt_error_code ).
    IF mt_error_code IS INITIAL.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_number = '100'
          message_type   = 'E'.
    ENDIF.
    CALL TRANSFORMATION /bvccsap/k7_errorcode_xslt
            SOURCE error_code = mt_error_code
            RESULT XML <xstr>.
    save_xml_local( <xstr> ).
  ENDMETHOD.


  METHOD TRANSFORM_HMP.
    FIELD-SYMBOLS <xstr> TYPE xstring.
    DATA lr_xstr TYPE REF TO xstring.
    CREATE DATA lr_xstr.
    ASSIGN lr_xstr->* TO <xstr>.
    mo_codelist_data->get_data( IMPORTING es_data = me->ms_ch_topol_data ).
    IF ms_ch_topol_data IS INITIAL.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_number = '100'
          message_type   = 'E'.
    ENDIF.
    CALL TRANSFORMATION /bvccsap/k7_municipality_xslt
            SOURCE municipalities = ms_ch_topol_data-municipalities
            RESULT XML <xstr>.
    save_xml_local( <xstr> ).
  ENDMETHOD.


  METHOD transform_ic.
    FIELD-SYMBOLS <xstr> TYPE xstring.
    DATA lr_xstr TYPE REF TO xstring.

    CREATE DATA lr_xstr.
    ASSIGN lr_xstr->* TO <xstr>.
    mo_codelist_data->get_table_data( IMPORTING et_table_data = me->mt_info_carrier ).
    DELETE mt_info_carrier WHERE deleted EQ abap_true
                              OR rec_state NE /bvccsap/cl_k7_codelist_ass=>gc_rec_state_checked.
    IF mt_info_carrier[] IS INITIAL.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_number = '100'
          message_type   = 'E'.
    ENDIF.
    CALL TRANSFORMATION /BVCCSAP/K7_INFOCARRIER_XSLT
        SOURCE info_carrier       = mt_info_carrier
        RESULT XML <xstr>.
    save_xml_local( <xstr> ).
  ENDMETHOD.


  METHOD transform_mp.
    DATA(lt_municipal) = /bvccsap/cl_k7_codelist_data=>read_municipal_inventory( ).
    FIELD-SYMBOLS <xstr> TYPE xstring.
    DATA lr_xstr TYPE REF TO xstring.
    CREATE DATA lr_xstr.
    ASSIGN lr_xstr->* TO <xstr>.
    CALL TRANSFORMATION /bvccsap/k7_municipal_xslt
        SOURCE municipal = lt_municipal
        RESULT XML <xstr>.
    save_xml_local( <xstr> ).
  ENDMETHOD.


  METHOD transform_sc.
    FIELD-SYMBOLS <xstr> TYPE xstring.
    DATA lr_xstr TYPE REF TO xstring.
    CREATE DATA lr_xstr.
    ASSIGN lr_xstr->* TO <xstr>.

    mo_codelist_data->get_table_data( IMPORTING et_table_data = me->mt_codeid ).
    LOOP AT mt_codeid ASSIGNING FIELD-SYMBOL(<lfs_codeid>).
      LOOP AT <lfs_codeid>-codeidvalues ASSIGNING FIELD-SYMBOL(<lfs_codeidvalues>).
        LOOP AT /bvccsap/cl_k7_codelist_data=>gt_language ASSIGNING FIELD-SYMBOL(<lfs_language>).
          READ TABLE <lfs_codeidvalues>-codeidvaluedesc TRANSPORTING NO FIELDS with key spras = <lfs_language>-spras.
          if sy-subrc ne 0.
            APPEND INITIAL LINE TO <lfs_codeidvalues>-codeidvaluedesc ASSIGNING FIELD-SYMBOL(<lfs_codeidvaluedesc>).
            <lfs_codeidvaluedesc>-spras = <lfs_language>-spras.
          endif.
        ENDLOOP.

      ENDLOOP.

    ENDLOOP.
    IF mt_codeid IS INITIAL.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_e2_publish
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_number = '100'
          message_type   = 'E'.
    ENDIF.
    CALL TRANSFORMATION /bvccsap/k7_standardcode_xslt
            SOURCE codeid = mt_codeid
            RESULT XML <xstr>.
    save_xml_local( <xstr> ).
  ENDMETHOD.
ENDCLASS.
