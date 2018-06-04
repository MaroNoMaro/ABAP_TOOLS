class zitab_utils definition
  public
  create public .

  public section.
        class-methods: record_exists_in_table
            importing i_record type any
                      i_table type any table
            returning value(r_if_exists) type abap_bool.
        class-methods: add_record_to_table
            importing i_record type any
                      i_table type ref to data
            returning value(r_if_exists) type abap_bool.
        class-methods: change_record_at_index
            importing i_record type any
                      i_table type ref to data
                      i_index type i
            returning value(r_if_exists) type abap_bool,
    get_record_at_index
      importing
        i_index            type i
        i_table            type ref to data
      returning
          VALUE(ref_to_line) TYPE REF TO DATA
      raising CX_SY_ITAB_LINE_NOT_FOUND,
    delete_record_at_index
      importing
        i_index        type i
          I_REF_TO_TABLE TYPE REF TO DATA.
    protected section.
    private section.
endclass.



class zitab_utils implementation.

    method record_exists_in_table.
      data table_ref type ref to data.
      data line_ref type ref to data.
      create data table_ref like i_table.
      create data line_ref like line of i_table.
      field-symbols: <table_fs> type any table.
      field-symbols: <line_fs> type any.
      assign table_ref->* to <table_fs>.
      <table_fs> = i_table.

      if line_exists( <table_fs>[ table_Line = i_record ] ).
          r_if_exists = abap_true.
        else.
          r_if_exists = abap_false.
      endif.
    endmethod.

  method add_record_to_table.
    field-symbols: <table> type any table.
    assign i_table->* to <table>.
    insert i_record into table <table>.
  endmethod.

  method change_record_at_index.
    field-symbols: <line> type any, <table> type index table.
    assign i_table->* to <table>.
    <table>[ i_index ] = i_record.
  endmethod.


  method get_record_at_index.
    field-symbols: <line> type any, <table> type index table.
    assign i_table->* to <table>.
    create data ref_to_line like line of <table>.
    assign ref_to_line->* to <line>.
    move-corresponding <table>[ i_index ] to <line>.
  endmethod.




  method delete_record_at_index.
    field-symbols: <line> type any, <table> type index table.
    assign i_ref_to_table->* to <table>.
    delete <table> index i_index.
  endmethod.

endclass.
