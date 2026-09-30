*&---------------------------------------------------------------------*
*& 01_basics.abap
*& Topic: Variables, Data Types, Basic Output
*& Notes: These are the building blocks of any ABAP program.
*&        Every variable must be declared before use.
*&---------------------------------------------------------------------*

REPORT z_basics.

* ── Elementary Data Types ──────────────────────────────────────────
DATA: lv_name    TYPE string,       " Variable-length text
      lv_age     TYPE i,            " Integer
      lv_salary  TYPE p DECIMALS 2, " Packed decimal (for amounts)
      lv_dob     TYPE d,            " Date: stored as YYYYMMDD
      lv_active  TYPE c LENGTH 1.   " Single character flag: 'X' or ' '

* ── Assigning Values ───────────────────────────────────────────────
lv_name   = 'Swapnanil'.
lv_age    = 21.
lv_salary = '45000.00'.
lv_dob    = '20030101'.
lv_active = 'X'.

* ── Output using WRITE ─────────────────────────────────────────────
WRITE: / 'Name   :', lv_name.
WRITE: / 'Age    :', lv_age.
WRITE: / 'Salary :', lv_salary.
WRITE: / 'Active :', lv_active.

* ── Inline Declaration (Modern ABAP style) ─────────────────────────
" Instead of declaring first, you can declare inline:
DATA(lv_greeting) = |Hello, { lv_name }! You are { lv_age } years old.|.
WRITE: / lv_greeting.

* ── Simple Arithmetic ──────────────────────────────────────────────
DATA(lv_tax)       = lv_salary * '0.10'.
DATA(lv_net_salary) = lv_salary - lv_tax.
WRITE: / 'Tax (10%)  :', lv_tax.
WRITE: / 'Net Salary :', lv_net_salary.

* ── Conditional Logic ──────────────────────────────────────────────
IF lv_active = 'X'.
  WRITE: / 'Employee is active.'.
ELSE.
  WRITE: / 'Employee is inactive.'.
ENDIF.

* ── CASE Statement ─────────────────────────────────────────────────
DATA(lv_dept) = 'IT'.

CASE lv_dept.
  WHEN 'IT'.   WRITE: / 'Department: Information Technology'.
  WHEN 'HR'.   WRITE: / 'Department: Human Resources'.
  WHEN 'FI'.   WRITE: / 'Department: Finance'.
  WHEN OTHERS. WRITE: / 'Department: Unknown'.
ENDCASE.
