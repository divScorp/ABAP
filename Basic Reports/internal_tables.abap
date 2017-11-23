*&---------------------------------------------------------------------*
*& Report  ZDIV_INTERNAL
*&
*&---------------------------------------------------------------------*
*& created by -divScorp
*&
*&---------------------------------------------------------------------*

REPORT  zrp_internal.

"Structure of type ty_doctor from ZTDOCTOR Table
TYPES: BEGIN OF ty_doctor,
  id TYPE zdocid,
  name TYPE zde_docname,
  specialization TYPE zde_special,
END OF ty_doctor.

"gwa_doctor is workspace area of type ty_doctor structure.
DATA: gwa_doctor TYPE ty_doctor,
      gt_doctor TYPE TABLE OF ty_doctor. "Internal table of type ty_doctor

 SELECT doctor_id doctorname specialization FROM ztdoctor INTO TABLE gt_doctor.

"Read TABLE gt_doctor into gwa_doctor INDEX 100001.
LOOP AT gt_doctor INTO gwa_doctor.
  WRITE:/'', gwa_doctor-id, gwa_doctor-name, gwa_doctor-specialization.
ENDLOOP.
