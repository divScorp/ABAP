*&---------------------------------------------------------------------*
*& Report  ZDIV_LOOPS
*&
*&---------------------------------------------------------------------*

report  zdiv_loops.

*- DO loop check
data: a1 type i, b1 type i.
a1 = 0.
b1 = 0.
do 2 times.
  a1 = a1 + 1.
  write: /'Outer: ', a1.
  do 7 times.
    b1 = b1 + 1.
    write: /'Inner',b1.
  enddo.
  write /.
enddo.

*if else statements check
data title(20) type c.
title = 'Tutorials'.
if title = 'Tutorial'.
  write /'True'.
else.
  write /'False'.
endif.

* While loop check

data a type i.
a = 0.
while a <= 5.
  a = a + 1.
  write: /'count: ',a.
endwhile.
