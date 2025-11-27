# Vendor Rating Enhancements in Business Central (AL)

This extension enhances the **Vendor** management experience in Microsoft Dynamics 365 Business Central by introducing rating fields to evaluate vendor performance. It adds:

## Overview

Add fields to track vendor ratings, such as delivery speed and quality scores. Create a factbox on the Vendor Card page showing average ratings and a report summarizing top and bottom vendors.

- New fields on the **Vendor** table to track delivery speed and quality score.
- A **FactBox** on the Vendor Card to display average rating information.
- A **Vendor Rating Summary Report** highlighting top and bottom-performing vendors.

**Skills covered:** Factboxes, data aggregation, reporting.

## Features

### 1. **Vendor Rating Fields**

New fields introduced in the **Vendor** table:

- **Delivery Speed Rating** (Integer or Decimal)
- **Quality Rating** (Integer or Decimal)
- **Overall Rating** (calculated or manually updated)

These fields allow organizations to monitor and compare vendor performance consistently.

---

### 2. **Vendor Rating FactBox**

A FactBox is added to the **Vendor Card** to show key rating statistics:

- Average Delivery Speed
- Average Quality Score
- Overall Performance Indicator (optional)

This gives users quick insight into vendor performance directly from the Vendor Card page.

---

### 3. **Vendor Rating Summary Report**

A new report summarizes vendor performance across all vendors. It includes:

- Vendor Name & No.
- Delivery Speed Rating
- Quality Rating
- Overall Rating
- Ranking of top and bottom vendors

The report helps procurement teams make data-driven decisions when selecting or evaluating vendors.

---

## Technical Components

### **Table Extensions**

- Extend `Vendor` table (`Table 23`) to add rating fields.
- Add necessary validations and default values.

### **Page Extensions**

- Extend `Vendor Card` to include rating fields in the layout.
- Add a new **FactBox page** to display averages and links to related entries.

### **Report Object**

- Create a report object (e.g., ID 50110 `"Vendor Rating Summary"`)
- Define dataset based on the Vendor table.
- Include logic to sort vendors by rating.

### **Codeunits (Optional)**

- A helper codeunit to calculate average ratings.
- Encapsulate logic for maintainability.

---

## Installation & Setup

1. Publish the extension using Visual Studio Code and the AL Language extension.
2. Navigate to **Vendors > Vendor Card** to view the new FactBox.
3. Run the report **Vendor Rating Summary** from the **Reports** menu.

---

## Usage Scenarios

### **Procurement Evaluation**

Evaluate top-performing vendors based on their delivery and quality metrics.

### **Performance Tracking**

Monitor performance over time and identify vendors that need improvement.

### **Data-Driven Decision Making**

Use the summary report to support contract renewal and vendor negotiation decisions.

---

## Future Enhancements (Optional)

- Add rating history table with timestamps.
- Enable user feedback or comments on ratings.
- Build Power BI dashboard for advanced analytics.
- Integrate rating calculations into purchasing documents.

---

## Version

**1.0.0**

---

## Author

Business Central AL Development – Vendor Performance Enhancements Module
