class zcx_invalid_data definition
  public
  inheriting from cx_static_check
  final
  create public .

  public section.

    interfaces if_t100_dyn_msg .
    interfaces if_t100_message .

    constants:
    begin of zcx_invalid_data,
      msgid type symsgid value 'ZFIN',
      msgno type symsgno value '219',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of zcx_invalid_data .

    methods constructor
      importing
         i_bapiret type bapiret2_t optional
         textid   like if_t100_message=>t100key optional
         previous like previous optional .
    methods: get_bapiret returning value(r_result) type bapiret2_t.
  protected section.
  private section.
    data bapiret type bapiret2_t.
endclass.



class zcx_invalid_data implementation.


  method constructor ##ADT_SUPPRESS_GENERATION.
    call method super->constructor
      exporting
        previous = previous.
    clear me->textid.
    if textid is initial.
      if_t100_message~t100key = zcx_invalid_data.
    else.
      if_t100_message~t100key = textid.
    endif.
    if i_bapiret is supplied.
      me->bapiret = i_bapiret.
    endif.
  endmethod.
  method get_bapiret.
    r_result = me->bapiret.
  endmethod.

endclass.
