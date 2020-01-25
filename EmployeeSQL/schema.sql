-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- #### Data Modeling
-- Inspect the CSVs and sketch out an ERD of the tables. Feel free to use a tool like [http://www.quickdatabasediagrams.com](http://www.quickdatabasediagrams.com).
-- employees
-- -
-- emp_no INTEGER PK
-- birth_date DATE
-- first_name VARCHAR
-- last_name VARCHAR
-- gender VARCHAR
-- hire_date DATE

-- departments
-- -
-- dept_no VARCHAR PK
-- dept_name VARCHAR

-- dept_emp
-- -
-- emp_no INTEGER PK FK >- employees.emp_no
-- dept_no VARCHAR PK FK >- departments.dept_no
-- from_date DATE
-- to_date DATE

-- dept_manager
-- -
-- dept_no VARCHAR PK FK >- departments.dept_no
-- emp_no INTEGER PK FK >- employees.emp_no
-- from_date DATE
-- to_date DATE


-- titles
-- -
-- #added column as PK
-- #title/emp_no does not work.
-- promo_no INTEGER PK
-- emp_no INTEGER FK >- employees.emp_no
-- title VARCHAR
-- from_date DATE
-- to_date DATE

-- salaries
-- -
-- #emp_no has a one to one relationship
-- emp_no INTEGER PK FK - employees.emp_no
-- salary INTEGER
-- from_date DATE
-- to_date DATE


-- #### Data Engineering
-- * Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.

--Drop Existing Tables
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

--Create Tables
CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "titles" (
     -- title/emp_no cannot be primary keys - there are duplicates.
     -- create primary key "promo_no" after loading CSV
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
	);

CREATE TABLE "salaries" (
    -- emp_no has a one to one relationship
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

--alter table with constraints/foreign keys
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- Import each CSV file into the corresponding SQL table.
COPY employees
FROM'C:\Users\heain\Desktop\Homework\sql-challenge\EmployeeSQL\data\employees.csv'
CSV HEADER;

COPY departments
FROM'C:\Users\heain\Desktop\Homework\sql-challenge\EmployeeSQL\data\departments.csv'
CSV HEADER;

COPY dept_emp
FROM'C:\Users\heain\Desktop\Homework\sql-challenge\EmployeeSQL\data\dept_emp.csv'
CSV HEADER;

COPY dept_manager
FROM'C:\Users\heain\Desktop\Homework\sql-challenge\EmployeeSQL\data\dept_manager.csv'
CSV HEADER;

COPY titles
FROM'C:\Users\heain\Desktop\Homework\sql-challenge\EmployeeSQL\data\titles.csv'
CSV HEADER;

COPY salaries
FROM'C:\Users\heain\Desktop\Homework\sql-challenge\EmployeeSQL\data\salaries.csv'
CSV HEADER;

--add primary key to "titles"
ALTER TABLE titles
ADD COLUMN promo_no SERIAL PRIMARY KEY;