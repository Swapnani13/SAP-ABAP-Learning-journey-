# SAP Architecture & Concepts — My Notes

Personal notes written in plain English to solidify my understanding.
These are not copy-pasted — they are how I understand things.

---

## What is SAP?

SAP is an ERP — Enterprise Resource Planning system. Think of it as one giant
connected software that runs an entire company. Instead of having separate
software for Finance, Inventory, HR, and Sales that don't talk to each other,
SAP puts everything in one place.

When a sales order is created in SAP, it automatically:
- Checks inventory (MM module)
- Triggers a delivery (SD module)
- Posts a revenue entry (FI module)
- Updates production planning (PP module)

That automatic connection is the whole point of ERP.

---

## SAP Architecture — 3 Tiers

```
[ Presentation Layer ]   ← What the user sees (SAP GUI / Fiori browser UI)
        ↓
[ Application Server ]   ← Where ABAP programs run and business logic lives
        ↓
[ Database Layer ]       ← Where all data is stored (SAP HANA / Oracle / etc.)
```

ABAP code runs on the Application Server — never on the user's machine.
This is why SAP is fast even for thousands of users simultaneously.

---

## What is ABAP?

ABAP = Advanced Business Application Programming

It is SAP's own programming language, created in the 1980s and still actively
developed. It is a 4th generation language (4GL) — meaning it is higher level
than C/Java, designed specifically for business data processing.

ABAP lives entirely inside SAP. You write code using transaction SE38 (ABAP
Editor) or SE80 (Object Navigator). There is no external IDE needed.

---

## Key Transaction Codes (T-Codes)

| T-Code | What it does |
|--------|-------------|
| SE38 | ABAP Editor — write and run programs |
| SE80 | Object Navigator — full development environment |
| SE11 | ABAP Data Dictionary — table definitions, structures |
| SE37 | Function Module browser — view and test FMs |
| SM30 | Table Maintenance — view/edit table contents |
| ST05 | SQL Trace — find slow database queries |
| SU01 | User administration |

---

## ABAP Data Dictionary (SE11)

The Data Dictionary is like the schema of the entire SAP system.
It stores:
- **Transparent Tables** — 1:1 mapping to a database table (e.g. MARA, KNA1)
- **Structures** — like a table but no data stored, used as templates
- **Data Elements** — define the type and label of a single field
- **Domains** — define the technical type and allowed values for a field
- **Views** — join multiple tables into one logical view

---

## Internal Tables vs Database Tables

| | Database Table | Internal Table |
|---|---|---|
| Where | Stored on disk permanently | Lives in memory during program run only |
| Accessed via | Open SQL (SELECT) | LOOP AT, READ TABLE |
| Persists after program | Yes | No — lost when program ends |
| Example | MARA (material master) | lt_materials (my temp list) |

---

## sy- System Variables — the ones I use most

| Variable | What it holds |
|----------|--------------|
| sy-subrc | Return code of last operation. 0 = success |
| sy-tabix | Current row index inside a LOOP AT |
| sy-uname | Logged-in SAP username |
| sy-datum | Today's date |
| sy-langu | Current user's language key |
| sy-lines | Set after DESCRIBE TABLE — number of rows |

---

## SAP Modules — overview

| Module | Short name | What it handles |
|--------|-----------|----------------|
| Financial Accounting | FI | Books, ledgers, payments |
| Controlling | CO | Internal cost accounting |
| Materials Management | MM | Purchasing, inventory, vendors |
| Sales & Distribution | SD | Orders, delivery, billing |
| Human Capital Mgmt | HCM | Payroll, HR records |
| Production Planning | PP | Manufacturing, BOMs |
| Technology | BASIS/ABAP | System admin, programming |

---

## What I want to understand better

- How a real BADI is found and implemented (SPRO / SE18)
- How Fiori apps connect to ABAP backend via OData services
- How SAP BTP differs from on-premise — what changes in ABAP Cloud
- How a real project delivery works — what a junior consultant actually does day 1

---

*Last updated: September 2026*
