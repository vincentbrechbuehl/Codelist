*----------------------------------------------------------------------*
*       CLASS /BVCCSAP/CL_K7_XLSX_writer DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class /BVCCSAP/CL_K7_XSLX_WRITER definition
  public
  final
  create public .

public section.
  type-pools ABAP .
  class ZCL_XLSX definition load .
  class ZCL_XLSX_WRITER definition load .

  types:
    BEGIN OF ys_format_exception,
        row         TYPE i,
        col         TYPE i,
        style_alias TYPE string,
      END OF ys_format_exception .
  types:
    ys_format_exceptions TYPE HASHED TABLE OF ys_format_exception WITH UNIQUE KEY row col .
  types:
    BEGIN OF ys_allignment,
        text_rotation TYPE i,
      END OF ys_allignment .
  types:
    BEGIN OF ys_abap_meta.
            INCLUDE TYPE dfies.
    TYPES:
      z_style  TYPE string,
      z_header TYPE string,
      z_width  TYPE i,
      END OF ys_abap_meta .
  types:
    ys_abap_metas TYPE TABLE OF ys_abap_meta .
  types:
    BEGIN OF ys_doc_prop,
        fmtid      TYPE string,
        pid        TYPE string,
        prop_name  TYPE string,
        prop_value TYPE string,
      END OF ys_doc_prop .
  types:
    ys_doc_props TYPE TABLE OF ys_doc_prop .
  types:
    BEGIN OF ys_columninfo,
        columnid   TYPE string,
        field      TYPE string,
        width      TYPE i,
        properties TYPE if_salv_bs_model_column=>s_type_uie_properties,
        attribute  TYPE if_salv_bs_t_data=>s_type_attribute,
      END OF ys_columninfo .
  types:
    yt_columninfo TYPE HASHED TABLE OF ys_columninfo WITH UNIQUE KEY columnid .
  types:
    BEGIN OF ys_style_numfmt,
        id    TYPE i,
        alias TYPE string,
        code  TYPE string,
      END OF ys_style_numfmt .
  types:
    BEGIN OF ys_style_cellxf,
        id         TYPE i,
        alias      TYPE string,
        numfmtid   TYPE i,
        fontid     TYPE i,
        fillid     TYPE i,
        borderid   TYPE i,
        is_string  TYPE i,
        indent     TYPE i,
        xfid       TYPE i,
        wrap       TYPE i,
        key        TYPE string,
        allignment TYPE ys_allignment,
      END OF ys_style_cellxf .
  types:
    BEGIN OF ys_font,
        id        TYPE i,
        alias     TYPE string,
        name      TYPE string,
        size      TYPE i,
        bold      TYPE boolean,
        italic    TYPE boolean,
        underline TYPE boolean,
        color_rgb TYPE string,
      END OF ys_font .
  types:
    BEGIN OF ys_fill,
        id              TYPE i,
        alias           TYPE string,
        patterntype     TYPE string,
        fgcolor_rgb     TYPE string,
        bgcolor_indexed TYPE i,
      END OF ys_fill .
  types:
    BEGIN OF ys_border,
        id               TYPE i,
        alias            TYPE string,
        left_style       TYPE string,
        left_color_rgb   TYPE string,
        right_style      TYPE string,
        right_color_rgb  TYPE string,
        top_style        TYPE string,
        top_color_rgb    TYPE string,
        bottom_style     TYPE string,
        bottom_color_rgb TYPE string,
      END OF ys_border .
  types:
    BEGIN OF ys_style_struc,
        t_fonts          TYPE HASHED TABLE OF ys_font WITH UNIQUE KEY alias,
        t_fills          TYPE HASHED TABLE OF ys_fill WITH UNIQUE KEY alias,
        t_borders        TYPE HASHED TABLE OF ys_border WITH UNIQUE KEY alias,
        t_numfmts        TYPE HASHED TABLE OF ys_style_numfmt WITH UNIQUE KEY alias,
        t_cellxfs        TYPE HASHED TABLE OF ys_style_cellxf WITH UNIQUE KEY alias,
        numfonts_count   TYPE i,
        numfills_count   TYPE i,
        numborders_count TYPE i,
        numfmts_count    TYPE i,
        cellxfs_count    TYPE i,
      END OF ys_style_struc .
  types:
    BEGIN OF ys_sharedstring,
        value TYPE string,
        pos   TYPE i,
      END OF ys_sharedstring .
  types:
    yth_sharedstring TYPE STANDARD TABLE OF ys_sharedstring WITH NON-UNIQUE KEY value .
  types:
    BEGIN OF ys_sharedstring_struc,
        t_strings     TYPE yth_sharedstring,
        string_count  TYPE i,
        string_ucount TYPE i,
      END OF ys_sharedstring_struc .
  types:
    BEGIN OF ys_cell_struc,
        position     TYPE string,
        value        TYPE string,
        index        TYPE i,
        style        TYPE i,
        sharedstring TYPE string,
      END OF ys_cell_struc .
  types:
    BEGIN OF ys_col_struc,
        min     TYPE i,
        max     TYPE i,
        bestfit TYPE i,
        width   TYPE i,
      END OF ys_col_struc .
  types:
    BEGIN OF ys_hyperlink_struc,
        rel_id  TYPE string,
        cell_id TYPE string,
      END OF ys_hyperlink_struc .
  types:
    BEGIN OF ys_row_struc,
        spans        TYPE string,
        position     TYPE i,
        outlinelevel TYPE i,
        hidden       TYPE char1,
        height       TYPE i,
        t_cells      TYPE STANDARD TABLE OF ys_cell_struc WITH NON-UNIQUE KEY position,
      END OF ys_row_struc .
  types:
    BEGIN OF ys_merged_cell,
        ref TYPE string,
      END OF ys_merged_cell .
  types:
    BEGIN OF ys_sheet_struc,
        dim                TYPE string,
        defaultrowheight   TYPE i,
        merged_cells_count TYPE i,
        t_merged_cells     TYPE STANDARD TABLE OF ys_merged_cell WITH NON-UNIQUE KEY ref,
        s_header_row       TYPE ys_row_struc,
        t_header_rows      TYPE STANDARD TABLE OF ys_row_struc WITH NON-UNIQUE KEY position,
        t_body_rows        TYPE STANDARD TABLE OF ys_row_struc WITH NON-UNIQUE KEY position,
        t_footer_rows      TYPE STANDARD TABLE OF ys_row_struc WITH NON-UNIQUE KEY position,
        t_cols             TYPE STANDARD TABLE OF ys_col_struc WITH NON-UNIQUE KEY min,
        t_hyperlinks       TYPE STANDARD TABLE OF ys_hyperlink_struc WITH NON-UNIQUE KEY cell_id,
        drawing_id         TYPE string,
      END OF ys_sheet_struc .

  constants STYLE_HEADER type STRING value 'header' ##NO_TEXT.
  constants STYLE_TEXT_DEFAULT type STRING value 'normalText' ##NO_TEXT.
  constants STYLE_DATE_DEFAULT type STRING value 'date' ##NO_TEXT.
  constants STYLE_TIME_DEFAULT type STRING value 'timeNormal' ##NO_TEXT.
  constants STYLE_GRAY125 type STRING value 'gray125' ##NO_TEXT.
  constants STYLE_DEFAULT type STRING value 'default' ##NO_TEXT.
  constants STYLE_NUMBER_DEFAULT type STRING value 'normalNumber' ##NO_TEXT.
  constants RGB_BLUE type STRING value 'FF00CCFF' ##NO_TEXT.
  constants RGB_GRAY_25 type STRING value 'FFC0C0C0' ##NO_TEXT.
  constants RGB_BRIGHT_GREEN type STRING value 'FF00FF00' ##NO_TEXT.
  constants INDEXED_COL_SYS_BACKGROUND type I value 64 ##NO_TEXT.
  constants FILL_PATTERN_SOLID type STRING value 'solid' ##NO_TEXT.
  constants RGB_YELLOW type STRING value 'FFFFFF00' ##NO_TEXT.
  constants C_DEFAULT_ROW_HEIGHT type I value 13 ##NO_TEXT.
  constants C_TYPE_STRING type C value 'C' ##NO_TEXT.
  data COLS_EXCLUDED type STRING_TABLE .

  methods CONSTRUCTOR
    importing
      !IV_DATA type XSTRING optional
      !SHEET_CONTENT type ANY TABLE optional
      !IM_ROW_HEIGHT_HEADER type I default C_DEFAULT_ROW_HEIGHT
      !IM_ROW_HEIGHT_BODY type I default C_DEFAULT_ROW_HEIGHT
      !IT_COLS_EXCL type STRING_TABLE optional .
  methods GET_WORKSHEETS
    importing
      !IV_INDEX type I
    returning
      value(RO_PART) type ref to CL_XLSX_WORKBOOKPART .
  class-methods BROWSE_SERVER_FS
    changing
      !FILENAME type ANY .
  methods SAVE_FILE_TO_SERVER
    importing
      !FS_FILENAME type ANY
    exceptions
      ERROR_WRITING_FILE .
  class-methods BROWSE_CLIENT_FS
    changing
      !FILENAME type ANY .
  methods SAVE_FILE_TO_CLIENT
    importing
      !FS_FILENAME type ANY
      !START_EXCEL type BOOLEAN default ABAP_FALSE
    exceptions
      ERROR_WRITING_FILE .
  methods GET_FILE_AS_EMAIL_ATTACHMENT
    exporting
      value(XLSX_ATTACHMENT) type SOLIX_TAB
      !ATTACHMENT_LENGHT type SO_OBJ_LEN .
  methods GET_FILE_AS_XSTRING
    returning
      value(XLSX_AS_XSTRING) type XSTRING .
  methods ADD_CUSTOM_DOC_PROPERTY
    importing
      !PROPERTY_NAME type ANY
      !PROPERTY_VALUE type ANY .
  methods SET_DEFAULT_COLUMNS .
  methods GET_CELLPOSITION
    importing
      !ROW type I
      !COL type I
    returning
      value(RESULT) type STRING .
  methods INSERT_STYLE
    importing
      !ALIAS type STRING
      !FONT_ALIAS type STRING default 'default'
      !FILL_ALIAS type STRING default 'none'
      !BORDER_ALIAS type STRING default 'default'
      !NUMFORMAT_ALIAS type STRING default 'default'
      !NUMFORMAT_ID type I optional
      !TEXT_ROTATION type I optional .
  methods INSERT_FONT
    importing
      !ALIAS type STRING
      !NAME type STRING
      !SIZE type I
      !BOLD type BOOLEAN default ABAP_FALSE
      !ITALIC type BOOLEAN default ABAP_FALSE
      !UNDERLINE type BOOLEAN default ABAP_FALSE
      !COLOR_RGB type STRING optional .
  methods INSERT_FILL
    importing
      !ALIAS type STRING
      !PATTERNTYPE type STRING optional
      !FGCOLOR_RGB type STRING optional
      !BGCOLOR_INDEXED type I optional .
  methods INSERT_BORDER
    importing
      !ALIAS type STRING
      !LEFT_STYLE type STRING optional
      !LEFT_COLOR_RGB type STRING optional
      !RIGHT_STYLE type STRING optional
      !RIGHT_COLOR_RGB type STRING optional
      !TOP_STYLE type STRING optional
      !TOP_COLOR_RGB type STRING optional
      !BOTTOM_STYLE type STRING optional
      !BOTTOM_COLOR_RGB type STRING optional .
  methods BUILD_ABAP_META .
  methods GET_ABAP_META
    exporting
      value(EX_ABAP_META) type YS_ABAP_METAS .
  methods SET_ABAP_META
    importing
      value(FIELDNAME) type FIELDNAME
      !HEADER type ANY optional
      !WIDTH type I optional .
  methods BUILD
    importing
      !ADD_DEFAULT_HEADER type BOOLEAN default ABAP_TRUE .
  methods FEED_DATA_HEADER
    importing
      !HEADERS type YS_ABAP_METAS
      !STYLE type STRING default STYLE_HEADER .
  methods FEED_DATA_BODY
    importing
      !CONTENT type ANY TABLE .
  methods ADD_STYLE_EXCEPTION
    importing
      !STYLE_ALIAS type STRING
      !ROW type I optional
      !COL type I optional .
  methods MERGE_CELLS
    importing
      !ROW_START type I
      !COL_START type I
      !ROW_END type I
      !COL_END type I .
  methods GET_XLSX_FILE_RAW
    returning
      value(EV_XSTRING) type XSTRING .
  methods ATTACH_FILE_TO_RESPONSE
    importing
      !I_FILENAME type STRING .
  PROTECTED SECTION.

    DATA abap_meta TYPE ys_abap_metas .
    DATA sheet_struct TYPE ys_sheet_struc .
    DATA sharedstring_struct TYPE ys_sharedstring_struc .
    DATA style_struct TYPE ys_style_struc .
    CONSTANTS c_decimals_format TYPE char26 VALUE '0.000000000'. "#EC NOTEXT
    DATA xlsx_document TYPE REF TO cl_xlsx_document .
    DATA xlsx_file_raw TYPE xstring .
    DATA custom_doc_props TYPE ys_doc_props .
    CONSTANTS c_docprop_abap_struc TYPE string VALUE 'SapStruc'. "#EC NOTEXT
    DATA abap_sheet_content TYPE REF TO data .
