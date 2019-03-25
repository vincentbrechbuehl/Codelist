class /BVCCSAP/CL_K7_CODELIST_DATA definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF ts_lang,
             spras TYPE spras,
           END OF ts_lang .
  types:
    tt_lang TYPE STANDARD TABLE OF ts_lang WITH KEY spras .
  types:
    BEGIN OF ts_vt,
        key   TYPE char72,
        langu TYPE langu,
        text  TYPE char72,
      END OF ts_vt .
  types:
    tt_vt TYPE STANDARD TABLE OF ts_vt WITH KEY key langu .

  data MV_CODELIST_TYPE type /BVCCSAP/K7_CODELIST_TYPE read-only .
  data MT_CODELIST_VERSION type /BVCCSAP/K7_VERSION_EXT_TTYP read-only .
  data MS_CURRENT_CODELIST_VERSION type /BVCCSAP/K7_VERSION_EXT_STRUC read-only .
  data MS_NEW_CODELIST_VERSION type /BVCCSAP/K7_VERSION_EXT_STRUC .
  data MV_NEW_VERSION_ACTIVE type ABAP_BOOL read-only .
  data MV_INITIAL_LOAD type ABAP_BOOL read-only .
  data MO_TRANSPORT_HNDL type ref to /BVCCSAP/CL_K7_TRANSPORT_HNDL read-only .
  data MT_CHANGE_LOG type /BVCCSAP/K7_CHANGE_LOG_TT .
  data MV_INITIAL_VERSION type ABAP_BOOL read-only .
  class-data GT_ENVIRONMENT type /BVCCSAP/K7_ENVIRONMENT_TT read-only .
  data MT_CODEID type /BVCCSAP/K7_CODEID_TT read-only .
  data MT_ERROR_CODE type /BVCCSAP/K7_ERROR_CODE_TT read-only .
  class-data GT_SERVICEID type /BVCCSAP/K7_SERVICEID_TT read-only .
  class-data GT_SYSTEMID type /BVCCSAP/K7_SYSTEMID_TT read-only .
  constants GC_LANGUAGES type STRING value 'DE;FR;IT;EN' ##NO_TEXT.
  class-data GT_LANGUAGE type TT_LANG read-only .
  class-data GS_EXCEL_TEMPLATE type /BVCCSAP/K7_0599 read-only .
  class-data GT_CODE_LIST_TYPE type DD07V_TAB .

  methods SET_TABLE_DATA
    importing
      !IT_DATA type TABLE
      !IV_INITIAL_LOAD type ABAP_BOOL
    exporting
      !ET_DATA type TABLE
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods SET_DATA
    importing
      !IS_DATA type ANY
      !IV_INITIAL_LOAD type ABAP_BOOL
    exporting
      !ES_DATA type ANY .
  methods UPDATE
    exporting
      !ET_RETURN type BAPIRET2_TAB
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods READ
    importing
      !IV_CODELIST_TYPE type /BVCCSAP/K7_CODELIST_TYPE
      !IV_VERSION_ID type /BVCCSAP/K7_VERSION_ID optional
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods CONSTRUCTOR
    importing
      !IV_CODELIST_TYPE type /BVCCSAP/K7_CODELIST_TYPE
      !IV_VERSION_ID type /BVCCSAP/K7_VERSION_ID optional
      !IO_TRANSPORT_HNDL type ref to /BVCCSAP/CL_K7_TRANSPORT_HNDL optional
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods GET_TABLE_DATA
    exporting
      !ET_TABLE_DATA type TABLE .
  methods GET_DATA
    exporting
      !ES_DATA type ANY .
  methods GET_NEW_CODELIST_VERSION
    returning
      value(RS_NEW_CODELIST_VERSION) type /BVCCSAP/K7_VERSION_EXT_STRUC .
  methods GET_CODELIST_VERSIONS
    returning
      value(RT_CODELIST_VERSION) type /BVCCSAP/K7_VERSION_EXT_TTYP .
  methods DELETE_NEW_CODELIST_VERSION .
  class-methods READ_MUNICIPAL_INVENTORY
    importing
      !IV_DATE type DATS default '31129999'
    returning
      value(RT_MUNICIPALITIES) type /BVCCSAP/K7_0553_TT .
  class-methods READ_DTEL
    importing
      !IV_ROLLNAME type ROLLNAME
      !IV_LANGU type LANGU default '*'
    exporting
      !EV_DOMNAME type DOMNAME
      !ET_DOM_VALUE type TT_VT
    changing
      !CS_CODEID type /BVCCSAP/K7_CODEID_TS .
  class-methods READ_CODEID_LIST
    returning
      value(RT_CODEID_LIST) type /BVCCSAP/K7_CODEID_TT .
  class-methods READ_ENVIRONMENTS
    importing
      !IV_ALL type ABAP_BOOL default ABAP_FALSE
    returning
      value(RT_ENVIRONMENT) type /BVCCSAP/K7_ENVIRONMENT_TT .
  class-methods CLASS_CONSTRUCTOR .
  class-methods EXPORT_TO_EXCEL
    returning
      value(RV_EXCEL_DATA) type XSTRING .
protected section.
private section.

  data MT_INFO_CARRIER type /BVCCSAP/K7_INFOCARR_EXT_TTYP .
  data MS_CH_TOPOL_DATA type /BVCCSAP/K7_CH_TOPOL_DATA_TS .

  methods READ_RTC
    importing
      !IV_VERSION_ID type /BVCCSAP/K7_VERSION_ID
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods READ_EC
    importing
      !IV_VERSION_ID type /BVCCSAP/K7_VERSION_ID
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods READ_IC
    importing
      !IV_VERSION_ID type /BVCCSAP/K7_VERSION_ID
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods READ_SC
    importing
      !IV_VERSION_ID type /BVCCSAP/K7_VERSION_ID
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods UPDATE_RTC
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods UPDATE_SC
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods UPDATE_EC
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods UPDATE_IC
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods DELETE_RTC
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods DELETE_SC
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods DELETE_EC
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods DELETE_IC
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods UPDATE_VERSION
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods UPDATE_TRANSPORT
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods UPDATE_CHANGE_LOG
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods READ_CHANGE_LOG
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  class-methods READ_SERVICEID
    returning
      value(RT_SERVICEID) type /BVCCSAP/K7_SERVICEID_TT .
  class-methods READ_SYSTEMID
    returning
      value(RT_SYSTEMID) type /BVCCSAP/K7_SYSTEMID_TT .
  methods SET_STANDARD_CODES
    importing
      !IT_DATA type TABLE
      !IV_INITIAL_LOAD type ABAP_BOOL
    exporting
      !ET_DATA type TABLE
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods SET_ERROR_CODES
    importing
      !IT_DATA type TABLE
      !IV_INITIAL_LOAD type ABAP_BOOL
    exporting
      !ET_DATA type TABLE
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
  methods SET_INFO_CARRIER
    importing
      !IT_DATA type TABLE
      !IV_INITIAL_LOAD type ABAP_BOOL
    exporting
      !ET_DATA type TABLE
    raising
      /BVCCSAP/CX_K7_CODELIST_DATA .
ENDCLASS.



