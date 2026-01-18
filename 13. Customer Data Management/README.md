# Customer Data Management – Business Central AL Extension

## 📌 Overview

The **Customer Data Management** extension is a custom Microsoft Dynamics 365 Business Central AL solution designed to manage customer master data in a centralized, structured, and validated manner.  
It enhances data quality, enforces business rules, and provides reporting and analytical capabilities that can be consumed by Sales, Finance, and Marketing modules.

---

## 🎯 Objectives

- Centralize customer data management
- Enforce data accuracy and consistency
- Prevent duplicate customer records
- Apply credit limit and payment term policies
- Provide insightful reports and queries for decision-making

---

## 🏗️ Solution Architecture

### Objects Included

| Object Type | Description                                       |
| ----------- | ------------------------------------------------- |
| Tables      | Customer, Customer Address                        |
| Pages       | Customer List, Customer Card, Customer Statistics |
| Codeunits   | Customer Management, Customer Validation          |
| Reports     | Customer List Report, Credit Limit Report         |
| Queries     | High Credit Limit Customers, Overdue Customers    |

---

## 🧱 Data Model

### Customer Table

Stores core customer master information.

**Key Fields**

- Customer No.
- Name
- Address
- Phone No.
- Email
- Credit Limit
- Payment Terms
- Discount %
- Blocked
- Created Date
- Last Modified Date

---

### Customer Address Table

Stores multiple addresses per customer.

**Key Fields**

- Customer No.
- Address Type (Billing / Shipping)
- Address
- City
- Country Code
- Phone No.

---

## 📄 Pages

### Customer List

- Displays all customers
- Supports filtering by credit limit, payment terms, and status
- Provides actions for navigation and reporting

### Customer Card

- Full customer details grouped by FastTabs
- Real-time validation during data entry
- Business rule actions (e.g., credit limit checks)

### Customer Statistics

- Displays customer financial and activity metrics
- Used for quick decision-making

---

## ⚙️ Business Logic (Codeunits)

### Customer Validation

Handles:

- Mandatory field checks
- Email and phone format validation
- Duplicate customer detection
- Save-time validation enforcement

### Customer Management

Handles:

- Credit limit enforcement
- Payment terms compliance
- Customer risk evaluation logic

---

## 📑 Reports

### Customer List Report

Provides a printable overview of:

- Customer details
- Contact information
- Payment terms

### Credit Limit Report

Used by finance teams to:

- Identify customers with high credit limits
- Assess financial exposure

---

## 🔍 Queries

### High Credit Limit Customers

Returns customers whose credit limit exceeds a defined threshold.

### Overdue Customers

Returns customers with outstanding overdue balances (when integrated with ledger entries).

---

## ✅ Validation Rules

- Customer Name is mandatory
- Customer Address is mandatory
- Contact details must be in a valid format
- Credit Limit must be greater than zero
- Duplicate customers are not allowed
- Required fields must be completed before saving
- Credit limit and payment term policies are enforced

---

## 🛠️ Technical Requirements

- Microsoft Dynamics 365 Business Central
- AL Language Extension
- Visual Studio Code

---

## 🚀 Installation

1. Clone or download the repository
2. Open the project in Visual Studio Code
3. Update `app.json` with your target BC version
4. Publish the extension to your Business Central environment

---

## 📈 Use Cases

- Customer master data governance
- Credit risk assessment
- Sales and finance reporting
- Data quality enforcement

---

## 📌 Future Enhancements

- Integration with standard Customer table
- Approval workflows for credit limit changes
- Role-based permissions
- Power BI integration
- Customer activity dashboards

---

## 👨‍💻 Author

Developed by a Microsoft Dynamics 365 Business Central Consultant.

---

## 📄 License

This project is provided for educational and demonstration purposes.