private section.

  data ROW_HEIGHT_HEADER type I .
  data ROW_HEIGHT_BODY type I .
  data ROW_INDEX type I .
  data SPANS type STRING .
  data STYLE_EXCEPTIONS type YS_FORMAT_EXCEPTIONS .

  methods SET_CONTENT
    importing
      !SHEET_CONTENT type ANY TABLE .
  methods INSERT_MANDATORY_STYLES .
  methods INSERT_DEFAULT_STYLES .
  methods INSERT_MANDATORY_FONTS .
  methods INSERT_MANDATORY_FILLS .
  methods GET_FILL_ID_FROM_ALIAS
    importing
      !ALIAS type STRING
    returning
      value(ID) type I .
  methods INSERT_MANDATORY_BORDERS .
  methods GET_BORDER_ID_FROM_ALIAS
    importing
      !ALIAS type STRING
    returning
      value(ID) type I .
  methods INSERT_NUMBER_FORMAT
    importing
      !ALIAS type STRING
      !CODE type STRING .
  methods INSERT_MANDATORY_NUMBER_FORMAT .
  methods GET_NUMFMT_ID_FROM_ALIAS
    importing
      !ALIAS type STRING
    returning
      value(ID) type I .
  methods CREATE_CELLS
    importing
      !ROW_INDEX type I .
  methods ADD_SHAREDSTRING
    importing
      !I_SHAREDSTRING type STRING
    exporting
      !E_INDEX type I .
  methods TRANSFORM_TO_XSLX .
  methods GET_STYLE
    importing
      !ALIAS type STRING
      !ROW type I
      !COL type I
    returning
      value(STYLE_ID) type I .
  methods SET_SPANS .
  methods GET_FONT_ID_FROM_ALIS
    importing
      !ALIAS type STRING
    returning
      value(ID) type I .
