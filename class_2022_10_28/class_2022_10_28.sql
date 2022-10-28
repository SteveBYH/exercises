## Exercise 1

### 1. The total costs in payroll for this company

SELECT sum(salary) AS total_payroll FROM employees;

### 2. The average salary within each department
 
SELECT dept, round(avg(salary),2) AS avg_salary FROM employees GROUP BY dept;


## Exercise 2

SELECT dept, round(avg(salary),2) AS avg_salary FROM employees GROUP BY dept;

SELECT *, salary - avg_salary AS salary_diff FROM employees 
NATURAL JOIN (
  SELECT dept, round(avg(salary),2) AS avg_salary FROM employees GROUP BY dept
);


## Exercise 3

SELECT count(*), sum(seats) FROM flights NATURAL JOIN planes;

SELECT count(*), sum(seats) FROM flights JOIN planes USING (tailnum);

SELECT count(*), sum(seats) FROM (SELECT tailnum FROM flights) 
  JOIN (SELECT tailnum, seats FROM planes) USING (tailnum);

EXPLAIN QUERY PLAN SELECT count(*), sum(seats) FROM planes JOIN flights USING (tailnum);


