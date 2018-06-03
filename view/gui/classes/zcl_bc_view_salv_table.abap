class zcl_bc_view_salv_table  definition
  public abstract
  create public .
  "Na podstawie ABAP TO THE FUTURE STR. 411

  public section.

    interfaces zif_bc_alv_report_view.
    methods application_specific_changes abstract.
    methods set_column_width
        importing
            id_field_name  type lvc_fname
            i_column_width type i.
    data: mo_alv_grid type ref to cl_salv_table.
    data: mo_controller type ref to zcl_bc_controller.
  protected section.
  private section.
    data: mo_aggregations type ref to cl_salv_aggregations.
    data: mo_column type ref to cl_salv_column_table.
    data: mo_columns type ref to cl_salv_columns_table.
    data: mo_events type ref to cl_salv_events_table.
    data: mo_functions type ref to cl_salv_functions_list.
    data: mo_layout type ref to cl_salv_layout.
    data: mo_selections type ref to cl_salv_selections.
    data: mo_sorts type ref to cl_salv_sorts.
    data: mo_settings type ref to cl_salv_display_settings.
    data: md_report_name type sy-repid.
    data: ms_variant type DISVARIANT.
    data: mt_user_commands type ttb_button.
    data: mt_data_table.

    methods display_basic_toolbar.
    methods set_layout
      importing
        id_variant type disvariant-variant.
    methods set_handlers.
    methods set_checkbox
      importing
        id_field_name type lvc_fname.
    methods set_hotspot
      importing
        id_field_name type lvc_fname.
    methods set_visible
      importing
        id_field_name type lvc_fname
        if_is_visible type abap_bool.
    methods set_technical
      importing
        id_field_name type lvc_fname.
    methods set_column_as_button
      importing
        id_field_name type lvc_fname.
    methods set_subtotal
      importing
        id_field_name type lvc_fname.
    methods set_long_text
      importing
        id_field_name type lvc_fname
        id_long_text  type scrtext_l.
    methods set_medium_text
      importing
        id_field_name  type lvc_fname
        id_medium_text type scrtext_m.
    methods set_short_text
      importing
        id_field_name type lvc_fname
        id_short_text type scrtext_s.
    methods set_tooltip
      importing
        id_field_name type lvc_fname
        id_tooltip    type lvc_tip.
    methods add_commands_to_toolbar
      importing
        it_commands type ttb_button.
    methods set_checkbox_hotspot
      importing
        id_field_name type lvc_fname.
    methods handle_user_command for event added_function of cl_salv_events
        importing e_salv_function.
    methods handle_link_click for event link_click of cl_salv_events_table
        importing row column.

endclass.



class zcl_bc_view_salv_table implementation.

  method display_basic_toolbar.
    mo_functions = mo_alv_grid->get_functions( ).
    mo_functions->set_all( if_salv_c_bool_sap=>true ).
  endmethod.


  method zif_bc_alv_report_view~add_sort_criteria.
    data(ld_sequence) = cond salv_de_sort_sequence( when if_descending = abap_true then if_salv_c_sort=>sort_down
                                                    else if_salv_c_sort=>sort_up ).
    try.

      catch cx_salv_data_error
            cx_salv_existing
            cx_salv_not_found.
        "Raise fatal exception
    endtry.
  endmethod.


  method zif_bc_alv_report_view~display.
    mo_alv_grid->display( ).
  endmethod.


  method zif_bc_alv_report_view~initialize.
    try.
        IF io_container IS SUPPLIED AND
           io_container IS BOUND.
                cl_salv_table=>factory(
                  EXPORTING
                      r_container = io_container
                  IMPORTING
                      r_salv_table = mo_alv_grid
                  CHANGING
                      t_table = ct_data_table[] ).
                display_basic_toolbar( ).
                IF it_user_commands[] IS NOT INITIAL.
                    add_commands_to_toolbar( it_user_commands ).
                ENDIF.
         endif.
