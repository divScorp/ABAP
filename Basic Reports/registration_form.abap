*&---------------------------------------------------------------------*
*& Report  ZRP_REGISTER_FORM
*&
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

report  zrp_register_form.


selection-screen begin of block res with frame title text-001.
parameters: p_name type c length 40 obligatory,
            p_email type c length 30 obligatory,
            p_pass type c length 16 obligatory,
            p_mob type c length 10 obligatory.

selection-screen skip 1.
"gender
selection-screen: begin of line,
comment 1(15) text-c02.
parameters: male radiobutton group grp1.
selection-screen comment 20(15) text-g03.
parameters female radiobutton group grp1.
selection-screen: comment 39(10) text-g04,
end of line,skip 1.
"Date of Birth
parameters: p_dob type sy-datum default sy-datlo obligatory.
selection-screen skip 1.
"Country List
parameters: ps_parm(20) as listbox visible length 20 default text-ct1 obligatory.
selection-screen skip 1.
"Checkbox, Area of interest
selection-screen: begin of line,
   comment 1(15) text-cb1.
parameters: p_cpp as checkbox.
selection-screen comment 20(15) text-cb2.
parameters: p_java as checkbox.
selection-screen: comment 39(10) text-cb3,
end of line.
selection-screen: begin of line,
  comment 1(15) text-a01.
parameters: p_abap as checkbox.
selection-screen comment 20(15) text-cb4.
parameters: p_other as checkbox.
selection-screen: comment 39(10) text-cb5,
end of line, skip 1.
selection-screen skip 1.
"Push button
selection-screen: begin of line,
    pushbutton 2(10) submit user-command cli1, "submit
    pushbutton 16(10) cancel user-command cli2, "clear.
end of line.

selection-screen end of block res.


*&---------------------------------------------------------------------*
*&Selection Screen output.
*&---------------------------------------------------------------------*
at selection-screen output.
  "setup password input format.
  loop at screen.
    if screen-name = 'P_PASS'.
      screen-invisible = '1'.
      modify screen.
    endif.
  endloop.

  "Data for dropdown country list
  type-pools: vrm.
  data: name  type vrm_id,
        list  type vrm_values,
        value like line of list.
  name = 'PS_PARM'.
  value-key = '1'.
  value-text = 'INDIA'.
  append value to list.
  value-key = '2'.
  value-text = 'Ireland'.
  append value to list.
  value-key = '3'.
  value-text = 'Nepal'.
  append value to list.
  value-key = '4'.
  value-text = 'Other'.
  append value to list.
  call function 'VRM_SET_VALUES'
    exporting
      id     = name
      values = list.

*&---------------------------------------------------------------------*
*&PushButton operations
*&---------------------------------------------------------------------*
initialization.
  submit = 'Submit'.
  cancel = 'Cancel'.
  tables sscrfields.
  data flag.
  call function 'ICON_CREATE'
    exporting
      name   = icon_okay
      text   = 'Click to Continue'
      info   = 'Okay'
    importing
      result = submit
    exceptions
      others = 0.

  call function 'ICON_CREATE'
    exporting
      name   = icon_cancel
      text   = 'Click to Exit'
      info   = 'Exit'
    importing
      result = cancel
    exceptions
      others = 0.

at selection-screen.
  case sscrfields.
    when 'CLI1'.
      flag = '1'.
    when 'CLI2'.
      flag = '2'.
  endcase.

start-of-selection.
  case flag.
    when '1'.
      write / 'Submit was clicked'.
    when '2'.
      write / 'Cancel was clicked'.
   endcase.
