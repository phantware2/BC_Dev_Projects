# **Bank Statement Upload & Manual Matching – Business Central Extension**

This extension provides a simple framework for uploading bank statement lines (using CSV file simulation), manually matching statements with bank ledger entries, and visually indicating matched/unmatched transactions using color cues.

## Overview:

Develop a page to upload bank statement lines (using CSV simulation). Allow users to manually match statements with ledger entries and add color indicators for matched or unmatched transactions.

**Skills covered:** File imports, reconciliation, UI customization.

## **📌 Features**

### **1. Upload Bank Statement (CSV Simulation)**

- A custom **Page** allows users to upload a bank statement file.
- CSV data is parsed and stored into a custom **Bank Statement Line** table.
- Fields include:

  - Posting Date
  - Document No.
  - Description
  - Amount
  - Match Status

### **2. Manual Matching Interface**

- A dedicated **Matching Page** displays:

  - Imported bank statement lines
  - Available bank ledger entries

- Users can manually pair statement lines with posted ledger entries.
- Validation logic ensures:

  - Only lines with identical amounts can be matched
  - No ledger entry can be matched more than once

### **3. Color Indicators (Matched / Unmatched)**

- Visual cues are added using **StyleExpr**:

  - **Green** → Matched
  - **Yellow** → Partially matched (optional scenario)
  - **Red** → Unmatched

- Enhances clarity and speeds up reconciliation.

---

## **📂 Object Overview**

| Object Type | ID    | Name                         | Description                                        |
| ----------- | ----- | ---------------------------- | -------------------------------------------------- |
| Table       | 50100 | Bank Statement Line          | Stores imported CSV statement data                 |
| Page        | 50100 | Bank Statement Upload        | Upload & preview statement lines                   |
| Table       | 50101 | Bank Match Buffer (optional) | Temporary match support                            |
| Page        | 50101 | Bank Manual Matching         | Interface for pairing statement and ledger entries |
| Codeunit    | 50100 | Bank CSV Import Mgt.         | Logic to parse CSV and populate table              |

---

## **⚙️ How It Works**

### **Step 1 — Upload CSV File**

1. Open **Bank Statement Upload** page.
2. Select CSV file.
3. System reads lines and inserts into _Bank Statement Line_ table.
4. Preview the data before confirmation.

### **Step 2 — Review & Match**

1. Open **Bank Manual Matching** page.
2. Select a statement line.
3. Choose a matching ledger entry from the factbox/list.
4. Click **Match**.

### **Step 3 — Visual Cue Updates**

- Once matched, the **StyleExpr** formula updates row color:

  ```al
  StyleExpr := GetStatusStyle("Match Status");
  ```

---

## **🧪 CSV Format Example**

```
PostingDate,DocumentNo,Description,Amount
2025-01-01,TRX001,NEPA Bill,-15000
2025-01-02,DEP001,Customer Payment,45000
2025-01-03,TRF100,Transfer Fee,-500
```

---

## **🛠 AL Code Highlights**

### **1. Import Logic Snippet**

```al
procedure ImportCSV(FileContent: Text)
var
    Line: Text;
    Fields: List of [Text];
begin
    foreach Line in FileContent.Split('\n') do begin
        Fields := Line.Split(',');
        InsertStatementLine(Fields);
    end;
end;
```

### **2. Row Coloring Expression**

```al
procedure GetStatusStyle(Status: Enum "Match Status"): Text
begin
    case Status of
        Status::Matched: exit('Favorable');
        Status::Unmatched: exit('Attention');
        Status::Partial: exit('StandardAccent');
    end;
end;
```

---

## **🚀 Future Enhancements**

- Automatic matching based on:

  - Amount similarity
  - Document number
  - Description pattern

- Reconciliation report
- Bank account linking for multi‐account support
- Real file upload using standard BC **Stream** APIs

---

## **📄 Dependencies**

- Microsoft _Base Application_
- File Management Codeunit
- Bank Account Ledger Entry table

---

## **👨‍💻 Author**

Developed by: _Business Central Consultant / AL Developer_
Solution tailored for improving bank reconciliation efficiency in Dynamics 365 Business Central.
