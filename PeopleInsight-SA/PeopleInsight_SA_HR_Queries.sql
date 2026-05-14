-- Queries 

USE peopleinsight_sa;

-- Query 1: Average salary by department

SELECT department, 
       ROUND(AVG(salary), 0) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

-- Query 2: Average salary by performance rating:

SELECT performance_rating,
       ROUND(AVG(salary), 0) AS avg_salary,
       COUNT(*) AS employee_count
FROM employees
GROUP BY performance_rating
ORDER BY performance_rating;

-- Query 3: High performers potentially underpaid (flight risk)

SELECT full_name, department, job_level,
       salary, performance_rating,
       ROUND(AVG(salary) OVER(PARTITION BY department), 0) AS dept_avg_salary,
       salary - ROUND(AVG(salary) OVER(PARTITION BY department), 0) AS salary_vs_dept_avg
FROM employees
WHERE performance_rating >= 4
ORDER BY salary_vs_dept_avg ASC
LIMIT 10;

-- Query 4: Average salary by gender and department

SELECT 
    department,
    gender,
    ROUND(AVG(salary), 0) AS avg_salary,
    COUNT(*) AS employee_count
FROM
    employees
GROUP BY department , gender
ORDER BY department , gender;

-- Query 5: Department performance summary

SELECT department,
       COUNT(*) AS headcount,
       ROUND(AVG(salary), 0) AS avg_salary,
       ROUND(AVG(performance_rating), 1) AS avg_performance,
       SUM(CASE WHEN performance_rating = 5 THEN 1 ELSE 0 END) AS top_performers
FROM employees
GROUP BY department
ORDER BY avg_performance DESC;

-- Query 6: Top earner per department

SELECT department, full_name, job_level, salary
FROM (
    SELECT department, full_name, job_level, salary,
           ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS salary_rank
    FROM employees
) AS ranked
WHERE salary_rank = 1
ORDER BY salary DESC;

-- Query 7: Average years at company by job level

SELECT job_level,
       COUNT(*) AS employee_count,
       ROUND(AVG(years_at_company), 1) AS avg_years,
       ROUND(AVG(salary), 0) AS avg_salary
FROM employees
GROUP BY job_level
ORDER BY FIELD(job_level, 'Junior', 'Mid', 'Senior');

-- Query 8: Best performer by gender per department

SELECT department, gender, full_name, 
       performance_rating, salary
FROM (
    SELECT department, gender, full_name,
           performance_rating, salary,
           ROW_NUMBER() OVER(
               PARTITION BY department, gender 
               ORDER BY performance_rating DESC, salary DESC
           ) AS perf_rank
    FROM employees
) AS ranked
WHERE perf_rank = 1
ORDER BY department, gender;