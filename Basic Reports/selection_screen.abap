*&---------------------------------------------------------------------*
*& Report  ZRP_APP_FORM
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

report  zrp_app_form no standard page heading.

define lb_macro_doc.
  selection-screen: begin of line,
  comment 1(31) &3.
  parameters: &1 as listbox visible length &2 obligatory.
  selection-screen end of line.
end-of-definition.
*&---------------------------------------------------------------------*
*& Selection screen for FORM BEGINS
*&---------------------------------------------------------------------*
selection-screen begin of block sc_b with frame title text-001.
selection-screen skip 1.
"Text-box parameters.
parameters: p_docid type zdocid,
            p_docn  type zde_docname.

selection-screen skip 1.

"Radio Button
selection-screen: begin of line,
comment 1(15) text-002.
parameters: male radiobutton group grp1.
selection-screen comment 20(15) text-003.
parameters female radiobutton group grp1.
selection-screen: comment 39(10) text-004,
end of line,skip 1.
"End of radio button

"Checkbox
selection-screen: begin of line,
   comment 1(15) text-c01.
parameters: p_india as checkbox.
selection-screen comment 20(15) text-c02.
parameters: p_nepal as checkbox.
selection-screen: comment 39(10) text-c03,
end of line.
selection-screen: begin of line,
  comment 1(15) text-a01.
parameters: p_france as checkbox.
selection-screen comment 20(15) text-c04.
parameters: p_ger as checkbox.
selection-screen: comment 39(10) text-c05,
end of line, skip 1.

"Dropdown
lb_macro_doc mylist(10) 25 comment.
selection-screen skip 2.

"Push button
selection-screen: begin of line,
    pushbutton 2(10) text-020 user-command cli1,
    pushbutton 16(10) text-021 user-command cli2,
end of line.
selection-screen end of block sc_b.
*&---------------------------------------------------------------------*
*& Selection screen for FORM ENDS
*&---------------------------------------------------------------------*

at selection-screen output.
  perform add_values_to_doc.
  comment = 'Doctor Name'.
start-of-selection.
  data: begin of it_name,
  name type zde_docname,
  end of it_name.
  select doctorname from ztdoctor into it_name where doctor_id = mylist(10).
    write: /'Selected name', it_name-name.
  endselect.
  include zin_doc_name.
  
  
*&---------------------------------------------------------------------*
*&  Include           ZIN_DOC_NAME
*&---------------------------------------------------------------------*

form add_values_to_doc.
  type-pools: vrm.

  "Structure for internal table
  types: begin of ty_doc,
    docid type zdocid,
    dname type zde_docname,
    end of ty_doc.

  "My-list Declaration
  data: my_list type vrm_values,
  value like line of my_list.

  data: wa_doc type ty_doc,
        it_doc type table of ty_doc.


  "Retrive data from doctor table
  select doctor_id doctorname from ztdoctor into table it_doc.


  " Filling data into my-list
  loop at it_doc into wa_doc.
    value-key = wa_doc-docid.
    value-text = wa_doc-dname.
    append value to my_list.
  endloop.

  " Finally calling the function module to create the list box.
  call function 'VRM_SET_VALUES'
    exporting
      id     = 'MYLIST'
      values = my_list.
endform.  
