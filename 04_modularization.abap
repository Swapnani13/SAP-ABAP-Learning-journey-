*&---------------------------------------------------------------------*
*& 04_modularization.abap
*& Topic: Modularization — FORM subroutines & Function Modules
*& Notes: Modularization = breaking code into reusable blocks.
*&        FORM = local to the program (like a private method)
*&        Function Module = global, can be called from any program
*&                          RFC-enabled FMs can be called externally
*&---------------------------------------------------------------------*

REPORT z_modularization.

DATA: lv_salary  TYPE p DECIMALS 2 VALUE '60000',
      lv_tax     TYPE p DECIMALS 2,
      lv_result  TYPE string,
      lv_answer  TYPE c LENGTH 1.

* ── Calling a FORM subroutine ──────────────────────────────────────
PERFORM calculate_tax
  USING    lv_salary
  CHANGING lv_tax.

WRITE: / 'Salary:', lv_salary.
WRITE: / 'Tax   :', lv_tax.

* ── Calling a Function Module ──────────────────────────────────────
" POPUP_TO_CONFIRM is a standard SAP Function Module
" that shows a dialog box asking the user to confirm an action.
CALL FUNCTION 'POPUP_TO_CONFIRM'
  EXPORTING
    titlebar       = 'Confirm Action'
    text_question  = 'Do you want to proceed?'
    text_button_1  = 'Yes'
    text_button_2  = 'No'
  IMPORTING
    answer         = lv_answer   " '1' = Yes, '2' = No
  EXCEPTIONS
    text_not_found = 1
    OTHERS         = 2.

IF sy-subrc <> 0.
  WRITE: / 'Function Module call failed.'.
ENDIF.

IF lv_answer = '1'.
  WRITE: / 'User confirmed.'.
ELSE.
  WRITE: / 'User cancelled.'.
ENDIF.

*&---------------------------------------------------------------------*
*& FORM: calculate_tax
*& Purpose: Calculates 10% tax on a given salary
*& USING    = input parameter (read-only inside FORM)
*& CHANGING = input+output parameter (can be modified)
*&---------------------------------------------------------------------*
FORM calculate_tax
  USING    p_salary TYPE p
  CHANGING p_tax    TYPE p.

  p_tax = p_salary * '0.10'.

ENDFORM.

* ── Key difference: FORM vs Function Module ─────────────────────────
" FORM subroutine:
"   - Defined within the same program
"   - Called with PERFORM
"   - Cannot be called from outside the program
"   - Good for organising code within one report
"
" Function Module:
"   - Stored in a Function Group (SE37 to view/edit)
"   - Called with CALL FUNCTION from any program
"   - Can be RFC-enabled (called remotely / from other systems)
"   - Has strict IMPORTING / EXPORTING / CHANGING / TABLES / EXCEPTIONS interface
"   - BAPI = a special RFC-enabled FM that follows SAP naming standards