CLASS /BVCCSAP/CL_K7_CODELIST_DATA IMPLEMENTATION.


  METHOD class_constructor.
    gt_environment = read_environments( iv_all = abap_false ).
    gt_serviceid = read_serviceid( ).
    gt_systemid = read_systemid( ).
    SPLIT gc_languages AT ';' INTO TABLE gt_language.
    SELECT SINGLE * FROM /bvccsap/k7_0599 INTO gs_excel_template WHERE file_name = 'CODELISTENTEMPLATE.XLSX'.
    IF sy-subrc NE 0.
      "Kein Excel Export möglich ohne Template

    ENDIF.
    CLEAR gt_code_list_type.
    DATA lt_dd07v_n LIKE gt_code_list_type.
    CALL FUNCTION 'DD_DOMA_GET'
      EXPORTING
        domain_name   = '/BVCCSAP/K7_CODELIST_TYPE'
        langu         = 'D'
        withtext      = 'X'
      TABLES
        dd07v_tab_a   = gt_code_list_type
        dd07v_tab_n   = lt_dd07v_n
      EXCEPTIONS
        illegal_value = 1
        op_failure    = 2
        OTHERS        = 3.
    IF sy-subrc <> 0.
      "RAISE error_occurred.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    mv_codelist_type = iv_codelist_type.
    mo_transport_hndl = io_transport_hndl.
    read( iv_codelist_type = iv_codelist_type
          iv_version_id = iv_version_id ).
  ENDMETHOD.


  METHOD delete_ec.
    DELETE FROM /bvccsap/k7_0504 WHERE version_id = ms_current_codelist_version-version_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0504:MessageId"'
          textid       = /bvccsap/cx_k7_codelist_data=>delete_error.
    ELSE.
      DELETE FROM /bvccsap/k7_504t WHERE version_id = ms_current_codelist_version-version_id.
      IF sy-subrc NE 0.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_type = 'E'
            message_v1   = '"K7_504T:MessageId Texte"'
            textid       = /bvccsap/cx_k7_codelist_data=>delete_error.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD delete_ic.
    DELETE FROM /bvccsap/k7_0550 WHERE version_id = ms_current_codelist_version-version_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0550:Infocarrier Codes"'
          textid       = /bvccsap/cx_k7_codelist_data=>delete_error.
    ENDIF.

  ENDMETHOD.


  method DELETE_NEW_CODELIST_VERSION.
    delete TABLE mt_codelist_version FROM ms_new_codelist_version.
    mv_new_version_active = abap_false.
  endmethod.


  METHOD delete_rtc.
    DELETE FROM /bvccsap/k7_0552 WHERE version_id = ms_current_codelist_version-version_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0552:Kanton"'
          textid       = /bvccsap/cx_k7_codelist_data=>delete_error.
    ENDIF.
    DELETE FROM /bvccsap/k7_0551 WHERE version_id = ms_current_codelist_version-version_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0551:Bezirk"'
          textid       = /bvccsap/cx_k7_codelist_data=>delete_error.

    ENDIF.
    DELETE FROM /bvccsap/k7_0553 WHERE version_id = ms_current_codelist_version-version_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0553:Gemeinde"'
          textid       = /bvccsap/cx_k7_codelist_data=>delete_error.

    ENDIF.
  ENDMETHOD.


  METHOD DELETE_SC.
    DELETE FROM /bvccsap/k7_0502 WHERE version_id = ms_current_codelist_version-version_id.
    DELETE FROM /bvccsap/k7_502T WHERE version_id = ms_current_codelist_version-version_id.

  ENDMETHOD.


  METHOD export_to_excel.
    DATA lx_excel TYPE REF TO zcx_excel.
    DATA lv_msg TYPE string.
    DATA lo_excel TYPE REF TO zcl_excel.
    DATA lo_excel_reader TYPE REF TO zcl_excel_reader_2007.
    DATA lo_worksheet TYPE REF TO zcl_excel_worksheet.
    DATA lo_ws_iterator	TYPE REF TO cl_object_collection_iterator.
    DATA lv_found TYPE abap_bool.
    DATA lv_worksheet_name TYPE string.
    CLEAR lv_worksheet_name.
    DATA lv_codelist_type TYPE /bvccsap/k7_codelist_type.
    DATA lo_codelist_data TYPE REF TO /bvccsap/cl_k7_codelist_data.
    DATA lo_columns TYPE REF TO zcl_excel_columns.
    FIELD-SYMBOLS <lfs_ws_table> TYPE ANY TABLE.
    FIELD-SYMBOLS <lfs_ws_row> TYPE any.

    DATA lv_row_index TYPE zexcel_cell_row.
    FIELD-SYMBOLS <lfs_data_struc> TYPE any.
    DATA lt_attr_name TYPE string_table.
    DATA lv_attr_name TYPE string.
    DATA lo_struct_descr TYPE REF TO cl_abap_structdescr.
    TRY.
        CREATE OBJECT lo_excel_reader.
        lo_excel = lo_excel_reader->zif_excel_reader~load(
               i_excel2007            = gs_excel_template-file_content ).

        lo_ws_iterator = lo_excel->get_worksheets_iterator( ).
        WHILE lo_ws_iterator->has_next( ) EQ abap_true.
          lo_worksheet ?= lo_ws_iterator->get_next( ).
          CLEAR lv_codelist_type.
          IF lo_worksheet IS BOUND.
            lv_found = abap_false.
            DATA(lv_title) = lo_worksheet->get_title( ).
            LOOP AT gt_code_list_type ASSIGNING FIELD-SYMBOL(<lfs_code_list>).
              IF lv_title CP <lfs_code_list>-domvalue_l && | - *|
              OR lv_title CP 'GC' && | - *|.
                lv_found = abap_true.
                lv_codelist_type = <lfs_code_list>-domvalue_l.
                EXIT.
              ENDIF.
            ENDLOOP.
            IF lv_found NE abap_true.
              lv_msg = 'Kein Worksheet &1 nicht vorhanden!'.
              CONTINUE.
            ENDIF.
            TRY .
                CREATE OBJECT lo_codelist_data
                  EXPORTING
                    iv_codelist_type = lv_codelist_type.

                CASE lv_codelist_type.
                  WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_rtc.
                    CONTINUE.
                  WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_sc.
                    DATA lt_codeid TYPE /bvccsap/k7_codeid_import_tt.
                    CLEAR lt_codeid.
                    TRY.
                        DATA lo_table_descr TYPE REF TO cl_abap_tabledescr.

                        lo_table_descr ?= cl_abap_tabledescr=>describe_by_data( lt_codeid ).
                        lo_struct_descr ?= lo_table_descr->get_table_line_type( ).
                      CATCH cx_sy_move_cast_error.
                        CONTINUE.
                    ENDTRY.

                    LOOP AT lo_struct_descr->components ASSIGNING FIELD-SYMBOL(<lfs_attr>).
                      lv_attr_name = <lfs_attr>-name.
                      APPEND lv_attr_name TO lt_attr_name.
                    ENDLOOP.
                    DELETE lt_attr_name WHERE table_line EQ 'DATA_ELEMENT'.
                    lv_row_index = 2.
                    LOOP AT lo_codelist_data->mt_codeid ASSIGNING FIELD-SYMBOL(<lfs_codeid>).
                      LOOP AT <lfs_codeid>-codeidvalues ASSIGNING FIELD-SYMBOL(<lfs_codeidvalues>).
                        APPEND INITIAL LINE TO lt_codeid ASSIGNING <lfs_ws_row>.
                        MOVE-CORRESPONDING <lfs_codeid> TO <lfs_ws_row>.
                        MOVE-CORRESPONDING <lfs_codeidvalues> TO <lfs_ws_row>.
                        LOOP AT <lfs_codeidvalues>-codeidvaluedesc ASSIGNING FIELD-SYMBOL(<lfs_codeidvaluedesc>).
                          DATA lv_langu_attr TYPE string.
                          CASE <lfs_codeidvaluedesc>-spras.
                            WHEN 'D'.
                              lv_langu_attr = 'CODEVALUEIDDESC' && '_DE'.
                            WHEN 'F'.
                              lv_langu_attr = 'CODEVALUEIDDESC' && '_FR'.
                            WHEN 'I'.
                              lv_langu_attr = 'CODEVALUEIDDESC' && '_IT'.
                            WHEN 'E'.
                              lv_langu_attr = 'CODEVALUEIDDESC' && '_EN'.
                            WHEN OTHERS.
                          ENDCASE.
                          ASSIGN COMPONENT lv_langu_attr OF STRUCTURE <lfs_ws_row> TO FIELD-SYMBOL(<lfs_codeidvaluedesc_spras>).
                          IF sy-subrc EQ 0.
                            <lfs_codeidvaluedesc_spras> = <lfs_codeidvaluedesc>-codevalueiddesc.
                          ENDIF.
                        ENDLOOP.
                      ENDLOOP.
                    ENDLOOP.
                    ASSIGN lt_codeid TO <lfs_ws_table>.
                  WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ic.
                    CONTINUE.
                  WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ec.
                    CONTINUE.
                  WHEN OTHERS.
                    CONTINUE.
                ENDCASE.

                LOOP AT <lfs_ws_table> ASSIGNING <lfs_ws_row>.
                  lv_row_index = lv_row_index + 1.
                  DO lines( lt_attr_name ) TIMES.
                    ASSIGN COMPONENT sy-index OF STRUCTURE <lfs_ws_row> TO FIELD-SYMBOL(<lfs_ws_cell>).
                    TRY .
                        lo_worksheet->set_cell( EXPORTING ip_column    = sy-index
                                                          ip_row       = lv_row_index
                                                          ip_value     = <lfs_ws_cell> ).
                      CATCH zcx_excel.    "

                    ENDTRY.
                  ENDDO.
                ENDLOOP.

              CATCH /bvccsap/cx_k7_codelist_data.

            ENDTRY.

          ENDIF.
        ENDWHILE.
        DATA LO_EXCEL_WRITER TYPE REF TO ZCL_EXCEL_WRITER_2007.
        CREATE OBJECT lo_excel_writer.
        rv_excel_data = lo_excel_writer->zif_excel_writer~write_file( io_excel = lo_excel ).
      CATCH zcx_excel.

    ENDTRY.
  ENDMETHOD.


  METHOD get_codelist_versions.
    DATA lt_k7_0560 TYPE STANDARD TABLE OF /bvccsap/k7_0560.
    DATA ls_k7_0560 LIKE LINE OF lt_k7_0560.
    DATA ls_codelist_version LIKE LINE OF mt_codelist_version.
    CLEAR mt_codelist_version.

    SELECT * FROM /bvccsap/k7_0560 INTO TABLE lt_k7_0560
      WHERE codelist_type = mv_codelist_type. "#EC CI_NOWHERE
    "Wenn keine Versionen existieren wird eine erstellt.
    IF sy-subrc NE 0 and mv_new_version_active = abap_false.
      ms_current_codelist_version = ms_new_codelist_version = get_new_codelist_version( ).
      MV_INITIAL_LOAD = abap_true.
    ENDIF.

    LOOP AT lt_k7_0560 INTO ls_k7_0560.
      MOVE-CORRESPONDING ls_k7_0560 TO ls_codelist_version.
      ls_codelist_version-version_desc = |Version: | && ls_codelist_version-version
                                         && | | && ls_codelist_version-creation_date.
      APPEND ls_codelist_version TO mt_codelist_version.
    ENDLOOP.
    SORT mt_codelist_version DESCENDING BY creation_date creation_time.
    CLEAR ms_current_codelist_version.
    READ TABLE mt_codelist_version INTO ms_current_codelist_version INDEX 1.
    rt_codelist_version[] = mt_codelist_version[].
  ENDMETHOD.


  METHOD get_data.
    CASE mv_codelist_type.
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_rtc.
        es_data = ms_ch_topol_data.
      WHEN OTHERS.
        RETURN.
    ENDCASE.


  ENDMETHOD.


  METHOD get_new_codelist_version.
    ms_new_codelist_version-codelist_type = mv_codelist_type.
    ms_new_codelist_version-version_id = ms_current_codelist_version-version_id + 1.
    ms_new_codelist_version-creation_date = sy-datum.
    ms_new_codelist_version-creation_time = sy-timlo.
    ms_new_codelist_version-creator = sy-uname.
    ms_new_codelist_version-version_desc = 'Neue Version erstellen'.
    INSERT ms_new_codelist_version INTO mt_codelist_version INDEX 1.
    mv_new_version_active = abap_true.
    rs_new_codelist_version = ms_new_codelist_version.
  ENDMETHOD.


  METHOD get_table_data.
    CASE mv_codelist_type.
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ic.
        et_table_data[] = mt_info_carrier[].
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_sc.
        et_table_data[] = mt_codeid[].
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ec.
        et_table_data[] = mt_error_code[].
    ENDCASE.
  ENDMETHOD.


  METHOD read.
    DATA lv_version_id LIKE iv_version_id.

    get_codelist_versions( ).
    lv_version_id = iv_version_id.
    IF iv_version_id IS INITIAL.
      lv_version_id = ms_current_codelist_version-version_id .
    ENDIF.
    if mv_codelist_type = /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_sc.
      mt_codeid = /bvccsap/cl_k7_codelist_data=>read_codeid_list( ).
    endif.
    IF mv_new_version_active = abap_false
    AND lv_version_id IS NOT INITIAL.
      read_change_log( ).

      CASE mv_codelist_type.
        WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_IC.
          read_ic( lv_version_id ).
        WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_rtc.
          read_rtc( lv_version_id ).
        when /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_sc.
          read_sc( lv_version_id ).
        when /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ec.
          read_ec( lv_version_id ).
      ENDCASE.
    ENDIF.
  ENDMETHOD.


  METHOD read_change_log.

    SELECT * FROM /bvccsap/k7_0561 INTO CORRESPONDING FIELDS OF TABLE mt_change_log
      WHERE codelist_type = mv_codelist_type
        AND version_id = ms_current_codelist_version-version_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0561:Change Log"'
          textid       = /bvccsap/cx_k7_codelist_data=>read_error.

    ENDIF.

  ENDMETHOD.


  METHOD read_codeid_list.
    DATA lt_codeidselection TYPE /bvccsap/k7_codeidselection_tt.
    FIELD-SYMBOLS <lfs_codeid> LIKE LINE OF rt_codeid_list.
    CLEAR rt_codeid_list.

    SELECT * FROM /bvccsap/k7_0501 AS a                "#EC CI_NOFIRST.
      INNER JOIN /bvccsap/k7_501t AS at
          ON at~systemid = a~systemid
         AND at~codeid = a~codeid
         AND at~spras = sy-langu
      INTO CORRESPONDING FIELDS OF TABLE rt_codeid_list.

    CLEAR lt_codeidselection.
    SELECT * FROM /bvccsap/k7_0507
      INTO CORRESPONDING FIELDS OF TABLE lt_codeidselection
      FOR ALL ENTRIES IN rt_codeid_list
      WHERE systemid = rt_codeid_list-systemid
        AND ( codeid   = rt_codeid_list-codeid
         OR   codeid  = '' ).


    LOOP AT rt_codeid_list ASSIGNING <lfs_codeid>
       WHERE systemid = /bvccsap/cl_k7_codelist_ass=>gc_systemid_sap
      AND data_element IS NOT INITIAL.
      LOOP AT lt_codeidselection ASSIGNING FIELD-SYMBOL(<lfs_codeidselection>) WHERE systemid = <lfs_codeid>-systemid
        AND ( codeid   = <lfs_codeid>-codeid
         OR   codeid  = '' ).
        APPEND INITIAL LINE TO <lfs_codeid>-codeidselection ASSIGNING FIELD-SYMBOL(<lfs_new_codeselection>).
        MOVE-CORRESPONDING <lfs_codeidselection> TO <lfs_new_codeselection>.
      ENDLOOP.

      "Für die Code aus dem System 010=SAP sind keine CodeIdValues gespeichert.
      "Denn dazu werden die Domänenwerte über das Datenelement beschafft.
      /bvccsap/cl_k7_codelist_data=>read_dtel( EXPORTING iv_rollname = <lfs_codeid>-data_element
                                               CHANGING  cs_codeid = <lfs_codeid> ).

    ENDLOOP.
  ENDMETHOD.


  METHOD read_dtel.
    DATA ls_dom_value LIKE LINE OF et_dom_value.
    DATA lt_dd07v	TYPE dd07v_tab.
    DATA ls_dd01l TYPE dd01l.
    DATA lv_tabname TYPE tabname.
    DATA lv_tabname_t   TYPE tabname.
    DATA lt_textvalues TYPE STANDARD TABLE OF ts_vt.
    DATA lt_what       TYPE STANDARD TABLE OF char72.
    DATA lv_what        TYPE char72.
    DATA lt_where      TYPE STANDARD TABLE OF char72.
    DATA lv_where      TYPE string.
    DATA lt_values     TYPE STANDARD TABLE OF char72.
    DATA lt_dd03p      TYPE STANDARD TABLE OF dd03p.
    DATA ls_dd03p_key  LIKE LINE OF lt_dd03p.
    DATA ls_dd03p_text  LIKE LINE OF lt_dd03p.
    DATA ls_codeidvalue LIKE LINE OF cs_codeid-codeidvalues.
    DATA ls_codeidvaluedesc LIKE LINE OF ls_codeidvalue-codeidvaluedesc.
    DATA lt_dom_value_desc   TYPE tt_vt.
    CLEAR: ls_dd03p_key, ls_dd03p_text, et_dom_value, lt_textvalues, lt_where, lt_values, lt_dd03p.
    ASSIGN cs_codeid TO FIELD-SYMBOL(<lfs_codeid>).
    CLEAR: <lfs_codeid>-domname, <lfs_codeid>-tabname, <lfs_codeid>-tabname_text, <lfs_codeid>-codeidvalues.
    CHECK iv_rollname IS NOT INITIAL.

    CALL FUNCTION 'DD_DTEL_GET'
      EXPORTING
        withtext      = ''
        roll_name     = iv_rollname
      IMPORTING
        dd01l_wa      = ls_dd01l
      EXCEPTIONS
        illegal_value = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
    <lfs_codeid>-domname = ev_domname = ls_dd01l-domname.

    CALL FUNCTION 'DD_DOMVALUES_GET'
      EXPORTING
        domname        = ls_dd01l-domname
        text           = 'X'
        langu          = '*'
      TABLES
        dd07v_tab      = lt_dd07v
      EXCEPTIONS
        wrong_textflag = 1
        OTHERS         = 2.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    IF lt_dd07v[] IS NOT INITIAL.
      LOOP AT lt_dd07v ASSIGNING FIELD-SYMBOL(<lfs_dd07v>).
        CLEAR ls_dom_value.
        ls_dom_value-key  = <lfs_dd07v>-domvalue_l.
        ls_dom_value-langu  = <lfs_dd07v>-ddlanguage.
        ls_dom_value-text = <lfs_dd07v>-ddtext.
        INSERT ls_dom_value INTO TABLE et_dom_value.
      ENDLOOP.
    ELSE.
      <lfs_codeid>-tabname = ls_dd01l-entitytab.
      IF cs_codeid-entitytab IS NOT INITIAL.
        ls_dd01l-entitytab = cs_codeid-entitytab.
      ENDIF.
      IF ls_dd01l-entitytab IS INITIAL.
        EXIT.
      ENDIF.

      lv_tabname = ls_dd01l-entitytab.
      CALL FUNCTION 'DD_GET_DD03P'
        EXPORTING
          tabname       = lv_tabname    " Name der Tabelle
        TABLES
          dd03p_tab     = lt_dd03p
        EXCEPTIONS
          illegal_value = 1
          OTHERS        = 2.

      IF sy-subrc <> 0 OR lt_dd03p[] IS INITIAL.
        EXIT.
      ENDIF.
