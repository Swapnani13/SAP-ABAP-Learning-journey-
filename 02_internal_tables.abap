*&---------------------------------------------------------------------*
*& 02_internal_tables.abap
*& Topic: Internal Tables — the most important concept in ABAP
*& Notes: Internal tables are temporary in-memory tables used to
*&        store and process sets of data during program execution.
*&        Think of them like arrays of structs / lists of objects.
*&---------------------------------------------------------------------*

REPORT z_internal_tables.

* ── Step 1: Define a Structure (like a row blueprint) ──────────────
TYPES: BEGIN OF ty_employee,
         emp_id  TYPE i,
         name    TYPE string,
         dept    TYPE c LENGTH 10,
         salary  TYPE p DECIMALS 2,
       END OF ty_employee.

* ── Step 2: Declare the Internal Table and a Work Area ─────────────
" Internal table = the full table (many rows)
" Work area (ls_) = one row at a time
DATA: lt_employees TYPE STANDARD TABLE OF ty_employee,
      ls_employee  TYPE ty_employee.

* ── Step 3: Add rows using APPEND ──────────────────────────────────
ls_employee = VALUE #( emp_id = 1 name = 'Swapnanil' dept = 'IT'
                       salary = '45000' ).
APPEND ls_employee TO lt_employees.

ls_employee = VALUE #( emp_id = 2 name = 'Priya' dept = 'HR'
                       salary = '50000' ).
APPEND ls_employee TO lt_employees.

ls_employee = VALUE #( emp_id = 3 name = 'Rahul' dept = 'IT'
                       salary = '48000' ).
APPEND ls_employee TO lt_employees.

* ── Step 4: Loop through the table ─────────────────────────────────
WRITE: / '--- All Employees ---'.
LOOP AT lt_employees INTO ls_employee.
  WRITE: / ls_employee-emp_id, ls_employee-name, ls_employee-dept,
            ls_employee-salary.
ENDLOOP.

* ── Step 5: Loop with a WHERE filter ───────────────────────────────
WRITE: / '--- IT Department Only ---'.
LOOP AT lt_employees INTO ls_employee WHERE dept = 'IT'.
  WRITE: / ls_employee-name, ls_employee-salary.
ENDLOOP.

* ── Step 6: READ TABLE — find a specific row ───────────────────────
READ TABLE lt_employees INTO ls_employee WITH KEY emp_id = 2.
IF sy-subrc = 0.
  " sy-subrc = 0 means the record was found successfully
  WRITE: / 'Found:', ls_employee-name.
ELSE.
  WRITE: / 'Record not found.'.
ENDIF.

* ── Step 7: Modify a row ───────────────────────────────────────────
READ TABLE lt_employees INTO ls_employee WITH KEY emp_id = 1.
IF sy-subrc = 0.
  ls_employee-salary = '50000'.
  MODIFY lt_employees FROM ls_employee TRANSPORTING salary
    WHERE emp_id = 1.
ENDIF.

* ── Step 8: Delete a row ───────────────────────────────────────────
DELETE lt_employees WHERE dept = 'HR'.

* ── Step 9: Check table size ───────────────────────────────────────
DATA(lv_count) = lines( lt_employees ).
WRITE: / 'Remaining employees:', lv_count.
