class /BVCCSAP/CL_K7_TRANSPORT_HNDL definition
  public
  final
  create public .

public section.

  data MV_ORDER type TRKORR read-only .
  data MV_TASK type TRKORR read-only .
  data MS_ORDER type TRWBO_REQUEST_HEADER read-only .
  data MS_TASK type TRWBO_REQUEST_HEADER read-only .
  data MT_KEYLIST type /BVCCSAP/K7_KEYLIST_TT .

  methods CONSTRUCTOR .
  methods CHECK_UPDATE_TRANSPORT
    importing
      !IT_KEYLIST type /BVCCSAP/K7_KEYLIST_TT
    raising
      /BVCCSAP/CX_K7_TRANSPORT .
  methods DETERMINE_TRANSPORT
    exporting
      !EV_ORDER type TRKORR
      !EV_TASK type TRKORR
    raising
      /BVCCSAP/CX_K7_TRANSPORT .
  methods UNLOCK_TRANSPORT .
  methods LOCK_TRANSPORT
    raising
      /BVCCSAP/CX_K7_TRANSPORT .
  methods IS_TRANSPORT_ACTIVE
    returning
      value(RV_IS_ACTIVE) type ABAP_BOOL .
  methods SET_ORDER
    importing
      !IV_ORDER type TRKORR
      !IV_TASK type TRKORR optional
    raising
      /BVCCSAP/CX_K7_TRANSPORT .
  methods ADD_KEYLIST
    importing
      !IV_TABNAME type TABNAME .
protected section.
private section.

  methods READ_TRANSPORT
    importing
      !IV_ORDER type TRKORR
      !IV_TASK type TRKORR
    raising
      /BVCCSAP/CX_K7_TRANSPORT .
ENDCLASS.



CLASS /BVCCSAP/CL_K7_TRANSPORT_HNDL IMPLEMENTATION.


  METHOD add_keylist.
    DATA ls_keylist	LIKE LINE OF mt_keylist.
    ls_keylist-tabname = iv_tabname.
    APPEND ls_keylist TO mt_keylist.
  ENDMETHOD.


  METHOD check_update_transport.

    DATA: lt_tab_key  TYPE /bvccsap/k7_keylist_tt,
          ls_tab_key  LIKE LINE OF lt_tab_key,
          lt_ko200    TYPE STANDARD TABLE OF ko200,
          lt_e071k    TYPE STANDARD TABLE OF e071k,
          ls_api_call TYPE sctsa_s_api_call,
          ls_result   TYPE sctsa_s_result,
          ls_cts_msg  TYPE cts_message,
          ls_cts_var  TYPE cts_variable,
          ls_ko200    TYPE ko200,
          ls_e071k    TYPE e071k,
          lv_tp_task  TYPE e070-trkorr,
          lv_trkorr   TYPE trkorr,
          lv_msgno    TYPE symsgno,
          lv_msgv1    TYPE symsgv,
          lv_msgv2    TYPE symsgv,
          lv_msgv3    TYPE symsgv,
          lv_msgv4    TYPE symsgv.

* check input
    IF it_keylist IS INITIAL.
      RETURN.
    ENDIF.

* get transport order
    lv_trkorr = me->mv_order.
    IF lv_trkorr IS INITIAL.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport "Es wurde kein Transport selektiert
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_type   = 'E'
          message_number = '153'.
    ENDIF.

* transfer table keys
    lt_tab_key = it_keylist.
    SORT lt_tab_key BY tabname.
    DELETE ADJACENT DUPLICATES FROM lt_tab_key COMPARING tabname.

    LOOP AT lt_tab_key INTO ls_tab_key.
      CLEAR ls_ko200.
      ls_ko200-pgmid      = 'R3TR'.
      ls_ko200-object     = 'TABU'.
      ls_ko200-obj_name   = ls_tab_key-tabname.
      ls_ko200-objfunc    = 'K'.
      APPEND ls_ko200 TO lt_ko200.
    ENDLOOP.

    LOOP AT it_keylist INTO ls_tab_key.
      CLEAR ls_e071k.
      ls_e071k-pgmid      = 'R3TR'.
      ls_e071k-object     = 'TABU'.
      ls_e071k-objname    = ls_tab_key-tabname.
      ls_e071k-mastertype = 'TABU'.
      ls_e071k-mastername = ls_tab_key-tabname.
      ls_e071k-tabkey     = ls_tab_key-tabkey.
      APPEND ls_e071k TO lt_e071k.
    ENDLOOP.

