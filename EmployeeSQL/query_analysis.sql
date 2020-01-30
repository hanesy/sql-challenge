-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
DROP VIEW IF EXISTS emp_sal;

CREATE VIEW emp_sal AS
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees 
LEFT JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY employees.emp_no;

SELECT * FROM emp_sal;

-- 2. List employees who were hired in 1986.
DROP VIEW IF EXISTS emp_1986;

CREATE VIEW emp_1986 AS
SELECT *
FROM employees 
--selection of dates is inclusive--
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY employees.emp_no;

SELECT * FROM emp_1986;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
DROP VIEW IF EXISTS dept_man_info;

CREATE VIEW dept_man_info AS
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, 
employees.last_name, employees.first_name, 
dept_manager.from_date AS "start_date_asmanager", dept_manager.to_date AS "end_date_asmanager"
FROM dept_manager 
LEFT JOIN departments ON dept_manager.dept_no = departments.dept_no
LEFT JOIN employees ON dept_manager.emp_no = employees.emp_no
ORDER BY dept_manager.dept_no;

SELECT * FROM dept_man_info;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
DROP VIEW IF EXISTS emp_dept_info;

CREATE VIEW emp_dept_info AS
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp 
LEFT JOIN employees ON dept_emp.emp_no = employees.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no
ORDER BY dept_emp.emp_no;

SELECT * FROM emp_dept_info;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
DROP VIEW IF EXISTS emp_herc_b;

CREATE VIEW emp_herc_b AS
SELECT *
FROM employees 
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%'
ORDER BY emp_no;

SELECT * FROM emp_herc_b;

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
DROP VIEW IF EXISTS emp_sales_info;

CREATE VIEW emp_sales_info AS
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp 
LEFT JOIN employees ON dept_emp.emp_no = employees.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales'
ORDER BY dept_emp.emp_no;

SELECT * FROM emp_sales_info;

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
DROP VIEW IF EXISTS emp_salesdev_info;

CREATE VIEW emp_salesdev_info AS
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp 
LEFT JOIN employees ON dept_emp.emp_no = employees.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales'
OR dept_name = 'Development'
ORDER BY dept_emp.emp_no;

SELECT * FROM emp_salesdev_info;

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
DROP VIEW IF EXISTS lastname_count;

CREATE VIEW lastname_count AS
SELECT last_name, COUNT (emp_no) AS "count"
FROM employees 
GROUP BY last_name
ORDER BY count DESC;

SELECT * FROM lastname_count;