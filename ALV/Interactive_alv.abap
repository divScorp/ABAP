*&---------------------------------------------------------------------*
*& Report  ZRP_ALV_1
*&
*&---------------------------------------------------------------------*
*& Created by - divScorp
*&
*&---------------------------------------------------------------------*

report  zrp_alv_1.

type-pools: slis.

types: begin of ty_flight, box.
include structure spfli.
types: end of ty_flight.

data: lt_spfli type table of ty_flight.
data: ls_spfli type ty_flight.
data: ls_layout type slis_layout_alv.
data: lt_fieldcat type slis_t_fieldcat_alv.


start-of-selection.
  perform build_data.
  perform build_fieldcatalog.
  perform build_layout.
  perform display_list_alv.


*&---------------------------------------------------------------------*
*&      Form  BUILD_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form build_data .
  select * from spfli into corresponding fields of table lt_spfli.
endform.                    " BUILD_DATA
*&---------------------------------------------------------------------*
*&      Form  BUILD_LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form build_layout .

  ls_layout-zebra = 'X'.
  ls_layout-box_fieldname = 'BOX'.
endform.                    " BUILD_LAYOUT
*&---------------------------------------------------------------------*
*&      Form  BUILD_FIELDCATALOG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form build_fieldcatalog .
  data: ls_fieldcat type line of slis_t_fieldcat_alv.
  call function 'REUSE_ALV_FIELDCATALOG_MERGE'
 exporting
      i_program_name         = sy-cprog
*     i_internal_tabname     =
      i_structure_name       = 'SPFLI'
*     I_CLIENT_NEVER_DISPLAY = ‘X’
*     I_INCLNAME             =
*     I_BYPASSING_BUFFER     =
*     I_BUFFER_ACTIVE        =
    changing
      ct_fieldcat            = lt_fieldcat
    exceptions
      inconsistent_interface = 1
      program_error          = 2
      others                 = 3.

  loop at lt_fieldcat into ls_fieldcat.
    case ls_fieldcat-fieldname.
      when 'COUNTRYFR' or
      'COUNTRYTO' or
      'CITYFROM' or
      'CITYTO' or
      'AIRPFROM' or
      'AIRPTO' .
        ls_fieldcat-no_out = 'X'.
        modify lt_fieldcat from ls_fieldcat transporting no_out.
      when others.
    endcase.

  endloop.
            .
  if sy-subrc <> 0.
* Implement suitable error handling here
  endif.

endform.                    " BUILD_FIELDCATALOG
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_LIST_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form display_list_alv .
call function 'REUSE_ALV_LIST_DISPLAY'
 exporting
      i_callback_program = sy-cprog
      is_layout          = ls_layout
      it_fieldcat        = lt_fieldcat
    tables
      t_outtab           = lt_spfli
    exceptions
      program_error      = 1
      others             = 2.
  case sy-subrc.
    when 1.
      message 'program error' type 'i'.
    when others.
  endcase.

endform.                    " DISPLAY_LIST_ALV