*********************************************
* check tp correct
*********************************************
    CLEAR ls_api_call.
    ls_api_call-is_api      = abap_true.
    ls_api_call-is_check    = abap_true.
    ls_api_call-is_insert   = abap_false.
    ls_api_call-as4user     = sy-uname.
    ls_api_call-as4text     = space.
    ls_api_call-request     = space.
    ls_api_call-new_request = space.

    CALL FUNCTION 'TRINT_OBJECTS_CHECK_AND_INSERT'
      EXPORTING
        iv_order                     = ' '
        iv_with_dialog               = ' '
        iv_send_message              = space
        iv_no_show_option            = space
        iv_no_standard_editor        = space
        iv_externalps                = space
        iv_externalid                = space
        iv_no_ps                     = 'X'
        iv_read_activity_from_memory = 'X'
        iv_append_to_order           = space
        iv_insert_into_sbcsets       = space
        iv_old_call                  = space
        is_api_call                  = ls_api_call
      IMPORTING
        es_result                    = ls_result
*       et_objprops                  = lt_objprops
      CHANGING
        ct_ko200                     = lt_ko200
        ct_e071k                     = lt_e071k
      EXCEPTIONS
        OTHERS                       = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport "Interner Fehler beim Schreiben des Transports
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_type   = 'E'
          message_number = '154'.
    ENDIF.
    IF ls_result-result <> 'S'.
      READ TABLE ls_result-messages
        INDEX 1
        INTO ls_cts_msg.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport "Interner Fehler beim Schreiben des Transports
          EXPORTING
            message_id     = '/BVCCSAP/K7_5'
            message_type   = 'E'
            message_number = '154'.
      ELSE.
        LOOP AT ls_cts_msg-variables INTO ls_cts_var.
          CASE sy-tabix.
            WHEN '1'.
              lv_msgv1 = ls_cts_var-variable.
            WHEN '2'.
              lv_msgv2 = ls_cts_var-variable.
            WHEN '3'.
              lv_msgv3 = ls_cts_var-variable.
            WHEN '4'.
              lv_msgv4 = ls_cts_var-variable.
          ENDCASE.
        ENDLOOP.
        lv_msgno = ls_cts_msg-msgnr.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport
          EXPORTING
            message_id     = ls_cts_msg-arbgb
            message_type   = 'E'
            message_number = lv_msgno
            message_v1     = lv_msgv1
            message_v2     = lv_msgv2
            message_v3     = lv_msgv3
            message_v4     = lv_msgv4.
      ENDIF.
    ENDIF.

*********************************************
* insert into tp
*********************************************
    CLEAR ls_api_call.
    ls_api_call-is_api      = abap_true.
    ls_api_call-is_check    = abap_false.
    ls_api_call-is_insert   = abap_true.
    ls_api_call-as4user     = sy-uname.
    ls_api_call-as4text     = space.
    ls_api_call-request     = lv_trkorr.
    ls_api_call-new_request = space.

    CALL FUNCTION 'TRINT_OBJECTS_CHECK_AND_INSERT'
      EXPORTING
        iv_order                     = ' '
        iv_with_dialog               = 'D'
        iv_send_message              = space
        iv_no_show_option            = space
        iv_no_standard_editor        = space
        iv_externalps                = space
        iv_externalid                = space
        iv_no_ps                     = 'X'
        iv_read_activity_from_memory = 'X'
        iv_append_to_order           = space
        iv_insert_into_sbcsets       = space
        iv_old_call                  = space
        is_api_call                  = ls_api_call
      IMPORTING
        ev_task                      = lv_tp_task
        es_result                    = ls_result