*   Den Feldnamen mit dieser Domäne ermitteln
      DATA lv_key_is_spras TYPE abap_bool.
      lv_key_is_spras = abap_false.
      READ TABLE lt_dd03p ASSIGNING FIELD-SYMBOL(<lfs_dd03p_key>)
      WITH KEY keyflag = 'X' domname = ev_domname.
      IF sy-subrc NE 0.
        EXIT.
      ENDIF.
      ls_dd03p_key = <lfs_dd03p_key>.
      IF <lfs_dd03p_key> IS ASSIGNED
      AND ( <lfs_dd03p_key>-fieldname EQ 'SPRAS'
      OR    <lfs_dd03p_key>-fieldname EQ 'SPRSL').
        lv_key_is_spras = abap_true.
      ENDIF.
      CONCATENATE <lfs_dd03p_key>-fieldname 'AS KEY' INTO lv_what
      SEPARATED BY space.
      APPEND lv_what TO lt_what.
*   Werte für dieses Feld aus Tabelle holen
      SELECT (lt_what) FROM (lv_tabname)
        INTO TABLE lt_values.
*   Füllen der Rückgabetabelle
      SORT lt_values.
      DELETE ADJACENT DUPLICATES FROM lt_values.

*   Texttabelle ermitteln
      CALL FUNCTION 'DDUT_TEXTTABLE_GET'
        EXPORTING
          tabname   = lv_tabname
        IMPORTING
          texttable = lv_tabname_t.
      <lfs_codeid>-tabname_text = lv_tabname_t.
      DATA lv_no_texttable TYPE abap_bool.
      lv_no_texttable = abap_false.
      IF lv_tabname_t IS INITIAL.
        lv_no_texttable = abap_true.
        lv_tabname_t = lv_tabname.
      ENDIF.
*   Kein Texttabelle da ? Dann einfach Werte zurück
      IF lv_no_texttable EQ abap_true AND cs_codeid-entitytab IS INITIAL.
        lt_textvalues[] = lt_values[].
      ELSE.

        IF lv_no_texttable EQ abap_false.
          CLEAR: lt_dd03p[].
          CALL FUNCTION 'DD_GET_DD03P'
            EXPORTING
              tabname       = lv_tabname_t    " Name der Tabelle
            TABLES
              dd03p_tab     = lt_dd03p
            EXCEPTIONS
              illegal_value = 1
              OTHERS        = 2.

          IF sy-subrc <> 0 OR lt_dd03p[] IS INITIAL.
            EXIT.
          ENDIF.
        ENDIF.
*       Anderes Textfeld auswählen?
        IF cs_codeid-value_fieldname IS NOT INITIAL.
          READ TABLE lt_dd03p
          WITH KEY fieldname = cs_codeid-value_fieldname
          ASSIGNING FIELD-SYMBOL(<lfs_dd03p_text>).
        ELSE.
          READ TABLE lt_dd03p
          WITH KEY keyflag = ' ' inttype = 'C'
          ASSIGNING <lfs_dd03p_text>.
        ENDIF.
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.
        ls_dd03p_text = <lfs_dd03p_text>.
        CONCATENATE <lfs_dd03p_text>-fieldname 'AS TEXT' INTO lv_what
              SEPARATED BY space.
        APPEND lv_what TO lt_what.
        CLEAR lv_where.

*       Bestimmter Schlüssel für Valueset Tabelle übernehmen
        IF cs_codeid-key_fieldname IS NOT INITIAL.
          READ TABLE lt_dd03p
            WITH KEY keyflag = 'X' fieldname = cs_codeid-key_fieldname
            ASSIGNING <lfs_dd03p_key>.
          IF sy-subrc EQ 0.
            READ TABLE lt_what ASSIGNING FIELD-SYMBOL(<lfs_what>) INDEX 1.
            IF sy-subrc EQ 0.
              ls_dd03p_key = <lfs_dd03p_key>.
              CONCATENATE cs_codeid-key_fieldname 'AS KEY' INTO <lfs_what>
              SEPARATED BY space.
            ENDIF.
          ENDIF.
        ENDIF.
*       Zusätzliche Schlüssel zum Filtern der Ergebnismenge
        DATA lv_first_field TYPE abap_bool.
        lv_first_field = abap_true.

        DATA(lt_codeidselection_field) = cs_codeid-codeidselection[].
        DELETE ADJACENT DUPLICATES FROM lt_codeidselection_field COMPARING fieldname.
        LOOP AT lt_codeidselection_field ASSIGNING FIELD-SYMBOL(<lfs_codeidselection_field>)
          WHERE key_comp_option IS NOT INITIAL
            AND key_comp_value_low IS NOT INITIAL.

          DATA(lv_index) = sy-tabix.
          READ TABLE lt_dd03p
            WITH KEY fieldname = <lfs_codeidselection_field>-fieldname
            ASSIGNING FIELD-SYMBOL(<lfs_dd03p>).
          IF sy-subrc <> 0.
            IF <lfs_codeidselection_field>-fieldname EQ 'SPRAS'.
              LOOP AT lt_dd03p ASSIGNING <lfs_dd03p> WHERE fieldname CP '*SPRAS*'
                                                        OR fieldname CP '*LANGU*'.
                EXIT.
              ENDLOOP.

            ENDIF.
            IF sy-subrc <> 0 OR <lfs_dd03p> IS NOT ASSIGNED.
              CONTINUE.
            ENDIF.

          ENDIF.

          DATA lv_count TYPE i.
          lv_count = 0.
          LOOP AT cs_codeid-codeidselection ASSIGNING FIELD-SYMBOL(<lfs_codeid_count>)
            WHERE fieldname = <lfs_codeidselection_field>-fieldname
              AND sql_option = 'OR'.
            lv_count = lv_count + 1.
          ENDLOOP.
          "AND Operator hinzufügen
          IF lv_first_field = abap_false.
            lv_where = lv_where && | AND|.
          ENDIF.
          IF lv_count > 0.
            lv_where = lv_where && | (|.
          ENDIF.
          LOOP AT cs_codeid-codeidselection ASSIGNING FIELD-SYMBOL(<lfs_codeidselection>)
            WHERE fieldname = <lfs_codeidselection_field>-fieldname
              AND key_comp_option IS NOT INITIAL
              AND key_comp_value_low IS NOT INITIAL.
            DATA lv_key_comp_option TYPE string.
            DATA lv_key_comp_value_low TYPE string.
            lv_key_comp_option = <lfs_codeidselection>-key_comp_option.
            lv_key_comp_value_low = <lfs_codeidselection>-key_comp_value_low.
            IF <lfs_codeidselection>-key_comp_value_low CS '*'.
              lv_key_comp_option = 'LIKE'.
              lv_key_comp_value_low = replace( val = <lfs_codeidselection>-key_comp_value_low sub = '*' with = '%' ).
            ENDIF.
            lv_where = lv_where && | | && <lfs_codeidselection>-sql_option && | | && <lfs_dd03p>-fieldname && | | && lv_key_comp_option && | '| && lv_key_comp_value_low && |'|.
          ENDLOOP.
          IF lv_count > 0.
            lv_where = lv_where && | )|.
          ENDIF.
          lv_first_field = abap_false.
        ENDLOOP.
*       Feldname mit Sprachenschlüssel
        DATA lv_no_lang TYPE abap_bool.
        lv_no_lang = abap_false.
        READ TABLE lt_dd03p
          WITH KEY keyflag = 'X' languflag = 'X'
          ASSIGNING <lfs_dd03p>.
        IF sy-subrc <> 0.
          READ TABLE lt_dd03p
            WITH KEY keyflag = 'X' domname = 'SPRAS'
            ASSIGNING <lfs_dd03p>.
          IF sy-subrc <> 0.
            lv_no_lang = abap_true.
          ENDIF.
        ENDIF.
        "Kein Feld mit Sprachenschlüssel vorhanden
        IF lv_no_lang EQ abap_false.
          CONCATENATE <lfs_dd03p>-fieldname 'AS LANGU' INTO lv_what
          SEPARATED BY space.
          APPEND lv_what TO lt_what.
*       Alle Sprachen
          IF iv_langu NE '*'.
            IF lv_index > 0.
              lv_where = lv_where && | AND | && <lfs_dd03p>-fieldname && | = '| && iv_langu && |'|.
            ELSE.
              lv_where = <lfs_dd03p>-fieldname && | = '| && iv_langu && |'|.
            ENDIF.

          ENDIF.
        ENDIF.