*        cl_salv_table=>factory(
*            importing
*                r_salv_table = mo_alv_grid
*            changing
*                t_table = ct_data_table[] ).
        mo_columns = mo_alv_grid->get_columns( ).
        set_layout( id_variant ).
        set_handlers( ).
      catch cx_salv_msg.
        return.
    endtry.
  endmethod.


  method zif_bc_alv_report_view~optimise_column_widths.

  endmethod.


  method zif_bc_alv_report_view~prepare_display_data.
    zif_bc_alv_report_view~initialize( exporting id_report_name = id_report_name
                                                 id_variant = id_variant
                                                 io_container = io_container
                                                 it_user_commands = it_user_commands
                                       changing ct_data_table = ct_data_table ).
    application_specific_changes( ).
    zif_bc_alv_report_view~display( ).
  endmethod.


  method zif_bc_alv_report_view~refresh_display.
    DATA(ls_stable_refresh) =  value lvc_s_stbl( row = abap_true
                                                 col = abap_true ).
    mo_alv_grid->refresh( s_stable = ls_stable_refresh ).
  endmethod.


  method zif_bc_alv_report_view~set_column_attributes.
    check id_field_name is not initial.

    if if_is_hotspot = abap_true.
      set_hotspot( id_field_name ).
    endif.
    if if_is_a_checkbox = abap_true.
      set_checkbox( id_field_name ).
    endif.
    if if_is_a_checkbox_hotspot = abap_true.
      set_checkbox_hotspot( id_field_name ).
    endif.
    if if_is_visible is supplied.
      set_visible( id_field_name = id_field_name
                   if_is_visible = if_is_visible ).
    endif.
    if if_is_technical = abap_true.
      set_technical( id_field_name ).
    endif.
    if if_is_a_button = abap_true.
      set_column_as_button( id_field_name ).
    endif.
    if if_is_subtotal = abap_true.
      set_subtotal( id_field_name ).
    endif.
    if id_long_text is not initial.
      set_long_text( id_field_name = id_field_name
  id_long_text = id_long_text ).
    endif.
    if id_medium_text is not initial.
      set_medium_text( id_field_name = id_field_name
  id_medium_text = id_medium_text ).
    endif.
    if id_short_text is not initial.
      set_short_text( id_field_name = id_field_name
  id_short_text = id_short_text ).
    endif.
    if id_tooltip is not initial.
      set_tooltip( id_field_name = id_field_name
    id_tooltip = id_tooltip ).
    endif.
  endmethod.


  method zif_bc_alv_report_view~set_list_header.

  endmethod.

  method set_layout.
    data: ls_key type salv_s_layout_key.

    mo_layout = mo_alv_grid->get_layout( ).

    ls_key-report = sy-cprog.
    mo_layout->set_key( ls_key ).

    mo_layout->set_default( 'X' ).
    if id_variant is not initial.
      mo_layout->set_initial_layout( id_variant ).
    endif.
    mo_layout->set_save_restriction( if_salv_c_layout=>restrict_none ).

  endmethod.


  method set_handlers.
    mo_events = mo_alv_grid->get_event( ).
    set handler handle_link_click for mo_events.
    set handler handle_user_command for mo_events.
  endmethod.


  method handle_link_click.
    RAISE EVENT zif_bc_alv_report_view~user_command_received
      EXPORTING ed_user_command = '&IC1'
      ed_row = row
      ed_column = column.
  endmethod.


  method handle_user_command.
    data(ld_command) = conv sy-ucomm( e_salv_function ).

    RAISE EVENT zif_bc_alv_report_view~user_command_received
        EXPORTING ed_user_command = e_salv_function.
  endmethod.


  method set_checkbox.
    data lf_error_occured type abap_bool.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_cell_type( value = if_salv_c_cell_type=>checkbox ).
      catch cx_salv_not_found into data(not_found_ex).
        lf_error_occured = abap_true.
        "Raise exception
    endtry.
  endmethod.


  method set_hotspot.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_cell_type( value = if_salv_c_cell_type=>hotspot ).
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.

  method set_checkbox_hotspot.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_cell_type( value = if_salv_c_cell_type=>checkbox_hotspot ).
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.


  method set_visible.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_visible( if_is_visible ).
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.


  method set_technical.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_technical( abap_true ).
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.


  method set_column_as_button.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_icon( if_salv_c_bool_sap=>true ).
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.


  method set_subtotal.
    mo_aggregations = mo_alv_grid->get_aggregations( ).
    try.
        mo_aggregations->add_aggregation( columnname = id_field_name ).
      catch cx_salv_not_found cx_salv_data_error cx_salv_existing .
      "Raise exception
    endtry.
  endmethod.


  method set_long_text.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_long_text( id_long_text ).
        IF strlen( id_long_text ) LE 20.
          data(ld_medium_text) = id_long_text.
          mo_column->set_medium_text( conv #( ld_medium_text ) ).
        ENDIF.
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.


  method set_medium_text.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_medium_text( id_medium_text ).
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.


  method set_short_text.
  try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_short_text( id_short_text ).
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.


  method set_tooltip.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_tooltip( id_tooltip ).
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.

  method set_column_width.
    try.
        mo_column ?= mo_columns->get_column( id_field_name ).
        mo_column->set_output_length( conv #( i_column_width ) ).
      catch cx_salv_not_found into data(cx_salv_not_found).
      "Raise exception
    endtry.
  endmethod.

.


  method add_commands_to_toolbar.
    DATA: ls_commands LIKE LINE OF it_commands,
        ld_icon TYPE string,
        ld_tooltip TYPE string,
        ld_text TYPE string.
    TRY.
        LOOP AT it_commands INTO ls_commands.
          CHECK ls_commands-function <> '&IC1'.
          ld_icon = ls_commands-icon.
          ld_text = ls_commands-text.
          ld_tooltip = ls_commands-quickinfo.
          mo_functions->add_function(
          name = ls_commands-function
          icon = ld_icon
          text = ld_text
          tooltip = ld_tooltip
          position = if_salv_c_function_position=>right_of_salv_functions ).
        ENDLOOP.
    CATCH cx_salv_wrong_call.
        "Raise Fatal Exception
    CATCH cx_salv_existing.
        "Raise Fatal Exception
    ENDTRY.
  endmethod.



  method zif_bc_alv_report_view~get_row_numbers.
    data(selections) = mo_alv_grid->get_selections( ).
    r_selected_rows = selections->get_selected_rows( ).
  endmethod.

  method zif_bc_alv_report_view~show_bapiret.
    call function 'RSCRMBW_DISPLAY_BAPIRET2'
      tables
        it_return = i_bapiret
      .
  endmethod.




endclass.