ENDCLASS.



CLASS /BVCCSAP/CL_K7_XSLX_WRITER IMPLEMENTATION.


  METHOD add_custom_doc_property.

    DATA:
      ls_doc_prop LIKE LINE OF custom_doc_props,
      lv_pid      TYPE sytabix.

    ls_doc_prop-fmtid = '{d5cdd505-2e9c-101b-9397-08002b2cf9ae}'.
    DESCRIBE TABLE custom_doc_props LINES lv_pid .
    ADD 2 TO lv_pid.
    ls_doc_prop-pid = lv_pid.
    CONDENSE ls_doc_prop-pid NO-GAPS.
    ls_doc_prop-prop_name = property_name.
    ls_doc_prop-prop_value = property_value.
    APPEND ls_doc_prop TO custom_doc_props.

  ENDMETHOD.                    "ADD_CUSTOM_DOC_PROPERTY


  METHOD add_sharedstring.

    DATA: l_index         TYPE i,
          ls_sharedstring TYPE ys_sharedstring.

* Check: is the string already in our shared string table?
*    -> If yes, give me the position/index
*    -> In no, insert the string and give me then the position/index
    READ TABLE sharedstring_struct-t_strings WITH KEY value = i_sharedstring INTO ls_sharedstring.
    IF sy-subrc EQ 0.
*      nothing to do here
    ELSE.
      ADD 1 TO sharedstring_struct-string_ucount.
      CLEAR ls_sharedstring.
      ls_sharedstring-value = i_sharedstring.
      ls_sharedstring-pos = sharedstring_struct-string_ucount.
      APPEND ls_sharedstring TO sharedstring_struct-t_strings.
    ENDIF.

    ADD 1 TO sharedstring_struct-string_count.
    e_index = ls_sharedstring-pos - 1.


  ENDMETHOD.                    "ADD_SHAREDSTRING


  METHOD add_style_exception.
    DATA:
     ls_style_exception LIKE LINE OF style_exceptions.

    IF row IS INITIAL AND col IS INITIAL.
      EXIT.
    ENDIF.

    ls_style_exception-row = row.
    ls_style_exception-col = col.
    ls_style_exception-style_alias = style_alias.

    INSERT ls_style_exception INTO TABLE style_exceptions.

  ENDMETHOD.                    "ADD_STYLE_EXCEPTION


  METHOD attach_file_to_response.

    wdr_task=>client_window->client->attach_file_to_response(
      i_filename = i_filename
      i_content =  me->xlsx_file_raw
      i_mime_type = 'application/msexcel' ).

  ENDMETHOD.


  METHOD browse_client_fs.

    DATA:
      lv_fullpath TYPE string,
      lv_filename TYPE string,
      lv_path     TYPE string.

    CALL METHOD cl_gui_frontend_services=>file_save_dialog
      EXPORTING
        default_extension    = 'xlsx'
        file_filter          = 'Microft Excel Files (*.xlsx)|*.xlsx'
      CHANGING
        fullpath             = lv_fullpath
        filename             = lv_filename
        path                 = lv_path
      EXCEPTIONS
        cntl_error           = 1
        error_no_gui         = 2
        not_supported_by_gui = 3
        OTHERS               = 4.

    filename = lv_fullpath.
  ENDMETHOD.                    "BROWSE_CLIENT_FS


  METHOD browse_server_fs.
    CALL FUNCTION '/SAPDMC/LSM_F4_SERVER_FILE'
      EXPORTING
        directory        = '/usr/sap/tmp'
      IMPORTING
        serverfile       = filename
      EXCEPTIONS
        canceled_by_user = 1
        OTHERS           = 2.

  ENDMETHOD.                    "BROWSE_SERVER_FS


  METHOD build.

    FIELD-SYMBOLS:
      <li_sheet_content> TYPE ANY TABLE,
      <ls_sheet_content> TYPE any,
      <lv_cell_value>    TYPE any.

    DATA:
      lv_no_columns TYPE i,
      lv_no_rows    TYPE i,
      lv_dim        TYPE string.

    UNASSIGN <li_sheet_content>.
    ASSIGN abap_sheet_content->* TO <li_sheet_content>.

*Columns
    me->set_default_columns( ).

* Header
    IF add_default_header EQ abap_true.
      me->feed_data_header( headers = abap_meta ).
    ENDIF.

    me->set_spans( ).

*  Body
    me->feed_data_body( content = <li_sheet_content> ).
* create the xml streams
    me->transform_to_xslx( ).

  ENDMETHOD.                    "build


  METHOD build_abap_meta.
    DATA:
      lr_sheet_line          TYPE REF TO data,
      lr_type_descr          TYPE REF TO cl_abap_typedescr,
      lr_struc_descr         TYPE REF TO cl_abap_structdescr,
      ls_abap_meta           LIKE LINE OF abap_meta,
      ls_abap_compdescr      TYPE abap_compdescr,
      lr_table_descr         TYPE REF TO cl_abap_tabledescr,
      li_ddfields            TYPE ddfields,
      ls_ddfield             TYPE LINE OF ddfields,
      lv_tabix               TYPE sytabix,
      lv_num_format_part     TYPE i,
      lv_number_format_alias TYPE string,
      lv_number_format       TYPE string.

    lr_table_descr ?= cl_abap_tabledescr=>describe_by_data_ref( abap_sheet_content ).
    lr_struc_descr  ?= lr_table_descr->get_table_line_type( ).

    IF NOT abap_meta IS INITIAL.
      CLEAR abap_meta.
    ENDIF.
    CALL METHOD lr_struc_descr->get_ddic_field_list
      EXPORTING
        p_langu                  = sy-langu
        p_including_substructres = abap_true
      RECEIVING
        p_field_list             = li_ddfields
      EXCEPTIONS
        not_found                = 1
        no_ddic_type             = 2
        OTHERS                   = 3.

    IF sy-subrc EQ 0.
      LOOP AT li_ddfields INTO ls_ddfield.
        CLEAR ls_abap_meta.
        READ TABLE cols_excluded WITH KEY table_line = ls_ddfield-fieldname TRANSPORTING NO FIELDS.
        CHECK sy-subrc NE 0.
        MOVE-CORRESPONDING ls_ddfield TO ls_abap_meta.
        APPEND ls_abap_meta TO abap_meta.
      ENDLOOP.
    ELSE.
