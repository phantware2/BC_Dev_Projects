# Employee Management System (Business Central AL)

## Overview

The **Employee Management System** is a Business Central AL mini-project designed to manage employee information, track performance evaluations, and generate useful insights through queries and reports. This project demonstrates how to design tables, pages, queries, and reports while applying proper validations and enhancements commonly required in real-life HR scenarios.

---

## Objectives

- Centralize employee personal and job-related information
- Track employee performance evaluations over time
- Enable efficient searching and reporting
- Apply data validation and business rules
- Introduce enhancements such as training, certifications, and hiring management

---

## Objects Used

- **Tables**
- **Pages**
- **Queries**
- **Reports**

---

## Tables

### 1. Employee Table

Stores core employee information.

**Fields:**

1. Employee ID (Primary Key)
2. First Name
3. Last Name
4. Address
5. Phone
6. Email
7. Start Date
8. End Date
9. Job Title
10. Department

---

### 2. Performance Evaluation Table

Stores employee performance reviews.

**Fields:**

1. Evaluation ID (Primary Key)
2. Employee ID (Secondary Key / Foreign Key)
3. Evaluation Date
4. Rating
5. Comments

---

## Pages

### Employee Pages

- **Employee List Page** – Displays all employees with filters and search
- **Employee Card Page** – Used to create and maintain employee records

### Performance Evaluation Pages

- **Performance Evaluation List Page** – Displays evaluations per employee
- **Performance Evaluation Card Page** – Used to record and review evaluations

---

## Queries

1. **Employee Search Query**
   - Search employees by department, job title, or name

2. **Performance Employee Search Query**
   - View employee performance history and ratings

---

## Reports

1. **Employee Directory Report**
   - Lists employees grouped by department and job title

2. **Performance Evaluation Summary Report**
   - Summarizes employee ratings and evaluation history

---

## Validation Rules

1. **Start and End Date Validation**
   - End Date must not be earlier than Start Date

2. **Mandatory Fields Enforcement**
   - Employee ID, First Name, Last Name, Job Title, and Department are required

3. **Duplicate Record Checks**
   - Prevent duplicate Employee ID and Email entries

4. **Automatic Calculations**
   - Calculate employment duration based on Start and End Dates

5. **Warning and Information Messages**
   - Display warnings for inactive employees or missing evaluations

---

## Enhancements

1. **Employee Training and Certifications**
   - Track completed trainings and professional certifications

2. **Recruitment and Hiring Management**
   - Create job postings
   - Track applicants and hiring status

---

## Key Takeaways

- Understand how to manage employee data in Business Central
- Learn how to track and evaluate employee performance
- Generate meaningful reports using AL objects
- Apply validations and business rules
- Extend the solution to cover training, certifications, and hiring processes

---

## Skill Level

- Beginner to Intermediate Business Central AL Development

---

## Suggested Next Steps

- Add role-based security
- Integrate payroll or attendance tracking
- Add Power BI reporting integration

---

**Author:** Jamiu Ismail
**Role:** Microsoft Dynamics 365 Business Central Consultant
