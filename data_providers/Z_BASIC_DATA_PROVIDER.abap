interface Z_BASIC_DATA_PROVIDER
  public .
    methods query_db.
    methods set_records_to_delete
      importing
        i_records_to_delete type any table.
    methods set_records_to_update
      importing
        i_records_to_update type any table.
    methods update_db.
    methods: get_records_to_delete returning value(r_result) type ref to data.
    methods: get_records_to_update returning value(r_result) type ref to data.
    methods: get_query_results returning value(r_query_result) type ref to data.
    methods: get_num_of_read_records returning value(r_num_of_records) type i.

endinterface.