* no DDIC type - so retrieve the technical names
      LOOP AT lr_struc_descr->components INTO ls_abap_compdescr.
        CLEAR ls_abap_meta.
        ls_abap_meta-fieldname = ls_abap_compdescr-name.
        ls_abap_meta-inttype = ls_abap_compdescr-type_kind.
        ls_abap_meta-leng = ls_abap_meta-outputlen = ls_abap_compdescr-length.
        APPEND ls_abap_meta TO abap_meta.
      ENDLOOP.
    ENDIF.

*  set the default styles and default texts

    LOOP AT abap_meta INTO ls_abap_meta.
      lv_tabix = sy-tabix.
      CASE ls_abap_meta-inttype.
        WHEN cl_abap_typedescr=>typekind_packed
            OR cl_abap_typedescr=>typekind_int.
*         create a number format with the matching decimals
          CLEAR: lv_number_format_alias, lv_number_format.
          lv_number_format_alias = ls_abap_meta-fieldname.
          IF ls_abap_meta-decimals GT 0.
            lv_num_format_part = ls_abap_meta-decimals + 2.
            lv_number_format = c_decimals_format(lv_num_format_part).
          ENDIF.
          CONCATENATE '#,##' lv_number_format INTO lv_number_format.
          me->insert_number_format(
              alias  = lv_number_format_alias
              code   = lv_number_format ).
          me->insert_style(
                alias           = lv_number_format_alias
                numformat_alias = lv_number_format_alias ).
          ls_abap_meta-z_style =   lv_number_format_alias.
        WHEN cl_abap_typedescr=>typekind_date.
          ls_abap_meta-z_style = style_date_default.
        WHEN cl_abap_typedescr=>typekind_time.
          ls_abap_meta-z_style = style_time_default.
        WHEN OTHERS.
          ls_abap_meta-z_style = style_text_default.
      ENDCASE.

      ls_abap_meta-z_width = ls_abap_meta-outputlen + 2.
*    First try with DDIC fieldname
      IF NOT ls_abap_meta-fieldtext IS INITIAL AND strlen( ls_abap_meta-fieldtext ) LE ls_abap_meta-z_width.
        ls_abap_meta-z_header = ls_abap_meta-fieldtext.
      ELSEIF NOT ls_abap_meta-scrtext_l IS INITIAL AND strlen( ls_abap_meta-scrtext_l ) LE ls_abap_meta-z_width.
        ls_abap_meta-z_header = ls_abap_meta-scrtext_l.
      ELSEIF NOT ls_abap_meta-scrtext_m IS INITIAL AND strlen( ls_abap_meta-scrtext_m ) LE ls_abap_meta-z_width.
        ls_abap_meta-z_header = ls_abap_meta-scrtext_m.
      ELSEIF NOT ls_abap_meta-scrtext_s IS INITIAL AND strlen( ls_abap_meta-scrtext_s ) LE ls_abap_meta-z_width.
        ls_abap_meta-z_header = ls_abap_meta-scrtext_s.
      ELSEIF NOT ls_abap_meta-scrtext_s IS INITIAL.
        ls_abap_meta-z_header = ls_abap_meta-scrtext_s.
      ELSE.
        ls_abap_meta-z_header = ls_abap_meta-fieldname.
      ENDIF.

      IF ( strlen( ls_abap_meta-z_header ) + 2 ) GE ls_abap_meta-z_width.
        ls_abap_meta-z_width = strlen( ls_abap_meta-z_header ) + 2.
      ENDIF.

      MODIFY abap_meta FROM ls_abap_meta INDEX lv_tabix.
    ENDLOOP.

  ENDMETHOD.                    "build_abap_meta


  METHOD constructor.
    IF iv_data IS SUPPLIED AND iv_data IS NOT INITIAL.
      TRY .
          xlsx_document = cl_xlsx_document=>load_document( iv_data = iv_data ).
        CATCH cx_openxml_format.

      ENDTRY.

    ELSE.
      xlsx_document = cl_xlsx_document=>create_document( ).
      row_height_header = im_row_height_header.
      row_height_body  = im_row_height_body.
*Begin Added by AAD
      cols_excluded = it_cols_excl.
*End Added by AAD

      me->set_content( sheet_content = sheet_content ).
      me->build_abap_meta( ).
      me->insert_mandatory_styles( ).
      me->insert_default_styles( ).
    ENDIF.
  ENDMETHOD.                    "constructor


  METHOD create_cells.

    DATA:
      ls_cell     TYPE ys_cell_struc,
      l_col_index TYPE i.

    CALL METHOD me->get_cellposition
      EXPORTING
        row    = row_index
        col    = l_col_index
      RECEIVING
        result = ls_cell-position.

  ENDMETHOD.                    "CREATE_CELLS


  METHOD feed_data_body.

    DATA:
      ls_row              TYPE ys_row_struc,
      lv_current_col      TYPE sytabix,
      ls_abap_meta        LIKE LINE OF abap_meta,
      ls_cell             TYPE ys_cell_struc,
      lv_value            TYPE string,
      lv_date_xlsx_format TYPE string,
      lv_add_cell         TYPE boolean.

    FIELD-SYMBOLS:
      <ls_sheet_content> TYPE any,
      <lv_cell_value>    TYPE any.

    LOOP AT content ASSIGNING <ls_sheet_content>.
      ADD 1 TO row_index.
      CLEAR ls_row.
      lv_add_cell = abap_false.
      ls_row-spans = spans.
      IF row_height_body NE c_default_row_height.
        ls_row-height = row_height_body.
      ENDIF.
      ls_row-position = row_index.
