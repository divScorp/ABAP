*&---------------------------------------------------------------------*
*& Report  ZRP_LOOP_EVENTS
*&
*&---------------------------------------------------------------------*
*& created  by - divScorp
*&
*&---------------------------------------------------------------------*

report  zrp_loop_events.

types: begin of ty_doc,
      docid type zdocid,
      docname type zde_docname,
  end of ty_doc.

data: it_doc type standard table of ty_doc,
      wa_doc type ty_doc,
      wa_temp type ty_doc.

select doctor_id doctorname from ztdoctor into table it_doc.
  sort it_doc by docid.

  field-symbols: <doctor_id> type ztdoctor-doctor_id.

  "" Full table print.
  write:/ 'Full Table'.
  loop at it_doc into wa_doc.
    wa_temp = wa_doc.
    write: / sy-tabix, wa_temp-docid, wa_temp-docname.
  endloop.

  "AT FIRST and AT LAST
  write:/ 'AT FIRST & AT LAST'.
  loop at it_doc into wa_doc.
    wa_temp = wa_doc.
    at first.
      write:/ 'First Entry'.
      write: / wa_temp-docid, wa_temp-docname.
    endat.
    at last.
      write:/ 'Last Entry'.
      write: / wa_temp-docid, wa_temp-docname.
    endat.
  endloop.

  " AT END OF
  write:/ 'AT END OF'.
  loop at it_doc into wa_doc.
    wa_temp = wa_doc.
    at end of docid.
      write: / sy-tabix, wa_temp-docid, wa_temp-docname.
    endat.
  endloop.

  " AT NEW
  write:/ 'AT NEW '.
  loop at it_doc into wa_doc.
    wa_temp = wa_doc.
    at new docid.
      write: / sy-tabix, wa_temp-docid, wa_temp-docname.
    endat.
  endloop.


 " ON CHANGE OF.
 write:/ 'ON CHANGE OF'.
  loop at it_doc into wa_doc.
    wa_temp = wa_doc.
    assign wa_doc-docid to <doctor_id>.
    on change of wa_doc-docid.
      write: / sy-tabix, wa_temp-docid, wa_temp-docname.
    endon.
  endloop.
