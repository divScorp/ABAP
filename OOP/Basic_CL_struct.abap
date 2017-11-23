*&---------------------------------------------------------------------*
*& Report  ZRP_CONSTRUCTOR
*&
*&---------------------------------------------------------------------*
*& Basic class method structure
*& created by - divScorp
*&---------------------------------------------------------------------*

report  zrp_constructor.


load-OF-PROGRAM.
  WRITE: / 'LOAD-OF-PROGRAM'.

START-OF-SELECTION.
SKIP 3.
WRITE: / 'Calling a static Constructor'.
WRITE:/'ZCL_DIV_CONS =>c_a',/ zcl_div_cons=>c_a.

SKIP 2.
DATA: lo_cons TYPE REF TO zcl_div_cons.
WRITE: / 'Calling a Constructor'.
CREATE OBJECT LO_CONS.
WRITE:/ lo_cons->c_a.

*----------------------------------------------------------------------*
*       CLASS cl_s DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class cl_s definition.
  public section.
    methods: m_one, constructor.
endclass.                    "cl_s DEFINITION

*----------------------------------------------------------------------*
*       CLASS cl_s IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class cl_s implementation.
  method m_one.
    write:/ 'method'.
  endmethod.                    "m_one

  method constructor.
    write: / 'Constructor'.
  endmethod.                    "constructor
endclass.                    "cl_s IMPLEMENTATION

* start-of-selection.
* data obj type ref to cl_s.
* create object obj.
