# Customer Credit Limit Extension for Business Central

This extension enhances the **Customer** table in Microsoft Dynamics 365 Business Central by adding a **Credit Limit** field. It provides functionality to monitor customer credit usage during sales transactions and ensures proactive management of customer credit risk.

## Overview

Extend the Customer table to include a credit limit. Add logic in sales documents to display warnings when customers exceed their limits and log these events for future analysis.

**Skills covered:** Event subscribers, page notifications, logging.

### Key Features

- **Credit Limit Field**: Added to the Customer table to define maximum allowable credit for each customer.
- **Sales Document Warnings**: Sales orders and invoices display warnings when the customer exceeds their credit limit.
- **Event Logging**: Attempts to exceed credit limits are logged for reporting and future analysis.

## Tables and Fields

- **Customer Table (`Customer`)**

  - `Credit Limit` (Decimal) – Maximum allowable credit for the customer.

- **Credit Limit Log Table (`Credit Limit Log`)**
  - `Customer No.` – Reference to the Customer.
  - `Document No.` – Sales document triggering the limit warning.
  - `Date/Time` – Timestamp of the event.
  - `Current Balance` – Customer balance at the time of the event.
  - `Credit Limit` – Customer’s set credit limit.
  - `Warning Message` – Details of the exceeded limit.

## Pages

- **Customer Card**

  - Displays the new **Credit Limit** field for editing and review.

- **Sales Order / Invoice**

  - Warning message appears if the customer exceeds their credit limit when creating or posting a document.

- **Credit Limit Log List**
  - Allows users to review historical credit limit events for analysis.

## Codeunit Logic

- Validates customer balance against the credit limit on sales documents.
- Triggers a warning message when the credit limit is exceeded.
- Writes entries to the **Credit Limit Log** for monitoring.

## Reports

- **Credit Limit Exceeded Report**
  - Summarizes all instances where customers exceeded their credit limits.
  - Supports management review and risk assessment.

## Installation

1. Deploy the AL extension via Visual Studio Code.
2. Synchronize the database schema to include the new field and log table.
3. Update Customer Cards with the **Credit Limit** field as required.
4. Test sales transactions to ensure warnings and logging work as expected.

## Usage

1. Set a **Credit Limit** on each customer as needed.
2. Process sales orders or invoices.
3. Observe warning messages if the credit limit is exceeded.
4. Review the **Credit Limit Log** or run the **Credit Limit Exceeded Report** for historical analysis.

## Benefits

- Helps prevent overselling to customers beyond their credit capacity.
- Provides management with actionable insights on customer credit usage.
- Enhances financial control and reduces risk exposure.
