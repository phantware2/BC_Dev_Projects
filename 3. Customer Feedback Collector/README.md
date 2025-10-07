# Customer Feedback Collector (AL Business Central)

This project extends Microsoft Dynamics 365 Business Central to help sales teams efficiently capture and follow up on customer feedback.

## Overview

Extend the Customer table by adding a “Feedback” field. Create a page action for salespeople to capture customer feedback and develop a report listing all customers who’ve provided feedback for follow-up.

## Features

- **Customer Table Extension:**  
  Adds a new `Feedback` field to the Customer table.

- **Feedback Capture:**  
  Introduces a page action on the Customer Card for salespeople to enter and update customer feedback.

- **Feedback Report:**  
  Provides a report listing all customers who have provided feedback, enabling easy follow-up.

## Installation

1. Clone or download this repository.
2. Open the project in Visual Studio Code with the AL Language extension.
3. Update `app.json` as needed for your environment.
4. Publish the extension to your Business Central sandbox or production environment.

## Usage

- Navigate to the Customer Card page.
- Use the new **Capture Feedback** action to enter feedback for a customer.
- Run the **Customer Feedback Report** to view all customers with feedback.

## Technologies

- AL Language (Business Central)
- Visual Studio Code

## Contributing

1. Fork the repository
2. Create a new branch
3. Submit a pull request

## License

This project is licensed under the MIT License.
