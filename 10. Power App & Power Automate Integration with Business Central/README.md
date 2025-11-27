# Power App & Power Automate Integration with Business Central

This solution extends Microsoft Dynamics 365 Business Central by introducing a **Customer Support Tickets** system. It allows organizations to track customer issues efficiently and integrates with **Power Apps** and **Power Automate** to provide mobile access and automated notifications.

## Overview

Create a custom table, such as Customer Support Tickets, with fields like Customer No., Issue Description, and Status. Develop a Power App that connects to Business Central so users can create or update tickets on the go. Build a Power Automate flow to send email notifications when the ticket’s status changes.

**Skills covered:** Business Central APIs, Power Platform connectors, external automation.

## Features

### Business Central AL

- **Custom Table**: `Customer Support Tickets`
  - Fields:
    - **Customer No.** – Links the ticket to a customer.
    - **Issue Description** – Text describing the customer issue.
    - **Status** – Current state of the ticket (e.g., Open, In Progress, Resolved, Closed).
- **Pages**:
  - **List Page** – View all tickets.
  - **Card Page** – Create, edit, and review individual tickets.
- **Validation & Logic**:
  - Status updates are logged.
  - Optional reminders for unresolved tickets.

### Power Apps Integration

- **Mobile Access**: Users can create or update tickets from their mobile devices.
- **Real-time Sync**: Changes made in the app are reflected in Business Central immediately.
- **Custom Views**: Filter and sort tickets by status, customer, or date.

### Power Automate Integration

- **Email Notifications**:
  - Triggered when a ticket’s **Status** changes.
  - Sends emails to responsible users or customer support teams.
- **Automated Workflows**:
  - Optionally escalate tickets that remain unresolved for a set period.
  - Log updates or comments automatically.

---

## Setup Instructions

### 1. Deploy AL Solution

1. Import the AL project into **Visual Studio Code**.
2. Publish the extension to your Business Central environment.
3. Verify that the `Customer Support Tickets` table and pages appear in the system.

### 2. Power Apps Setup

1. Open **Power Apps** and create a new app.
2. Connect to your Business Central environment.
3. Add the `Customer Support Tickets` table as a data source.
4. Design screens for:
   - Ticket creation
   - Ticket updates
   - Ticket lists

### 3. Power Automate Setup

1. Open **Power Automate** and create a new flow.
2. Trigger: **When a Business Central record is updated**.
3. Condition: Check if the **Status** field has changed.
4. Action: Send an **Email Notification** to the relevant recipients.
5. Test the flow by updating a ticket in Business Central or Power Apps.

---

## Usage

1. Create a ticket in Business Central or via the Power App.
2. Update the ticket’s status as progress is made.
3. Receive email notifications whenever the status changes.
4. Track and manage tickets using the Business Central list or mobile Power App interface.

---

## Requirements

- Microsoft Dynamics 365 Business Central
- Power Apps license
- Power Automate license
- User permissions to create/edit tickets and access Power Automate

---

## Notes

- Ensure proper user permissions are set for both Business Central and Power Apps.
- Consider adding additional fields, such as Priority or Assigned To, based on business needs.
- Workflows can be enhanced to include Teams notifications or other channels.

---

## Authors

- **Jamiu Ismail** – Solution design and development

---

## License

This project is licensed under MIT License. See LICENSE file for details.