*    now go column by column
      LOOP AT abap_meta INTO ls_abap_meta.
        lv_current_col = sy-tabix.
        ASSIGN COMPONENT ls_abap_meta-fieldname OF STRUCTURE <ls_sheet_content> TO <lv_cell_value>.

        CLEAR: lv_value, ls_cell.

        ls_cell-style = me->get_style(   alias     = ls_abap_meta-z_style
                                         row       = row_index
                                         col       = lv_current_col ).
        IF ls_cell-style NE 0.
          lv_add_cell = abap_true.
        ENDIF.

        CALL METHOD me->get_cellposition
          EXPORTING
            row    = row_index
            col    = lv_current_col
          RECEIVING
            result = ls_cell-position.
        IF ls_abap_meta-inttype EQ cl_abap_typedescr=>typekind_packed
          OR ls_abap_meta-inttype EQ cl_abap_typedescr=>typekind_int.
          IF NOT <lv_cell_value> IS INITIAL.
            lv_add_cell = abap_true.
            ls_cell-value = <lv_cell_value>.
          ENDIF.

        ELSEIF ls_abap_meta-inttype EQ cl_abap_typedescr=>typekind_date.

          IF NOT <lv_cell_value> IS INITIAL.
            lv_add_cell = abap_true.
            CALL METHOD cl_alv_xslt_transform=>get_days_since_1900
              EXPORTING
                i_date = <lv_cell_value>
              RECEIVING
                e_num  = ls_cell-value.
          ENDIF.

        ELSEIF ls_abap_meta-inttype EQ cl_abap_typedescr=>typekind_time.
          IF NOT <lv_cell_value> IS INITIAL.
            lv_add_cell = abap_true.

            CALL METHOD cl_alv_xslt_transform=>get_percent_of_act_day
              EXPORTING
                i_time = <lv_cell_value>
              RECEIVING
                e_num  = ls_cell-value.
          ENDIF.
        ELSE.
*        All the rest is string
          IF NOT <lv_cell_value> IS INITIAL.
            lv_add_cell = abap_true.

            ls_cell-sharedstring = 's'.
            lv_value = <lv_cell_value>.

            CALL METHOD me->add_sharedstring
              EXPORTING
                i_sharedstring = lv_value
              IMPORTING
                e_index        = ls_cell-index.
          ENDIF.
        ENDIF.
        IF lv_add_cell = abap_true.
          INSERT ls_cell INTO TABLE ls_row-t_cells.
        ENDIF.
      ENDLOOP.
      INSERT ls_row INTO TABLE sheet_struct-t_body_rows.
    ENDLOOP.

  ENDMETHOD.                    "feed_data_body


  METHOD feed_data_header.

    DATA:
      ls_row         TYPE ys_row_struc,
      ls_header      LIKE LINE OF headers,
      ls_cell        TYPE ys_cell_struc,
      lv_current_col TYPE sy-tabix,
      lv_add_cell    TYPE boolean.

    ADD 1 TO row_index.
    LOOP AT headers INTO ls_header.
      lv_current_col = sy-tabix.

      CLEAR: ls_cell.

*    ls_row-spans = spans.
      ls_row-position = row_index.
      IF row_height_header NE c_default_row_height.
        ls_row-height = row_height_body.
      ENDIF.

*    now go column by column

      CLEAR: ls_cell.
      CALL METHOD me->get_cellposition
        EXPORTING
          row    = row_index
          col    = lv_current_col
        RECEIVING
          result = ls_cell-position.

      ls_cell-style = me->get_style( alias = style row = row_index col = lv_current_col  ).
      IF ls_cell-style NE 0.
        lv_add_cell = abap_true.
      ENDIF.
      IF NOT ls_header-z_header IS INITIAL.
*        headers are always string
        lv_add_cell = abap_true.
        ls_cell-sharedstring = 's'.
        CALL METHOD me->add_sharedstring
          EXPORTING
            i_sharedstring = ls_header-z_header
          IMPORTING
            e_index        = ls_cell-index.
      ENDIF.
      IF lv_add_cell EQ abap_true.
        INSERT ls_cell INTO TABLE ls_row-t_cells.
      ENDIF.
    ENDLOOP.
    INSERT ls_row INTO TABLE sheet_struct-t_header_rows.

  ENDMETHOD.                    "feed_data_header


  METHOD get_abap_meta.
    ex_abap_meta = abap_meta.
  ENDMETHOD.                    "GET_ABAP_META


  METHOD get_border_id_from_alias.

    DATA:
     ls_border        LIKE LINE OF style_struct-t_borders.

    READ TABLE style_struct-t_borders INTO ls_border WITH KEY alias = alias.
    IF sy-subrc EQ 0.
      id = ls_border-id.
    ELSE.
      CLEAR id.  "set to default
    ENDIF.


  ENDMETHOD.                    "GET_BORDER_ID_FROM_ALIAS


  METHOD get_cellposition.

    DATA:
      l_part1 TYPE string,
      l_part2 TYPE string,
      l_part3 TYPE string,
      l_mod   TYPE i,
      l_div   TYPE i.

    l_mod = ( col - 1 ) MOD 26.
    l_div = ( col - 1 ) DIV 26.

    l_part1 = sy-abcde+l_mod(1).
    l_part3 = |{ row }|.

    IF l_div > 0.
      l_div = l_div - 1.
      l_part2 = sy-abcde+l_div(1).
      CONCATENATE l_part2 l_part1 l_part3 INTO result.
    ELSE.
      CONCATENATE l_part1 l_part3 INTO result.
    ENDIF.

  ENDMETHOD.                    "get_cellposition


  METHOD get_file_as_email_attachment.

    attachment_lenght = xstrlen( me->xlsx_file_raw ).

    CALL METHOD cl_bcs_convert=>xstring_to_solix
      EXPORTING
        iv_xstring = me->xlsx_file_raw
      RECEIVING
        et_solix   = xlsx_attachment.

  ENDMETHOD.                    "GET_FILE_AS_EMAIL_ATTACHMENT


  METHOD get_file_as_xstring.
    xlsx_as_xstring = me->xlsx_file_raw.
  ENDMETHOD.                    "GET_FILE_AS_XSTRING


  METHOD get_fill_id_from_alias.

    DATA:
     ls_fill        LIKE LINE OF style_struct-t_fills.

    READ TABLE style_struct-t_fills INTO ls_fill WITH KEY alias = alias.
    IF sy-subrc EQ 0.
      id = ls_fill-id.
    ELSE.
      CLEAR id.  "set to default
    ENDIF.


  ENDMETHOD.                    "GET_FILL_ID_FROM_ALIAS


  METHOD get_font_id_from_alis.

    DATA:
     ls_font        LIKE LINE OF style_struct-t_fonts.

    READ TABLE style_struct-t_fonts INTO ls_font WITH KEY alias = alias.
    IF sy-subrc EQ 0.
      id = ls_font-id.
    ELSE.
      CLEAR id.  "set to default
    ENDIF.


  ENDMETHOD.                    "GET_FONT_ID_FROM_ALIS


  METHOD get_numfmt_id_from_alias.

    DATA:
     ls_numfmt        LIKE LINE OF style_struct-t_numfmts.

    READ TABLE style_struct-t_numfmts INTO ls_numfmt WITH KEY alias = alias.
    IF sy-subrc EQ 0.
      id = ls_numfmt-id.
    ELSE.
      CLEAR id.  "set to default
    ENDIF.


  ENDMETHOD.                    "GET_NUMFMT_ID_FROM_ALIAS


  METHOD get_style.

    DATA:
      ls_cellxf          TYPE ys_style_cellxf,
      lv_style_alias     TYPE string,
      ls_style_exception LIKE LINE OF style_exceptions.


