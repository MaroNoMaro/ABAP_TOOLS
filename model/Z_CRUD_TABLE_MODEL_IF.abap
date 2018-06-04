interface Z_CRUD_TABLE_MODEL_IF
  public .
    types: begin of enum screen_mode,
           edit,
           view,
           new,
           end of enum screen_mode.

  methods set_initial_records importing i_initial_records type any table.
  methods set_initial_records_from_ref importing i_initial_records type ref to data.
  methods: get_initial_records returning value(r_intiial_records) type ref to data.
  methods: get_current_records returning value(r_current_records) type ref to data.
  methods: get_deleted_records returning value(r_deleted_records) type ref to data.
  methods: get_nex_row returning value(r_next_row) type ref to data.
  methods: add_record importing i_new_record type any raising zcx_invalid_data.
  methods: delete_record importing i_index type i raising zcx_invalid_data.
  methods: change_record importing i_record_index type i
                                   i_changed_record type any raising zcx_invalid_data.
  methods: get_record importing i_record_index type i
        returning
          value(r_requested_record) type ref to data
        raising zcx_invalid_data.
  methods get_if_records_changed returning value(r_if_records_changed) type abap_bool.

endinterface.
