# Product Warranty Management

## Overview

Design a Warranty table linked to Items to track product warranties. Build pages for registering warranties when items are sold and add logic to monitor warranty expiry dates and send notifications.

- A **Warranty table** linked to Items (via Item No.).
- Pages to **register warranties** automatically or manually when items are sold.
- Logic to **monitor warranty expiry dates**.
- **Notifications** sent to relevant users when warranties are close to expiring.

**Skills covered:** Relationships, date calculations, notifications.

## Features

### 1. Warranty Table

A custom table designed to store warranty details such as:

- Warranty No.
- Item No.
- Serial/Lot No. (optional)
- Customer No.
- Sales Document No.
- Purchase/Sales Date
- Warranty Period (Months)
- Warranty Expiry Date
- Status (Active / Expired)

### 2. Warranty Registration

Warranties can be registered in two ways:

- **Automatically** during posting of Sales Orders/Invoices.
- **Manually** using a Warranty Registration Page.

The logic calculates the _Warranty Expiry Date_ based on the Warranty Period set on the Item Card.

## Pages Included

### Warranty List Page

Allows users to view all registered warranties with filters for:

- Active
- Expiring soon
- Expired

### Warranty Card Page

Used for viewing and editing a single warranty record.

### Warranty Setup Page

Configuration options such as:

- Default Warranty Period
- Notification Period (Days before expiry)

---

## Notification Logic

A scheduled Job Queue codeunit is included to:

- Check warranties nearing expiry.
- Send notifications to responsible users via:

  - Business Central notifications
  - Email (optional)

Notification triggers when:

```
Today >= (Warranty Expiry Date - Notification Period)
```

---

## AL Components Summary

### Tables

- **Warranty** (Custom)
- **Warranty Setup** (Custom)

### Pages

- Warranty List
- Warranty Card
- Warranty Setup

### Codeunits

- Warranty Registration Logic
- Warranty Expiry Monitor (Job Queue)
- Notification Manager

---

## Installation & Setup

1. Publish and install the extension.
2. Open **Warranty Setup** and configure:

   - Default Warranty Period
   - Notification Period
   - Notification Recipients

3. Enable the Job Queue entry for automatic expiry monitoring.

---

## How Warranty is Linked to Items

- Each Item Card includes a new field: **Warranty Period (Months)**.
- When selling an item, the system reads this field to generate the warranty.

---

## Example Workflow

1. User posts a Sales Invoice for an item with a warranty.
2. System creates a **Warranty** record with:

   - Customer No.
   - Item No.
   - Sales Doc No.
   - Warranty Start & End date.

3. Job Queue checks expiry schedule.
4. Notification sent before expiry.

---

## Future Enhancements

- Warranty Claim Management
- Integration with Service Orders
- Warranty PDF Certificates

---

## Version

**v1.0.0** — Initial Release