* set the default

    lv_style_alias = alias.
*   check if we do not have an exception


    READ TABLE style_exceptions INTO ls_style_exception
     WITH KEY row = row
              col = col.

    IF sy-subrc EQ 0.
      lv_style_alias = ls_style_exception-style_alias.
    ELSE.
*  is there an override for the whole row
      READ TABLE style_exceptions INTO ls_style_exception
       WITH KEY row = row
                col = 0.
      IF sy-subrc EQ 0 .

        lv_style_alias = ls_style_exception-style_alias.
      ELSE.
        READ TABLE style_exceptions INTO ls_style_exception
         WITH KEY row = 0
                  col = col.

        IF sy-subrc EQ 0.

          lv_style_alias = ls_style_exception-style_alias.
        ENDIF.
      ENDIF.
    ENDIF.

    READ TABLE style_struct-t_cellxfs WITH TABLE KEY
              alias = lv_style_alias
              TRANSPORTING id
              INTO ls_cellxf.
    IF sy-subrc EQ 0.
      style_id = ls_cellxf-id.
    ELSE.
      style_id = 0.
    ENDIF.

  ENDMETHOD.                    "get_style


  method GET_WORKSHEETS.

    data(ro_parts) = xlsx_document->get_workbookpart( )->get_worksheetparts( ).
    ro_parts->get_part( iv_index = IV_INDEX ).
*    LOOP AT - ASSIGNING FIELD-SYMBOL(<lfs_part>).
*
*    ENDLOOP.
*                                              CATCH cx_openxml_format.  "

  endmethod.


  METHOD get_xlsx_file_raw.

    ev_xstring = me->xlsx_file_raw.

  ENDMETHOD.


  METHOD insert_border.

    DATA:
     ls_border        LIKE LINE OF style_struct-t_borders.

    READ TABLE style_struct-t_borders INTO ls_border WITH KEY alias = alias.
    IF sy-subrc EQ 0.
*  delete the existing one
      DELETE TABLE style_struct-t_borders WITH TABLE KEY alias = alias.
    ELSE.
* new font
    ENDIF.

    CLEAR ls_border.
    DESCRIBE TABLE style_struct-t_borders LINES style_struct-numborders_count.

    ls_border-id = style_struct-numborders_count.
    ls_border-alias = alias.
    ls_border-left_style          = left_style.
    ls_border-left_color_rgb      = left_color_rgb.
    ls_border-right_style         = right_style.
    ls_border-right_color_rgb     = right_color_rgb.
    ls_border-top_style           = top_style.
    ls_border-top_color_rgb       = top_color_rgb.
    ls_border-bottom_style        = bottom_style.
    ls_border-bottom_color_rgb    = bottom_color_rgb.

    INSERT ls_border INTO TABLE style_struct-t_borders.
    SORT style_struct-t_borders BY id.
    ADD 1 TO style_struct-numborders_count.

  ENDMETHOD.                    "insert_border


  METHOD insert_default_styles.

    me->insert_fill(
         alias           = style_header
         patterntype     = fill_pattern_solid
         fgcolor_rgb     = rgb_gray_25
         bgcolor_indexed = indexed_col_sys_background ).

    me->insert_style(
        alias           = style_header
        fill_alias      = style_header  ).

    me->insert_style(
       alias           = style_date_default
       numformat_id         = 14 ).

  ENDMETHOD.                    "INSERT_DEFAULT_STYLES


  METHOD insert_fill.


    DATA:
     ls_fill        LIKE LINE OF style_struct-t_fills.

    READ TABLE style_struct-t_fills INTO ls_fill WITH KEY alias = alias.
    IF sy-subrc EQ 0.
      DELETE TABLE style_struct-t_fills WITH TABLE KEY alias = alias.
    ELSE.
* new font
    ENDIF.

    CLEAR ls_fill.
    DESCRIBE TABLE style_struct-t_fills LINES style_struct-numfills_count.

    ls_fill-id = style_struct-numfills_count.
    ls_fill-alias = alias.
    ls_fill-patterntype  = patterntype.
    ls_fill-fgcolor_rgb = fgcolor_rgb.
    ls_fill-bgcolor_indexed = bgcolor_indexed.
    INSERT ls_fill INTO TABLE style_struct-t_fills.
    SORT style_struct-t_fills BY id.
    ADD 1 TO style_struct-numfills_count.

  ENDMETHOD.                    "INSERT_FILL


  METHOD insert_font.

    DATA:
     ls_font        LIKE LINE OF style_struct-t_fonts.

    READ TABLE style_struct-t_fonts INTO ls_font WITH KEY alias = alias.
    IF sy-subrc EQ 0.
      DELETE TABLE style_struct-t_fonts WITH TABLE KEY alias = alias.
    ENDIF.

    DESCRIBE TABLE style_struct-t_fonts LINES style_struct-numfonts_count.

    ls_font-id = style_struct-numfonts_count.
    ls_font-alias = alias.

    ls_font-name  = name.
    ls_font-size = size.
    IF bold IS SUPPLIED.
      ls_font-bold = bold.
    ENDIF.
    IF italic IS SUPPLIED.
      ls_font-italic = italic.
    ENDIF.
    IF underline IS SUPPLIED.
      ls_font-underline = underline.
    ENDIF.
    IF color_rgb IS SUPPLIED.
      ls_font-color_rgb = color_rgb.
    ENDIF.
    INSERT ls_font INTO TABLE style_struct-t_fonts.
    SORT style_struct-t_fonts BY id.
    ADD 1 TO style_struct-numfonts_count.

  ENDMETHOD.                    "insert_font


  METHOD insert_mandatory_borders.
    me->insert_border( alias = 'default' ).

  ENDMETHOD.                    "INSERT_MANDATORY_BORDERS


  METHOD insert_mandatory_fills.

    me->insert_fill(
        alias           = 'none'
        patterntype     = 'none' ).

    me->insert_fill(
        alias           = 'gray125'
        patterntype     = 'gray125' ).


  ENDMETHOD.                    "INSERT_MANDATORY_FILLS


  METHOD insert_mandatory_fonts.
    me->insert_font(
        alias     = 'default'
        name      = 'Calibri'
        size      = 11   ).
  ENDMETHOD.                    "INSERT_MANDATORY_FONTS


  METHOD insert_mandatory_number_format.
    me->insert_number_format(
        alias  = style_time_default
        code   = '[$-F400]h:mm:ss\ AM/PM' ).

  ENDMETHOD.                    "insert_mandatory_number_format


  METHOD insert_mandatory_styles.

    me->insert_mandatory_fonts( ).
    me->insert_mandatory_fills( ).
    me->insert_mandatory_borders( ).
    me->insert_mandatory_number_format( ).

    me->insert_style(
        alias           = 'default'
        fill_alias      = 'none'  ).

    me->insert_style(
        alias           = 'gray125'
        fill_alias      = 'gray125' ).

    me->insert_style(
        alias           = style_time_default
        numformat_alias = style_time_default ).

  ENDMETHOD.                    "INSERT_MANDATORY_STYLES


  METHOD insert_number_format.

    DATA:
     ls_numfmt        LIKE LINE OF style_struct-t_numfmts.

    READ TABLE style_struct-t_numfmts INTO ls_numfmt WITH KEY alias = alias.
    IF sy-subrc EQ 0.
