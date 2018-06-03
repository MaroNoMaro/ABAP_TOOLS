class z_faktor_parameters_view definition inheriting from zcl_bc_view_salv_table
  public
  create public .

  public section.
    interfaces zif_raise_save_ucom.
    aliases raise_save_event for zif_raise_save_ucom~raise_save_event.
    methods: application_specific_changes redefinition.

  protected section.
  private section.
    methods optimise_column_width.
endclass.



class z_faktor_parameters_view implementation.

  method application_specific_changes.
    data ls_message type bal_s_msg.
    try.
        me->optimise_column_width( ).
        me->zif_bc_alv_report_view~set_column_attributes( : id_field_name = 'MANDT'
                                        if_is_technical = abap_true ),
                                        id_field_name = 'PARTNER'
                                        if_is_technical = abap_true ),
                                        id_field_name = 'ZFAKTOR_MOD_NUM'
                                          id_tooltip = |modułów może być wiele z deklaracją, bez deklaracji|
                                          id_medium_text = |Wariant faktoringu|
                                          id_long_text = |Wariant faktoringu| ),
                                        id_field_name = 'AGREEEMENT_NUMBER'
                                          id_tooltip = |Numer umowy/modułu|
                                          id_medium_text = |Numer umowy/modułu|
                                          id_long_text = |Numer umowy/modułu| ),
                                        id_field_name = 'FIN_TYPE'
                                          id_tooltip = |Okres finansowania/ograniczenie finansowania|
                                          id_medium_text = |Ok./Ogr finansowania|
                                          id_long_text = |Ok./Ogr finansowania| ),
                                        id_field_name = 'OUT_FILE_FORMAT'
                                          id_tooltip = |Format pliku wyjściowego|
                                          id_medium_text = |Format pliku wyjściowego|
                                          id_long_text = |Format pliku wyjściowego| ),
                                        id_field_name = 'OUT_STATEMENT_FORMAT'
                                          id_tooltip = |Format pliku wyciągu|
                                          id_medium_text = |Format pliku wyciągu|
                                          id_long_text = |Format pliku wyciągu| )
                                        .
      catch cx_salv_not_found into data(lo_not_found).
        ls_message = lo_not_found->get_message( ).
        if ls_message-msgid is initial.
          message s290(zbc_horizontool_mc01). "Report in Trouble
        else.
          message id ls_message-msgid type 'I' number ls_message-msgno
              with ls_message-msgv1 ls_message-msgv2 ls_message-msgv3 ls_message-msgv4.
        endif.
      catch cx_salv_data_error into data(lo_data_error).
        ls_message = lo_data_error->get_message( ).
        if ls_message-msgid is initial.
          message s290(zbc_horizontool_mc01). "Report in Trouble
        else.
          message id ls_message-msgid type 'I' number ls_message-msgno
          with ls_message-msgv1 ls_message-msgv2 ls_message-msgv3 ls_message-msgv4.
        endif.
      catch cx_salv_msg into data(lo_error).
        if lo_error->msgid is initial.
          message s290(zbc_horizontool_mc01). "Report in Trouble
        else.
          message id lo_error->msgid type 'I' number lo_error->msgno
              with lo_error->msgv1 lo_error->msgv2 lo_error->msgv3 lo_error->msgv4.
        endif.
        return.
    endtry.
  endmethod.

  method optimise_column_width.
    "TODO: Calculate column width
    me->set_column_width( : id_field_name = 'ZFAKTOR_MOD_NUM'
                                 i_column_width = 18 ),
                                 id_field_name = 'AGREEEMENT_NUMBER'
                                 i_column_width = 18 ),
                                 id_field_name = 'FIN_TYPE'
                                 i_column_width = 20 ),
                                 id_field_name = 'OUT_FILE_FORMAT'
                                 i_column_width = 24 ),
                                 id_field_name = 'OUT_STATEMENT_FORMAT'
                                 i_column_width = 20 )
                                 .
  endmethod.

  method raise_save_event.
    RAISE EVENT zif_bc_alv_report_view~user_command_received
      EXPORTING ed_user_command = conv #( z_faktor_parameters_ctrl=>save_data )
      ed_row =  0
      ed_column =  conv #( 0 ).
  endmethod.

endclass.
