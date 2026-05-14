# PeopleInsight SA — HR Salary & Performance Analysis

## Project Overview

Understanding how salary relates to performance, gender, and department is critical for any organisation looking to retain top talent and maintain fair compensation practices.

This project analyses simulated HR data for a South African company with **200 employees across 7 departments**, uncovering insights around **salary equity, performance-based pay, gender pay gaps, and flight risk employees** using **Excel, MySQL, and Power BI**.

---

## Business Questions Answered

- Which departments pay the most and least on average?
- Does salary increase with performance rating — and are there anomalies?
- Which high performers are significantly underpaid relative to their department average (flight risk)?
- Are there gender pay gaps across departments?
- Which departments have the most top performers?
- Who is the best performer by gender in each department?
- Are junior employees being promoted, or are they stagnating?

---

## Tools Used

| Tool | Purpose |
|------|---------|
| Excel | Data exploration, formatting, and pivot tables |
| MySQL | Data storage, querying, and advanced analysis |
| Power BI | Interactive dashboard and data visualisation |

---

## Dataset

Simulated South African HR dataset including:
- 200 employees across 7 departments
- Departments: Finance, Human Resources, IT, Legal, Marketing, Operations, Sales
- Provinces: Gauteng, KwaZulu-Natal, Western Cape, Eastern Cape, Limpopo, Mpumalanga, North West
- Fields: `employee_id`, `full_name`, `gender`, `province`, `department`, `job_level`, `years_at_company`, `salary`, `performance_rating`
- Salary ranges reflect realistic South African market rates per department and job level

---

## Excel Analysis

Before moving to SQL, the data was explored in Excel to establish baseline insights:

**Pivot Table 1 — Average Salary by Department**
Confirmed IT (R51,586) and Legal (R49,017) as the highest paying departments, with Operations (R29,720) and Sales (R29,796) at the bottom.

**Pivot Table 2 — Average Salary by Performance Rating**
Revealed an anomaly: employees rated 4 (R38,508) earn less on average than those rated 3 (R41,486) — a key business finding flagged for further investigation.

---

## SQL Analysis

Eight queries were written to extract deeper business insights:

**Query 1 — Average Salary by Department**
Ranked all 7 departments by average salary to identify compensation tiers.

**Query 2 — Average Salary by Performance Rating**
Confirmed the rating 3 vs rating 4 salary anomaly and revealed that rating 5 employees earn significantly more (R53,554).

**Query 3 — Flight Risk Employees (Window Function)**
Used `AVG() OVER(PARTITION BY department)` to compare individual salaries against department averages, identifying high performers earning well below their peers.

```sql
SELECT full_name, department, job_level,
       salary, performance_rating,
       ROUND(AVG(salary) OVER(PARTITION BY department), 0) AS dept_avg_salary,
       salary - ROUND(AVG(salary) OVER(PARTITION BY department), 0) AS salary_vs_dept_avg
FROM employees
WHERE performance_rating >= 4
ORDER BY salary_vs_dept_avg ASC
LIMIT 10;
```

**Query 4 — Gender Pay Analysis**
Broke down average salary by gender per department. Key finding: Marketing showed the largest gender pay gap (R29,250 female vs R49,208 male), while IT and HR showed women earning more than men.

**Query 5 — Department Performance Summary**
Combined headcount, average salary, average performance rating, and count of top performers (rating 5) per department in a single summary view.

**Query 6 — Top Earner per Department (Window Function)**
Used `ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC)` to identify the highest earning employee in each department. All top earners were Senior level.

**Query 7 — Years at Company by Job Level**
Revealed a surprising insight: Junior employees have been at the company the longest on average (8.3 years) compared to Seniors (7.3 years) — suggesting a promotion pipeline problem.

**Query 8 — Best Performer by Gender per Department**
Used `ROW_NUMBER() OVER(PARTITION BY department, gender ORDER BY performance_rating DESC, salary DESC)` to surface the top rated male and female employee in each department. Key finding: top-rated females in Legal and Marketing earn a fraction of their male counterparts.

---

## Power BI Dashboard

The dashboard presents four key visuals on a single page:

- **KPI Card** — Total employee headcount: 200
- **Bar Chart** — Average salary by department (IT leads, Operations lowest)
- **Column Chart** — Average salary by performance rating (shows the rating 4 anomaly visually)
- **Clustered Bar Chart** — Average salary by department and gender (gender pay gap clearly visible in Legal and Marketing)

![PeopleInsight Dashboard](PeopleInsight_SA_Dashboard.png)

---

## Key Insights

- **IT and Legal** are the highest paying departments — scarce skills and qualifications drive compensation
- **Rating 4 employees earn less than Rating 3** on average — a compensation anomaly that could drive turnover among strong performers
- **Marketing shows the largest gender pay gap** — female employees earn R19,958 less on average than male colleagues
- **IT and HR show reversed gender pay gap** — female employees earn more than male colleagues in these departments
- **Junior employees have the longest average tenure** (8.3 years) — suggesting a promotion pipeline issue that may be driving disengagement
- **Top-rated women in Legal earn as little as R31,000** compared to R98,000 for top-rated male colleagues — a critical equity concern

---

## Project Structure

```
PeopleInsight-SA/
│
├── PeopleInsight_SA_HR_Data.csv        # Raw dataset (200 employees)
├── peopleinsight_queries.sql           # All 8 analytical SQL queries
├── PeopleInsight_SA_Dashboard.png      # Power BI dashboard screenshot
├── PeopleInsight_SA_Dashboard.pbix     # Power BI file
└── README.md                           # Project documentation
```

---

## About

This project was built as part of a self-directed data analytics portfolio, demonstrating skills across the full analytics workflow — from data exploration and cleaning in Excel, to relational database querying in MySQL, to business intelligence dashboarding in Power BI.

**Author:** Chantelle Denyssche  
**Skills demonstrated:** MySQL · Excel · Power BI · Window Functions · Gender Pay Analysis · Business Insight Communication