* TODO existing font --> replace
      EXIT.
    ELSE.
* new font
    ENDIF.

    CLEAR ls_numfmt.
    DESCRIBE TABLE style_struct-t_numfmts LINES style_struct-numfmts_count.

    ls_numfmt-id = 168 + style_struct-numfmts_count.
    ls_numfmt-alias = alias.
    ls_numfmt-code = code.

    INSERT ls_numfmt INTO TABLE style_struct-t_numfmts.
    ADD 1 TO style_struct-numfmts_count.

  ENDMETHOD.                    "INSERT_NUMBER_FORMAT


  METHOD insert_style.

    DATA:
      ls_cellxf        TYPE ys_style_cellxf,
      ls_fill          LIKE LINE OF style_struct-t_fills,
      lv_current_index TYPE ys_style_cellxf-id.

    READ TABLE style_struct-t_cellxfs WITH TABLE KEY
              alias = alias
              INTO ls_cellxf.
    IF sy-subrc EQ 0.
* style exists --> override of style.
*  keep everything, just override what is supplied
* Delete the current style
      DELETE TABLE style_struct-t_cellxfs WITH TABLE KEY
                  alias = alias.
    ELSE.
*    We have a new style
      ADD 1 TO style_struct-cellxfs_count.
      ls_cellxf-id =  style_struct-cellxfs_count - 1.
    ENDIF.
*
    ls_cellxf-alias = alias.
    ls_cellxf-is_string = 1.

    IF font_alias IS SUPPLIED.
      ls_cellxf-fontid = me->get_font_id_from_alis( alias = font_alias ).
    ENDIF.

    IF fill_alias IS SUPPLIED.
      ls_cellxf-fillid = me->get_fill_id_from_alias( alias = fill_alias ).
    ENDIF.

    IF  numformat_id IS SUPPLIED.
      ls_cellxf-numfmtid = numformat_id.
    ENDIF.

    IF numformat_alias IS SUPPLIED.
      ls_cellxf-numfmtid = me->get_numfmt_id_from_alias( alias = numformat_alias ).
    ENDIF.

    IF border_alias IS SUPPLIED.
      ls_cellxf-borderid = me->get_border_id_from_alias( alias = border_alias ).
    ENDIF.

    IF text_rotation IS SUPPLIED.
      ls_cellxf-allignment-text_rotation = text_rotation.
    ENDIF.

    INSERT ls_cellxf INTO TABLE style_struct-t_cellxfs.
    SORT style_struct-t_cellxfs BY id.

  ENDMETHOD.                    "insert_style


  METHOD merge_cells.

    DATA:
      ls_merged_cell LIKE LINE OF sheet_struct-t_merged_cells,
      lv_merged_ref  TYPE string.


    CALL METHOD me->get_cellposition
      EXPORTING
        row    = row_start
        col    = col_start
      RECEIVING
        result = lv_merged_ref.

    ls_merged_cell-ref = lv_merged_ref.

    CLEAR lv_merged_ref.

    CALL METHOD me->get_cellposition
      EXPORTING
        row    = row_end
        col    = col_end
      RECEIVING
        result = lv_merged_ref.

    CONCATENATE ls_merged_cell-ref ':' lv_merged_ref INTO ls_merged_cell-ref.

    APPEND ls_merged_cell TO sheet_struct-t_merged_cells.
    ADD 1 TO sheet_struct-merged_cells_count.

  ENDMETHOD.                    "merge_cells


  METHOD save_file_to_client.

    DATA:
      lv_fs_file_name TYPE string,
      li_binary_tab   TYPE solix_tab,
      lv_file_length  TYPE i.

    CHECK NOT fs_filename IS INITIAL.

    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer        = me->xlsx_file_raw
      IMPORTING
        output_length = lv_file_length
      TABLES
        binary_tab    = li_binary_tab.

    lv_fs_file_name = fs_filename.

    cl_gui_frontend_services=>gui_download(
      EXPORTING
        bin_filesize              = lv_file_length
        filename                  = lv_fs_file_name
        filetype                  = 'BIN'
        write_bom                 = abap_true
      CHANGING
        data_tab                  = li_binary_tab
      EXCEPTIONS
        OTHERS                    = 1 ).
    IF sy-subrc <> 0.
      RAISE error_writing_file.
    ENDIF.

    IF start_excel EQ abap_true.
      cl_gui_frontend_services=>execute(
        EXPORTING
          document               = lv_fs_file_name
        EXCEPTIONS
          OTHERS                 = 1 ).
    ENDIF.

  ENDMETHOD.                    "save_file_to_client


  METHOD save_file_to_server.

    DATA:
     lv_fs_file_name      TYPE string.

    CHECK NOT fs_filename IS INITIAL.
    lv_fs_file_name = fs_filename.
    OPEN DATASET lv_fs_file_name FOR OUTPUT IN BINARY MODE.
    IF sy-subrc NE 0.
      RAISE error_writing_file.
    ENDIF.
    TRANSFER me->xlsx_file_raw TO lv_fs_file_name.
    CLOSE DATASET lv_fs_file_name.

  ENDMETHOD.                    "SAVE_FILE_TO_SERVER


  METHOD set_abap_meta.
    DATA:
     ls_abap_meta LIKE LINE OF abap_meta.
    READ TABLE abap_meta INTO ls_abap_meta
     WITH KEY fieldname = fieldname.
    CHECK sy-subrc EQ 0.
    IF header IS SUPPLIED.
      ls_abap_meta-z_header = header.
    ENDIF.
    IF width IS SUPPLIED.
      ls_abap_meta-z_width = width.
    ENDIF.
    MODIFY abap_meta FROM ls_abap_meta INDEX sy-tabix.
  ENDMETHOD.                    "set_abap_meta


  METHOD set_content.
    FIELD-SYMBOLS:
      <li_sheet_content> TYPE STANDARD TABLE.
    CREATE DATA abap_sheet_content LIKE sheet_content.
    ASSIGN abap_sheet_content->* TO <li_sheet_content>.
    <li_sheet_content> = sheet_content.

  ENDMETHOD.                    "SET_CONTENT


  METHOD set_default_columns.
* sets defaults for header, width and style
    DATA:
      ls_col       TYPE ys_col_struc,
      ls_abap_meta LIKE LINE OF abap_meta.

    LOOP AT abap_meta INTO ls_abap_meta.

      CLEAR: ls_col.
      ls_col-min = ls_col-max = sy-tabix.
      ls_col-width = ls_abap_meta-z_width.
      ls_col-bestfit = 1.
      INSERT ls_col INTO TABLE sheet_struct-t_cols.

    ENDLOOP.

  ENDMETHOD.                    "set_default_columns


  METHOD set_spans.

    FIELD-SYMBOLS:
     <ls_header_row>            LIKE LINE OF sheet_struct-t_header_rows.

    DATA:
      lv_no_columns     TYPE i,
      lv_no_data_rows   TYPE i,
      lv_no_header_rows TYPE i,
      lv_dim            TYPE string.