*   Werte für dieses Feld aus Texttabelle holen
        SELECT (lt_what) FROM (lv_tabname_t)
          INTO CORRESPONDING FIELDS OF
          TABLE lt_textvalues
          WHERE (lv_where).

        SORT lt_textvalues.
        DELETE ADJACENT DUPLICATES FROM lt_textvalues.
        LOOP AT lt_textvalues ASSIGNING FIELD-SYMBOL(<lv_textvalue>).
          CLEAR ls_dom_value.
          DATA lv_spras TYPE t002-spras.
          DATA lv_laiso TYPE t002-laiso.
          IF lv_key_is_spras = abap_true.
            lv_spras = <lv_textvalue>-key.
            CALL FUNCTION 'CONVERT_SAP_LANG_TO_ISO_LANG'
              EXPORTING
                input  = lv_spras
              IMPORTING
                output = lv_laiso.
            ls_dom_value-key = lv_laiso.
          ELSE.
            IF ls_dd03p_key-convexit IS NOT INITIAL.
              DATA lv_conv_exit TYPE string.
              lv_conv_exit = 'CONVERSION_EXIT_' && ls_dd03p_key-convexit && '_OUTPUT'.
              CALL FUNCTION lv_conv_exit
                EXPORTING
                  input  = <lv_textvalue>-key
                IMPORTING
                  output = ls_dom_value-key.
            ELSE.
              ls_dom_value-key    = <lv_textvalue>-key.
            ENDIF.
          ENDIF.

          ls_dom_value-langu  = <lv_textvalue>-langu.
          IF ls_dd03p_text-convexit IS NOT INITIAL.
            lv_conv_exit = 'CONVERSION_EXIT_' && ls_dd03p_text-convexit && '_OUTPUT'.
            CALL FUNCTION lv_conv_exit
              EXPORTING
                input  = <lv_textvalue>-text
              IMPORTING
                output = ls_dom_value-text.
          ELSE.
            ls_dom_value-text   = <lv_textvalue>-text.
          ENDIF.
          INSERT ls_dom_value INTO TABLE et_dom_value.
        ENDLOOP.
      ENDIF.
    ENDIF.
    DATA(lt_dom_value) = et_dom_value.
    lt_dom_value_desc[] = lt_dom_value[].
    SORT lt_dom_value BY key.
    DELETE ADJACENT DUPLICATES FROM lt_dom_value COMPARING key.
    LOOP AT lt_dom_value ASSIGNING FIELD-SYMBOL(<lfs_dom_value>).
      CLEAR ls_codeidvalue.
      ls_codeidvalue-codeidvalue = <lfs_dom_value>-key.
      LOOP AT lt_dom_value_desc ASSIGNING FIELD-SYMBOL(<lfs_dom_value_desc>) WHERE key = <lfs_dom_value>-key.
        CLEAR ls_codeidvaluedesc.
        ls_codeidvaluedesc-spras = <lfs_dom_value_desc>-langu.
        ls_codeidvaluedesc-codevalueiddesc = <lfs_dom_value_desc>-text.
        APPEND ls_codeidvaluedesc TO ls_codeidvalue-codeidvaluedesc.
      ENDLOOP.
      APPEND ls_codeidvalue TO <lfs_codeid>-codeidvalues.
    ENDLOOP.

  ENDMETHOD.


  METHOD read_ec.
    CLEAR mt_error_code.
    DATA lt_504t TYPE /bvccsap/k7_504t_tt.
    SELECT *
      FROM /bvccsap/k7_0504
      INTO CORRESPONDING FIELDS OF TABLE @mt_error_code "#EC CI_NOFIRST.
      WHERE version_id = @iv_version_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0504:Error Codes"'
          textid       = /bvccsap/cx_k7_codelist_data=>read_error.
    ENDIF.
    CLEAR lt_504t.
    DATA lo_table_descr TYPE REF TO cl_abap_tabledescr.
    DATA lo_struc_descr TYPE REF TO cl_abap_structdescr.
    DATA lv_spras TYPE spras.
    TRY.
        lo_table_descr ?= cl_abap_typedescr=>describe_by_data( mt_error_code ).
        lo_struc_descr ?= lo_table_descr->get_table_line_type( ).
      CATCH cx_sy_move_cast_error.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_type = 'E'
            textid       = /bvccsap/cx_k7_codelist_data=>read_error.
    ENDTRY.
    SELECT *
      FROM /bvccsap/k7_504t
      INTO TABLE @lt_504t                              "#EC CI_NOFIRST.
      FOR ALL ENTRIES IN @mt_error_code
      WHERE systemid   = @mt_error_code-systemid
        AND serviceid   = @mt_error_code-serviceid
        AND messageid   = @mt_error_code-messageid
        AND version_id = @mt_error_code-version_id.
    LOOP AT mt_error_code ASSIGNING FIELD-SYMBOL(<lfs_error_code>).

      READ TABLE /bvccsap/cl_k7_codelist_data=>gt_serviceid ASSIGNING FIELD-SYMBOL(<lfs_serviceid>)
      WITH KEY systemid   = <lfs_error_code>-systemid
               serviceid   = <lfs_error_code>-serviceid.
      if sy-subrc eq 0.
        <lfs_error_code>-serviceiddesc = <lfs_serviceid>-serviceiddesc.
      endif.
      DATA lv_messageid_full TYPE /bvccsap/k7_messageid_full.
      <lfs_error_code>-messageid_full = <lfs_error_code>-systemid && |-| && <lfs_error_code>-systemid && |-| && <lfs_error_code>-messageid.

      LOOP AT lo_struc_descr->components ASSIGNING FIELD-SYMBOL(<lfs_comp_descr>)
              WHERE name(13) = 'MESSAGEIDDESC'.
        ASSIGN COMPONENT sy-tabix OF STRUCTURE <lfs_error_code> TO FIELD-SYMBOL(<lfs_ws_field>).
        IF sy-subrc EQ 0.
          lv_spras = <lfs_comp_descr>-name+14(2).
          READ TABLE lt_504t ASSIGNING FIELD-SYMBOL(<lfs_504t>)
          WITH KEY systemid  = <lfs_error_code>-systemid
                   serviceid   = <lfs_error_code>-serviceid
                   messageid   = <lfs_error_code>-messageid
                   version_id = <lfs_error_code>-version_id
                   spras = lv_spras.
          IF sy-subrc EQ 0.
            <lfs_ws_field> = <lfs_504t>-messageiddesc.
          ENDIF.
        ENDIF.

      ENDLOOP.

    ENDLOOP.
    SORT mt_error_code BY systemid serviceid messageid ASCENDING.
  ENDMETHOD.


  METHOD read_environments.
    FIELD-SYMBOLS <lfs_environment> LIKE LINE OF gt_environment.
    SELECT * INTO CORRESPONDING FIELDS OF TABLE rt_environment
      FROM ( /bvccsap/k7_0510 AS v
      INNER JOIN /bvccsap/k7_510t AS t ON v~env = t~env
                                      AND t~spras = sy-langu ).

    LOOP AT rt_environment ASSIGNING <lfs_environment>.
      IF iv_all EQ abap_false.
        IF <lfs_environment>-logsys(3) NE sy-sysid.
          DELETE rt_environment INDEX sy-tabix.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD read_ic.
    CLEAR mt_info_carrier.

    SELECT *
      FROM /bvccsap/k7_0550
      INTO CORRESPONDING FIELDS OF TABLE mt_info_carrier "#EC CI_NOFIRST.
      WHERE version_id = iv_version_id.
    if sy-subrc ne 0.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0550:Infocarrier Codes"'
          textid       = /bvccsap/cx_k7_codelist_data=>read_error.
    endif.
    SORT mt_info_carrier BY info_carrier_id ASCENDING.
  ENDMETHOD.


  METHOD READ_MUNICIPAL_INVENTORY.
    FIELD-SYMBOLS <lfs_municipal> LIKE LINE OF rt_municipalities.
    DATA lt_municipalities TYPE /bvccsap/k7_0553_tt.
    SELECT * FROM /bvccsap/k7_0553 INTO TABLE rt_municipalities
      WHERE municipalityentrymode = '11' " Nur politische Gemeinden
        and municipalityadmissiondate LE iv_date
        AND ( municipalityabolitiondate EQ '00000000'
        OR municipalityabolitiondate GE iv_date ).
      sort rt_municipalities by municipalityid historymunicipalityid ASCENDING.
  ENDMETHOD.


  METHOD read_rtc.
    CLEAR ms_ch_topol_data.

    SELECT *
      FROM /bvccsap/k7_0552
      INTO CORRESPONDING FIELDS OF TABLE ms_ch_topol_data-cantons
        WHERE version_id = iv_version_id.              "#EC CI_NOFIRST.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0552:Kanton"'
          textid       = /bvccsap/cx_k7_codelist_data=>read_error.
    ENDIF.
    SORT ms_ch_topol_data-cantons BY cantonid ASCENDING.
    SELECT *
      FROM /bvccsap/k7_0551
      INTO CORRESPONDING FIELDS OF TABLE ms_ch_topol_data-districts
        WHERE version_id = iv_version_id.              "#EC CI_NOFIRST.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0551:Bezirk"'
          textid       = /bvccsap/cx_k7_codelist_data=>read_error.
    ENDIF.
    SORT ms_ch_topol_data-districts BY districtid districthistid ASCENDING.
    SELECT *
      FROM /bvccsap/k7_0553
      INTO CORRESPONDING FIELDS OF TABLE ms_ch_topol_data-municipalities "#EC CI_NOFIRST.
        WHERE version_id = iv_version_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0553:Gemeinde"'
          textid       = /bvccsap/cx_k7_codelist_data=>read_error.
    ENDIF.
    SORT ms_ch_topol_data-municipalities BY municipalityid historymunicipalityid ASCENDING.
  ENDMETHOD.


  METHOD read_sc.
    DATA lt_codeid  TYPE  /bvccsap/k7_codeid_tt.
    DATA lt_dd07v   TYPE dd07v_tab.
    DATA lt_dom_value        TYPE tt_vt.
    DATA lt_dom_value_desc   TYPE tt_vt.
    CLEAR mt_codeid.
    FIELD-SYMBOLS <lfs_codeid> LIKE LINE OF lt_codeid.
    FIELD-SYMBOLS <lfs_codeidvalues> LIKE LINE OF <lfs_codeid>-codeidvalues.
    FIELD-SYMBOLS <lfs_codeidvaluedesc> LIKE LINE OF <lfs_codeidvalues>-codeidvaluedesc.
    DATA ls_codeidvalue LIKE LINE OF <lfs_codeid>-codeidvalues.
    DATA ls_codeidvaluedesc LIKE LINE OF <lfs_codeidvalues>-codeidvaluedesc.
    mt_codeid = /bvccsap/cl_k7_codelist_data=>read_codeid_list( ).

    "Alle weiteren Codes werden hier abhängig von der Version gelesen
    LOOP AT mt_codeid ASSIGNING <lfs_codeid> WHERE systemid ne /bvccsap/cl_k7_codelist_ass=>gc_systemid_sap.
         SELECT * FROM /bvccsap/k7_0502
          APPENDING CORRESPONDING FIELDS OF TABLE <lfs_codeid>-codeidvalues
          WHERE systemid = <lfs_codeid>-systemid
            AND codeid   = <lfs_codeid>-codeid.

        LOOP AT <lfs_codeid>-codeidvalues ASSIGNING <lfs_codeidvalues>.
          SELECT * FROM /bvccsap/k7_502t
             APPENDING CORRESPONDING FIELDS OF TABLE <lfs_codeidvalues>-codeidvaluedesc
            WHERE systemid = <lfs_codeid>-systemid
            AND codeid   = <lfs_codeid>-codeid
            and codeidvalue = <lfs_codeidvalues>-codeidvalue
            AND version_id =  <lfs_codeidvalues>-version_id.

        ENDLOOP.

    ENDLOOP.
  ENDMETHOD.


  METHOD read_serviceid.
    SELECT a~systemid, a~serviceid, t~SERVICEIDDESC INTO CORRESPONDING FIELDS OF TABLE @rt_serviceid
          FROM ( /bvccsap/k7_0503 AS a
          INNER JOIN /bvccsap/k7_503t AS t ON t~systemid = a~systemid
                                          and t~serviceid = a~serviceid
                                          AND t~spras = @sy-langu ).
  ENDMETHOD.


  METHOD read_systemid.
    SELECT a~systemid, t~systemiddesc INTO CORRESPONDING FIELDS OF TABLE @rt_systemid
      FROM ( /bvccsap/k7_0500 AS a
      INNER JOIN /bvccsap/k7_500t AS t ON t~systemid = a~systemid
                                      AND t~spras = @sy-langu ).

  ENDMETHOD.


  METHOD set_data.
    FIELD-SYMBOLS <lfs_canton> LIKE LINE OF ms_ch_topol_data-cantons.
    FIELD-SYMBOLS <lfs_district> LIKE LINE OF ms_ch_topol_data-districts.
    FIELD-SYMBOLS <lfs_municipality> LIKE LINE OF ms_ch_topol_data-municipalities.
    CLEAR ms_ch_topol_data.
    CASE mv_codelist_type.
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_rtc.
        ms_ch_topol_data = is_data.
        DATA(lv_version_id) = ms_current_codelist_version-version_id.
        IF ms_new_codelist_version IS NOT INITIAL.
          lv_version_id = ms_new_codelist_version-version_id.
        ENDIF.
        LOOP AT ms_ch_topol_data-cantons ASSIGNING <lfs_canton>.
          <lfs_canton>-version_id = lv_version_id.
        ENDLOOP.
        LOOP AT ms_ch_topol_data-districts ASSIGNING <lfs_district>.
          <lfs_district>-version_id = lv_version_id.
        ENDLOOP.
        LOOP AT ms_ch_topol_data-municipalities ASSIGNING <lfs_municipality>.
          <lfs_municipality>-version_id = lv_version_id.
        ENDLOOP.
      WHEN OTHERS.
        RETURN.
    ENDCASE.

    es_data = ms_ch_topol_data.

  ENDMETHOD.


  METHOD set_error_codes.
    DATA lv_index TYPE sy-index.
    DATA lt_error_code TYPE /bvccsap/k7_error_code_tt.
    DATA lv_msgv1 TYPE sy-msgv1.
    DATA lv_msgv2 TYPE sy-msgv2.
    FIELD-SYMBOLS <lfs_error_code> LIKE LINE OF lt_error_code.
    FIELD-SYMBOLS <lfs_error_code_db> LIKE LINE OF lt_error_code.

    lt_error_code[] = it_data[].

    "Übernehmen der Error Code in die neue Version, die nicht durch dem Import tangiert sind
    IF ms_new_codelist_version IS NOT INITIAL.
      LOOP AT mt_error_code ASSIGNING <lfs_error_code_db> WHERE deleted EQ abap_false.
        READ TABLE lt_error_code ASSIGNING <lfs_error_code>
        WITH KEY systemid = <lfs_error_code_db>-systemid
                 serviceid = <lfs_error_code_db>-serviceid
                 messageid = <lfs_error_code_db>-messageid
                 version_id      = 0.
        IF sy-subrc NE 0.
          <lfs_error_code_db>-mandt = sy-mandt.
          <lfs_error_code_db>-version_id = ms_new_codelist_version-version_id.
          <lfs_error_code_db>-iud = 'I'.
        ENDIF.
      ENDLOOP.

    ENDIF.

    "Erzeugen und Ändern der Error Code die durch den Import tangiert sind.
    LOOP AT lt_error_code ASSIGNING <lfs_error_code> WHERE iud IS NOT INITIAL.

      READ TABLE mt_error_code ASSIGNING <lfs_error_code_db>
      WITH KEY systemid = <lfs_error_code>-systemid
                 serviceid = <lfs_error_code>-serviceid
                 messageid = <lfs_error_code>-messageid.
      IF sy-subrc EQ 0.

        IF <lfs_error_code>-iud EQ 'I'
        AND mv_new_version_active EQ abap_false.
          lv_msgv1 = 'MessageID'.
          lv_msgv2 = <lfs_error_code>-messageid_full.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
            EXPORTING
              message_id     = '/BVCCSAP/K7_5'
              message_number = '021'
              message_type   = 'E'
              message_v1     = lv_msgv1
              message_v2     = lv_msgv2.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data.
        ENDIF.
        IF <lfs_error_code>-iud EQ 'D'.
          <lfs_error_code>-deleted = abap_true.
        ENDIF.
        <lfs_error_code>-mandt = sy-mandt.
        <lfs_error_code>-version_id = ms_current_codelist_version-version_id.
        IF mv_new_version_active EQ abap_true
        AND <lfs_error_code>-iud NE 'D'.
          <lfs_error_code>-iud = 'I'.
          <lfs_error_code>-version_id = ms_new_codelist_version-version_id.
        ENDIF.
        <lfs_error_code_db> = <lfs_error_code>.

      ELSE.
        IF <lfs_error_code>-iud EQ 'U' OR <lfs_error_code>-iud EQ 'D'.
          lv_msgv1 = 'MessageID'.
          lv_msgv2 = <lfs_error_code>-messageid_full.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
            EXPORTING
              message_id     = '/BVCCSAP/K7_5'
              message_number = '022'
              message_type   = 'E'
              message_v1     = lv_msgv1
              message_v2     = lv_msgv2.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data.
        ENDIF.
        <lfs_error_code>-mandt = sy-mandt.
        <lfs_error_code>-version_id = ms_current_codelist_version-version_id.
        IF ms_new_codelist_version IS NOT INITIAL.
          <lfs_error_code>-version_id = ms_new_codelist_version-version_id.
        ENDIF.
        APPEND <lfs_error_code> TO mt_error_code.
      ENDIF.

    ENDLOOP.
    SORT mt_error_code BY systemid serviceid messageid ASCENDING.

    et_data[] = mt_error_code[].
  ENDMETHOD.


  METHOD set_info_carrier.
    DATA lv_index TYPE sy-index.
    DATA lt_info_carrier TYPE /bvccsap/k7_infocarr_ext_ttyp.
              data lv_msgv1 type sy-msgv1.
          data lv_msgv2 type sy-msgv2.
    FIELD-SYMBOLS <lfs_info_carrier> LIKE LINE OF lt_info_carrier.
    FIELD-SYMBOLS <lfs_info_carrier_db> LIKE LINE OF lt_info_carrier.

    lt_info_carrier[] = it_data[].

    "Übernehmen der InfoCarriers in die neue Version, die nicht durch dem Import tangiert sind
    IF ms_new_codelist_version IS NOT INITIAL.
      LOOP AT mt_info_carrier ASSIGNING <lfs_info_carrier_db> WHERE deleted EQ abap_false.
        READ TABLE lt_info_carrier ASSIGNING <lfs_info_carrier>
        WITH KEY info_carrier_id = <lfs_info_carrier_db>-info_carrier_id
                 version_id      = 0.
        IF sy-subrc NE 0.
          <lfs_info_carrier_db>-mandt = sy-mandt.
          <lfs_info_carrier_db>-version_id = ms_new_codelist_version-version_id.
          <lfs_info_carrier_db>-iud = 'I'.
        ENDIF.
      ENDLOOP.

    ENDIF.

    "Erzeugen und Ändern der InfoCarrier die durch den Import tangiert sind.
    LOOP AT lt_info_carrier ASSIGNING <lfs_info_carrier> WHERE iud IS NOT INITIAL.

      READ TABLE mt_info_carrier ASSIGNING <lfs_info_carrier_db>
      WITH KEY info_carrier_id = <lfs_info_carrier>-info_carrier_id.
      IF sy-subrc EQ 0.

        IF <lfs_info_carrier>-iud EQ 'I'
        AND mv_new_version_active EQ abap_false.
          lv_msgv1 = 'InfoCarrier ID'.
          lv_msgv2 = <lfs_info_carrier>-info_carrier_id.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
            EXPORTING
              message_id     = '/BVCCSAP/K7_5'
              message_number = '021'
              message_type   = 'E'
              message_v1     = lv_msgv1
              message_v2     = lv_msgv2.
