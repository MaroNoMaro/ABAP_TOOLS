class zsd_salesdocument_create_wrapp definition
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
    types tt_sales_contract_in   type table of    bapictr with default key.
    types tt_sales_contract_inx  type table of    bapictrx with default key.
    types tt_extensionin type table of bapiparex with default key.
    types tt_partneraddresses type table of bapiaddr1 with default key.
    types tt_extensionex type table of bapiparex with default key.
    types tt_nfmetallitms type table of /nfm/bapidocitm with default key.
*    types tt_EXTENSIONIN type table of    BAPIPAREX  with default key.
*types tt_PARTNERADDRESSES    type table of    BAPIADDR1  with default key.
    types tt_sales_sched_conf_in type table of    bapischdl2  with default key.
    types tt_items_ex    type table of    bapisdit  with default key.
    types tt_schedule_ex type table of    bapisdhedu  with default key.
    types tt_business_ex type table of    bapisdbusi  with default key.
    types tt_incomplete_log  type table of    bapiincomp  with default key.
*types tt_EXTENSIONEX type table of    BAPIPAREX  with default key.
    types tt_conditions_ex   type table of    bapicond  with default key.
    types tt_partners_ex type table of    bapisdpart  with default key.
    types tt_textheaders_ex  type table of    bapisdtehd  with default key.
    types tt_textlines_ex    type table of    bapitextli  with default key.
    types tt_batch_charc type table of    bapibtsel  with default key.
    types tt_campaign_asgn   type table of    bapisdca  with default key.
    types tt_sales_etax  type table of    oi0bapisdetax  with default key.
    types tt_sales_etaxx type table of    oi0bapisdetaxx with default key.
    types tt_sales_transp    type table of    oi0bapisdtransp with default key.
    types tt_sales_transpx   type table of    oi0bapisdtranspx with default key.

    types: begin of t_importing,
             salesdocument           type    bapivbeln-vbeln,
             sales_header_in         type    bapisdhd1,
             sales_header_inx        type    bapisdhd1x,
             sender                  type    bdi_logsys,
             binary_relationshiptype type    breltyp-reltype,
             int_number_assignment   type    bapiflag-bapiflag,
             behave_when_error       type    bapiflag-bapiflag,
             logic_switch            type    bapisdls,
             business_object         type    bapiusw01-objtype,
             testrun                 type    bapiflag-bapiflag,
             convert_parvw_auart     type    bapiflag-bapiflag,
             status_buffer_refresh   type    bapiflag-bapiflag,
             call_active             type    char4,
             without_init            type    bapiflag-bapiflag,
           end of t_importing.
    types: begin of t_exporting,
             salesdocument_ex    type    bapivbeln-vbeln,
             sales_header_out    type    bapisdhd,
             sales_header_status type    bapisdhdst,
           end of t_exporting.
    types: begin of t_tables,
             return               type tt_return,
             sales_items_in       type tt_order_items_in,
             sales_items_inx      type tt_order_items_inx,
             sales_partners       type tt_order_partners,
             sales_schedules_in   type tt_order_schedules_in,
             sales_schedules_inx  type tt_order_schedules_inx,
             sales_conditions_in  type tt_order_conditions_in,
             sales_conditions_inx type tt_order_conditions_inx,
             sales_cfgs_ref       type tt_order_cfgs_ref,
             sales_cfgs_inst      type tt_order_cfgs_inst,
             sales_cfgs_part_of   type tt_order_cfgs_part_of,
             sales_cfgs_value     type tt_order_cfgs_value,
             sales_cfgs_blob      type tt_order_cfgs_blob,
             sales_cfgs_vk        type tt_order_cfgs_vk,
             sales_cfgs_refinst   type tt_order_cfgs_refinst,
             sales_ccard          type tt_order_ccard,
             sales_text           type tt_order_text,
             sales_keys           type tt_order_keys,
             sales_contract_in    type tt_sales_contract_in,
             sales_contract_inx   type tt_sales_contract_inx,
             extensionin          type tt_extensionex,
             partneraddresses     type tt_partneraddresses,
             sales_sched_conf_in  type tt_sales_sched_conf_in,
             items_ex             type tt_items_ex,
             schedule_ex          type tt_schedule_ex,
             business_ex          type tt_business_ex,
             incomplete_log       type tt_incomplete_log,
             extensionex          type tt_extensionex,
             conditions_ex        type tt_conditions_ex,
             partners_ex          type tt_partners_ex,
             textheaders_ex       type tt_textheaders_ex,
             textlines_ex         type tt_textlines_ex,
             BATCH_CHARC type tt_batch_charc,
