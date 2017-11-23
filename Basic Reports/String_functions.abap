*&---------------------------------------------------------------------*
*& Report  ZDIV_STRING
*&
*&---------------------------------------------------------------------*

REPORT  zdiv_string.

*&-- String input.
DATA str TYPE string.
str = 'Divyanshu'.
*&---- Char array type
DATA: my_str(10) VALUE 'Sharma',length TYPE i,
      res TYPE string,sep.

*&--- Inbuild methods of string
length = strlen( str ).
WRITE: 'Length of first String : ',length.

*concatnate of two string
CONCATENATE str my_str INTO res SEPARATED BY sep.
WRITE: /'After concatnation string : ',res.

*Condence method of string.
DATA str2 TYPE string.
str2 = 'Welcome   to    ABAP.'.
CONDENSE str2.
WRITE: /'Condense with space: ',str2.
CONDENSE str2 NO-GAPS.
WRITE: /'Condense with no-space: ',str2.

* Split method of string
DATA  str4(30) VALUE 'Welcome to ABAP'.
DATA: s1(7), s2(5), s3(5).
SPLIT str4 AT ' ' INTO s1 s2 s3.
WRITE: / s1, / s2, / s3.

*Search  in string
DATA str5(3) VALUE 'to'.
SEARCH str4 FOR str5.
WRITE: /'Position of given string: ', sy-fdpos.

*Shift method
DATA sft(20) VALUE 'welcome to abap'.
SHIFT sft CIRCULAR BY 5 PLACES.
WRITE sft COLOR 5.

*Transalate method
DATA tr(10) VALUE 'BANGALORE'.
TRANSLATE tr TO LOWER CASE.
WRITE: /'Translate: ', tr.

*Replace method
DATA: rep(20) VALUE 'ALL IS WELL',
      rp(5) VALUE 'IN'.
REPLACE 'IS' IN rep WITH rp.
WRITE: / 'After Replacing: ', rep.