*       et_objprops                  = lt_objprops
      CHANGING
        ct_ko200                     = lt_ko200
        ct_e071k                     = lt_e071k
      EXCEPTIONS
        OTHERS                       = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport "Interner Fehler beim Schreiben des Transports
        EXPORTING
          message_id     = '/BVCCSAP/K7_5'
          message_type   = 'E'
          message_number = '154'.
    ENDIF.
    IF ls_result-result <> 'S'.
      READ TABLE ls_result-messages
        INDEX 1
        INTO ls_cts_msg.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport "Interner Fehler beim Schreiben des Transports
          EXPORTING
            message_id     = '/BVCCSAP/K7_5'
            message_type   = 'E'
            message_number = '154'.
      ELSE.
        LOOP AT ls_cts_msg-variables INTO ls_cts_var.
          CASE sy-tabix.
            WHEN '1'.
              lv_msgv1 = ls_cts_var-variable.
            WHEN '2'.
              lv_msgv2 = ls_cts_var-variable.
            WHEN '3'.
              lv_msgv3 = ls_cts_var-variable.
            WHEN '4'.
              lv_msgv4 = ls_cts_var-variable.
          ENDCASE.
        ENDLOOP.
        lv_msgno = ls_cts_msg-msgnr.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport
          EXPORTING
            message_id     = ls_cts_msg-arbgb
            message_type   = 'E'
            message_number = lv_msgno
            message_v1     = lv_msgv1
            message_v2     = lv_msgv2
            message_v3     = lv_msgv3
            message_v4     = lv_msgv4.
      ENDIF.
    ENDIF.

** update transport (task)
*  IF lv_tp_task IS NOT INITIAL.
*    me->/xft/if_wdy_transport_model~set_transport( im_trkorr = lv_tp_task ).
*  ENDIF.
  ENDMETHOD.


  METHOD constructor.
    clear mt_keylist.
  ENDMETHOD.


  METHOD determine_transport.
    DATA: lt_tab_key  TYPE /bvccsap/k7_keylist_tt,
          ls_tab_key  LIKE LINE OF lt_tab_key,
          lt_e071     TYPE STANDARD TABLE OF e071,
          lt_e071k    TYPE STANDARD TABLE OF e071k,
          ls_api_call TYPE sctsa_s_api_call,
          ls_result   TYPE sctsa_s_result,
          ls_cts_msg  TYPE cts_message,
          ls_cts_var  TYPE cts_variable,
          ls_e071     TYPE e071,
          ls_e071k    TYPE e071k,
          lv_tp_task  TYPE e070-trkorr,
          lv_trkorr   TYPE trkorr,
          lv_msgno    TYPE symsgno,
          lv_msgv1    TYPE symsgv,
          lv_msgv2    TYPE symsgv,
          lv_msgv3    TYPE symsgv,
          lv_msgv4    TYPE symsgv.

* check input
    IF mt_keylist IS INITIAL.
      "Keine keylist EInträge vorhanden
      RETURN.
    ENDIF.
    CLEAR: ev_order, ev_task, mv_order, mv_task.