*          mo_msg_mgr->report_error_message( EXPORTING message_text  = |InfoCarrier ID <|
*                                                   && <lfs_info_carrier>-info_carrier_id
*                                                   && |> existiert bereits und kann nicht eingefügt werden.| ).
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data.
        ENDIF.
        IF <lfs_info_carrier>-iud EQ 'D'.
          <lfs_info_carrier>-deleted = abap_true.
        ENDIF.
        <lfs_info_carrier>-mandt = sy-mandt.
        <lfs_info_carrier>-version_id = ms_current_codelist_version-version_id.
        IF mv_new_version_active EQ abap_true
        AND <lfs_info_carrier>-iud NE 'D'.
          <lfs_info_carrier>-iud = 'I'.
          <lfs_info_carrier>-version_id = ms_new_codelist_version-version_id.
        ENDIF.
        <lfs_info_carrier_db> = <lfs_info_carrier>.

      ELSE.
        IF <lfs_info_carrier>-iud EQ 'U' OR <lfs_info_carrier>-iud EQ 'D'.
          lv_msgv1 = 'InfoCarrier ID'.
          lv_msgv2 = <lfs_info_carrier>-info_carrier_id.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
            EXPORTING
              message_id     = '/BVCCSAP/K7_5'
              message_number = '022'
              message_type   = 'E'
              message_v1     = lv_msgv1
              message_v2     = lv_msgv2.
*          mo_msg_mgr->report_error_message( EXPORTING message_text  = |InfoCarrier ID <|
*                                                   && <lfs_info_carrier>-info_carrier_id
*                                                   && |> existiert nicht und kann nicht mutiert oder gelöscht werden.| ).
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data.
        ENDIF.
        <lfs_info_carrier>-mandt = sy-mandt.
        <lfs_info_carrier>-version_id = ms_current_codelist_version-version_id.
        IF ms_new_codelist_version IS NOT INITIAL.
          <lfs_info_carrier>-version_id = ms_new_codelist_version-version_id.
        ENDIF.
        APPEND <lfs_info_carrier> TO mt_info_carrier.
      ENDIF.

    ENDLOOP.
    SORT mt_info_carrier BY info_carrier_id ASCENDING.

    et_data[] = mt_info_carrier[].
  ENDMETHOD.


  METHOD set_standard_codes.
    DATA lv_index TYPE sy-index.
    DATA lt_codeid TYPE /bvccsap/k7_codeid_tt.
    DATA lv_msgv1 TYPE sy-msgv1.
    DATA lv_msgv2 TYPE sy-msgv2.
    FIELD-SYMBOLS <lfs_codeid> LIKE LINE OF lt_codeid.
    FIELD-SYMBOLS <lfs_codeidvalues> LIKE LINE OF <lfs_codeid>-codeidvalues.
    FIELD-SYMBOLS <lfs_codeid_db> LIKE LINE OF lt_codeid.
    FIELD-SYMBOLS <lfs_codeidvalues_db> LIKE LINE OF <lfs_codeid_db>-codeidvalues.
    lt_codeid[] = it_data[].

    "Übernehmen der Standard Codes in die neue Version, die nicht durch dem Import tangiert sind
    IF ms_new_codelist_version IS NOT INITIAL.
      LOOP AT mt_codeid ASSIGNING <lfs_codeid_db> WHERE systemid NE /bvccsap/cl_k7_codelist_ass=>gc_systemid_sap." WHERE deleted EQ abap_false.
        READ TABLE lt_codeid ASSIGNING <lfs_codeid>
         WITH KEY systemid = <lfs_codeid_db>-systemid
                  codeid = <lfs_codeid_db>-codeid.
        IF sy-subrc EQ 0.
          LOOP AT <lfs_codeid_db>-codeidvalues ASSIGNING <lfs_codeidvalues_db>.
            READ TABLE <lfs_codeid>-codeidvalues TRANSPORTING NO FIELDS
            WITH KEY codeidvalue = <lfs_codeidvalues_db>-codeidvalue
                     version_id      = 0.
            IF sy-subrc NE 0.
              <lfs_codeidvalues_db>-version_id = ms_new_codelist_version-version_id.
              <lfs_codeidvalues_db>-iud = 'I'.
            ENDIF.
          ENDLOOP.
        ENDIF.

      ENDLOOP.

    ENDIF.

    "Erzeugen und Ändern der Standard Codes die durch den Import tangiert sind.
    LOOP AT lt_codeid ASSIGNING <lfs_codeid>.

      READ TABLE mt_codeid ASSIGNING <lfs_codeid_db>
      WITH KEY systemid = <lfs_codeid>-systemid
               codeid = <lfs_codeid>-codeid.
      IF sy-subrc NE 0 AND <lfs_codeid>-iud EQ 'I'.
        APPEND INITIAL LINE TO mt_codeid ASSIGNING <lfs_codeid_db>.
        MOVE-CORRESPONDING  <lfs_codeid> TO <lfs_codeid_db>.
      ELSE.
        IF <lfs_codeid>-iud EQ 'D'.
          MOVE-CORRESPONDING  <lfs_codeid> TO <lfs_codeid_db>.
*          <lfs_codeid_db>-deleted = abap_true.
*          <lfs_codeid_db>-date_deleted = sy-datum.
          <lfs_codeid_db>-publish_to_e2 = abap_false.
        ELSEIF <lfs_codeid>-iud EQ 'U'.
          MOVE-CORRESPONDING  <lfs_codeid> TO <lfs_codeid_db>.
        ENDIF.
      ENDIF.
      IF <lfs_codeid>-systemid EQ /bvccsap/cl_k7_codelist_ass=>gc_systemid_sap.
        CONTINUE.
      ENDIF.
      LOOP AT <lfs_codeid>-codeidvalues ASSIGNING <lfs_codeidvalues> WHERE iud IS NOT INITIAL.
        READ TABLE <lfs_codeid_db>-codeidvalues ASSIGNING <lfs_codeidvalues_db>
        WITH KEY codeidvalue = <lfs_codeidvalues>-codeidvalue.
        IF sy-subrc EQ 0.


          IF <lfs_codeidvalues>-iud EQ 'I'
          AND mv_new_version_active EQ abap_false
          AND iv_initial_load EQ abap_false.
            lv_msgv1 = 'Standard Code'.
            lv_msgv2 = <lfs_codeidvalues>-codeidvalue.
            RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
              EXPORTING
                message_id     = '/BVCCSAP/K7_5'
                message_number = '021'
                message_type   = 'E'
                message_v1     = lv_msgv1
                message_v2     = lv_msgv2.
*            mo_msg_mgr->report_error_message( EXPORTING message_text  = |Standard Code <|
*                                                     && <lfs_codeidvalues>-codeidvalue
*                                                     && |> existiert bereits und kann nicht eingefügt werden.| ).
            RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data.
          ENDIF.
          IF <lfs_codeidvalues>-iud EQ 'D'.
            "<lfs_codeidvalues>-deleted = abap_true.
          ENDIF.
          IF <lfs_codeid>-systemid EQ /bvccsap/cl_k7_codelist_ass=>gc_systemid_sap.
            CLEAR <lfs_codeidvalues>-iud.
          ELSE.
            <lfs_codeidvalues>-version_id = ms_current_codelist_version-version_id.
            IF mv_new_version_active EQ abap_true
            AND <lfs_codeidvalues>-iud NE 'D'.
              <lfs_codeidvalues>-iud = 'I'.
              <lfs_codeidvalues>-version_id = ms_new_codelist_version-version_id.
            ENDIF.
          ENDIF.

          <lfs_codeidvalues_db> = <lfs_codeidvalues>.

        ELSE.
          IF <lfs_codeidvalues>-iud EQ 'U' OR <lfs_codeidvalues>-iud EQ 'D'.
            lv_msgv1 = 'Standard Code'.
            lv_msgv2 = <lfs_codeidvalues>-codeidvalue.
            RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
              EXPORTING
                message_id     = '/BVCCSAP/K7_5'
                message_number = '022'
                message_type   = 'E'
                message_v1     = lv_msgv1
                message_v2     = lv_msgv2.
