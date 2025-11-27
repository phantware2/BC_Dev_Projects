# Sales Order Approval Enhancement

## Overview

Enhance the Sales Order object with an “Approval Status” field. Add logic to block posting until approval is granted. Create a role-based page action for managers to approve or reject orders directly in Business Central.

**Skills covered:** Permissions, business rules, workflow simulation.

## Features

### 1. Approval Status Field

A new field, **"Approval Status"**, is added to the _Sales Header_ table to track the approval workflow of each sales order. The field includes the following option values:

- **Open**
- **Pending Approval**
- **Approved**
- **Rejected**

### 2. Posting Block Logic

Logic is embedded into the **Sales Order posting process** to prevent posting when a document has not been approved. Only sales orders with an **Approval Status = Approved** can be posted.

### 3. Manager Approval/Rejection Actions

Role-based page actions are added to the Sales Order page:

- **Approve Order**
- **Reject Order**

Only users with a **Manager role** (or appropriate permission set) can access these buttons.

On approval:

- Approval Status is set to **Approved**.

On rejection:

- Approval Status is set to **Rejected**.

---

## Technical Components

### ● AL Object Changes

- **Table Extension**: Adds `Approval Status` to Sales Header.
- **Page Extension**: Adds Approve/Reject actions to the Sales Order page.
- **Codeunit**: Implements approval handling logic.
- **Event Subscriptions**: Blocks posting until approval is granted.

---

## Setup Instructions

1. Deploy the extension to your Business Central environment.
2. Assign the custom **Manager Approval Permission Set** to designated users.
3. Ensure workflow steps are communicated to sales staff.

---

## Usage

1. Salesperson creates a sales order.
2. Salesperson sets **Approval Status = Pending Approval** (or the system sets this automatically).
3. Manager reviews the order and selects **Approve Order** or **Reject Order**.
4. If approved, the order can be posted normally.
5. If rejected, the salesperson must update the order before re-submitting.

---

## Notes

- Approval logic can be customized or expanded to include email notifications or automated approval workflows.
- This enhancement can coexist with the built-in Business Central approval workflows if needed.

---

## Version

**1.0.0** – Initial Release
