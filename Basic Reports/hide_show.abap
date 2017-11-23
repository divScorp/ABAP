
*&---------------------------------------------------------------------*
*& Report  ZRP_HIDE_SHOW
*&
*&---------------------------------------------------------------------*
*& created by -divScorp
*&
*& Hide & show screen on radio button click
*&---------------------------------------------------------------------*

report  zrp_hide_show.

type-pools: icon.

data: switch.

selection-screen begin of block b2 with frame title text-001 no intervals.
parameters: radio radiobutton group rnd user-command sc1 default 'X',
            radio2 radiobutton group rnd.
selection-screen end of block b2.

selection-screen: begin of block b1 with frame title text-002 no intervals.
"Line 1
selection-screen:begin of line,
comment 10(15) text-s01 modif id sc1.
parameters: p_name type c length 17 modif id sc1.
selection-screen:end of line.
"Line 2
selection-screen:begin of line,
comment 10(15) text-s02 modif id sc1.
parameters: p_pass type c length 17 modif id sc1.
selection-screen:end of line, skip 1.
"Line 3
selection-screen: begin of line,
    pushbutton 15(10) text-b02 user-command cli1 modif id sc1,
    pushbutton 29(10) text-b01 user-command cli2 modif id sc1,
end of line.
selection-screen end of block b1.


selection-screen begin of block b3 with frame title text-003 no intervals.
"Line 1
selection-screen:begin of line ,
comment 10(15) text-201 modif id sc2.
parameters: p_fname type c length 17 modif id sc2.
selection-screen:end of line.
"Line 2
selection-screen:begin of line,
comment 10(15) text-202 modif id sc2.
parameters: p_lname type c length 17 modif id sc2.
selection-screen:end of line.
"Line 3
selection-screen:begin of line,
comment 10(15) text-204 modif id sc2.
parameters: p_pass2  type c length 17 modif id sc2.
selection-screen:end of line.
"Line 4
selection-screen:begin of line,
comment 10(15) text-203 modif id sc2.
parameters: p_email type c length 17 modif id sc2.
selection-screen:end of line, skip 1.
"Line 5
selection-screen: begin of line,
pushbutton 15(10) text-x01 user-command cli3 modif id sc2,
pushbutton 29(10) text-x02 user-command cli4 modif id sc2,
end of line.
selection-screen end of block b3.

at selection-screen output.
  "setup password input format.
  loop at screen.
    if screen-name = 'P_PASS' or screen-name = 'P_PASS2'.
      screen-invisible = '1'.
      modify screen.
    endif.
  endloop.

  loop at screen.
    if screen-group1 = 'SC1' and radio eq 'X'.
      screen-active = '0'.
      modify screen.
      continue.
    elseif screen-group1 = 'SC2' and radio2 eq 'X'.
      screen-active = '0'.
      modify screen.
      continue.
    endif.
  endloop.

start-of-selection.