CAMPAIGN_ASGN type tt_campaign_asgn,
SALES_ETAX type tt_sales_etax,
SALES_ETAXX type tt_sales_etaxx,
SALES_TRANSP type tt_sales_transp,
SALES_TRANSPX type tt_sales_transp,
           end of t_tables.
    types: begin of t_bapi_data,
             import type t_importing,
             export type t_exporting,
             tables type t_tables,
           end of t_bapi_data.
    METHODS: get_bapi_data RETURNING value(r_result) TYPE t_bapi_data,
             set_bapi_data IMPORTING i_bapi_data TYPE t_bapi_data.
    methods call_bapi importing i_commit type abap_bool default abap_true raising zcx_invalid_data.
  protected section.
  private section.
    data bapi_data type t_bapi_data.
    methods set_default_values.
endclass.



class zsd_salesdocument_create_wrapp implementation.
  method get_bapi_data.
    r_result = me->bapi_data.
  endmethod.

  method set_bapi_data.
    me->bapi_data = i_bapi_data.
  endmethod.

  method call_bapi.
    set_default_values( ).
    "bez sortowania nie zadziała
    "dorobić metodę na sortowanie
    sort bapi_data-tables-sales_items_in by itm_number.
    sort bapi_data-tables-sales_items_inx by itm_number.
    sort bapi_data-tables-sales_schedules_in by itm_number.
    sort bapi_data-tables-sales_conditions_inx by itm_number.
    call function 'SD_SALESDOCUMENT_CREATE'
      exporting
        salesdocument           = bapi_data-import-salesdocument    " Sales and Distribution Document Number
        sales_header_in         = bapi_data-import-sales_header_in    " Document Header Data
        sales_header_inx        = bapi_data-import-sales_header_inx    " Header Data Checkboxes
        sender                  = bapi_data-import-sender    " Logical System - Sender
        binary_relationshiptype = bapi_data-import-binary_relationshiptype    " Binary Relationship Type (Private)
        int_number_assignment   = bapi_data-import-int_number_assignment    " Internal Item Number Assignment
        behave_when_error       = bapi_data-import-behave_when_error    " Error Handling
        logic_switch            = bapi_data-import-logic_switch    " Internal Control Parameter BAPISDLS
        business_object         = bapi_data-import-business_object    " Business Object
        testrun                 = bapi_data-import-testrun    " Test Run
        convert_parvw_auart     = bapi_data-import-convert_parvw_auart    " Conversion of Partner Function and Order Type
        status_buffer_refresh   = bapi_data-import-status_buffer_refresh    " Initialization of Status Buffer
        call_active             = bapi_data-import-call_active
        i_without_init          = bapi_data-import-without_init
      importing
        salesdocument_ex        = bapi_data-export-salesdocument_ex    " Number of Generated Document
        sales_header_out        = bapi_data-export-sales_header_out    " BAPI Structure of VBAK with English Field Names
        sales_header_status     = bapi_data-export-sales_header_status    " BAPI Structure of VBUK with English Field Names
      tables
        return                  = bapi_data-tables-return    " Return Messages
        sales_items_in          = bapi_data-tables-sales_items_in    " Item Data
        sales_items_inx         = bapi_data-tables-sales_items_inx    " Item Data Checkboxes
        sales_partners          = bapi_data-tables-sales_partners    " Document Partner
        sales_schedules_in      = bapi_data-tables-sales_schedules_in    " Schedule Line Data
        sales_schedules_inx     = bapi_data-tables-sales_schedules_inx   " Checkbox Schedule Line Data
        sales_conditions_in     = bapi_data-tables-sales_conditions_in    " Conditions
        sales_conditions_inx    = bapi_data-tables-sales_conditions_inx    " Conditions Checkbox
        sales_cfgs_ref          = bapi_data-tables-sales_cfgs_ref    " Configuration: Reference Data
        sales_cfgs_inst         = bapi_data-tables-sales_cfgs_inst    " Configuration: Instances
        sales_cfgs_part_of      = bapi_data-tables-sales_cfgs_part_of    " Configuration: Part-of Specifications
        sales_cfgs_value        = bapi_data-tables-sales_cfgs_value    " Configuration: Characteristic Values
        sales_cfgs_blob         = bapi_data-tables-sales_cfgs_blob    " Configuration: BLOB Internal Data (SCE)
        sales_cfgs_vk           = bapi_data-tables-sales_cfgs_vk    " Configuration: Variant Condition Key
        sales_cfgs_refinst      = bapi_data-tables-sales_cfgs_refinst    " Configuration: Reference Item / Instance
        sales_ccard             = bapi_data-tables-sales_ccard    " Credit Card Data
        sales_text              = bapi_data-tables-sales_text    " Texts
        sales_keys              = bapi_data-tables-sales_keys    " Output Table of Reference Keys
        sales_contract_in       = bapi_data-tables-sales_contract_in    " Contract Data
        sales_contract_inx      = bapi_data-tables-sales_contract_inx    " Checkbox: Contract Data
        extensionin             = bapi_data-tables-extensionin    " Customer Enhancment Import
        partneraddresses        = bapi_data-tables-partneraddresses    " BAPI Reference Structure for Addresses (Org./Company)
        sales_sched_conf_in     = bapi_data-tables-sales_sched_conf_in    " Schedule Line Data Confirmation
        items_ex                = bapi_data-tables-items_ex    " Structure of VBAP with English Field Names
        schedule_ex             = bapi_data-tables-schedule_ex    " Struture of VBEP with English Field Names
        business_ex             = bapi_data-tables-business_ex    " BAPI Structure of VBKD with English Field Names
        incomplete_log          = bapi_data-tables-incomplete_log    " Communication Fields: Incompletion
        extensionex             = bapi_data-tables-extensionex    " Reference Structure for BAPI Parameters ExtensionIn/Extensio
        conditions_ex           = bapi_data-tables-conditions_ex    " Communication Fields for Maintaining Conditions in the Order
        partners_ex             = bapi_data-tables-partners_ex    " BAPI Structure of VBPA with English Field Names
        textheaders_ex          = bapi_data-tables-textheaders_ex    " BAPI Structure of THEAD with English Field Names
        textlines_ex            = bapi_data-tables-textlines_ex    " BAPI Structure for STX_LINES Structure
        batch_charc             = bapi_data-tables-batch_charc    " BAPI Transfer Structure Selection Data CRM -> ERP
        campaign_asgn           = bapi_data-tables-campaign_asgn    " BAPI Structure for Table CMPB_ASGN
