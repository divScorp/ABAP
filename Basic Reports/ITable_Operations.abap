*&---------------------------------------------------------------------*
*& Report  ZRP_ITAB_OP
*&
*&---------------------------------------------------------------------*
*&
*& created by -divScorp
*&---------------------------------------------------------------------*

report  zrp_itab_op.

*DATA: BEGIN OF it_str OCCURS 0,
*  roll_no TYPE i,
*  Name(20) TYPE c,
*  END OF it_str.
*
*DATA: wa_str Like it_str.

types: begin of it_tab,
  roll_no type i ,
  name(20) type c,
  end of it_tab.

data: it_tab1 type table of it_tab,
      it_tab2 type table of it_tab,
       wa_tab type it_tab.

append initial line to it_tab2.  " this will add empty line with default value in table.

" Data insertion using append.
wa_tab-roll_no = 1.
wa_tab-name = 'div'.
append wa_tab to it_tab1.

wa_tab-roll_no = 2.
wa_tab-name = 'ranjan'.
append wa_tab to it_tab1.

wa_tab-roll_no = 3.
wa_tab-name = 'ram'.
append wa_tab to it_tab1.

" Append data element of one table into another.
append lines of it_tab1 to it_tab2.

"--- INSERT data into internal table
wa_tab-roll_no = 4.
wa_tab-name = 'manash'.
insert wa_tab into table it_tab2.

"--- Insert at particular index
wa_tab-roll_no = 5.
wa_tab-name = 'Arnav'.
insert wa_tab into it_tab2 index 3.

"--- Sort table it_tab2 in descending order.
sort it_tab2 by roll_no descending .
"--- Describe table used to count no of records.
data lv_count type i.
describe table it_tab2 lines lv_count.
write:/ 'No of records: ', lv_count.
loop at it_tab2 into wa_tab.
 write:/ wa_tab-roll_no, wa_tab-name.
endloop.

uline.
" Using Field-symbol modify the table
field-symbols: <fs_tab> like line of it_tab2.
read table it_tab2 assigning <fs_tab> with key roll_no = 5.
if sy-subrc = 0.
  <fs_tab>-name = 'mohan'.
endif.
write: / 'Update using Field-Symbols'.
loop at it_tab2 into wa_tab.
 write:/ wa_tab-roll_no, wa_tab-name.
endloop.

uline.
"Using MODIFY update the table.
wa_tab-roll_no = 5.
wa_tab-name = 'Arnav'.
*&------- Both MODIFY works
*MODIFY it_tab2 FROM wa_tab INDEX 1 TRANSPORTING roll_no name.
modify it_tab2 from wa_tab transporting roll_no name where roll_no = 5.
write:/'After updating using MODIFY: '.
loop at it_tab2 into wa_tab.
 write:/ wa_tab-roll_no, wa_tab-name.
endloop.

**&-----MOVE-CORRESPONDING
*MOVE-CORRESPONDING it_tab to it_tab2.
*LOOP AT it_tab1 INTO wa_tab.
* WRITE:/ wa_tab-roll_no, wa_tab-name.
*ENDLOOP.
uline.

*&----Collect statement.
sort it_tab2 by roll_no.
wa_tab-roll_no = 5.
wa_tab-name = 'Arnav'.
collect wa_tab into it_tab2.

write:/ 'Collect statment: '.
loop at it_tab2 into wa_tab.
 write:/ wa_tab-roll_no, wa_tab-name.
endloop.
