class zbapi_billingdoc_createmultipl definition
  public
  create public .

  public section.
    types bapiccard_vf_t type standard table of bapiccard_vf with default key.
    types bapikomfktx_t type standard table of bapikomfktx with default key.
    types bapivbrkerrors_t type standard table of bapivbrkerrors with default key.

    types: begin of t_import,
             creatordatain type bapicreatordata,
             testrun       type bapivbrktestrun-testrun,
             posting       type posting_type_ct,
           end of t_import.
    types: begin of t_tables,
             billingdatain   type bapivbrk_t,
             conditiondatain type bapikomv_t,
             ccarddatain     type bapiccard_vf_t,
             textdatain      type bapikomfktx_t,
             errors          type bapivbrkerrors_t,
             return          type bapiret1_t,
             success         type ewapbapivbrksuccess,
             nfmetallitms    type /nfm/bapidocitm_t,
           end of t_tables.
    types: begin of t_bapi_data,
             import type t_import,
             tables type t_tables,
           end of t_bapi_data.
    METHODS: get_bapi_data RETURNING value(r_result) TYPE t_bapi_data,
             set_bapi_data IMPORTING i_bapi_data TYPE t_bapi_data.
    methods call_bapi importing i_commit type abap_bool default abap_true raising zcx_invalid_data.
  protected section.
  private section.
    data bapi_data type t_bapi_data.
endclass.



class zbapi_billingdoc_createmultipl implementation.
  method get_bapi_data.
    r_result = me->bapi_data.
  endmethod.

  method set_bapi_data.
    me->bapi_data = i_bapi_data.
  endmethod.

  method call_bapi.
    call function 'BAPI_BILLINGDOC_CREATEMULTIPLE'
      exporting
        creatordatain   = bapi_data-import-creatordatain   " Date Order Taken
        testrun         = bapi_data-import-testrun    " Simulation Run ('X'), Update Run (' ')
        posting         = bapi_data-import-posting    " Posting category: post directly
      tables
        billingdatain   = bapi_data-tables-billingdatain    " Table for Item Data to be Processed
        conditiondatain = bapi_data-tables-conditiondatain    " Table for Conditions to be Processed
        ccarddatain     = bapi_data-tables-ccarddatain    " Table for Method of Payment to be Processed
        textdatain      = bapi_data-tables-textdatain    " Communication Structure Texts for Billing Interface
        errors          = bapi_data-tables-errors    " Information on Incorrect Processing of Preceding Items
        return          = bapi_data-tables-return    " Table for Processing Errors
        success         = bapi_data-tables-success    " Table for Successfully Processed Items
      .
      if line_exists( bapi_data-tables-return[ type = 'E' ] ) or line_exists( bapi_data-tables-return[ type = 'A' ] ) or not line_exists( bapi_data-tables-success[ 1 ] ).
        rollback work.
        data bapi_msg type bapiret2_t.
        move-corresponding bapi_data-tables-return to bapi_msg.
        raise exception type zcx_invalid_data exporting i_bapiret = bapi_msg.
    else.
      if i_commit = abap_true.
        commit work and wait.
      endif.
    endif.
  endmethod.

endclass.