* Determine positions of start cell and end cell of table content

    DESCRIBE TABLE sheet_struct-t_body_rows LINES lv_no_data_rows.
    DESCRIBE TABLE sheet_struct-t_header_rows LINES lv_no_header_rows.
    DESCRIBE TABLE sheet_struct-t_cols LINES lv_no_columns.

    CALL METHOD me->get_cellposition
      EXPORTING
        row    = ( lv_no_data_rows + lv_no_header_rows )
        col    = lv_no_columns
      RECEIVING
        result = lv_dim.

    CONCATENATE 'A1:' lv_dim INTO sheet_struct-dim.
    spans = |{ lv_no_columns }|.
    CONCATENATE '1:' spans INTO spans.
    sheet_struct-defaultrowheight = c_default_row_height.


*  update the header table with the SPANS

    LOOP AT sheet_struct-t_header_rows ASSIGNING <ls_header_row>.
      <ls_header_row>-spans = spans.
    ENDLOOP.

    LOOP AT sheet_struct-t_body_rows ASSIGNING <ls_header_row>.
      <ls_header_row>-spans = spans.
    ENDLOOP.

  ENDMETHOD.                    "set_spans


  METHOD transform_to_xslx.

    DATA:
      lr_workbookpart         TYPE REF TO cl_xlsx_workbookpart,
      lr_worksheetparts       TYPE REF TO cl_openxml_partcollection,
      lr_part                 TYPE REF TO cl_openxml_part,
      lr_worksheetpart        TYPE REF TO cl_xlsx_worksheetpart,
      lr_stylespart           TYPE REF TO cl_xlsx_stylespart,
      lr_sharedstringspart    TYPE REF TO cl_xlsx_sharedstringspart,
      lr_drawingpart          TYPE REF TO cl_oxml_drawingspart,
      lr_custom_properties    TYPE REF TO cl_oxml_custompropertiespart,
      lv_sheetxml             TYPE xstring,
      lv_shared_xml           TYPE xstring,
      lv_styles_xml           TYPE xstring,
      lv_custom_doc_props_xml TYPE xstring,
      lr_xml_string_writer    TYPE REF TO cl_sxml_string_writer.

*   we need to use a string_writer when calling the transformation.
*   Reasons are:
*       1. the parameter "ignore_conversion_errors" which makes the
*          transformation more robust in case of conversion errors
*          especially with Japanese DoubleByte Characters in a non-unicode system
*       2. it keeps the order of the attributes

    TRY.

*   Transformation for the SHEET part
* merge the different content parts:
        APPEND LINES OF sheet_struct-t_header_rows TO sheet_struct-t_body_rows.
        CLEAR sheet_struct-t_header_rows.
        SORT sheet_struct-t_body_rows BY position.
        lr_xml_string_writer = cl_sxml_string_writer=>create( ignore_conversion_errors = abap_true ).
        CALL TRANSFORMATION /BVCCSAP/K7_XSLX_SHEET_XSLT
           SOURCE param = sheet_struct
           RESULT XML lr_xml_string_writer.
        lv_sheetxml = lr_xml_string_writer->get_output( abap_true ).

*   Transformation for the SHARED STRINGS part
        lr_xml_string_writer = cl_sxml_string_writer=>create( ignore_conversion_errors = abap_true ).
        CALL TRANSFORMATION salv_bs_xml_off2007_shared
           SOURCE param = sharedstring_struct
           RESULT XML lr_xml_string_writer.
        lv_shared_xml = lr_xml_string_writer->get_output( abap_true ).

*   Transformation for the STYLES part
        lr_xml_string_writer = cl_sxml_string_writer=>create( ignore_conversion_errors = abap_true ).
        CALL TRANSFORMATION /BVCCSAP/K7_XSLX_STYLE_XSLT
          SOURCE param = style_struct
          RESULT XML lr_xml_string_writer.
        lv_styles_xml = lr_xml_string_writer->get_output( abap_true ).

*   Transformation for the custom doc properties
        lr_xml_string_writer = cl_sxml_string_writer=>create( ignore_conversion_errors = abap_true ).
        CALL TRANSFORMATION /BVCCSAP/K7_XSLX_CDP_XSLT
         SOURCE custom_doc_props = custom_doc_props
         RESULT XML  lr_xml_string_writer .
        lv_custom_doc_props_xml = lr_xml_string_writer->get_output( abap_true ).

      CATCH cx_xslt_abap_call_error.                    "#EC NO_HANDLER
      CATCH cx_xslt_deserialization_error.              "#EC NO_HANDLER
      CATCH cx_xslt_format_error.                       "#EC NO_HANDLER
      CATCH cx_xslt_runtime_error.                      "#EC NO_HANDLER
      CATCH cx_xslt_serialization_error.                "#EC NO_HANDLER
    ENDTRY.

* Get the workbook part of the document
    TRY.
        CALL METHOD xlsx_document->get_workbookpart
          RECEIVING
            rr_part = lr_workbookpart.
*Get the custom properties part
        lr_custom_properties = xlsx_document->add_custompropertiespart( ).
        lr_custom_properties->feed_data( iv_data = lv_custom_doc_props_xml ).

*   Get the first worksheet part
        CALL METHOD lr_workbookpart->get_worksheetparts
          RECEIVING
            rr_parts = lr_worksheetparts.
        CALL METHOD lr_worksheetparts->get_part
          EXPORTING
            iv_index = 0
          RECEIVING
            rr_part  = lr_part.
        lr_worksheetpart ?= lr_part.
*   Fill first worksheet part with the XML data
        CALL METHOD lr_worksheetpart->feed_data
          EXPORTING
            iv_data = lv_sheetxml.
*   Get the style part from the workbook part
        CALL METHOD lr_workbookpart->add_stylespart
          RECEIVING
            rr_part = lr_stylespart.
*   Set the style data into style part
        CALL METHOD lr_stylespart->feed_data
          EXPORTING
            iv_data = lv_styles_xml.
*   Get the shared strings part from the workbook
        CALL METHOD lr_workbookpart->add_sharedstringspart
          RECEIVING
            rr_part = lr_sharedstringspart.
*   Set the sharedstrings XML to the part
        CALL METHOD lr_sharedstringspart->feed_data
          EXPORTING
            iv_data = lv_shared_xml.
*   Package and get the output binary string
        CALL METHOD xlsx_document->get_package_data
          RECEIVING
            rv_data = me->xlsx_file_raw.
      CATCH: cx_openxml_format, cx_openxml_not_found, cx_openxml_not_allowed.
    ENDTRY.
  ENDMETHOD.                    "TRANSFORM_TO_XSLX
ENDCLASS.
