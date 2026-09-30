*&---------------------------------------------------------------------*
*& 05_oop_basics.abap
*& Topic: Object-Oriented ABAP — Classes and Objects
*& Notes: ABAP supports full OOP. Modern SAP development (Fiori,
*&        RAP, BTP) relies heavily on OO ABAP. Classes are defined
*&        in two parts: DEFINITION (what exists) and
*&        IMPLEMENTATION (what it does).
*&---------------------------------------------------------------------*

REPORT z_oop_basics.

*&---------------------------------------------------------------------*
*& CLASS DEFINITION
*& Visibility sections:
*&   PUBLIC    — accessible from outside the class
*&   PROTECTED — accessible by subclasses only
*&   PRIVATE   — accessible only within this class
*&---------------------------------------------------------------------*
CLASS lcl_employee DEFINITION.
  PUBLIC SECTION.
    DATA: emp_id TYPE i,
          name   TYPE string,
          dept   TYPE string.

    METHODS:
      constructor
        IMPORTING
          iv_id   TYPE i
          iv_name TYPE string
          iv_dept TYPE string,

      get_details
        RETURNING
          VALUE(rv_info) TYPE string,

      calculate_bonus
        IMPORTING
          iv_percent     TYPE p DECIMALS 2
        RETURNING
          VALUE(rv_bonus) TYPE p DECIMALS 2.

  PRIVATE SECTION.
    DATA: salary TYPE p DECIMALS 2.

ENDCLASS.

*&---------------------------------------------------------------------*
*& CLASS IMPLEMENTATION
*&---------------------------------------------------------------------*
CLASS lcl_employee IMPLEMENTATION.

  METHOD constructor.
    emp_id = iv_id.
    name   = iv_name.
    dept   = iv_dept.
    salary = '50000'.   " default salary
  ENDMETHOD.

  METHOD get_details.
    rv_info = |ID: { emp_id } | Name: { name } | Dept: { dept }|.
  ENDMETHOD.

  METHOD calculate_bonus.
    rv_bonus = salary * ( iv_percent / 100 ).
  ENDMETHOD.

ENDCLASS.

*&---------------------------------------------------------------------*
*& MAIN PROGRAM — creating and using objects
*&---------------------------------------------------------------------*

" Create object using NEW operator (modern ABAP)
DATA(lo_emp1) = NEW lcl_employee( iv_id   = 1
                                   iv_name = 'Swapnanil'
                                   iv_dept = 'IT' ).

DATA(lo_emp2) = NEW lcl_employee( iv_id   = 2
                                   iv_name = 'Priya'
                                   iv_dept = 'HR' ).

" Call methods using -> (instance method call)
WRITE: / lo_emp1->get_details( ).
WRITE: / lo_emp2->get_details( ).

DATA(lv_bonus) = lo_emp1->calculate_bonus( iv_percent = '15' ).
WRITE: / |Bonus for { lo_emp1->name }: { lv_bonus }|.

* ── Key OOP concepts in ABAP ────────────────────────────────────────
" Encapsulation : private data (salary) hidden from outside
" Abstraction   : get_details hides internal formatting logic
" Inheritance   : INHERITING FROM — child class gets parent's members
" Polymorphism  : reference to parent class can hold child object
"
" Interfaces    : defined with INTERFACE keyword
"                 implementing class MUST define all interface methods
"                 called using: lo_obj->if_name~method_name( )