*            mo_msg_mgr->report_error_message( EXPORTING message_text  = |Standard Code <|
*                                                     && <lfs_codeidvalues>-codeidvalue
*                                                     && |> existiert nicht und kann nicht mutiert oder gelöscht werden.| ).
            RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data.
          ENDIF.

          <lfs_codeidvalues>-version_id = ms_current_codelist_version-version_id.
          IF ms_new_codelist_version IS NOT INITIAL.
            <lfs_codeidvalues>-version_id = ms_new_codelist_version-version_id.
          ENDIF.
          APPEND <lfs_codeidvalues> TO <lfs_codeid_db>-codeidvalues.

        ENDIF.

      ENDLOOP.

    ENDLOOP.
    SORT mt_codeid BY systemid codeid ASCENDING.

    et_data[] = mt_codeid[].
  ENDMETHOD.


  METHOD set_table_data.
    mv_initial_load = iv_initial_load.
    IF iv_initial_load EQ abap_true.
      CLEAR mt_info_carrier.
      "CLEAR mt_codeid.
    ENDIF.

    CASE mv_codelist_type.
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ic.
        set_info_carrier( EXPORTING it_data = it_data
                                    iv_initial_load = iv_initial_load
                          IMPORTING et_data = et_data ).
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_sc.
        set_standard_codes( EXPORTING it_data = it_data
                                      iv_initial_load = iv_initial_load
                            IMPORTING et_data = et_data ).
      WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ec.
        set_error_codes( EXPORTING it_data = it_data
                                   iv_initial_load = iv_initial_load
                         IMPORTING et_data = et_data ).
    ENDCASE.

  ENDMETHOD.


  METHOD update.
    DATA ls_return LIKE LINE OF et_return.
    DATA lx_trsp_exc TYPE REF TO /bvccsap/cx_k7_transport.
    DATA lx_codelist_data_exc TYPE REF TO /bvccsap/cx_k7_codelist_data.
    CLEAR et_return.
    TRY.
        mo_transport_hndl->lock_transport( ).
      CATCH /bvccsap/cx_k7_transport INTO lx_trsp_exc.

        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_id     = lx_trsp_exc->message_id
            message_type   = lx_trsp_exc->message_type
            message_number = lx_trsp_exc->message_number
            message_v1     = lx_trsp_exc->message_v1
            message_v2     = lx_trsp_exc->message_v2
            message_v3     = lx_trsp_exc->message_v3
            message_v4     = lx_trsp_exc->message_v4.
    ENDTRY.
    TRY.
        update_version( ).
        update_change_log( ).
        CASE mv_codelist_type.
          WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ic.
            update_ic( ).
          WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_rtc.
            update_rtc( ).
          WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_sc.
            update_sc( ).
          WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ec.
            update_ec( ).
        ENDCASE.
        update_transport( ).
        COMMIT WORK.
        "Neue Version erzeugt und wir nun zur aktuellen Version
        IF mv_new_version_active EQ abap_true.
          ms_current_codelist_version = ms_new_codelist_version.
          CLEAR ms_new_codelist_version.
          mv_new_version_active = abap_false.
          mv_initial_load = abap_false.
        ENDIF.
        FIELD-SYMBOLS <lfs_change_log> LIKE LINE OF mt_change_log.
        READ TABLE mt_change_log ASSIGNING <lfs_change_log> WITH KEY new = abap_true.
        IF sy-subrc EQ 0.
          <lfs_change_log>-new = abap_false.
        ENDIF.
        mo_transport_hndl->unlock_transport( ).
        read( iv_codelist_type = mv_codelist_type ).
      CATCH /bvccsap/cx_k7_codelist_data INTO lx_codelist_data_exc.
        ROLLBACK WORK.                                 "#EC CI_ROLLBACK
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_id     = /bvccsap/cx_k7_codelist_data=>not_saved-msgid
            message_number = /bvccsap/cx_k7_codelist_data=>not_saved-msgno
            message_type   = 'E'.

      CLEANUP.
        mo_transport_hndl->unlock_transport( ).
    ENDTRY.

  ENDMETHOD.


  METHOD update_change_log.
    DATA ls_k7_0561 TYPE /bvccsap/k7_0561.
    FIELD-SYMBOLS <lfs_change_log> LIKE LINE OF mt_change_log.
    LOOP AT mt_change_log ASSIGNING <lfs_change_log> WHERE new = abap_true.
      MOVE-CORRESPONDING <lfs_change_log> TO ls_k7_0561.
      ls_k7_0561-mandt = sy-mandt.
      SELECT SINGLE * FROM /bvccsap/k7_0561
        INTO ls_k7_0561
        WHERE codelist_type = mv_codelist_type
          AND version_id = ls_k7_0561-version_id
          AND log_id = ls_k7_0561-log_id.
      IF sy-subrc EQ 0.
        ls_k7_0561-notice = <lfs_change_log>-notice.
        UPDATE /bvccsap/k7_0561 FROM @ls_k7_0561.
        IF sy-subrc NE 0.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
            EXPORTING
              message_type = 'E'
              message_v1   = '"K7_0561:Change Log"'
              textid       = /bvccsap/cx_k7_codelist_data=>update_error.

        ENDIF.
      ELSE.
        INSERT INTO /bvccsap/k7_0561 VALUES @ls_k7_0561.
        IF sy-subrc NE 0.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
            EXPORTING
              message_type = 'E'
              message_v1   = '"K7_0561:Change Log"'
              textid       = /bvccsap/cx_k7_codelist_data=>insert_error.

        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD update_ec.
    DATA lt_message_db_ins TYPE /bvccsap/k7_0504_tt.
    DATA lt_messagedesc_db_ins TYPE /bvccsap/k7_504t_tt.
    DATA lt_message_db_upd TYPE /bvccsap/k7_0504_tt.
    DATA lt_messagedesc_db_upd TYPE /bvccsap/k7_504t_tt.

    DATA ls_message_db_ins LIKE LINE OF lt_message_db_ins.
    DATA ls_messagedesc_db_ins LIKE LINE OF lt_messagedesc_db_ins.
    DATA ls_message_db_upd LIKE LINE OF lt_message_db_upd.
    DATA ls_messagedesc_db_upd LIKE LINE OF lt_messagedesc_db_upd.
    DATA lv_spras TYPE spras.
    "Die aktuelle Version wird komplett überschrieben
    IF mv_new_version_active EQ abap_false AND mv_initial_load EQ abap_true.
      delete_ec( ).
    ENDIF.
    CLEAR: lt_message_db_ins, lt_messagedesc_db_ins, lt_message_db_upd, lt_messagedesc_db_upd.

    DATA lo_table_descr TYPE REF TO cl_abap_tabledescr.
    DATA lo_struc_descr TYPE REF TO cl_abap_structdescr.
    TRY.
        lo_table_descr ?= cl_abap_typedescr=>describe_by_data( mt_error_code ).
        lo_struc_descr ?= lo_table_descr->get_table_line_type( ).
      CATCH cx_sy_move_cast_error.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_type = 'E'
            "message_v1   = '"K7_0504T:MessageId"'
            textid       = /bvccsap/cx_k7_codelist_data=>not_saved.
    ENDTRY.

    LOOP AT mt_error_code ASSIGNING FIELD-SYMBOL(<lfs_error_code>).
      IF <lfs_error_code>-iud EQ 'I'.
        MOVE-CORRESPONDING <lfs_error_code> TO ls_message_db_ins.
        ls_message_db_ins-mandt = sy-mandt.
        APPEND ls_message_db_ins TO lt_message_db_ins.
        LOOP AT lo_struc_descr->components ASSIGNING FIELD-SYMBOL(<lfs_comp_descr>)
        WHERE name(13) = 'MESSAGEIDDESC'.
          ASSIGN COMPONENT sy-tabix OF STRUCTURE <lfs_error_code> TO FIELD-SYMBOL(<lfs_ws_field>).
          IF sy-subrc EQ 0 AND <lfs_ws_field> IS NOT INITIAL.
            lv_spras = <lfs_comp_descr>-name+14(2).

            READ TABLE lt_messagedesc_db_ins ASSIGNING FIELD-SYMBOL(<lfs_messagedesc_db_ins>)
            WITH KEY systemid = <lfs_error_code>-systemid
                     serviceid = <lfs_error_code>-serviceid
                     messageid = <lfs_error_code>-messageid
                     spras = lv_spras.
            IF sy-subrc NE 0.
              APPEND INITIAL LINE TO lt_messagedesc_db_ins ASSIGNING <lfs_messagedesc_db_ins>.
              MOVE-CORRESPONDING <lfs_error_code> TO <lfs_messagedesc_db_ins>.
            ENDIF.
            <lfs_messagedesc_db_ins>-messageiddesc = <lfs_ws_field>.
            <lfs_messagedesc_db_ins>-spras = lv_spras.
          ENDIF.

        ENDLOOP.
      ELSEIF <lfs_error_code>-iud EQ 'D' OR <lfs_error_code>-iud EQ 'U'.
        MOVE-CORRESPONDING <lfs_error_code> TO ls_message_db_upd.
        ls_message_db_upd-mandt = sy-mandt.
        APPEND ls_message_db_upd TO lt_message_db_upd.
        LOOP AT lo_struc_descr->components ASSIGNING <lfs_comp_descr>
        WHERE name(13) = 'MESSAGEIDDESC'.
          ASSIGN COMPONENT sy-tabix OF STRUCTURE <lfs_error_code> TO <lfs_ws_field>.
          IF sy-subrc EQ 0 AND <lfs_ws_field> IS NOT INITIAL.

            lv_spras = <lfs_comp_descr>-name+14(2).

            READ TABLE lt_messagedesc_db_upd ASSIGNING FIELD-SYMBOL(<lfs_messagedesc_db_upd>)
            WITH KEY systemid = <lfs_error_code>-systemid
                     serviceid = <lfs_error_code>-serviceid
                     messageid = <lfs_error_code>-messageid
                     spras = lv_spras.
            IF sy-subrc NE 0.
              APPEND INITIAL LINE TO lt_messagedesc_db_upd ASSIGNING <lfs_messagedesc_db_upd>.
              MOVE-CORRESPONDING <lfs_error_code> TO <lfs_messagedesc_db_upd>.
            ENDIF.
            <lfs_messagedesc_db_upd>-messageiddesc = <lfs_ws_field>.
            <lfs_messagedesc_db_upd>-spras = lv_spras.
          ENDIF.

        ENDLOOP.

      ENDIF.
    ENDLOOP.

    INSERT /bvccsap/k7_0504 FROM TABLE lt_message_db_ins.
    IF sy-subrc EQ 0.
      INSERT /bvccsap/k7_504t FROM TABLE lt_messagedesc_db_ins.
      IF sy-subrc NE 0.

        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_type = 'E'
            message_v1   = '"K7_504T:MessageId Texttabelle"'
            textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
      ENDIF.
    ELSE.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0504T:MessageId"'
          textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
    ENDIF.


    UPDATE /bvccsap/k7_0504 FROM TABLE lt_message_db_upd.
    IF sy-subrc EQ 0.
      UPDATE /bvccsap/k7_504t FROM TABLE lt_messagedesc_db_upd.

      IF sy-subrc NE 0.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_type = 'E'
            message_v1   = '"K7_504T:MessageId Texttabelle"'
            textid       = /bvccsap/cx_k7_codelist_data=>update_error.
      ENDIF.
    ELSE.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0504T:MessageId"'
          textid       = /bvccsap/cx_k7_codelist_data=>update_error.
    ENDIF.

  ENDMETHOD.


  METHOD update_ic.
    DATA lt_info_carrier_db TYPE /bvccsap/k7_0550_ttyp.
    DATA ls_info_carrier_db LIKE LINE OF lt_info_carrier_db.
    FIELD-SYMBOLS <lfs_info_carrier> LIKE LINE OF mt_info_carrier.
    "Die aktuelle Version wird komplett überschrieben
    IF mv_new_version_active EQ abap_false AND mv_initial_load EQ abap_true.
      delete_ic( ).
    ENDIF.
    CLEAR lt_info_carrier_db.
    LOOP AT mt_info_carrier ASSIGNING <lfs_info_carrier> WHERE iud EQ 'I'.
      MOVE-CORRESPONDING <lfs_info_carrier> TO ls_info_carrier_db.
      APPEND ls_info_carrier_db TO lt_info_carrier_db.
    ENDLOOP.
    INSERT /bvccsap/k7_0550 FROM TABLE lt_info_carrier_db.
    IF sy-subrc EQ 0.
      CLEAR lt_info_carrier_db.
      LOOP AT mt_info_carrier ASSIGNING <lfs_info_carrier> WHERE iud EQ 'U'
                                                              OR iud EQ 'D'.
        MOVE-CORRESPONDING <lfs_info_carrier> TO ls_info_carrier_db.
        APPEND ls_info_carrier_db TO lt_info_carrier_db.
      ENDLOOP.
      IF lines( lt_info_carrier_db ) > 0.
        UPDATE /bvccsap/k7_0550 FROM TABLE lt_info_carrier_db.
        IF sy-subrc NE 0.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
            EXPORTING
              message_type = 'E'
              message_v1   = '"K7_0550:Infocarrier Codes"'
              textid       = /bvccsap/cx_k7_codelist_data=>update_error.
        ENDIF.
      ENDIF.
    ELSE.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0550:Infocarrier Codes"'
          textid       = /bvccsap/cx_k7_codelist_data=>insert_error.

    ENDIF.

  ENDMETHOD.


  METHOD update_rtc.
    DATA lt_cantons_db TYPE /bvccsap/k7_0552_tt.
    DATA ls_canton_db LIKE LINE OF lt_cantons_db.
    DATA lt_districts_db TYPE /bvccsap/k7_0551_tt.
    DATA ls_district_db LIKE LINE OF lt_districts_db.
    DATA lt_municipalities_db TYPE /bvccsap/k7_0553_tt.
    DATA ls_municipality_db LIKE LINE OF lt_municipalities_db.
    "Die aktuelle Version wird komplett überschrieben
    IF mv_new_version_active EQ abap_false.
      delete_rtc( ).
    ENDIF.
    FIELD-SYMBOLS <lfs_canton> LIKE LINE OF ms_ch_topol_data-cantons.
    CLEAR lt_cantons_db.
    LOOP AT ms_ch_topol_data-cantons ASSIGNING <lfs_canton>.
      MOVE-CORRESPONDING <lfs_canton> TO ls_canton_db.
      ls_canton_db-mandt = sy-mandt.
      APPEND ls_canton_db TO lt_cantons_db.
    ENDLOOP.
    FIELD-SYMBOLS <lfs_district> LIKE LINE OF ms_ch_topol_data-districts.
    CLEAR lt_districts_db.
    LOOP AT ms_ch_topol_data-districts ASSIGNING <lfs_district>.
      MOVE-CORRESPONDING <lfs_district> TO ls_district_db.
      ls_district_db-mandt = sy-mandt.
      APPEND ls_district_db TO lt_districts_db.
    ENDLOOP.
    FIELD-SYMBOLS <lfs_municipality> LIKE LINE OF ms_ch_topol_data-municipalities.
    CLEAR lt_municipalities_db.
    LOOP AT ms_ch_topol_data-municipalities ASSIGNING <lfs_municipality>.
      MOVE-CORRESPONDING <lfs_municipality> TO ls_municipality_db.
      ls_municipality_db-mandt = sy-mandt.
      APPEND ls_municipality_db TO lt_municipalities_db.
    ENDLOOP.

    INSERT /bvccsap/k7_0552 FROM TABLE lt_cantons_db.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0552:Kanton"'
          textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
    ENDIF.
    INSERT /bvccsap/k7_0551 FROM TABLE lt_districts_db.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0552:Bezirk"'
          textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
    ENDIF.
    INSERT /bvccsap/k7_0553 FROM TABLE lt_municipalities_db.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0552:Gemeinde"'
          textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
    ENDIF.

  ENDMETHOD.


  METHOD update_sc.
    DATA lt_codeid_db_ins TYPE /bvccsap/k7_0501_tt.
    DATA lt_codeiddesc_db_ins TYPE /bvccsap/k7_501t_tt.
    DATA lt_codeidvalue_db_ins TYPE /bvccsap/k7_0502_tt.
    DATA lt_codeidvaluedesc_db_ins TYPE /bvccsap/k7_502t_tt.
    DATA lt_codeidselection_db_ins TYPE /bvccsap/k7_0507_tt.
    DATA lt_codeid_db_upd TYPE /bvccsap/k7_0501_tt.
    DATA lt_codeiddesc_db_upd TYPE /bvccsap/k7_501t_tt.
    DATA lt_codeidvalue_db_upd TYPE /bvccsap/k7_0502_tt.
    DATA lt_codeidvaluedesc_db_upd TYPE /bvccsap/k7_502t_tt.
    DATA lt_codeidselection_db_upd TYPE /bvccsap/k7_0507_tt.
    DATA lt_codeidselection_db_del TYPE /bvccsap/k7_0507_tt.
    DATA ls_codeid_db_ins LIKE LINE OF lt_codeid_db_ins.
    DATA ls_codeiddesc_db_ins LIKE LINE OF lt_codeiddesc_db_ins.
    DATA ls_codeidvalue_db_ins LIKE LINE OF lt_codeidvalue_db_ins.
    DATA ls_codeidvaluedesc_db_ins LIKE LINE OF lt_codeidvaluedesc_db_ins.
    DATA ls_codeidselection_db_ins LIKE LINE OF lt_codeidselection_db_ins.
    DATA ls_codeid_db_upd LIKE LINE OF lt_codeid_db_upd.
    DATA ls_codeiddesc_db_upd LIKE LINE OF lt_codeiddesc_db_upd.
    DATA ls_codeidvalue_db_upd LIKE LINE OF lt_codeidvalue_db_upd.
    DATA ls_codeidvaluedesc_db_upd LIKE LINE OF lt_codeidvaluedesc_db_upd.
    DATA ls_codeidselection_db_upd LIKE LINE OF lt_codeidselection_db_upd.
    DATA ls_codeidselection_db_del LIKE LINE OF lt_codeidselection_db_del.

    "Die aktuelle Version wird komplett überschrieben
    IF mv_new_version_active EQ abap_false AND mv_initial_load EQ abap_true.
      delete_sc( ).
    ENDIF.
    CLEAR: lt_codeid_db_ins, lt_codeidvalue_db_ins, lt_codeidvaluedesc_db_ins, lt_codeidselection_db_ins,
           lt_codeid_db_upd, lt_codeidvalue_db_upd, lt_codeidvaluedesc_db_upd, lt_codeidselection_db_upd,
           lt_codeidselection_db_del.

    LOOP AT mt_codeid ASSIGNING FIELD-SYMBOL(<lfs_codeid>).
      IF <lfs_codeid>-iud EQ 'I'.
        MOVE-CORRESPONDING <lfs_codeid> TO ls_codeid_db_ins.
        ls_codeid_db_ins-mandt = sy-mandt.
        APPEND ls_codeid_db_ins TO lt_codeid_db_ins.
        MOVE-CORRESPONDING <lfs_codeid> TO ls_codeiddesc_db_ins.
        ls_codeiddesc_db_ins-spras = 'D'.
        APPEND ls_codeiddesc_db_ins TO lt_codeiddesc_db_ins.
      ELSEIF <lfs_codeid>-iud EQ 'D' OR <lfs_codeid>-iud EQ 'U'.
        MOVE-CORRESPONDING <lfs_codeid> TO ls_codeid_db_upd.
        ls_codeid_db_upd-mandt = sy-mandt.
        APPEND ls_codeid_db_upd TO lt_codeid_db_upd.
        MOVE-CORRESPONDING <lfs_codeid> TO ls_codeiddesc_db_upd.
        ls_codeiddesc_db_upd-spras = 'D'.
        APPEND ls_codeiddesc_db_upd TO lt_codeiddesc_db_upd.
      ENDIF.
      IF <lfs_codeid>-systemid NE /bvccsap/cl_k7_codelist_ass=>gc_systemid_sap.
        LOOP AT <lfs_codeid>-codeidvalues ASSIGNING FIELD-SYMBOL(<lfs_codeidvalues>).
          IF <lfs_codeidvalues>-iud EQ 'I'.
            MOVE-CORRESPONDING <lfs_codeid> TO ls_codeidvalue_db_ins.
            MOVE-CORRESPONDING <lfs_codeidvalues> TO ls_codeidvalue_db_ins.
            ls_codeidvalue_db_ins-mandt = sy-mandt.
            APPEND ls_codeidvalue_db_ins TO lt_codeidvalue_db_ins.
            LOOP AT <lfs_codeidvalues>-codeidvaluedesc ASSIGNING FIELD-SYMBOL(<lfs_codeidvaluesdesc>)
              WHERE codevalueiddesc IS NOT INITIAL.
              MOVE-CORRESPONDING <lfs_codeid> TO ls_codeidvaluedesc_db_ins.
              MOVE-CORRESPONDING <lfs_codeidvalues> TO ls_codeidvaluedesc_db_ins.
              MOVE-CORRESPONDING <lfs_codeidvaluesdesc> TO ls_codeidvaluedesc_db_ins.
              ls_codeidvaluedesc_db_ins-mandt = sy-mandt.
              APPEND ls_codeidvaluedesc_db_ins TO lt_codeidvaluedesc_db_ins.
            ENDLOOP.
          ELSEIF <lfs_codeidvalues>-iud EQ 'D' OR <lfs_codeidvalues>-iud EQ 'U'.
            MOVE-CORRESPONDING <lfs_codeid> TO ls_codeidvalue_db_upd.
            MOVE-CORRESPONDING <lfs_codeidvalues> TO ls_codeidvaluedesc_db_upd.
            MOVE-CORRESPONDING <lfs_codeidvalues> TO ls_codeidvalue_db_upd.
            ls_codeidvalue_db_upd-mandt = sy-mandt.
            APPEND ls_codeidvalue_db_upd TO lt_codeidvalue_db_upd.
            LOOP AT <lfs_codeidvalues>-codeidvaluedesc ASSIGNING <lfs_codeidvaluesdesc>
              WHERE codevalueiddesc IS NOT INITIAL.
              MOVE-CORRESPONDING <lfs_codeid> TO ls_codeidvaluedesc_db_upd.
              MOVE-CORRESPONDING <lfs_codeidvaluesdesc> TO ls_codeidvaluedesc_db_upd.
              ls_codeidvaluedesc_db_upd-mandt = sy-mandt.
              APPEND ls_codeidvaluedesc_db_ins TO lt_codeidvaluedesc_db_upd.
            ENDLOOP.
          ENDIF.
        ENDLOOP.
      ELSE.
        LOOP AT <lfs_codeid>-codeidselection ASSIGNING FIELD-SYMBOL(<lfs_codeidselection>) WHERE codeid IS NOT INITIAL.
          IF <lfs_codeidselection>-iud EQ 'I'.
            MOVE-CORRESPONDING <lfs_codeidselection> TO ls_codeidselection_db_ins.
            ls_codeidselection_db_ins-mandt = sy-mandt.
            APPEND ls_codeidselection_db_ins TO lt_codeidselection_db_ins.
          ELSEIF <lfs_codeidselection>-iud EQ 'D'.
            MOVE-CORRESPONDING <lfs_codeidselection> TO ls_codeidselection_db_del.
            ls_codeidselection_db_del-mandt = sy-mandt.
            APPEND ls_codeidselection_db_del TO lt_codeidselection_db_del.
          ELSEIF <lfs_codeidselection>-iud EQ 'U'.
            MOVE-CORRESPONDING <lfs_codeidselection> TO ls_codeidselection_db_upd.
            ls_codeidselection_db_upd-mandt = sy-mandt.
            APPEND ls_codeidselection_db_upd TO lt_codeidselection_db_upd.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.

    IF lines( lt_codeidselection_db_del ) > 0.
      DELETE /bvccsap/k7_0507 FROM TABLE lt_codeidselection_db_del.
      IF sy-subrc NE 0.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_type = 'E'
            message_v1   = '"K7_0507:CodeId Selektionskriterien"'
            textid       = /bvccsap/cx_k7_codelist_data=>delete_error.
      ENDIF.
    ENDIF.

    INSERT /bvccsap/k7_0501 FROM TABLE lt_codeid_db_ins.
    IF sy-subrc EQ 0.
      INSERT /bvccsap/k7_501t FROM TABLE lt_codeiddesc_db_ins.
      IF sy-subrc EQ 0.
        INSERT /bvccsap/k7_0507 FROM TABLE lt_codeidselection_db_ins.
        IF sy-subrc EQ 0.
          INSERT /bvccsap/k7_0502 FROM TABLE lt_codeidvalue_db_ins.
          IF sy-subrc EQ 0.
            INSERT /bvccsap/k7_502t FROM TABLE lt_codeidvaluedesc_db_ins.
            IF sy-subrc NE 0.
              RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
                EXPORTING
                  message_type = 'E'
                  message_v1   = '"K7_0502T:Texttabelle CodeIdValue"'
                  textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
            ENDIF.
          ELSE.
            RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
              EXPORTING
                message_type = 'E'
                message_v1   = '"K7_0502:CodeIdValue"'
                textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
          ENDIF.
        ELSE.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
            EXPORTING
              message_type = 'E'
              message_v1   = '"K7_0507:CodeId Selektionskriterien"'
              textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
        ENDIF.
      ELSE.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_type = 'E'
            message_v1   = '"K7_0501T:Texttabelle CodeId"'
            textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
      ENDIF.
    ELSE.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0501:CodeId"'
          textid       = /bvccsap/cx_k7_codelist_data=>insert_error.
    ENDIF.

    UPDATE /bvccsap/k7_0501 FROM TABLE lt_codeid_db_upd.
    IF sy-subrc EQ 0.
      UPDATE /bvccsap/k7_501t FROM TABLE lt_codeiddesc_db_upd.

      IF sy-subrc EQ 0.
        INSERT /bvccsap/k7_0507 FROM TABLE lt_codeidselection_db_upd.
        IF sy-subrc EQ 0.
          UPDATE /bvccsap/k7_0502 FROM TABLE lt_codeidvalue_db_upd.
          IF sy-subrc EQ 0.
            UPDATE  /bvccsap/k7_502t FROM TABLE lt_codeidvaluedesc_db_upd.
            IF sy-subrc NE 0.
              RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
                EXPORTING
                  message_type = 'E'
                  message_v1   = '"K7_0502T:Texttabelle CodeIdValue"'
                  textid       = /bvccsap/cx_k7_codelist_data=>update_error.
            ENDIF.
          ELSE.
            RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
              EXPORTING
                message_type = 'E'
                message_v1   = '"K7_0502:CodeIdValue"'
                textid       = /bvccsap/cx_k7_codelist_data=>update_error.
          ENDIF.
        ELSE.
          RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
            EXPORTING
              message_type = 'E'
              message_v1   = '"K7_0507:CodeId Selektionskriterien"'
              textid       = /bvccsap/cx_k7_codelist_data=>update_error.
        ENDIF.
      ELSE.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_type = 'E'
            message_v1   = '"K7_0501T:Texttabelle CodeId"'
            textid       = /bvccsap/cx_k7_codelist_data=>update_error.
      ENDIF.
    ELSE.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
        EXPORTING
          message_type = 'E'
          message_v1   = '"K7_0501:CodeId"'
          textid       = /bvccsap/cx_k7_codelist_data=>update_error.
    ENDIF.

  ENDMETHOD.


  METHOD update_transport.
    TRY.
        DATA lx_trsp_exc TYPE REF TO /bvccsap/cx_k7_transport.
        DATA lt_keylist TYPE  /bvccsap/k7_keylist_tt.
        DATA ls_keylist  LIKE LINE OF lt_keylist.
        FIELD-SYMBOLS <lfs_info_carrier> LIKE LINE OF mt_info_carrier.
        FIELD-SYMBOLS <lfs_canton> LIKE LINE OF ms_ch_topol_data-cantons.
        FIELD-SYMBOLS <lfs_district> LIKE LINE OF ms_ch_topol_data-districts.
        FIELD-SYMBOLS <lfs_municipality> LIKE LINE OF ms_ch_topol_data-municipalities.
        CLEAR: ls_keylist, lt_keylist.
        ls_keylist-tabname = '/BVCCSAP/K7_0560'.

        IF mv_new_version_active EQ abap_true.
          CONCATENATE sy-mandt  ms_new_codelist_version-codelist_type ms_new_codelist_version-version_id
          INTO ls_keylist-tabkey RESPECTING BLANKS.
        ELSE.
          CONCATENATE sy-mandt ms_current_codelist_version-codelist_type ms_current_codelist_version-version_id
          INTO ls_keylist-tabkey RESPECTING BLANKS.

        ENDIF.
        APPEND ls_keylist TO lt_keylist.

        FIELD-SYMBOLS <lfs_change_log> LIKE LINE OF mt_change_log.
        LOOP AT mt_change_log ASSIGNING <lfs_change_log> WHERE new = abap_true..
          ls_keylist-tabname = '/BVCCSAP/K7_0561'.
          CONCATENATE sy-mandt <lfs_change_log>-codelist_type <lfs_change_log>-version_id <lfs_change_log>-log_id
          INTO ls_keylist-tabkey RESPECTING BLANKS.
          APPEND ls_keylist TO lt_keylist.
        ENDLOOP.

        CASE mv_codelist_type.
          WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ic.
            LOOP AT mt_info_carrier ASSIGNING <lfs_info_carrier>.
              CLEAR ls_keylist.
              ls_keylist-tabname = '/BVCCSAP/K7_0550'.
              CONCATENATE sy-mandt <lfs_info_carrier>-info_carrier_id <lfs_info_carrier>-version_id
              INTO ls_keylist-tabkey RESPECTING BLANKS.
              APPEND ls_keylist TO lt_keylist.
            ENDLOOP.
          WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_rtc.
            LOOP AT ms_ch_topol_data-cantons ASSIGNING <lfs_canton>.
              CLEAR ls_keylist.
              ls_keylist-tabname = '/BVCCSAP/K7_0552'.
              CONCATENATE sy-mandt <lfs_canton>-cantonid <lfs_canton>-version_id
              INTO ls_keylist-tabkey RESPECTING BLANKS.
              APPEND ls_keylist TO lt_keylist.
            ENDLOOP.
            LOOP AT ms_ch_topol_data-districts ASSIGNING <lfs_district>.
              CLEAR ls_keylist.
              ls_keylist-tabname = '/BVCCSAP/K7_0551'.
              CONCATENATE sy-mandt <lfs_district>-districthistid <lfs_district>-version_id
              INTO ls_keylist-tabkey RESPECTING BLANKS.
              APPEND ls_keylist TO lt_keylist.
            ENDLOOP.
            LOOP AT ms_ch_topol_data-municipalities ASSIGNING <lfs_municipality>.
              CLEAR ls_keylist.
              ls_keylist-tabname = '/BVCCSAP/K7_0553'.
              CONCATENATE sy-mandt <lfs_municipality>-historymunicipalityid <lfs_municipality>-version_id
              INTO ls_keylist-tabkey RESPECTING BLANKS.
              APPEND ls_keylist TO lt_keylist.
            ENDLOOP.
          WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_sc.
            LOOP AT mt_codeid ASSIGNING FIELD-SYMBOL(<lfs_codeid>).
              IF <lfs_codeid>-iud IS NOT INITIAL.
                CLEAR ls_keylist.
                ls_keylist-tabname = '/BVCCSAP/K7_0501'.
                CONCATENATE sy-mandt <lfs_codeid>-systemid <lfs_codeid>-codeid
                INTO ls_keylist-tabkey RESPECTING BLANKS.
                APPEND ls_keylist TO lt_keylist.
                CLEAR ls_keylist.
                ls_keylist-tabname = '/BVCCSAP/K7_501T'.
                CONCATENATE sy-mandt <lfs_codeid>-systemid <lfs_codeid>-codeid 'D'
                INTO ls_keylist-tabkey RESPECTING BLANKS.
                APPEND ls_keylist TO lt_keylist.
              ENDIF.
              IF <lfs_codeid>-systemid NE /bvccsap/cl_k7_codelist_ass=>gc_systemid_sap.
                LOOP AT <lfs_codeid>-codeidvalues ASSIGNING FIELD-SYMBOL(<lfs_codeidvalues>)
                  WHERE iud IS NOT INITIAL.
                  CLEAR ls_keylist.
                  ls_keylist-tabname = '/BVCCSAP/K7_0502'.
                  CONCATENATE sy-mandt <lfs_codeid>-systemid <lfs_codeid>-codeid <lfs_codeidvalues>-version_id <lfs_codeidvalues>-codeidvalue
                  INTO ls_keylist-tabkey RESPECTING BLANKS.
                  APPEND ls_keylist TO lt_keylist.
                  LOOP AT <lfs_codeidvalues>-codeidvaluedesc ASSIGNING FIELD-SYMBOL(<lfs_codeidvaluesdesc>)
                    WHERE codevalueiddesc IS NOT INITIAL.
                    CLEAR ls_keylist.
                    ls_keylist-tabname = '/BVCCSAP/K7_502T'.
                    CONCATENATE sy-mandt <lfs_codeid>-systemid <lfs_codeid>-codeid <lfs_codeidvalues>-version_id <lfs_codeidvalues>-codeidvalue <lfs_codeidvaluesdesc>-spras
                    INTO ls_keylist-tabkey RESPECTING BLANKS.
                    APPEND ls_keylist TO lt_keylist.
                  ENDLOOP.
                ENDLOOP.
              ELSE.
                LOOP AT <lfs_codeid>-codeidselection ASSIGNING FIELD-SYMBOL(<lfs_codeidselection>)
                 WHERE iud IS NOT INITIAL.
                  CLEAR ls_keylist.
                  ls_keylist-tabname = '/BVCCSAP/K7_0507'.
                  CONCATENATE sy-mandt <lfs_codeidselection>-systemid <lfs_codeidselection>-codeid <lfs_codeidselection>-fieldname <lfs_codeidselection>-rec_nr
                  INTO ls_keylist-tabkey RESPECTING BLANKS.
                  APPEND ls_keylist TO lt_keylist.
                ENDLOOP.
              ENDIF.
            ENDLOOP.
          WHEN /bvccsap/cl_k7_codelist_ass=>gc_codelist_type_ec.
            LOOP AT mt_error_code ASSIGNING FIELD-SYMBOL(<lfs_error_code>).
              CLEAR ls_keylist.
              ls_keylist-tabname = '/BVCCSAP/K7_0504'.
              CONCATENATE sy-mandt <lfs_error_code>-systemid <lfs_error_code>-serviceid <lfs_error_code>-messageid <lfs_error_code>-version_id
              INTO ls_keylist-tabkey RESPECTING BLANKS.
              APPEND ls_keylist TO lt_keylist.
              DATA lv_spras TYPE spras.
              DATA lo_struct_descr TYPE REF TO cl_abap_structdescr.
              TRY.
                  lo_struct_descr ?= cl_abap_typedescr=>describe_by_data( <lfs_error_code> ).
                CATCH cx_sy_move_cast_error.
                  RETURN.
              ENDTRY.
              LOOP AT lo_struct_descr->components ASSIGNING FIELD-SYMBOL(<lfs_comp_descr>)
              WHERE name(13) = 'MESSAGEIDDESC'.
                ASSIGN COMPONENT sy-tabix OF STRUCTURE <lfs_error_code> TO FIELD-SYMBOL(<lfs_ws_field>).
                IF sy-subrc EQ 0.
                  lv_spras = <lfs_comp_descr>-name+14(2).
                  CLEAR ls_keylist.
                  ls_keylist-tabname = '/BVCCSAP/K7_504T'.
                  CONCATENATE sy-mandt <lfs_error_code>-systemid <lfs_error_code>-serviceid <lfs_error_code>-messageid <lfs_error_code>-version_id lv_spras
                  INTO ls_keylist-tabkey RESPECTING BLANKS.
                  APPEND ls_keylist TO lt_keylist.
                ENDIF.

              ENDLOOP.

            ENDLOOP.
        ENDCASE.
        mo_transport_hndl->check_update_transport( EXPORTING it_keylist = lt_keylist ).
      CATCH /bvccsap/cx_k7_transport INTO lx_trsp_exc.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_id     = lx_trsp_exc->message_id
            message_type   = lx_trsp_exc->message_type
            message_number = lx_trsp_exc->message_number
            message_v1     = lx_trsp_exc->message_v1
            message_v2     = lx_trsp_exc->message_v2
            message_v3     = lx_trsp_exc->message_v3
            message_v4     = lx_trsp_exc->message_v4.
    ENDTRY.
  ENDMETHOD.


  METHOD update_version.
    DATA ls_k7_0560 TYPE /bvccsap/k7_0560.
    IF ms_new_codelist_version IS NOT INITIAL.
      MOVE-CORRESPONDING ms_new_codelist_version TO ls_k7_0560.
      INSERT INTO /bvccsap/k7_0560 VALUES @ls_k7_0560.
      IF sy-subrc NE 0.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_codelist_data
          EXPORTING
            message_type = 'E'
            message_v1   = '"K7_0560:Codelisten Version"'
            textid       = /bvccsap/cx_k7_codelist_data=>update_error.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
