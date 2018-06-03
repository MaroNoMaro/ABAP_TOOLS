interface ZIF_BC_ALV_REPORT_VIEW
  public .
    interfaces Z_BASIC_VIEW.
  events user_command_received
    exporting   value(ed_user_command) type salv_de_function optional
                value(ed_row) type salv_de_row optional
                value(ed_column) type salv_de_column optional.

  methods initialize
    importing id_report_name type sy-repid optional
              id_variant type disvariant-variant optional
              io_container type ref to cl_gui_container optional
              it_user_commands type ttb_button optional
    changing ct_data_table type any table optional.
  methods prepare_display_data
    importing id_report_name type sy-repid optional
              id_variant type disvariant-variant optional
              io_container type ref to cl_gui_container optional
              it_user_commands type ttb_button optional
    changing ct_data_table type any table optional.
  methods display.
  methods set_column_attributes
    importing   id_field_name type lvc_fname
                    id_table_name type lvc_s_fcat-ref_table optional
                    if_is_hotspot type abap_bool optional
                    if_is_visible type abap_bool optional
                    if_is_technical type abap_bool optional
                    if_is_a_button type abap_bool optional
                    if_is_a_checkbox type abap_bool optional
                    if_is_subtotal type abap_bool optional
                    id_long_text type scrtext_l optional
                    id_medium_text type scrtext_m optional
                    id_short_text type scrtext_s optional
                    id_tooltip type lvc_tip optional
                    if_is_a_checkbox_hotspot type abap_bool optional.
  methods add_sort_criteria
    importing id_columnname type lvc_fname
              id_position type i optional
              if_descending type sap_bool optional
              if_subtotal type sap_bool default if_salv_c_bool_sap=>false
              id_group type salv_de_sort_group default if_salv_c_sort=>group_none
              if_obligatory type sap_bool default if_salv_c_bool_sap=>false.
  methods optimise_column_widths.
  methods set_list_header.
  methods refresh_display.
  methods get_row_numbers returning value(r_selected_rows) type salv_t_row .
    methods show_bapiret
      importing
        i_bapiret type bapiret2_t.

endinterface.
