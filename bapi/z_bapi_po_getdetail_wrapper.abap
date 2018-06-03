class z_bapi_po_getdetail_wrapper definition
  public
  create public .

  public section.
    types: begin of t_bapi_data,
            in_PURCHASEORDER type BAPIEKKO-PO_NUMBER,
            in_ITEMS type BAPIMMPARA-SELECTION,
            in_ACCOUNT_ASSIGNMENT type BAPIMMPARA-SELECTION,
            in_SCHEDULES type BAPIMMPARA-SELECTION,
            in_HISTORY type BAPIMMPARA-SELECTION,
            in_ITEM_TEXTS type BAPIMMPARA-SELECTION,
            in_HEADER_TEXTS type BAPIMMPARA-SELECTION,
            in_SERVICES type BAPIMMPARA-SELECTION,
            in_CONFIRMATIONS type BAPIMMPARA-SELECTION,
            in_SERVICE_TEXTS type BAPIMMPARA-SELECTION,
            in_EXTENSIONS type BAPIMMPARA-SELECTION,
            out_PO_HEADER type BAPIEKKOL,
            out_po_address type BAPIADDRESS,
            tab_PO_HEADER_TEXTS type BAPIEKKOTX_tp,
            tab_PO_ITEMS type bapiekpo_tp,
            tab_po_schedules type bapieket_tp,
            RETURN type bapiret2_t,
            end of t_bapi_data.
    METHODS: get_bapi_data RETURNING value(r_result) TYPE t_bapi_data,
             set_bapi_data IMPORTING i_bapi_data TYPE t_bapi_data.
    methods call_bapi.
    methods: get_po_number_to_query returning value(r_result) type bapiekko-po_number,
             set_po_number_to_query importing i_po_number_to_query type bapiekko-po_number.
  protected section.
    data bapi_data type t_bapi_data.
  private section.
  data po_number_to_query type BAPIEKKO-PO_NUMBER.
endclass.



class z_bapi_po_getdetail_wrapper implementation.
  method get_bapi_data.
    r_result = me->bapi_data.
  endmethod.

  method set_bapi_data.
    me->bapi_data = i_bapi_data.
  endmethod.

  method call_bapi.
    me->bapi_data-in_schedules = 'X'.
    call function 'BAPI_PO_GETDETAIL'
    exporting
      purchaseorder     = me->po_number_to_query
      schedules = me->bapi_data-in_schedules
    importing
      po_header = me->bapi_data-out_po_header
      po_address = me->bapi_data-out_po_address
    tables
      po_items          = me->bapi_data-tab_po_items
      po_item_schedules = me->bapi_data-tab_po_schedules
      return = me->bapi_data-return.
  endmethod.

  method get_po_number_to_query.
    r_result = me->po_number_to_query.
  endmethod.

  method set_po_number_to_query.
    me->po_number_to_query = i_po_number_to_query.
  endmethod.

endclass.
