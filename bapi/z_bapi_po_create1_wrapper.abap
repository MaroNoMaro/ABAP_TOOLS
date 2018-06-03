class z_bapi_po_create1_wrapper definition
  public
  create public .

  public section.
    types: begin of t_bapi_data,
            in_poheader type bapimepoheader,
            in_poheaderx type bapimepoheaderx,
            out_bapiret type bapiret2_t,
            out_expheader type ebeln,
            in_poitem type bapimepoitem_tp,
            in_poitemx type bapimepoitemx_tp,
            in_poschedule type bapimeposchedule_tp,
            in_pocond type bapimepocond_tp,
           end of t_bapi_data.
    METHODS: get_bapi_data RETURNING value(r_result) TYPE t_bapi_data,
             set_bapi_data IMPORTING i_bapi_data TYPE t_bapi_data,
    call_bapi
      importing
          I_COMMIT TYPE ABAP_BOOL default abap_true
          i_test_run type xfeld default abap_false
          raising zcx_exc_bapiret.
  protected section.
    data bapi_data type t_bapi_data.
  private section.
endclass.



class z_bapi_po_create1_wrapper implementation.
  method get_bapi_data.
    r_result = me->bapi_data.
  endmethod.

  method set_bapi_data.
    me->bapi_data = i_bapi_data.
  endmethod.


  method call_bapi.
    call function 'BAPI_PO_CREATE1'
      exporting
        poheader          = me->bapi_data-in_poheader
        poheaderx         = me->bapi_data-in_poheaderx
        testrun           = conv char1( i_test_run )
      importing
        exppurchaseorder = me->bapi_data-out_expheader
      tables
        poitem            = me->bapi_data-in_poitem
        poitemx           = me->bapi_data-in_poitemx
        poschedule        = me->bapi_data-in_poschedule
        pocond            = me->bapi_data-in_pocond
        return            = me->bapi_data-out_bapiret.
    if line_exists( me->bapi_data-out_bapiret[ type = 'E' ] ).
      data(err_message) = me->bapi_data-out_bapiret[ type = 'E' ].
      raise exception type zcx_exc_bapiret exporting i_messages = me->bapi_data-out_bapiret.
    endif.
    if i_commit = abap_true.
        commit work and wait.
    endif.
  endmethod.

endclass.