* transfer table keys
    lt_tab_key = mt_keylist.
    SORT lt_tab_key BY tabname.
    DELETE ADJACENT DUPLICATES FROM lt_tab_key COMPARING tabname.

    LOOP AT lt_tab_key INTO ls_tab_key.
      CLEAR ls_e071.
      ls_e071-pgmid      = 'R3TR'.
      ls_e071-object     = 'TABU'.
      ls_e071-obj_name   = ls_tab_key-tabname.
      ls_e071-objfunc    = 'K'.
      APPEND ls_e071 TO lt_e071.
    ENDLOOP.

    LOOP AT mt_keylist INTO ls_tab_key.
      CLEAR ls_e071k.
      ls_e071k-pgmid      = 'R3TR'.
      ls_e071k-object     = 'TABU'.
      ls_e071k-objname    = ls_tab_key-tabname.
      ls_e071k-mastertype = 'TABU'.
      ls_e071k-mastername = ls_tab_key-tabname.
      ls_e071k-tabkey     = ls_tab_key-tabkey.
      APPEND ls_e071k TO lt_e071k.
    ENDLOOP.

    CALL FUNCTION 'TRINT_ORDER_CHOICE'
      EXPORTING
        wi_simulation          = 'X'    " Flag: 'X'= keine Änderungen auf DB
        wi_order_type          = 'W'    " gewünschter Auftragstyp ('K','L',' ')
        wi_task_type           = 'Q'    " gewünschter Aufgabentyp ('S','R',' ')
        wi_category            = 'CUST'    " gew. Auftr.kategorie ('CUST','CUSY','SYST')
        wi_suppress_dialog     = 'D'    " ' '=Dialog;'X'=eingeschränkter Dialog;'D'=dunkel
      IMPORTING
        we_order               = ev_order
        we_task                = ev_task
      TABLES
        wt_e071                = lt_e071
        wt_e071k               = lt_e071k
      EXCEPTIONS
        no_correction_selected = 1
        display_mode           = 2
        object_append_error    = 3
        recursive_call         = 4
        wrong_order_type       = 5
        OTHERS                 = 6.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport
        EXPORTING
          message_id     = sy-msgid
          message_type   = sy-msgty
          message_number = sy-msgno
          message_v1     = sy-msgv1
          message_v2     = sy-msgv2
          message_v3     = sy-msgv3
          message_v4     = sy-msgv4.
    ENDIF.
    set_order( EXPORTING  iv_order                 = ev_order
                          iv_task                  = ev_task ).

  ENDMETHOD.


  METHOD is_transport_active.
    rv_is_active = abap_false.
    IF mv_order IS NOT INITIAL.
      rv_is_active = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD lock_transport.
    DATA lv_msgv1 TYPE sy-msgv1.
    DATA lv_msgv2 TYPE sy-msgv2.
    lv_msgv1 = mv_order.
    CALL FUNCTION 'ENQUEUE_E_TRKORR'
      EXPORTING
        trkorr         = mv_order
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2.
    CASE sy-subrc.
      WHEN 0.
      WHEN 1.
        lv_msgv2 = sy-msgv1.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport
          EXPORTING
            message_id     = 'TK'
            message_type   = 'E'
            message_number = '133'
            message_v1     = lv_msgv1
            message_v2     = lv_msgv2.
      WHEN 2.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport
          EXPORTING
            message_id     = sy-msgid
            message_type   = sy-msgty
            message_number = sy-msgno
            message_v1     = sy-msgv1
            message_v2     = sy-msgv2
            message_v3     = sy-msgv3
            message_v4     = sy-msgv4.
    ENDCASE.
    lv_msgv2 = mv_task.
    CALL FUNCTION 'ENQUEUE_E_TRKORR'
      EXPORTING
        trkorr         = mv_task
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2.
    CASE sy-subrc.
      WHEN 0.
      WHEN 1.
        lv_msgv2 = sy-msgv1.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport
          EXPORTING
            message_id     = 'TK'
            message_type   = 'E'
            message_number = '133'
            message_v1     = lv_msgv1
            message_v2     = lv_msgv2.
      WHEN 2.
        RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport
          EXPORTING
            message_id     = sy-msgid
            message_type   = sy-msgty
            message_number = sy-msgno
            message_v1     = sy-msgv1
            message_v2     = sy-msgv2
            message_v3     = sy-msgv3
            message_v4     = sy-msgv4.
    ENDCASE.
  ENDMETHOD.


  METHOD read_transport.

    DATA lt_request_headers TYPE  trwbo_request_headers.
    DATA lt_requests TYPE  trwbo_requests.

    CLEAR: mv_order, mv_task.
    CALL FUNCTION 'TR_READ_REQUEST_WITH_TASKS'
      EXPORTING
        iv_trkorr          = iv_order
      IMPORTING
        et_request_headers = lt_request_headers
        et_requests        = lt_requests
      EXCEPTIONS
        invalid_input      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport
        EXPORTING
          message_id     = sy-msgid
          message_type   = sy-msgty
          message_number = sy-msgno
          message_v1     = sy-msgv1
          message_v2     = sy-msgv2
          message_v3     = sy-msgv3
          message_v4     = sy-msgv4.
    ENDIF.
    READ TABLE lt_request_headers ASSIGNING FIELD-SYMBOL(<lfs_req_header>) WITH KEY trfunction = 'W'.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /bvccsap/cx_k7_transport
        EXPORTING
          message_id     = 'TK'
          message_type   = 'E'
          message_number = '762'.

    ENDIF.
    ms_order = <lfs_req_header>.
    mv_order = <lfs_req_header>-trkorr.
    READ TABLE lt_request_headers ASSIGNING FIELD-SYMBOL(<lfs_req>) WITH KEY trfunction = 'Q'
                                                                                    as4user = sy-uname.
    IF sy-subrc EQ 0.
      ms_task = <lfs_req>.
      mv_task = <lfs_req>-trkorr.
    ENDIF.


  ENDMETHOD.


  METHOD set_order.
    read_transport( EXPORTING iv_order = IV_ORDER iv_task = Iv_task ).

  ENDMETHOD.


  METHOD unlock_transport.
    CALL FUNCTION 'DEQUEUE_E_TRKORR'
      EXPORTING
        trkorr = mv_order.
    CALL FUNCTION 'DEQUEUE_E_TRKORR'
      EXPORTING
        trkorr = mv_task.

  ENDMETHOD.
ENDCLASS.
