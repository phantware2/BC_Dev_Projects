# Birthday Reminder App

## Overview

A lightweight Business Central extension that introduces birthday management features for Customers and Employees. The app allows businesses to track birthdays, send automated greetings, and view upcoming birthdays directly from their Role Center.

**Skills covered:** Codeunits, job queues, cues, notifications.

## Features

### 1. Date of Birth on Customer & Employee Records

- Extends the Customer and Employee tables to include a Date of Birth (DOB) field.
- DOB becomes available on all relevant pages (Customer Card, Employee Card).
- Validation ensures correct date formatting and prevents future dates.

### 2. Automated Birthday Greeting Job

- A background Scheduled Job (Codeunit) runs daily.
- Automatically detects records with birthdays matching the current day.
- Sends birthday greetings using:
  - Business Central Notification System, or
  - Email (if configured in SMTP settings).
- Includes proper error handling and logging

### 3. Dashboard Cue for Upcoming Birthdays

- Adds a Role Center Cue that displays the count of:
  - Today’s birthdays
  - Birthdays in the next 7 days
- Cue links to a List Page showing upcoming birthdays

## Technical Components

### ● AL Object Changes

- **tableextension XXXXX CustomerEx**: Adds Date of Birth field to Customer.
- **tableextension XXXXX EmployeeExt**: Adds Date of Birth field to Employee.
- **pageextension XXXXX CustomerCardExt**: Displays DOB on the Customer Card.
- **pageextension XXXXX EmployeeCardExt**: Displays DOB on the Employee Card.
- **cuegroup/pageextension RoleCenterCueExt**: Adds “Upcoming Birthdays” cue.
- **page XXXXX UpcomingBirthdayList**: List of upcoming birthdays.
- **codeunit XXXXX BirthdayScheduler**: Scheduled job that identifies birthdays and sends greetings.

## Setup Instructions

1. Install the Extension
   Publish and install the app using:
   `
   AL: Publish
   Ctrl + F5

   `

2. Activate the Birthday Job

- Go to Job Queue Entries
- Create a new entry:
  - Object Type: Codeunit
  - Object ID: Birthday Reminder Job
  - Recurrence: Daily
- Set status to Ready

3. Optional Email Setup

- If using email greetings:
  - Open SMTP Mail Setup
  - Configure your mail account
