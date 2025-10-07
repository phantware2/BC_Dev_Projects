# Simple Expense Tracker

This AL project adds an **Expense** table to Microsoft Dynamics 365 Business Central for tracking office expenditures. It includes both **List** and **Card** pages for efficient data entry and management.

## Overview

Add an expense table to track office expenditures with list and card pages for easy data entry. Implement validation logic — for example, prevent saving an entry if the amount exceeds 10,000 without manager approval.

Skills covered: Data validation, field triggers, workflow basics.

## Features

- **Expense Table**: Store office expense records with fields such as date, description, amount, and approval status.
- **List & Card Pages**: Easily view, add, and edit expenses.
- **Validation Logic**: Prevent saving entries where the amount exceeds 10,000 unless manager approval is provided.
- **Workflow Basics**: Demonstrates use of field triggers and simple approval logic.

## Skills Demonstrated

- Data validation using AL field triggers
- Implementing business rules in AL
- Creating List and Card pages
- Basic workflow and approval logic

## Example Validation

- If an expense amount is **greater than 10,000** and **manager approval** is not set, the record cannot be saved.

## Project Structure

- `Expense.Table.al` – Defines the Expense table and validation logic.
- `ExpenseList.Page.al` – List page for viewing all expenses.
- `ExpenseCard.Page.al` – Card page for detailed entry and editing.

## Technologies

- AL Language (Business Central)
- Visual Studio Code

## Contributing

1. Fork the repository
2. Create a new branch
3. Submit a pull request

## License

This project is licensed under the MIT License.
