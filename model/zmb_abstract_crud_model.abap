class zmb_abstract_crud_model definition abstract
  public
  create public .

  public section.
    interfaces Z_CRUD_TABLE_MODEL_IF.
    aliases set_initial_records for z_crud_table_model_if~set_initial_records.
    aliases get_initial_records for z_crud_table_model_if~get_initial_records.
    aliases get_current_records for z_crud_table_model_if~get_current_records.
    aliases get_deleted_records for z_crud_table_model_if~get_deleted_records.
    aliases get_if_records_changed for z_crud_table_model_if~get_if_records_changed.
    aliases get_nex_row for z_crud_table_model_if~get_nex_row.
    aliases add_record for z_crud_table_model_if~add_record.
    aliases delete_record for z_crud_table_model_if~delete_record.
    aliases change_record for z_crud_table_model_if~change_record.
    aliases get_record for z_crud_table_model_if~get_record.
    aliases set_initial_records_from_ref for z_crud_table_model_if~set_initial_records_from_ref.

    methods: validate_record abstract
      importing
        i_record_to_validate type any
          I_INDEX              TYPE I
      returning value(r_if_is_valid) type abap_bool
        raising zcx_invalid_data.
      methods: validate_new_record abstract
        importing i_new_record   type any
            returning
          VALUE(R_is_valid) TYPE abap_bool
      raising zcx_invalid_data.
    methods: validate_delete_record abstract
        importing index_to_validate   type i
            returning
          VALUE(R_is_valid) TYPE abap_bool
      raising zcx_invalid_data.
  protected section.
    methods get_ref_to_initial_table abstract returning value(r_ref_to_initial_table) type ref to data.
    methods get_ref_to_current_table abstract returning value(r_ref_to_current_records) type ref to data.
    methods get_ref_to_deleted_table abstract returning value(r_ref_to_del_table) type ref to data.
    DATA if_records_changed TYPE abap_bool.
  private section.
endclass.



class zmb_abstract_crud_model implementation.
  method add_record.
    me->if_records_changed = abap_true.
    validate_new_record( i_new_record = i_new_record ).
    zitab_utils=>add_record_to_table( i_record = i_new_record i_table = me->get_ref_to_current_table( ) ).
  endmethod.


  method change_record.
    me->if_records_changed = abap_true.
    me->validate_record( i_record_to_validate = i_changed_record i_index = i_record_index ).
    zitab_utils=>change_record_at_index( i_index = i_record_index i_record = i_changed_record i_table = me->get_ref_to_current_table( ) ).
  endmethod.

  method delete_record.
       me->if_records_changed = abap_true.
       me->validate_delete_record( index_to_validate = i_index ).
    try.
        data(ref_to_record_to_del) = zitab_utils=>get_record_at_index( i_index = i_index i_table = me->get_ref_to_current_table( ) ).
        field-symbols: <record_to_delete> type any.
        assign ref_to_record_to_del->* to <record_to_delete>.
        zitab_utils=>add_record_to_table( i_record = <record_to_delete> i_table = me->get_ref_to_deleted_table( ) ).
        zitab_utils=>delete_record_at_index( i_index = i_index i_ref_to_table = me->get_ref_to_current_table( ) ).
      catch CX_SY_ITAB_LINE_NOT_FOUND into data(LINE_NOT_FOUND_exc).
        raise exception type zcx_invalid_data exporting i_bapiret = value #( ( message = 'Index spoza zakresu' type = 'E' ) ).
    endtry.

  endmethod.

  method get_current_records.
    r_current_records =  me->get_ref_to_current_table( ).
  endmethod.

  method get_deleted_records.
    r_deleted_records =  me->get_ref_to_deleted_table( ).
  endmethod.

  method get_initial_records.
    r_intiial_records =  me->get_ref_to_initial_table( ).
  endmethod.

  method get_nex_row.
    data(ref_to_curr_table) = me->get_ref_to_current_table( ).
    field-symbols: <current_records_table> type any table.
    assign ref_to_curr_table->* to <current_records_table>.
    data ref_to_new_record type ref to data.
    create data r_next_row like line of <current_records_table>.
  endmethod.

  method get_record.
    data(ref_to_current_table) = me->get_ref_to_current_table( ).
    try.
    r_requested_record = zitab_utils=>get_record_at_index( i_index = i_record_index i_table = ref_to_current_table ).
      catch CX_SY_ITAB_LINE_NOT_FOUND into data(index_out_of_bounds_ex).
        raise exception type zcx_invalid_data exporting i_bapiret = value #( ( message = 'Index spoza zakresu' type = 'E' ) ).
    endtry.
  endmethod.

  method set_initial_records.
    data(ref_to_initial_table) = me->get_ref_to_initial_table( ).
    field-symbols: <initial_rec_table> type any table.
    assign ref_to_initial_table->* to <initial_rec_table>.
    <initial_rec_table> = i_initial_records.

    data(ref_to_current_table) = me->get_ref_to_current_table( ).
    field-symbols: <current_rec_table> type any table.
    assign ref_to_current_table->* to <current_rec_table>.
    <current_rec_table> = i_initial_records.
  endmethod.

  method set_initial_records_from_ref.
    field-symbols: <original_table> type any table.
    assign i_initial_records->* to <original_table>.
    set_initial_records( <original_table> ).
  endmethod.

  method get_if_records_changed.
    r_if_records_changed = me->if_records_changed.
  endmethod.

endclass.
