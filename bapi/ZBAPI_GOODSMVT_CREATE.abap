FUNCTION ZBAPI_GOODSMVT_CREATE
  IMPORTING
    VALUE(GOODSMVT_HEADER) LIKE BAPI2017_GM_HEAD_01
    VALUE(GOODSMVT_CODE) LIKE BAPI2017_GM_CODE
    VALUE(IV_SALES) TYPE VBELN
  EXPORTING
    VALUE(GOODSMVT_HEADRET) LIKE BAPI2017_GM_HEAD_RET
  TABLES
    GOODSMVT_ITEM LIKE BAPI2017_GM_ITEM_CREATE
    RETURN LIKE BAPIRET2.






  DATA: ls_header TYPE bapi2017_gm_head_ret,
        ls_oper   TYPE zzoperations,
        lt_oper   TYPE STANDARD TABLE OF zzoperations.

*  DO 50 TIMES.

    CALL FUNCTION 'BAPI_GOODSMVT_CREATE'
      EXPORTING
        goodsmvt_header  = goodsmvt_header
        goodsmvt_code    = goodsmvt_code
*       TESTRUN          = ' '
*       GOODSMVT_REF_EWM =
      IMPORTING
        goodsmvt_headret = ls_header
*       MATERIALDOCUMENT =
*       MATDOCUMENTYEAR  =
      TABLES
        goodsmvt_item    = goodsmvt_item[]
*       GOODSMVT_SERIALNUMBER         =
        return           = return[]
*       GOODSMVT_SERV_PART_DATA       =
*       EXTENSIONIN      =
      .
    IF return[] IS NOT INITIAL.
* Implement suitable error handling here

**Calling fm to get 1 second delay
**and call create TO fm
*      CALL FUNCTION 'ENQUE_SLEEP'
*        EXPORTING
*          seconds = 1
**     EXCEPTIONS
**         SYSTEM_FAILURE       = 1
**         OTHERS  = 2
*        .
*      IF sy-subrc <> 0.
** Implement suitable error handling here
*      ENDIF.

    ELSE.
      COMMIT WORK.
*      EXIT.
    ENDIF.
*  ENDDO.

*  SELECT SINGLE * FROM zzoperations
*      INTO ls_oper
*      WHERE vbeln = iv_sales.
*
*      ls_oper-zzdepozyt = 'XX'.
*      APPEND ls_oper TO lt_oper[].
*      MODIFY zzoperations FROM TABLE lt_oper[].
*      COMMIT WORK.

  goodsmvt_headret = ls_header.

ENDFUNCTION.