*        SALES_ETAX = bapi_data-tables-sales_etax
*        SALES_ETAXX = bapi_data-tables-sales_etaxx
*        SALES_TRANSP = bapi_data-tables-sales_transp
*        SALES_TRANSPX = bapi_data-tables-sales_transpx
      .
      if line_exists( bapi_data-tables-return[ type = 'E' ] ) or line_exists( bapi_data-tables-return[ type = 'A' ] ).
        rollback work.
        raise exception type zcx_invalid_data exporting i_bapiret = bapi_data-tables-return.
      endif.
      if i_commit = abap_true.
        commit work and wait.
      endif.
  endmethod.


  method set_default_values.
    if bapi_data-import-binary_relationshiptype is initial.
      bapi_data-import-binary_relationshiptype = space.
    endif.
    if bapi_data-import-int_number_assignment is initial.
      bapi_data-import-int_number_assignment = space.
    endif.
    if bapi_data-import-behave_when_error is initial.
      bapi_data-import-behave_when_error = space.
    endif.
    if bapi_data-import-logic_switch is initial.
      bapi_data-import-logic_switch = space.
    endif.
    if bapi_data-import-business_object is initial.
      bapi_data-import-business_object = space.
    endif.
    if bapi_data-import-testrun is initial.
      bapi_data-import-testrun = ''.
    endif.
    if bapi_data-import-convert_parvw_auart is initial.
      bapi_data-import-convert_parvw_auart = space.
    endif.
    if bapi_data-import-status_buffer_refresh is initial.
      bapi_data-import-status_buffer_refresh = 'X'.
    endif.
    if bapi_data-import-call_active is initial.
      bapi_data-import-call_active = space.
    endif.
    if bapi_data-import-without_init is initial.
      bapi_data-import-without_init = space.
    endif.
  endmethod.

endclass.
