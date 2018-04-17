class z_salesorder_createfromdat2_dc definition
  public
  create public .

  public section.
    types tt_order_items_in type table of bapisditm with default key.
    types tt_order_items_inx type table of bapisditmx with default key.
    types tt_order_partners type table of bapiparnr with default key.
    types tt_order_schedules_in type table of bapischdl with default key.
    types tt_order_schedules_inx type table of bapischdlx with default key.
    types tt_order_conditions_in type table of bapicond with default key.
    types tt_order_conditions_inx type table of bapicondx with default key.
    types tt_order_cfgs_ref type table of bapicucfg with default key.
    types tt_order_cfgs_inst type table of bapicuins with default key.
    types tt_order_cfgs_part_of type table of bapicuprt with default key.
    types tt_order_cfgs_value type table of bapicuval with default key.
    types tt_order_cfgs_blob type table of bapicublb with default key.
    types tt_order_cfgs_vk type table of bapicuvk with default key.
    types tt_order_cfgs_refinst type table of bapicuref with default key.
    types tt_order_ccard type table of bapiccard with default key.
    types tt_order_text type table of bapisdtext with default key.
    types tt_order_keys type table of bapisdkey with default key.
    types tt_extensionin type table of bapiparex with default key.
    types tt_partneraddresses type table of bapiaddr1 with default key.
    types tt_extensionex type table of bapiparex with default key.
    types tt_nfmetallitms type table of /nfm/bapidocitm with default key.

    data i_salesdocumentin type bapivbeln-vbeln.
    data i_order_header_in type bapisdhd1.
    data i_order_header_inx type bapisdhd1x.
    data i_sender type bapi_sender.
    data i_binary_relationshiptype type bapireltype-reltype.
    data i_int_number_assignment type bapiflag-bapiflag.
    data i_behave_when_error type bapiflag-bapiflag.
    data i_logic_switch type bapisdls.
    data i_testrun type bapiflag-bapiflag.
    data i_convert type bapiflag-bapiflag.
    data e_salesdocument type bapivbeln-vbeln.
    data return type bapiret2_t.
    data t_order_items_in type tt_order_items_in.
    data t_order_items_inx type tt_order_items_inx.
    data t_order_partners type tt_order_partners.
    data t_order_schedules_in type tt_order_schedules_in.
    data t_order_schedules_inx type tt_order_schedules_inx.
    data t_order_conditions_in type tt_order_conditions_in.
    data t_order_conditions_inx type tt_order_conditions_inx.
    data t_order_cfgs_ref type tt_order_cfgs_ref.
    data t_order_cfgs_inst type tt_order_cfgs_inst.
    data t_order_cfgs_part_of type tt_order_cfgs_part_of.
    data t_order_cfgs_value type tt_order_cfgs_value.
    data t_order_cfgs_blob type tt_order_cfgs_blob.
    data t_order_cfgs_vk type tt_order_cfgs_vk.
    data t_order_cfgs_refinst type tt_order_cfgs_refinst.
    data t_order_ccard type tt_order_ccard.
    data t_order_text type tt_order_text.
    data t_order_keys type tt_order_keys.
    data t_extensionin type tt_extensionin.
    data t_partneraddresses type tt_partneraddresses.
    data t_extensionex type tt_extensionex.
    data t_nfmetallitms type tt_nfmetallitms.

  protected section.
  private section.
endclass.



class z_salesorder_createfromdat2_dc implementation.
endclass.
