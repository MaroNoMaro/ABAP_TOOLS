*&---------------------------------------------------------------------*
*& Report zmail_exp
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zmail_exp.

data(logo_url) = '/SAP/PUBLIC/LOGO_ZABKA_TRANSPARENT'.
data(mime_api) = cl_mime_repository_api=>if_mr_api~get_api( ).
mime_api->get( exporting i_url = logo_url
                    importing e_is_folder = data(is_folder)
                                e_content = data(content_xstring)
                                e_loio = data(lolo) ).
*data(content_solix) = cl_bcs_convert=>xstring_to_solix( content_xstring ).
*data(attachement_size) = xstrlen( content_xstring ).
data(obj_len) = xstrlen( content_xstring ).
data(graphic_length) = xstrlen( content_xstring ).
data(r_xstrl) = content_xstring(obj_len).
data(offset) = 0.
data(length) = 255.
  data lt_solix type solix_tab.
  data ls_solix type solix.

while offset < graphic_length.
  data(diff) = graphic_length - offset.
  if diff > length.
    ls_solix-line = r_xstrl+offset(length).
  else.
    ls_solix-line = r_xstrl+offset(diff).
  endif.
  append ls_solix to lt_solix.
  add length to offset.
endwhile.

data(filename) = 'zabka_logo.gif'.
data(content_id) = 'zabka_logo.gif'.

data(mime_helper) = new cl_gbt_multirelated_service( ).
mime_helper->add_binary_part(
    content = lt_solix
    filename = conv #( filename )
    extension = conv #( '.gif' )
    description = 'Logo'
    content_type = 'image/gif'
    length = conv #( obj_len )
    content_id = conv #( content_id )
).

data mail_content type tabtype_soli.
append '<!DOCTYPE html><html><head><meta charset="UTF-8"></head>' to mail_content.
append '<body>' to mail_content.
append '<p>test' to mail_content.
append '<p>test2' to mail_content.
append '<p>test3' to mail_content.
append '<p>test4' to mail_content.
append '<p>test5' to mail_content.
append '<p>test6' to mail_content.
append '<br>' to mail_content.
append '<img alt="[LOGO]" src="cid:zabka_logo.gif"/><br>' to mail_content.
append '<p>test7' to mail_content.
append '<p>test8' to mail_content.
append '<p>test9' to mail_content.
append '</body></html>' to mail_content.

mime_helper->set_main_html(
    content = mail_content
    description = 'Niedoplata'
).

data(doc_bcs) = cl_document_bcs=>create_from_multirelated(
    i_subject = 'barcinskim_test'
    i_multirel_service = mime_helper
).

data(bcs) = cl_bcs=>create_persistent( ).
bcs->set_document( i_document = doc_bcs ).
data(sender) = cl_cam_address_bcs=>create_internet_address( 'mail@ipopema.pl' ).
data(recipient) = cl_cam_address_bcs=>create_internet_address( 'mail@ipopema.pl' ).
bcs->set_sender( sender ).
bcs->add_recipient( recipient ).


bcs->send( ).
commit work and wait.




write: / 'Koniec'.
