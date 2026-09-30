*&---------------------------------------------------------------------*
*& 03_open_sql.abap
*& Topic: Open SQL — reading from and writing to the SAP database
*& Notes: Open SQL is ABAP's way of talking to the database.
*&        It is database-independent — SAP handles the translation
*&        to the underlying DB (HANA, Oracle, SQL Server etc.)
*&        Always check sy-subrc after every database operation.
*&---------------------------------------------------------------------*

REPORT z_open_sql.

* Common SAP tables used in examples:
*   MARA  = Material Master (general data)
*   MAKT  = Material Descriptions (text)
*   KNA1  = Customer Master
*   LFA1  = Vendor Master
*   VBAK  = Sales Order Header
*   EKKO  = Purchase Order Header

* ── SELECT SINGLE — fetch exactly one row ──────────────────────────
DATA: ls_mara TYPE mara.

SELECT SINGLE *
  FROM mara
  INTO ls_mara
  WHERE matnr = '000000000000000001'.

IF sy-subrc = 0.
  WRITE: / 'Material found:', ls_mara-matnr.
ELSE.
  WRITE: / 'Material not found.'.
ENDIF.

* ── SELECT — fetch multiple rows into internal table ───────────────
DATA: lt_makt TYPE TABLE OF makt,
      ls_makt TYPE makt.

SELECT matnr maktx
  FROM makt
  INTO TABLE lt_makt
  WHERE spras = 'EN'.        " EN = English language key

IF sy-subrc = 0.
  LOOP AT lt_makt INTO ls_makt.
    WRITE: / ls_makt-matnr, ls_makt-maktx.
  ENDLOOP.
ENDIF.

* ── Modern ABAP SELECT syntax (inline) ─────────────────────────────
SELECT matnr, maktx
  FROM makt
  INTO TABLE @DATA(lt_materials)
  WHERE spras = @sy-langu      " sy-langu = current user's language
  ORDER BY matnr.

* ── SELECT with JOIN ───────────────────────────────────────────────
" Joining material number with its description
DATA: lt_result TYPE TABLE OF makt.

SELECT a~matnr b~maktx
  FROM mara AS a
  INNER JOIN makt AS b ON a~matnr = b~matnr
  INTO TABLE @DATA(lt_joined)
  WHERE b~spras = 'EN'
  AND   a~mtart = 'FERT'.    " FERT = Finished Product material type

* ── INSERT — add a new record ──────────────────────────────────────
" Note: In real SAP you would use BAPIs or Function Modules
"       to insert business data. Direct INSERT is used for
"       custom Z-tables only.
DATA: ls_ztable TYPE zmy_custom_table.
ls_ztable-key_field = '001'.
ls_ztable-value     = 'Test'.
INSERT INTO zmy_custom_table VALUES ls_ztable.
IF sy-subrc <> 0.
  WRITE: / 'Insert failed.'.
ENDIF.

* ── UPDATE ─────────────────────────────────────────────────────────
UPDATE zmy_custom_table
  SET value = 'Updated'
  WHERE key_field = '001'.

* ── DELETE ─────────────────────────────────────────────────────────
DELETE FROM zmy_custom_table WHERE key_field = '001'.

* ── Key system variable ─────────────────────────────────────────────
" sy-subrc : return code — ALWAYS check this after DB operations
"            0 = success / record found
"            4 = no records found
"            8 = error
