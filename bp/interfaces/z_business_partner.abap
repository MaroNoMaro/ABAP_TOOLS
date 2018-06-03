interface Z_BUSINESS_PARTNER_IF
  public .
    methods: get_bp_number returning value(r_partner_number) type bu_partner.
    methods: set_bp_number importing i_partner_number type bu_partner.

endinterface.
