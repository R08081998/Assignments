use for_me



create table emp_details
(
id bigint,
first_name varchar(100),
last_name varchar(100),
full_name varchar(100),
dept_name varchar(100),
dept_id bigint,
email varchar(300),
salary decimal(10,2),
mobile_no varchar(300),
add_ress varchar(400),
location varchar(300),
hire_date DATETIME
);

create table employee_data
(
id bigint,
first_name varchar(100),
last_name varchar(100),
full_name varchar(100),
dept_name varchar(100),
dept_id bigint,
email varchar(300),
salary decimal(10,2),
mobile_no varchar(300),
add_ress varchar(400),
location varchar(300),
hire_date DATETIME,
dob date
);

--1. Basic Queries:
--Retrieve all records from the table.

select * from emp_details

--01..0Fetch only id, first_name, and last_name columns.

SELECT id,first_name,last_name FROM emp_details

--02...Find all employees who work in the "HR" department.

SELECT * FROM emp_details WHERE dept_name = 'HR'

--03...Retrieve the full name and email of all employees.

SELECT full_name,email FROM emp_details

--04...Get the first 10 records from the table.
SELECT TOP 10 * FROM emp_details

--05...Retrieve all employees with a salary greater than 50,000.
SELECT * FROM emp_details WHERE salary > 50000

--06...List the employees whose first name starts with 'J'.

SELECT * FROM emp_details WHERE first_name LIKE 'J%'

--07...Fetch the employees who live in "New York".

SELECT * FROM emp_details WHERE location = 'New Mark'

--08...Find all employees with the last name "Smith".

SELECT * FROM emp_details WHERE  last_name = 'Smith'

--09...Retrieve all employees from the "HR" department with salaries between 40,000 and 80,000.

SELECT * FROM emp_details WHERE (dept_name ='HR') AND (salary BETWEEN 40000 AND 80000);

--10...Retrieve employees whose last name starts with the letter 'S'.

SELECT * FROM emp_details WHERE last_name LIKE '%S'

--11...Retrieve employees who have a specific mobile number (e.g., 5240261725).

SELECT * FROM emp_details WHERE mobile_no = '5240261725'

--12...Retrieve all distinct department names.

SELECT DISTINCT(dept_name) FROM emp_details

--13...Retrieve all distinct locations.

SELECT DISTINCT(location) FROM emp_details

--14...Count the total number of employees.

SELECT COUNT(*) AS ALL_COUNT FROM emp_details

--15...Retrieve the maximum salary.
SELECT MAX(salary) AS MAX_SALARY FROM emp_details

--16...Retrieve the minimum salary.

SELECT MIN(salary) AS MAX_SALARY FROM emp_details

--17...Retrieve the average salary of employees.

SELECT AVG(salary) AS MAX_SALARY FROM emp_details

--18...Retrieve the total salary paid to employees in the Marketing department.

SELECT * FROM emp_details WHERE dept_name= 'Marketing'

--19...Retrieve employees who do not have an email address.

SELECT * FROM emp_details WHERE email IS NULL

--20...Retrieve employees whose full name contains the letter 'a'.

SELECT * FROM emp_details WHERE full_name LIKE '%A%'

--21...Retrieve employees whose department is IT and salary is greater than 60,000.

SELECT * FROM emp_details WHERE dept_name = 'IT' AND salary > 60000

--22...Retrieve employees whose mobile number starts with +1.

SELECT * FROM emp_details WHERE mobile_no LIKE '+1%'

------------------------------------------------------------------------------------------------------------------------------------------------------
--2. Sorting & Filtering:

--23...List all employees sorted by salary in descending order.

SELECT * FROM emp_details ORDER BY salary ASC

--24...Find employees who have a salary greater than 75,000, sorted by last_name.

SELECT * FROM emp_details WHERE salary > 75000 ORDER BY last_name DESC

--25...Retrieve records ordered by location and full_name.

SELECT * FROM emp_details ORDER BY location DESC , full_name DESC

--26...Get the top 5 highest salaries in the "Sales" department.

SELECT TOP 5 * FROM emp_details WHERE dept_name = 'Sales' ORDER BY salary DESC

--27...Find the lowest 10 salaries.

SELECT TOP 10 * FROM emp_details ORDER BY salary ASC

--28...Retrieve all employees sorted by their location, then by salary.

SELECT * FROM emp_details ORDER BY location ASC , salary DESC

--29...Fetch employees who have a salary less than 40,000 or greater than 90,000.

SELECT * FROM emp_details WHERE salary <=40000 OR salary > 90000

--30...List employees in "Marketing" sorted by last_name alphabetically.

SELECT * FROM emp_details WHERE dept_name = 'Marketing' ORDER BY last_name ASC 

--31...Show employees who live in "Chadmouth" and earn more than 60,000.

SELECT * FROM emp_details WHERE location = 'Chadmouth' AND salary > 60000

--Subqueries
--32...Find employees who earn more than the average salary of all employees.

SELECT * FROM emp_details WHERE salary >
(
SELECT AVG(salary) AS AVG_SAL FROM emp_details
)

--33...Retrieve employees whose salary is greater than the average salary of employees in the "Sales" department.

SELECT * FROM emp_details WHERE salary >
(
SELECT AVG(salary) AS AVG_SAL FROM emp_details WHERE dept_name = 'Sales'
)

--34...Find employees who have the highest salary in their department (using a subquery).

SELECT * FROM emp_details AS A WHERE 2 = 
(
SELECT COUNT(DISTINCT salary) FROM emp_details AS B WHERE A.salary <= B.salary
);

WITH CTE AS
(
SELECT * ,
DENSE_RANK() OVER(ORDER BY salary DESC) AS RANK_SAL
FROM emp_details
)
SELECT * FROM CTE WHERE RANK_SAL = 2;

----LOWEST

SELECT * FROM emp_details AS A WHERE 2 = 
(
SELECT COUNT(DISTINCT salary) FROM emp_details AS B WHERE A.salary >= B.salary
);

WITH CTE AS
(
SELECT * ,
DENSE_RANK() OVER(ORDER BY salary ASC) AS RANK_SAL
FROM emp_details
)
SELECT * FROM CTE WHERE RANK_SAL = 2;

--35...List employees whose salary is higher than the average salary of their department.

SELECT * FROM emp_details AS A WHERE salary >
(
SELECT AVG(salary) FROM emp_details AS B WHERE 
A.dept_name = B.dept_name
)

--36...Retrieve the name of employees who have a higher salary than the employee with the lowest salary in the company.

SELECT * FROM emp_details WHERE 
salary >
(
SELECT MIN(salary) FROM emp_details
)

--37...Find all employees who earn more than the highest-paid employee in the "Marketing" department.

SELECT * FROM emp_details WHERE salary >
(
SELECT MAX(salary) AS MAX_SALARY FROM emp_details AS B
WHERE B.dept_name = 'Marketing'
)

--38...Find employees who have the same salary as the average salary in the "HR" department.

SELECT * FROM emp_details WHERE salary =
(
SELECT AVG(salary) AS MAX_SALARY FROM emp_details AS B
WHERE B.dept_name = 'HR'
)

--39...Retrieve employees whose location is the same as the employee with the highest salary.

SELECT * FROM emp_details WHERE location =
(
SELECT location FROM emp_details AS B
WHERE B.salary = (SELECT MAX(salary) FROM emp_details)
)

--40...Find employees who earn more than the average salary in their location.


SELECT * FROM emp_details AS A WHERE salary >
(
SELECT AVG(salary) FROM emp_details AS B
WHERE A.location = B.location
);

--41...List employees who earn more than the minimum salary of the "Finance" department.


SELECT * FROM emp_details WHERE salary >
(
SELECT MIN(salary) FROM emp_details AS B
WHERE B.dept_name = 'Finance'
)

--42...Retrieve employees who work in the same department as employee id = 100.

SELECT * FROM emp_details WHERE dept_name = 
(
SELECT dept_name FROM emp_details AS B WHERE
B.ID = 100
)

--43...Retrieve employees who earn more than the employee with id = 200.

SELECT * FROM emp_details WHERE salary >
(
SELECT salary  FROM emp_details
WHERE ID = 200
)

--44...Find the department with the highest number of employees.

SELECT dept_name,COUNT(*) AS DEPT_WISE_COUNT FROM emp_details GROUP BY dept_name 

UNION ALL

SELECT 'TOTAL',SUM(DEPT_WISE_COUNT) FROM
(SELECT dept_name, COUNT(*) AS DEPT_WISE_COUNT FROM emp_details GROUP BY dept_name 
) AS A;

--45...Find the employee with the highest salary in the Sales department.

SELECT TOP 1 * FROM emp_details AS A WHERE A.salary = 
(SELECT MAX(B.salary) FROM emp_details AS B
WHERE B.dept_name = 'Sales'
)

--46...Find employees who work in a department with more than 50 employees.

SELECT * 
FROM emp_details 
WHERE dept_name IN (
    SELECT dept_name 
    FROM emp_details 
    GROUP BY dept_name 
    HAVING COUNT(*) > 50
);

--47...Find employees whose salary is above the average salary of the employees in the same department.

SELECT * FROM emp_details AS A WHERE A.salary >
(
SELECT AVG(B.salary) FROM emp_details AS B
WHERE A.dept_name = B.dept_name
)

--48...Retrieve employees whose department has an average salary above 60,000.

SELECT * FROM emp_details AS A WHERE A.dept_name IN
(
SELECT B.dept_name FROM emp_details AS B GROUP BY B.dept_name
HAVING AVG(B.salary) > 60000)

SELECT * 
FROM emp_details 
WHERE dept_name IN (
    SELECT dept_name 
    FROM emp_details 
    GROUP BY dept_name 
    HAVING AVG(salary) > 60000
);

--49...Retrieve employees whose mobile number matches the number of the employee with id = 1.

SELECT * FROM emp_details AS A WHERE A.mobile_no = 
(
SELECT B.mobile_no FROM emp_details AS B
WHERE B.id = 1
)

--50...Retrieve employees whose address matches any of the addresses in a specific city.

SELECT * 
FROM emp_details 
WHERE add_ress IN (
    SELECT add_ress 
    FROM emp_details 
    WHERE location = 'Caitlinstad'
);

--7. String Functions:
--51...Find employees whose last_name ends with 'son'.

SELECT * FROM emp_details WHERE last_name LIKE '%SON'

--52...Get the full_name for employees where first_name starts with 'M' and last_name ends with 's'.

SELECT * FROM emp_details WHERE first_name LIKE 'M%' AND last_name LIKE '%S'

--53...Display only the first 3 characters of first_name for all employees.

SELECT SUBSTRING(first_name,1,3) AS FIRST_NMAE FROM emp_details

--54...Find employees whose email address contains the word "gmail".

SELECT * FROM emp_details WHERE email LIKE '%gmail%'

--55...Retrieve employees with email addresses from a specific domain, such as "company.com".

SELECT * 
FROM emp_details 
WHERE email LIKE '%company.com';

--56...Concatenate first_name and last_name to show full names.

SELECT CONCAT(first_name,'  ',last_name) AS FULL_NMAE FROM emp_details

--57...Display the first_name and last_name in reverse order.

SELECT first_name,last_name FROM emp_details ORDER BY first_name DESC,last_name DESC

--58...Replace the letter 'a' in the address with the letter 'A'.

SELECT add_ress, REPLACE(add_ress,'G','Z') FROM emp_details

--59...Find employees whose location contains the word "New".

SELECT * FROM emp_details WHERE location LIKE '%NEW%'

--60...Retrieve the length of each employee's name using the LEN function.

SELECT full_name, LEN(full_name) AS TOTAL_LENGTH FROM emp_details

--61...Extract the first three characters from employee names using SUBSTRING.

SELECT first_name, SUBSTRING(first_name,1,3) AS FIRST_THREE_CHAR FROM emp_details

--62...Find the position of the first occurrence of '@' in email addresses using CHARINDEX.

SELECT email, CHARINDEX('@',email) AS PositionOfAt FROM emp_details

--63...Convert all employee names to uppercase using the UPPER function.

SELECT UPPER(first_name) AS FIRST_NAME,UPPER(last_name) AS LAST_NAME,UPPER(full_name) AS full_name FROM emp_details

--64...Convert all employee names to lowercase using the LOWER function.

SELECT LOWER(first_name) AS FIRST_NAME,LOWER(last_name) AS LAST_NAME,LOWER(full_name) AS full_name FROM emp_details

--65...Replace all occurrences of "Street" with "St." in the address using REPLACE.

SELECT add_ress,REPLACE(add_ress,'Street','St') AS REPLACE_ST FROM emp_details

--66...Remove leading spaces from employee addresses using LTRIM.

SELECT first_name, LTRIM(first_name) AS F_NAME FROM emp_details

--67...Remove trailing spaces from employee addresses using RTRIM.

SELECT first_name, RTRIM(first_name) AS F_NAME FROM emp_details

--68...Combine first and last names into a full name using CONCAT.

SELECT CONCAT(first_name,' ', last_name) AS FULL_NAME FROM emp_details

SELECT CONCAT(
UPPER(LEFT(first_name,1))+ LOWER(SUBSTRING(first_name,2,LEN(first_name)-1 )),' ',
UPPER(LEFT(last_name,1))+ LOWER(SUBSTRING(last_name,2,LEN(last_name)-1 ))
) AS FULL_NAME FROM emp_details

--69...Check if the string "Manager" appears in the job title using PATINDEX.

SELECT email, PATINDEX('%@%', email) AS PositionOfAt
FROM emp_details;

--70...Extract the domain part of email addresses (after '@') using SUBSTRING and CHARINDEX.

SELECT EMAIL, SUBSTRING(EMAIL,CHARINDEX('@',EMAIL)+1,LEN(EMAIL)) AS HH FROM emp_details

--71...Pad employee IDs with zeros on the left to make them 5 characters long using FORMAT.

SELECT FORMAT(ID,'00000') AS FULL_ID FROM emp_details

--72...Replace all spaces in employee names with underscores using REPLACE.

SELECT REPLACE(full_name,' ','_') AS ADD_FG FROM emp_details

--73...Extract the last three characters from employee phone numbers using RIGHT.

SELECT first_name, SUBSTRING(first_name, LEN(first_name)-2,3) AS FIRST_THREE_CHAR FROM emp_details  --LAST THREE CHAR

--74...Reverse employee names using REVERSE.

SELECT first_name, REVERSE(first_name) FROM emp_details

--75...Check if the email column contains a valid domain using LIKE '%@%.%'.

SELECT email FROM emp_details WHERE email LIKE '%@%.%' 

--76...Count the number of occurrences of the letter 'a' in employee names using LEN and REPLACE.

SELECT 
    first_name, 
    LEN(first_name) - LEN(REPLACE(first_name, 'a', '')) AS Occurrences_Of_A
FROM emp_details;

--77...Concatenate the department name with employee name, separated by a hyphen.

SELECT CONCAT( dept_name,'-',
full_name
) FROM emp_details

--78...Extract all text before the first space in employee names using CHARINDEX and LEFT.

SELECT 
    full_name, 
    LEFT(full_name, CHARINDEX(' ', full_name) - 1) AS First_Name,
	    RIGHT(full_name,LEN(full_name)- CHARINDEX(' ', full_name) ) AS First_Name

FROM emp_details

--79...Remove all non-numeric characters from phone numbers.
SELECT 
    mobile_no, 
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(mobile_no, '-', ''), '(', ''), ')', ''), ' ', ''), '.', '') AS Cleaned_Phone_Number
FROM emp_details;

--80...Find employees whose addresses contain the word "Street" using LIKE.
SELECT * FROM emp_details WHERE add_ress LIKE '%Street%'

--81...Extract the username part of email addresses (before '@').

SELECT EMAIL, LEFT(EMAIL,CHARINDEX('@',EMAIL)-1) AS NEW_C FROM emp_details

--82...Find the length of the longest name in the table using LEN and MAX.

SELECT first_name, MAX(LEN(first_name)) AS FULL_LENGTH FROM emp_details GROUP BY first_name ORDER BY FULL_LENGTH DESC

--83...Convert the first letter of each word in names to uppercase using a combination of string functions.

SELECT 
    first_name,
    UPPER(SUBSTRING(first_name, 1, 1)) + LOWER(SUBSTRING(first_name, 2, LEN(first_name) - 1)) AS Capitalized_First_Name
FROM emp_details;

--84...Remove vowels from employee names.
SELECT 
    first_name,
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(first_name, 'a', ''), 'A', ''), 
                'e', ''), 'E', ''), 
                'i', ''), 'I', ''), 
                'o', ''), 'O', ''), 
                'u', ''), 'U', '') AS Name_Without_Vowels
FROM emp_details; ---- CODE IS INCOMPLETE

--85...Append " (Manager)" to the job titles of employees who are managers using CONCAT.

SELECT 
    id,
    first_name,
    last_name,
    dept_name,
    CONCAT(dept_name, '--(_it)') AS Updated_Job_Title
FROM 
    emp_details

--86...Check if any names contain special characters using PATINDEX.

SELECT 
    first_name,
    PATINDEX('%[^a-zA-Z ]%', first_name) AS Special_Char_Position
FROM 
    emp_details

--87...Trim all leading and trailing spaces from the address column.

select add_ress,LTRIM(RTRIM(add_ress)) AS TERMINAL_ADD from emp_details

--88...Replace the middle part of phone numbers with "XXXX" for privacy.
SELECT 
    mobile_no AS Original_Mobile_No,
    STUFF(mobile_no, 4, 4, 'XXXX') AS Masked_Mobile_No
FROM 
    emp_details;

--89...Extract the first name from the full name (assuming names are separated by a space).

SELECT 
    full_name,
    CONCAT(UPPER(LEFT(full_name, 1)), LOWER(SUBSTRING(full_name, 2, CHARINDEX(' ', full_name + ' ') - 2))) AS Formatted_First_Name
FROM 
    emp_details;

SELECT 
    full_name,
    LEFT(full_name, CHARINDEX(' ', full_name + ' ') - 1) AS First_Name
FROM 
    emp_details;


--90...Extract the last name from the full name (assuming names are separated by a space).

SELECT 
    full_name,
    LTRIM(SUBSTRING(full_name, CHARINDEX(' ', full_name + ' ') + 1, LEN(full_name))) AS Last_Name
FROM 
    emp_details;

SELECT 
full_name,
RIGHT(full_name,LEN(full_name)-CHARINDEX(' ',full_name+' ')) AS LAST_NAME
FROM emp_details

--91...Retrieve employees whose names contain exactly 5 characters using LEN.

SELECT * FROM emp_details WHERE LEN(first_name) = 5

--92...Replace all occurrences of "." in email addresses with "dot".

SELECT email,
REPLACE(email,'.','DOT')
FROM emp_details

--93...Find employees whose email domain is "gmail.com".

SELECT email
FROM emp_details WHERE email LIKE '%gmail.com%'

SELECT 
    * 
FROM 
    emp_details
WHERE 
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) = 'gmail.com';

--94...Capitalize the first letter of the dept_name for display purposes.

select dept_name,
UPPER(LEFT(dept_name,1)) + LOWER(SUBSTRING(dept_name,2,LEN(dept_name)-1))
from emp_details

--95...Split employee names into individual words using a string-splitting function.

SELECT 
    full_name,
    value AS Name_Part
FROM 
    emp_details
CROSS APPLY 
    STRING_SPLIT(full_name, ' ');

--96...Identify employees whose names are palindromes.

SELECT 
    full_name
FROM 
    emp_details
WHERE 
    full_name LIKE '%palindromes%'

--97...Format phone numbers to include hyphens (e.g., "1234567890" -> "123-456-7890").

SELECT 
    mobile_no,
    STUFF(STUFF(mobile_no, 4, 0, '-'), 8, 0, '-') AS formatted_phone_number
FROM 
    emp_details
WHERE 
    LEN(mobile_no) = 10;

--98...Mask the first part of email addresses for privacy (e.g., "johndoe@gmail.com" -> "****doe@gmail.com").

SELECT 
email,
STUFF(email,1,4,'*****') AS UPDATED_EMAIL

FROM emp_details

SELECT 
    email,
    STUFF(email, 1, CHARINDEX('@', email) - 1, '*****') AS UPDATED_EMAIL
FROM emp_details;

--99...Replace "HR" with "Human Resources" in department names.

SELECT dept_name,
REPLACE(dept_name,'HR','Human Resources') AS RPLACE_NAME
FROM emp_details

--100...Find employees whose names contain both "John" and "Smith".

SELECT * FROM emp_details
WHERE first_name IN ('John','Smith') AND last_name IN ('John','Smith')

SELECT * 
FROM emp_details
WHERE full_name LIKE '%John%' 
  AND full_name LIKE '%Smith%';

--101...Extract all text after the last space in the address column.

SELECT 
    add_ress,
    RIGHT(add_ress, LEN(add_ress) - CHARINDEX(' ', add_ress, LEN(add_ress) - LEN(REPLACE(add_ress, ' ', '')))) AS text_after_last_space
FROM emp_details;

--102...Count the total number of spaces in the address column.

SELECT 
    add_ress,
    LEN(add_ress) - LEN(REPLACE(add_ress, ' ', '')) AS space_count
FROM emp_details;

--103...Identify employees with duplicate email addresses.

SELECT email,
COUNT(email) AS COUNT_T
FROM emp_details
GROUP BY email  HAVING COUNT(email) >1
ORDER BY COUNT_T DESC

--104...Standardize phone numbers to remove all non-numeric characters.
SELECT 
    mobile_no,
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(mobile_no, '-', ''), '(', ''), ')', ''), ' ', ''), '.', ''), '+', ''), ',', ''), '/', '') AS standardized_phone_number
FROM emp_details;

--105...Find employees whose names contain numeric characters.

SELECT *
FROM emp_details
WHERE PATINDEX('%[0-9]%', add_ress) > 10
   OR PATINDEX('%[0-9]%', last_name) > 0;

SELECT 
    add_ress, 
    PATINDEX('%[0-9]%', add_ress) AS REMOVE_NUMBER,  -- Finds position of first numeric character
    PATINDEX('%[A-Za-z]%', add_ress) AS REMOVE_CHARACTER  -- Finds position of first alphabetic character
FROM emp_details;

--106...Replace all vowels in employee names with asterisks.
SELECT 
    first_name,
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(first_name, 'a', '*'), 'A', '*'), 
        'e', '*'), 'E', '*'), 'i', '*'), 'I', '*'), 
        'o', '*'), 'O', '*'), 'u', '*') AS Name_With_Asterisks
FROM emp_details;

--107...Validate if the email column contains a valid email address format.

SELECT 
    email,
    CASE 
        WHEN PATINDEX('%_@_%_.__%', email) > 0 THEN 'Valid'
        ELSE 'Invalid'
    END AS Email_Validation
FROM emp_details;

--108...Retrieve employees with the shortest name in the table.

SELECT first_name, last_name, full_name
FROM emp_details
WHERE LEN(first_name) = 
    (SELECT MIN(LEN(first_name)) FROM emp_details);

--109...Add a custom prefix to all department names.

SELECT 
    dept_name,
    CONCAT('CustomPrefix_', dept_name) AS dept_name_with_prefix
FROM emp_details;

--110...Check if any employees have empty or null addresses.

SELECT add_ress FROM emp_details WHERE add_ress  IS NULL

--111...Extract the middle name from a full name if it exists.
SELECT full_name,
PARSENAME(REPLACE(full_name,' ','.'),2) AS FIRST_NAME,
PARSENAME(REPLACE(full_name,' ','.'),1) AS LAST_NAME
FROM emp_details

--112...Remove all digits from the address column.

SELECT 
    add_ress, 
    TRANSLATE(add_ress, '0123456789', '**********') AS address_without_digits
FROM emp_details;

SELECT 
    add_ress, 
    TRANSLATE(add_ress, '0123456789', '----------') AS address_without_digits
FROM emp_details;

--113...Identify employees whose names contain more than one occurrence of "a".


SELECT 
    first_name,
    last_name
FROM 
    emp_details
WHERE 
    LEN(first_name) - LEN(REPLACE(LOWER(first_name), 'a', '')) > 1
    OR LEN(last_name) - LEN(REPLACE(LOWER(last_name), 'a', '')) > 1;


--114...Replace "Main St" with "Main Street" in the address column.

SELECT add_ress,
REPLACE(add_ress,'Main St','Main Street')
FROM emp_details 

--115...Convert the entire dept_name column to title case.
SELECT 
    dept_name,
    -- Convert the department name to title case
    UPPER(LEFT(dept_name, 1)) + LOWER(SUBSTRING(dept_name, 2, LEN(dept_name)-1)) AS Title_Case_Dept_Name
FROM 
    emp_details;

--116...Identify employees whose names include repeated characters.
SELECT 
    first_name,
    last_name
FROM 
    emp_details
WHERE 
    first_name LIKE '%[a-zA-Z]%[a-zA-Z]%[a-zA-Z]%[a-zA-Z]%'  -- looks for repeated characters in first_name
    OR last_name LIKE '%[a-zA-Z]%[a-zA-Z]%[a-zA-Z]%[a-zA-Z]%'  -- looks for repeated characters in last_name

--117...Find the most common first letter in employee names.

SELECT 
    LEFT(first_name, 1) AS First_Letter, 
    COUNT(*) AS Occurrence_Count
FROM 
    emp_details
GROUP BY 
    LEFT(first_name, 1)
ORDER BY 
First_Letter ASC,
    Occurrence_Count DESC

--118...Replace the last word in the address column with "Avenue".

SELECT * FROM emp_details WHERE add_ress LIKE '%Avenue%'

--119...Extract the top-level domain from email addresses (e.g., ".com").

SELECT 
    email,
    SUBSTRING(email, CHARINDEX('.', email) + 1, LEN(email) - CHARINDEX('.', email)) AS Top_Level_Domain
FROM 
    emp_details;

--120...Standardize all department names to remove trailing numbers.
SELECT 
    dept_name,
    CASE 
        WHEN PATINDEX('%[0-9]%', dept_name) > 0 
        THEN LEFT(dept_name, PATINDEX('%[0-9]%', dept_name) - 1)
        ELSE dept_name 
    END AS Standardized_dept_name
FROM 
    emp_details;

--121...Create a new column combining dept_name and employee count.
SELECT 
    dept_name,
    CONCAT(dept_name, ' - ', COUNT(*)) AS dept_with_count
FROM 
    emp_details
GROUP BY 
    dept_name;

--122...Add "Employee ID: " before each employee's ID for display.
SELECT 
    CONCAT('Employee ID: ', id) AS employee_display
FROM 
    emp_details;

--123...Validate if the address column starts with a specific keyword.
SELECT 
    add_ress
FROM 
    emp_details
WHERE 
    add_ress LIKE '123%';

--124...Check if employee names are unique in the table.

SELECT DISTINCT (first_name) AS UNIQ_NAME FROM emp_details

-- Basic Date Queries

--125...Retrieve all records where the hire_date is in the year 2023.

SELECT * FROM emp_details WHERE YEAR(hire_date) = 2023
SELECT * FROM emp_details WHERE DATEPART(YEAR,hire_date) = 2023
SELECT * FROM emp_details WHERE DATENAME(YEAR,hire_date) = 2023

--126...Retrieve all employees who joined after January 1, 2023.

SELECT * FROM emp_details WHERE MONTH(hire_date) = 1 AND YEAR(hire_date) = 2023
SELECT * FROM emp_details WHERE DATENAME(MONTH,hire_date) = 'January' AND YEAR(hire_date) = 2023

--127...Retrieve employees whose hire_date is before January 1, 2022.

SELECT * FROM emp_details WHERE hire_date < '2022-01-22'

--128...Retrieve all employees who joined in the month of December 2023.

SELECT * FROM emp_details WHERE DATENAME(MONTH,hire_date) = 'December' AND YEAR(hire_date) = 2023

--129...Retrieve all employees who have been with the company for more than 5 years.

SELECT * FROM emp_details WHERE DATEDIFF(YEAR,hire_date,GETDATE()) > 5

--130...Retrieve employees whose hire_date is in the last 30 days.

SELECT *
FROM emp_details
WHERE hire_date >= DATEADD(DAY, -30, GETDATE());

--131...Retrieve employees whose hire_date is between January 1, 2023, and December 31, 2023.

SELECT * 
FROM emp_details
WHERE 
    YEAR(hire_date) = 2023
    AND DATENAME(MONTH, hire_date) BETWEEN 'January' AND 'December'
    AND DAY(hire_date) BETWEEN 1 AND 31;

--132...Retrieve all records where the hire_date is on or after January 1, 2022.

SELECT * 
FROM emp_details
WHERE   
YEAR(hire_date) = 2022
AND DATENAME(MONTH,hire_date) = 'January'
AND DAY(hire_date) = 1

--133...Retrieve employees whose birthday (dob) is in the month of June.

SELECT * FROM emp_details WHERE DATENAME(MONTH,hire_date) = 'June'

--134...Retrieve employees whose hire_date is before the current date.

SELECT * FROM emp_details WHERE hire_date < GETDATE()

--135...Retrieve all employees whose hire_date is after a specific date (e.g., 2023-06-01).

SELECT * FROM emp_details WHERE hire_date = '2023-06-01'

--136...Retrieve employees who were hired in the last 6 months.

SELECT *
FROM emp_details
WHERE hire_date >= DATEADD(MONTH, -6, GETDATE());

--137...Retrieve employees who were hired in the last year.

SELECT *
FROM emp_details
WHERE hire_date >= DATEADD(YEAR, -1, GETDATE());

--138...Retrieve all employees whose birthday falls in the same month as today's date.

SELECT * FROM emp_details WHERE MONTH(hire_date) = MONTH(GETDATE())

--139...Retrieve employees hired on a specific day (e.g., 2023-05-15).

SELECT * FROM emp_details WHERE hire_date = '2023-05-15'

--140...Retrieve the current date using SQL.
SELECT GETDATE()

--141...Retrieve the difference in days between the hire_date and today's date.

SELECT FIRST_NAME,LAST_NAME,
DATEDIFF(DAY,hire_date,GETDATE()) AS DIFF_IN_DAY FROM emp_details 

--142...Extract the year from the hire_date column.
--Extract the month from the hire_date column.
--Extract the day from the hire_date column.


SELECT hire_date,
YEAR(hire_date) AS YEAR,
MONTH(hire_date) AS MONTH,
DATENAME(MONTH,hire_date) AS MONTH_NAME,
DAY(hire_date) AS DAY,
DATENAME(WEEKDAY,hire_date) AS DAY_NAME
FROM emp_details

--143...Retrieve the week number for each employee’s hire_date.

SELECT hire_date,
DATENAME(WEEK,hire_date) AS WEEK_NUMBER,
DATEPART(WEEK,hire_date) AS WEEK_NUMBER12

FROM emp_details

--144...Calculate the age of employees based on their dob.

SELECT 
    first_name, 
    last_name, 
    hire_date,
    DATEDIFF(YEAR, hire_date, GETDATE()) - 
        CASE 
            WHEN MONTH(hire_date) > MONTH(GETDATE()) OR (MONTH(hire_date) = MONTH(GETDATE()) AND DAY(hire_date) > DAY(GETDATE())) 
            THEN 1 
            ELSE 0 
        END AS Age
FROM emp_details;

SELECT 
    first_name, 
    last_name, 
    hire_date,
    DATEDIFF(YEAR, hire_date, GETDATE()) - 
    IIF(MONTH(hire_date) > MONTH(GETDATE()) OR (MONTH(hire_date) = MONTH(GETDATE()) AND DAY(hire_date) > DAY(GETDATE())), 1, 0) AS Age
FROM emp_details;

--144...Find employees whose age is greater than 30.

SELECT * FROM (
SELECT 
    first_name, 
    last_name, 
    hire_date,
    DATEDIFF(YEAR, hire_date, GETDATE()) - 
    IIF(MONTH(hire_date) > MONTH(GETDATE()) OR (MONTH(hire_date) = MONTH(GETDATE()) AND DAY(hire_date) > DAY(GETDATE())), 1, 0) AS Age
FROM emp_details
) AS A
WHERE Age > 3

--145...Format the hire_date in YYYY-MM-DD format.
SELECT 
    first_name, 
    last_name, 
    CONVERT(VARCHAR, hire_date, 23) AS formatted_hire_date
FROM emp_details;

--146...Retrieve the employees hired in the last week.

SELECT * FROM emp_details
WHERE hire_date >=   DATEADD(DAY,-7,GETDATE())

--147...Calculate the number of years between the hire_date and today's date.

SELECT hire_date,
DATEDIFF(YEAR,hire_date,GETDATE()) AS YAER_GAP
FROM emp_details

--148...Add 1 year to the hire_date column.

SELECT hire_date,
DATEADD (YEAR,1,hire_date)AS ADD_YEAR FROM emp_details

--149...Subtract 1 month from the hire_date column.

SELECT hire_date,
DATEADD (MONTH,-1,hire_date)AS SUB_MONTH FROM emp_details

--150...Add 10 days to the hire_date column.

SELECT hire_date,
DATEADD (DAY,10,hire_date)AS ADD_DAY FROM emp_details

--151...Calculate the number of days between two dates (e.g., hire_date and dob).

SELECT 
    first_name,
    last_name,
    hire_date,
    DATEDIFF(DAY, hire_date,GETDATE()) AS days_between
FROM 
    emp_details;

--152...Get the day of the week for the hire_date.

SELECT hire_date,
DATENAME(WEEKDAY,hire_date) AS WEEKDAY
FROM emp_details;

--153...Retrieve the first day of the month for each employee’s hire_date.

SELECT 
    first_name,
    last_name,
    hire_date,
    DATEADD(MONTH, DATEDIFF(MONTH, 0, hire_date), 0) AS first_day_of_month
FROM 
    emp_details;

--154...Retrieve the last day of the month for each employee’s hire_date.
SELECT 
    first_name,
    last_name,
    hire_date,
    EOMONTH(hire_date) AS last_day_of_month
FROM 
    emp_details;

--155...Convert the hire_date to the first day of the year.
SELECT 
    first_name,
    last_name,
    hire_date,
    DATEFROMPARTS(YEAR(hire_date), 1, 1) AS first_day_of_year
FROM 
    emp_details;

--156...Retrieve the quarter of the year for each employee's hire_date.
SELECT 
    first_name,
    last_name,
    hire_date,
    DATEPART(QUARTER, hire_date) AS hire_quarter
FROM 
    emp_details;

--157...Find the employees who were hired on the last day of the month.
SELECT 
    first_name,
    last_name,
    hire_date
FROM 
    emp_details
WHERE 
    hire_date = EOMONTH(hire_date);

--158...Format the dob column to show only the month and year.

SELECT hire_date,
DATENAME(MONTH,hire_date) AS MONTH_NAME,
YEAR(hire_date) AS YAER,
FORMAT(hire_date,'MM-yyyy') AS MONTH_FORMAT
FROM emp_details;

SELECT 
FORMAT(hire_date,'dd-MM-yyyy') AS MONTH_FORMAT
FROM emp_details;

--159...Retrieve employees whose hire_date is earlier than 2020.

SELECT * FROM emp_details WHERE YEAR(hire_date) < 2020 

--160...Retrieve employees whose hire_date is in the first quarter of the year.

SELECT * FROM emp_details WHERE DATEPART(QUARTER,hire_date) = 1

--161...Retrieve employees who were hired on a weekend (e.g., Saturday or Sunday).

SELECT * FROM emp_details WHERE DATENAME(WEEKDAY,hire_date) IN ('Saturday','Sunday')

--162...Retrieve employees hired on a specific weekday (e.g., Friday).

SELECT * FROM emp_details WHERE DATENAME(WEEKDAY,hire_date) IN ('Friday')

--163...Retrieve employees whose hire_date falls within the last 5 years.

SELECT COUNT(*) FROM emp_details
WHERE 
DATEDIFF(YEAR,hire_date,GETDATE()) < 5;



SELECT 
    COUNT(*)
FROM 
    emp_details
WHERE 
    hire_date >= DATEADD(YEAR, -5, GETDATE());

--164...Retrieve employees whose hire_date is in the past month.

SELECT * FROM emp_details WHERE hire_date >= DATEADD(MONTH,-1,GETDATE()) 

--165...Find employees whose hire_date is the same year as a specific employee.

SELECT * 
FROM emp_details 
WHERE 
    YEAR(hire_date) = (
        SELECT YEAR(hire_date) 
        FROM emp_details 
        WHERE id = 123
    );

--166...Retrieve employees whose hire_date is the same as their dob.

SELECT * FROM emp_details
WHERE hire_date IN
( SELECT hire_date FROM emp_details WHERE dept_name = 'Marketing');

--167...Retrieve employees whose hire_date is the same as today's date.

SELECT * FROM emp_details
WHERE DATEPART(DAY,hire_date) = DATEPART(DAY,GETDATE())

--168...Retrieve employees whose hire_date is exactly one year ago from today's date.

SELECT * FROM emp_details
WHERE hire_date = DATEADD(YEAR,-1,CAST(GETDATE() AS DATE))

--169...Retrieve employees whose hire_date is before a specific date (e.g., 2022-12-31).

SELECT * FROM emp_details
WHERE hire_date = DATEADD(YEAR,-1, '2022-12-31')

--170...Retrieve employees whose hire_date is on or after January 1, 2022.

SELECT COUNT(*) FROM emp_details
WHERE hire_date > '2022-01-01';

SELECT COUNT(*) 
FROM emp_details
WHERE
(
    YEAR(hire_date) > 2022
    OR (YEAR(hire_date) > 2022 AND DATENAME(MONTH, hire_date) > 'January')
    OR (YEAR(hire_date) > 2022 AND DATENAME(MONTH, hire_date) > 'January' AND DAY(hire_date) > 1)
);

--171...Retrieve employees who were hired before or on a specific date.

SELECT * 
FROM emp_details
WHERE hire_date <= '2023-01-01';

--- Date Aggregations

--172...Count the number of employees who joined in each year.

SELECT YEAR(hire_date) AS YEAR,
COUNT(*) AS ALL_COUNT
FROM emp_details GROUP BY YEAR(hire_date);

--173...Find the total number of employees hired in each quarter.

SELECT DATEPART(QUARTER,hire_date) AS ALL_QUARTER,
COUNT(*) AS ALL_COUNT
FROM emp_details GROUP BY DATEPART(QUARTER,hire_date) ORDER BY ALL_QUARTER;

--174...Retrieve the average tenure (difference between hire_date and today) of employees.

SELECT 
DATEDIFF(YEAR,hire_date,GETDATE()) AS YEAR_DIFF    ,
AVG(SALARY) AS AVG_SALARY
FROM emp_details GROUP BY 
DATEDIFF(YEAR,hire_date,GETDATE())

--175...Calculate the sum of all employees' ages based on dob.

SELECT SUM(DATEDIFF(YEAR, hire_date, GETDATE()) - 
           CASE 
               WHEN MONTH(hire_date) > MONTH(GETDATE()) OR (MONTH(hire_date) = MONTH(GETDATE()) AND DAY(hire_date) > DAY(GETDATE())) 
               THEN 1 
               ELSE 0 
           END) AS Total_Age
FROM emp_details;

--176...Retrieve the average number of days between hire_date and dob for each employee.

SELECT AVG(DATEDIFF(DAY,dob,hire_date)) AS AVG_NUMBER_BETWEEN_DOB_AND_HIRE_DATE FROM employee_data

--177...Find the minimum hire_date in the company.

SELECT MIN(hire_date) AS MIN_HIRING_THAT_DAY FROM employee_data

--178...Find the maximum hire_date in the company.

SELECT MAX(hire_date) AS MAX_HIRING_THAT_DAY FROM employee_data

--179...Count the number of employees hired in each month.

SELECT MONTH(hire_date) AS HIRE_MONTH, COUNT(*) AS TOTAL_COUNT FROM employee_data
GROUP BY MONTH(hire_date) ORDER BY HIRE_MONTH

--180...Retrieve the month with the most number of hires.

SELECT DATENAME(MONTH,hire_date) AS HIRE_MONTH, COUNT(*) AS TOTAL_COUNT FROM employee_data
GROUP BY DATENAME(MONTH,hire_date) ORDER BY TOTAL_COUNT DESC;


SELECT 
    DATENAME(MONTH, hire_date) AS Month_Name,
    MONTH(hire_date) AS Month_Number,
    COUNT(*) AS Hire_Count
FROM employee_data
GROUP BY DATENAME(MONTH, hire_date), MONTH(hire_date)
ORDER BY Hire_Count DESC;

--181...Find the department with the most employees hired in the first quarter of the year.

SELECT TOP 1 dept_name, COUNT(*) ASTOTAL_COUNT FROM employee_data
WHERE DATEPART(QUARTER,hire_date) = 1
GROUP BY dept_name
ORDER BY ASTOTAL_COUNT DESC;

SELECT
    dept_name,
    COUNT(*) AS Employee_Count
FROM employee_data
WHERE DATEPART(QUARTER, hire_date) = 1
GROUP BY dept_name
ORDER BY Employee_Count DESC;

SELECT
    dept_name,
    COUNT(CASE WHEN DATEPART(QUARTER, hire_date) = 1 THEN 1 END) AS Employee_Count
FROM employee_data
GROUP BY dept_name
ORDER BY Employee_Count DESC;


--182...Retrieve the earliest hire_date for employees who joined after 2015.

SELECT 
    MIN(hire_date) AS Earliest_Hire_Date
FROM 
    employee_data
WHERE 
    YEAR(hire_date) > 2015;

--183...Retrieve the latest hire_date for employees hired before 2020.

SELECT MAX(hire_date) AS HIRE_DATE FROM employee_data
WHERE YEAR(hire_date) < 2020

--184...Count the number of employees hired in each week of the year.

SELECT DATENAME(WEEK,hire_date) AS WEEK_OF_YEAR,
COUNT(*) AS TOTAL_COUNT
FROM employee_data GROUP BY DATENAME(WEEK,hire_date) ORDER BY TOTAL_COUNT DESC;

--185...Find the average hire date per department.

SELECT 
    dept_name,
    CAST(DATEADD(DAY, AVG(DATEDIFF(DAY, 0, hire_date)), 0) AS DATE) AS Average_Hire_Date
FROM 
    employee_data
GROUP BY 
    dept_name;

--186...Group employees by their hire month and count the number of employees hired each month.

SELECT 
    DATENAME(MONTH, hire_date) AS Hire_Month,
    COUNT(*) AS Employee_Count
FROM 
    employee_data
GROUP BY 
    DATENAME(MONTH, hire_date)
ORDER BY 
    Hire_Month;

--187...Retrieve the total number of employees who joined in each quarter of the year.

SELECT 
      DATENAME(QUARTER,hire_date) AS QR_HIRE,
	  COUNT(*) AS TOTAL_HIRE
FROM 
       employee_data
GROUP BY
         DATENAME(QUARTER,hire_date)
ORDER BY
		 QR_HIRE ASC;

--188...Group employees by year and retrieve the average salary of employees hired in each year.

SELECT
YEAR(hire_date) AS HIRUBG_YEAR,
AVG(salary) AS AVG_SALARY
FROM employee_data
GROUP BY YEAR(hire_date)
ORDER BY HIRUBG_YEAR ASC, AVG_SALARY DESC;

--189...Group employees by the day of the week they were hired and count how many employees were hired on each day.

SELECT DATENAME(WEEKDAY,hire_date) AS WEEK_HIRE,
COUNT(*) AS TOTAL_COUNT
FROM employee_data
GROUP BY DATENAME(WEEKDAY,hire_date)
ORDER BY TOTAL_COUNT

--190...Group employees by the year of their hire date and retrieve the minimum salary per year.

SELECT
YEAR(hire_date) AS YEAR_HIRE,
MIN(salary) AS MIN_SALARY
FROM employee_data
GROUP BY YEAR(hire_date)
ORDER BY MIN_SALARY

--191...Retrieve departments with more than 10 employees hired in the last year.

SELECT dept_name,
COUNT(*) AS TOTAL_COUNT
FROM employee_data WHERE 
hire_date >= DATEADD(YEAR,-1,CAST(GETDATE() AS DATE))
GROUP BY dept_name
HAVING COUNT(*) > 10
ORDER BY TOTAL_COUNT;

--192...Group employees by the month and year of their hire_date and count the number of employees hired each month.

SELECT 
YEAR(hire_date) AS YAER_,
DATENAME(MONTH,hire_date) AS MONTH_NAME,
COUNT(*) AS TOTAL_COUNT
FROM employee_data
GROUP BY YEAR(hire_date),
DATENAME(MONTH,hire_date)
ORDER BY YAER_ DESC,MONTH_NAME DESC

--193...Group employees by the quarter and calculate the average salary in each quarter.

SELECT
DATEPART(QUARTER,hire_date) AS QR_HIRE,
AVG(salary) AS AVG_SALARY
FROM employee_data
GROUP BY DATEPART(QUARTER,hire_date)
ORDER BY AVG_SALARY ASC;

--194...Find the department with the most hires in the past 6 months.

SELECT dept_name,
COUNT(*) AS TOTAL_COUNT
FROM employee_data
WHERE hire_date >= DATEADD(MONTH,-6,CAST(GETDATE() AS DATE))
GROUP BY dept_name
ORDER BY TOTAL_COUNT DESC;

--195...Retrieve employees whose hire_date is exactly 1 week after a specific date.

SELECT * FROM  employee_data
WHERE hire_date = DATEADD(DAY,7,'2020-02-24')

--196...Find employees hired within the last 6 months and earning more than 60,000.

SELECT * FROM employee_data
WHERE hire_date >=
DATEADD(MONTH,-6,CAST(GETDATE()AS DATE)) AND salary >60000;

--197...Retrieve employees hired before and after a specific employee’s hire_date.

SELECT *
FROM employee_data
WHERE hire_date < (SELECT hire_date FROM emp_details WHERE id = 545)
   OR hire_date > (SELECT hire_date FROM emp_details WHERE id = 812);

--198...Retrieve employees who were hired on the same day as the company’s founding date.

SELECT *
FROM emp_details
WHERE hire_date = '2010-05-15';

--199...Retrieve employees whose tenure is more than 3 years, but less than 5 years.

SELECT * FROM employee_data WHERE DATEDIFF(YEAR,hire_date,GETDATE()) BETWEEN 3 AND 5;

--200...Retrieve employees who were hired during the weekend.

SELECT * FROM employee_data
WHERE DATENAME(WEEKDAY,hire_date) IN( 'Saturday' , 'Sunday')

--201...Retrieve employees whose birthday is today.
SELECT * FROM employee_data WHERE DATENAME(DAY,DOB) = DATENAME(DAY,GETDATE())
AND DATENAME(MONTH,DOB) = DATENAME(MONTH,GETDATE())

--202...Find the department with the most hires in the last 30 days.

SELECT * FROM employee_data WHERE hire_date >= DATEADD(DAY,-30,CAST(GETDATE() AS DATE))

--203...Retrieve employees hired between the 15th and 30th of each month.

SELECT *
FROM employee_data
WHERE DAY(hire_date) BETWEEN 15 AND 30;

--204...Retrieve the first employee hired each year.

SELECT * FROM 
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY YEAR(hire_date) ORDER BY hire_date ASC) AS RANK_NO
FROM employee_data
) AS A
WHERE RANK_NO = 1

--205...Retrieve the last employee hired each month.

SELECT * FROM 
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY MONTH(hire_date),YEAR(hire_date) ORDER BY hire_date DESC) AS RANK_NO
FROM employee_data
) AS A
WHERE RANK_NO = 1

--206...Retrieve the employees whose tenure is the shortest (based on hire_date).

SELECT TOP 1 *
FROM employee_data
ORDER BY hire_date DESC;

--207...Retrieve the employees hired after a specific date, and sort them by the number of years they’ve been with the company.

SELECT *
FROM employee_data
WHERE hire_date > '2022-01-01'  
ORDER BY DATEDIFF(YEAR, hire_date, GETDATE()) DESC;

--208..Retrieve employees who were hired during the same week as the company's quarterly review.
SELECT *
FROM employee_data
WHERE DATEPART(WEEK, hire_date) = DATEPART(WEEK, '2024-04-01')  
AND DATEPART(YEAR, hire_date) = DATEPART(YEAR, '2024-04-01');  

--209...Retrieve the last employee hired in each department.

SELECT * FROM 
(
SELECT dept_name, 
        first_name, 
        hire_date,
ROW_NUMBER() OVER(PARTITION BY dept_name  ORDER BY hire_date DESC) AS RANK_NO
FROM employee_data
) AS A
WHERE RANK_NO = 1

--210...Retrieve employees who joined in the first half of the year.
SELECT *
FROM employee_data
WHERE MONTH(hire_date) BETWEEN 1 AND 6;

--211...Retrieve employees who joined in the second half of the year.

SELECT *
FROM employee_data
WHERE MONTH(hire_date) BETWEEN 7 AND 12;

--212...Retrieve employees who were hired within the last 10 days.

SELECT * FROM employee_data WHERE hire_date >=
DATEADD(DAY,-10,CAST(GETDATE()AS DATE));

--213...Find employees who were hired the most recently in each department.
WITH RankedEmployees AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY dept_name ORDER BY hire_date DESC) AS rn
    FROM employee_data
)
SELECT *
FROM RankedEmployees
WHERE rn = 1;

--214...Retrieve employees who were hired during the last fiscal quarter.

SELECT *
FROM employee_data
WHERE hire_date >= DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)
  AND hire_date < DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()), 0);

---... AGG FUNCATION...

--215...Count the total number of employees in the company.

SELECT COUNT(*) AS TOTAL_COUNT FROM employee_data

--216...Count the number of employees in each department.

SELECT DEPT_NAME, COUNT(*) AS TOTAL_COUNT FROM employee_data GROUP BY DEPT_NAME

--217...Count how many employees have a salary greater than 50,000.

SELECT COUNT(*) AS TOTAL_COUNT FROM employee_data WHERE salary > 50000

--218...Count how many employees were hired in 2023.

SELECT COUNT(*) AS TOTAL_COUNT FROM employee_data WHERE YEAR(hire_date) = 2023

--219...Count the number of employees who have a NULL value in their email field.

SELECT COUNT(*) AS TOTAL_COUNT FROM employee_data WHERE email IS NULL

--220...Count how many employees have been with the company for over 10 years.

SELECT COUNT(*) AS TOTAL_COUNT FROM employee_data WHERE DATEDIFF(YEAR,hire_date,GETDATE()) > 5
SELECT COUNT(*) AS TOTAL_COUNT FROM employee_data WHERE DATEDIFF(YEAR,DOB,GETDATE()) >10

--221...Count the number of employees in each location.

SELECT location,COUNT(*) AS TOTAL_COUNT FROM employee_data GROUP BY location;

--222...Count the total number of employees who have a salary between 40,000 and 60,000.

SELECT COUNT(*) AS TOTAL_COUNT FROM employee_data WHERE salary BETWEEN 40000 AND 60000;

--223...Count the number of employees who were hired in each month.

SELECT MONTH(HIRE_DATE) AS HIRE_MONTH, COUNT(*) AS TOTAL_COUNT FROM employee_data GROUP BY MONTH(HIRE_DATE)
ORDER BY HIRE_MONTH;

--224...Count the number of employees who have a dob in the month of December.

SELECT COUNT(*) AS TOTAL_COUNT FROM employee_data WHERE DATENAME(MONTH,hire_date) = 'December';

--225...Calculate the total salary paid to all employees in the company.

SELECT SUM(salary) AS TOTAL_SALARY FROM employee_data

--226...Calculate the total salary paid to employees in each department.

SELECT DEPT_NAME, SUM(salary) AS TOTAL_SALARY FROM employee_data GROUP BY DEPT_NAME;

--227...Calculate the total salary for employees who have been with the company for more than 5 years.

SELECT  SUM(salary) AS TOTAL_SALARY FROM employee_data WHERE DATEDIFF(YEAR,hire_date,GETDATE()) > 5

--228...Find the total bonus given to employees who earn more than 60,000.

SELECT  SUM(salary) AS TOTAL_SALARY FROM employee_data WHERE salary > 60000

--229...Calculate the total sales value for employees who work in the sales department.

SELECT  SUM(salary) AS TOTAL_SALARY FROM employee_data WHERE dept_name = 'SALES'

--230...Calculate the total number of hours worked by all employees.

SELECT 
    SUM(DATEDIFF(HOUR, hire_date, GETDATE())) AS Total_Hours_Worked
FROM 
    employee_data;

--231..Find the total salary of employees in the 'HR' department.

SELECT SUM(salary) AS TOTAL_SALARY FROM employee_data WHERE dept_name = 'HR'

--232...Calculate the total number of days worked for employees who joined in the last 3 months.

SELECT 
    SUM(DATEDIFF(DAY, hire_date, GETDATE())) AS Total_Days_Worked
FROM 
    employee_data
WHERE 
    hire_date >= DATEADD(MONTH, -3, GETDATE());

--232...Calculate the total expense in salary for the company in the current fiscal year.

WITH FiscalYearDates AS (
    SELECT 
        CAST(DATEFROMPARTS(YEAR(GETDATE()) - CASE WHEN MONTH(GETDATE()) < 4 THEN 1 ELSE 0 END, 4, 1) AS DATE) AS StartOfFiscalYear,
        CAST(DATEFROMPARTS(YEAR(GETDATE()) + CASE WHEN MONTH(GETDATE()) < 4 THEN 0 ELSE 1 END, 3, 31) AS DATE) AS EndOfFiscalYear
),
ProratedSalaries AS (
    SELECT 
        e.id,
        e.salary,
        CASE 
            WHEN hire_date > f.StartOfFiscalYear THEN DATEDIFF(DAY, hire_date, GETDATE()) * (salary / 365.0)
            ELSE salary
        END AS AdjustedSalary
    FROM 
        employee_data e
    CROSS JOIN 
        FiscalYearDates f
    WHERE 
        hire_date <= f.EndOfFiscalYear
)
SELECT 
    SUM(AdjustedSalary) AS TotalSalaryExpense
FROM 
    ProratedSalaries;  -- IAM NOT SOLVE THIS CODE

--233...Calculate the total income for employees who work in the marketing department.

SELECT SUM(salary) AS TOTAL_SALARY FROM employee_data
WHERE dept_name = 'marketing';

--234...Find the average salary of all employees.

SELECT AVG(salary) AS AVG_SALARY FROM employee_data

--235...Find the average salary for employees in each department.

SELECT DEPT_NAME, AVG(salary) AS AVG_SALARY FROM employee_data GROUP BY DEPT_NAME;

--236...Find the average salary of employees who were hired in the last year.

SELECT AVG(salary) AS AVG_SALARY FROM employee_data WHERE hire_date >= DATEADD(YEAR,-1,GETDATE())

--237...Calculate the average number of years each employee has been with the company.

SELECT 
    AVG(DATEDIFF(YEAR, hire_date, GETDATE())) AS Average_Years_With_Company
FROM 
    employee_data;

--238...Find the average salary for employees who have been with the company for more than 10 years.

SELECT AVG(salary) AS AVG_SALARY FROM employee_data WHERE YEAR(hire_date) > 5

--239...Find the average salary of employees in each location.

SELECT LOCATION, AVG(salary) AS AVG_SALARY FROM employee_data GROUP BY LOCATION;

--240...Calculate the average age of employees.

SELECT
AVG(DATEDIFF(YEAR,DOB,GETDATE())) AS AVG_AGE
FROM employee_data;

--241...Find the average salary for employees who are over 30 years old.

SELECT AVG(salary) AS ABG_SALARY FROM employee_data WHERE DOB >  DATEADD(YEAR,-30,DOB);
SELECT AVG(salary) AS ABG_SALARY FROM employee_data WHERE DATEDIFF(YEAR,DOB,CAST(GETDATE() AS DATE)) > 30;

--242...Find the average bonus for employees who have a salary greater than 50,000.

SELECT AVG(salary) AS AVG_SALARY FROM employee_data WHERE salary > 50000

--243...Calculate the average salary of employees who work in the IT department.

SELECT AVG(salary) AS AVG_SALARY FROM employee_data WHERE dept_name = 'IT'

--244...Find the highest salary in the company.Find the lowest salary in the company.

SELECT MAX(SALARY) AS MAX_SALARY,MIN(SALARY) AS MIN_SALARY FROM employee_data

--245...Find the highest salary in each department.Find the lowest salary in each department.

SELECT DEPT_NAME, MAX(SALARY) AS MAX_SALARY,MIN(SALARY) AS MIN_SALARY FROM employee_data GROUP BY dept_name

--246...Find the highest number of years worked by any employee.
SELECT 
    MAX(DATEDIFF(YEAR, hire_date, GETDATE())) AS Max_Years_Worked
FROM 
    employee_data;

--247...Find the employee who has the highest salary in the company.

SELECT MAX(SALARY) AS MAX_SALARY FROM employee_data;

SELECT * FROM employee_data AS A WHERE 1 = 
(SELECT COUNT(DISTINCT salary) FROM employee_data AS B WHERE A.salary <= B.salary);

--248...Find the employee who has the lowest salary in the company.

SELECT MIN(SALARY) AS MAX_SALARY FROM employee_data;

SELECT * FROM employee_data AS A WHERE 1 = 
(SELECT COUNT(DISTINCT salary) FROM employee_data AS B WHERE A.salary >= B.salary);

--249...Find the earliest hire date of any employee.

SELECT 
    MIN(hire_date) AS Earliest_Hire_Date
FROM 
    employee_data;
--250...Find the latest hire date of any employee.

SELECT 
    MAX(hire_date) AS Latest_Hire_Date
FROM 
    employee_data;

--251...Find the maximum salary for employees in each location.

SELECT location,MAX(salary) AS MAX_SALARY FROM employee_data GROUP BY location

--252...Group employees by department and calculate the total salary for each department.

SELECT dept_name,SUM(SALARY) AS TOTAL_SALARY FROM employee_data GROUP BY dept_name;

--253...Group employees by their hire year and calculate the average salary for each year.

SELECT YEAR(hire_date) AS YEAR,AVG(salary) AS AVG_SALARY FROM employee_data GROUP BY YEAR(hire_date)
ORDER BY YEAR ASC;

--254...Group employees by hire month and calculate the total salary paid in each month.

SELECT DATENAME(MONTH,hire_date) AS MONTH_NAME,SUM(salary) AS AVG_SALARY FROM employee_data GROUP BY DATENAME(MONTH,hire_date)

--255...Group employees by the first letter of their last_name and count how many employees have names starting with each letter.

SELECT 
 LEFT(last_name,1) AS LAST_CHAR,
 COUNT(*) AS TOTAL_COUNT
 FROM employee_data GROUP BY LEFT(last_name,1) ORDER BY LAST_CHAR ASC;

 --256...Group employees by their hire_date and calculate the average salary for each hire date.

SELECT hire_date,AVG(SALARY) AS AVG_SALARY FROM employee_data GROUP BY hire_date ORDER BY hire_date ASC;

--257...Group employees by department and find the highest salary in each department.

SELECT DEPT_NAME,MAX(SALARY) AS MAX_SALARY FROM employee_data GROUP BY DEPT_NAME;

--258...Group employees by department and find the departments with an average salary greater than 60,000.

SELECT dept_name,AVG(SALARY) AS AVG_SALARY FROM employee_data GROUP BY dept_name
HAVING AVG(SALARY) > 60000;

--257...Group employees by department and find departments with more than 50 employees.

SELECT dept_name,COUNT(*) AS TOTAL_COUNT  FROM employee_data GROUP BY dept_name
HAVING COUNT(*)>50;

--258...Group employees by department and find departments with an average salary less than 40,000.

SELECT dept_name,AVG(SALARY) AS AVG_SALARY FROM employee_data GROUP BY dept_name
HAVING AVG(SALARY) < 40000;

--258...Group employees by location and find locations with an average salary greater than 70,000.

SELECT location,AVG(SALARY) AS AVG_SALARY FROM employee_data GROUP BY location
HAVING AVG(SALARY) > 70000;

--259...Group employees by location and find locations with more than 10 employees.

SELECT location,COUNT(*) AS TOTAL_COUNT  FROM employee_data GROUP BY location
HAVING COUNT(*)> 10;

--260...Group employees by department and find departments where the highest salary is greater than 100,000.

SELECT dept_name,MAX(salary) AS MAX_SALARY FROM employee_data GROUP BY dept_name
HAVING MAX(salary) > 100000;

--261...Group employees by department and find those where the number of employees exceeds 30.

SELECT 
    LEFT(last_name, 1) AS First_Letter, 
    COUNT(*) AS Employee_Count
FROM 
    employee_data
GROUP BY 
    LEFT(last_name, 1)
ORDER BY 
    First_Letter;

--262...Group employees by their hire_date year and find those with more than 20 employees.

SELECT YEAR(hire_date) AS YEAR,COUNT(*) AS TOTAL_COUNT FROM employee_data
GROUP BY YEAR(hire_date) HAVING COUNT(*) > 20;

--263...Group employees by hire_date month and find those with more than 15 employees.

SELECT MONTH(hire_date) AS MONTH,COUNT(*) AS TOTAL_COUNT FROM employee_data
GROUP BY MONTH(hire_date) HAVING COUNT(*) > 15;

--264...Calculate the difference between the highest and lowest salaries for employees in each department.

SELECT dept_name,(MAX(salary) - MIN(salary)) AS Salary_Difference FROM employee_data GROUP BY dept_name

--265...Find the second highest salary in the company.

SELECT * FROM employee_data AS A WHERE 2 = 
(SELECT COUNT(DISTINCT salary) FROM employee_data AS B WHERE A.salary <= B.salary);

SELECT salary FROM employee_data ORDER BY salary DESC

--266...Calculate the number of employees in each department who earn more than 50,000.

SELECT dept_name,COUNT(*) AS TOTAL_COUNT FROM employee_data GROUP BY dept_name
HAVING COUNT(*)>5000

--267...Find the department with the highest average salary.
 
SELECT TOP 1 dept_name,AVG(SALARY) AS MAX_AVG_SALARY FROM employee_data GROUP BY dept_name ORDER BY MAX_AVG_SALARY DESC

--268...Find the department with the lowest average salary.

SELECT TOP 1 dept_name,AVG(SALARY) AS MAX_AVG_SALARY FROM employee_data GROUP BY dept_name ORDER BY MAX_AVG_SALARY ASC

--269...Calculate the total salary for employees who have been with the company for more than 10 years, and whose salary is above the average salary.

SELECT SUM(salary) AS TOTAL_SALARY FROM employee_data WHERE DATEDIFF(YEAR,hire_date,GETDATE()) >= 10 AND
salary > (SELECT AVG(salary) FROM employee_data);

--270...Find the department with the most employees. Find the department with the least employees.

SELECT 
    dept_name, 
    COUNT(*) AS Employee_Count
FROM 
    employee_data
GROUP BY 
    dept_name
ORDER BY 
    Employee_Count DESC;

SELECT 
    dept_name, 
    COUNT(*) AS Employee_Count
FROM 
    employee_data
GROUP BY 
    dept_name
ORDER BY 
    Employee_Count ASC;

--271...Calculate the average number of years employees have been with the company in each department.

SELECT dept_name,AVG(YEAR(hire_date)) AS AVG_YEAR FROM employee_data GROUP BY dept_name;

--272...Calculate the total number of employees who earn more than 60,000 in each department.

SELECT dept_name, COUNT(*) AS TOTAL_COUNT FROM employee_data  WHERE salary > 60000
GROUP BY dept_name 

--273...Find the department with the highest salary, the average salary, and the lowest salary.

select dept_name,
max(salary) as max_salary,
AVG(salary) as avg_salary,
min(salary) as lowest_salary
from employee_data group by dept_name;

--274...Find the total salary, average salary, and number of employees for each department.

select dept_name,
sum(salary) as TOTAL_salary,
AVG(salary) as avg_salary,
COUNT(*) as TOTAL_COUNT
from employee_data group by dept_name;

--275...Calculate the highest, lowest, and average salary for employees who were hired in 2023.

SELECT 
MAX(SALARY) AS MAX_SALARY,
MIN(SALARY) AS LOWEST_SALARY,
AVG(SALARY) AS AVG_SALARY
FROM employee_data WHERE YEAR(hire_date) = 2023;

--276...Find the total salary and the average salary for employees in each location.

SELECT 
location,
SUM(salary) AS TOTAL_SALARY,
AVG(SALARY) AS AVG_SALARY
FROM employee_data GROUP BY location;

--277...Find the highest, lowest, and average tenure of employees in each department.

SELECT 
    dept_name,
    MAX(DATEDIFF(YEAR, hire_date, GETDATE())) AS Max_Tenure,
    MIN(DATEDIFF(YEAR, hire_date, GETDATE())) AS Min_Tenure,
    AVG(DATEDIFF(YEAR, hire_date, GETDATE())) AS Avg_Tenure
FROM 
    employee_data
GROUP BY 
    dept_name;

--278...Group employees by hire_date year and calculate the total salary and the average salary for each year.

SELECT 
YEAR(hire_date) AS YEAR,
AVG(salary) AS AVG_SALARY
FROM employee_data GROUP BY YEAR(hire_date) ORDER BY YEAR ASC;

--279...Group employees by hire_date year and find the highest salary and lowest salary for each year.

SELECT 
YEAR(hire_date) AS YEAR,
MAX(salary) AS MAX_SALARY,
MIN(salary) AS LOWEST_SALARY
FROM employee_data GROUP BY YEAR(hire_date) ORDER BY YEAR ASC;

--280...Group employees by department and find the average age, highest salary, and total salary for each department.

SELECT 
dept_name,
AVG(DATEDIFF(YEAR,DOB,GETDATE())) AS AVG_YEAR,
MAX(salary) AS HIGHEST_SALARY,
SUM(salary) AS TOTAL_SALARY
FROM employee_data GROUP BY dept_name;

--281...Find the department with the highest salary, the lowest salary, and the average salary for employees in each department.

SELECT 
dept_name,
MAX(salary) AS HIGHEST_SALARY,
SUM(salary) AS TOTAL_SALARY,
AVG(salary) AS AVG_SALARY
FROM employee_data GROUP BY dept_name;

--282...Sort departments by the total salary in descending order.

SELECT 
dept_name,
SUM(salary) AS TOTAL_SALARY
FROM employee_data GROUP BY dept_name ORDER BY TOTAL_SALARY DESC;

--283...Sort departments by the average salary in ascending order.

SELECT 
dept_name,
AVG(salary) AS AVG_SALARY
FROM employee_data GROUP BY dept_name ORDER BY AVG_SALARY ;

--284...Sort employees by their tenure in descending order and calculate the average salary for each tenure group.

SELECT 
    DATEDIFF(YEAR, hire_date, GETDATE()) AS Tenure,
    AVG(salary) AS Average_Salary
FROM 
    employee_data
GROUP BY 
    DATEDIFF(YEAR, hire_date, GETDATE())
ORDER BY 
    Tenure DESC;

--285...Sort employees by their hire_date and find the average salary for each hire month.

SELECT 
DATENAME(MONTH,hire_date) AS MONTH_NAME,
AVG(salary) AS AVG_SALARY
FROM employee_data GROUP BY DATENAME(MONTH,hire_date);

--286...Sort employees by their salary and find the average salary for each salary range.

SELECT 
    CASE
        WHEN salary < 30000 THEN 'Below 30K'
        WHEN salary BETWEEN 30000 AND 49999 THEN '30K - 49K'
        WHEN salary BETWEEN 50000 AND 69999 THEN '50K - 69K'
        WHEN salary BETWEEN 70000 AND 89999 THEN '70K - 89K'
        WHEN salary BETWEEN 90000 AND 109999 THEN '90K - 109K'
        ELSE '110K and above'
    END AS Salary_Range,
    AVG(salary) AS Average_Salary
FROM 
    employee_data
GROUP BY 
    CASE
        WHEN salary < 30000 THEN 'Below 30K'
        WHEN salary BETWEEN 30000 AND 49999 THEN '30K - 49K'
        WHEN salary BETWEEN 50000 AND 69999 THEN '50K - 69K'
        WHEN salary BETWEEN 70000 AND 89999 THEN '70K - 89K'
        WHEN salary BETWEEN 90000 AND 109999 THEN '90K - 109K'
        ELSE '110K and above'
    END
ORDER BY 
    Salary_Range;

--287...Sort employees by their department and calculate the total salary paid to employees in each department.

SELECT 
    dept_name,
    SUM(salary) AS Total_Salary
FROM 
    employee_data
GROUP BY 
    dept_name
ORDER BY 
    dept_name;

--288...Sort employees by their dob and find the average age for each year of birth.

SELECT 
    YEAR(dob) AS Birth_Year,
    AVG(DATEDIFF(YEAR, dob, GETDATE())) AS Average_Age
FROM 
    employee_data
GROUP BY 
    YEAR(dob)
ORDER BY 
    Birth_Year;

--289...Sort employees by their hire month and find the highest salary for each month.

SELECT 
DATENAME(MONTH,hire_date) AS HIRE_MONTH,
MAX(salary) AS HIGH_SALARY
FROM employee_data GROUP BY DATENAME(MONTH,hire_date);

--290...Sort employees by their tenure and calculate the total salary for employees who have been with the company for more than 3 years.

SELECT 
    SUM(salary) AS Total_Salary
FROM 
    employee_data
WHERE 
    DATEDIFF(YEAR, hire_date, GETDATE()) > 3

--291...Sort departments by the number of employees and calculate the average salary in each department.

SELECT 
DEPT_NAME,
COUNT(*) AS TOTAL_COUNT,
AVG(salary) AS AVG_SALARY
FROM employee_data GROUP BY DEPT_NAME 

--292...Find the employees who have the highest salary and calculate the total salary of all employees.

SELECT * FROM employee_data
WHERE salary = (SELECT MAX(salary) FROM employee_data);

--293...Group employees by department and calculate the number of employees with salaries greater than the average salary in each department.

SELECT dept_name,
    COUNT(*) AS Employee_Count FROM employee_data WHERE salary >
(SELECT  AVG(salary) FROM employee_data )
GROUP BY dept_name;

SELECT 
    dept_name,
    COUNT(*) AS Employee_Count
FROM 
    employee_data e
WHERE 
    e.salary > (SELECT AVG(salary) FROM employee_data WHERE dept_name = e.dept_name)
GROUP BY 
    dept_name;

--294...Group employees by gender and calculate the total and average salary for each gender.
/*
SELECT 
    gender,
    SUM(salary) AS Total_Salary,
    AVG(salary) AS Average_Salary
FROM 
    employee_data
GROUP BY 
    gender;
*/

--295...Find the department with the highest number of employees and calculate the total salary in that department.

SELECT 
    dept_name,
    SUM(salary) AS Total_Salary
FROM 
    employee_data
WHERE 
    dept_name = (SELECT TOP 1 dept_name 
                  FROM employee_data
                  GROUP BY dept_name
                  ORDER BY COUNT(*) DESC)
GROUP BY 
    dept_name;

--296...Group employees by their age group (e.g., 20-30, 30-40) and find the total salary for each age group.
SELECT 
    CASE
        WHEN DATEDIFF(YEAR, dob, GETDATE()) BETWEEN 20 AND 29 THEN '20-29'
        WHEN DATEDIFF(YEAR, dob, GETDATE()) BETWEEN 30 AND 39 THEN '30-39'
        WHEN DATEDIFF(YEAR, dob, GETDATE()) BETWEEN 40 AND 49 THEN '40-49'
        WHEN DATEDIFF(YEAR, dob, GETDATE()) BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 and above'
    END AS Age_Group,
    SUM(salary) AS Total_Salary
FROM 
    employee_data
GROUP BY 
    CASE
        WHEN DATEDIFF(YEAR, dob, GETDATE()) BETWEEN 20 AND 29 THEN '20-29'
        WHEN DATEDIFF(YEAR, dob, GETDATE()) BETWEEN 30 AND 39 THEN '30-39'
        WHEN DATEDIFF(YEAR, dob, GETDATE()) BETWEEN 40 AND 49 THEN '40-49'
        WHEN DATEDIFF(YEAR, dob, GETDATE()) BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 and above'
    END
ORDER BY 
    Age_Group;

--297...Group employees by their hire_date and find the number of employees hired in each year.

SELECT YEAR(hire_date) AS YEAR,
COUNT(*) AS TOTAL_COUNT

FROM employee_data GROUP BY YEAR(hire_date);

--298...Calculate the average salary of employees who earn more than the company’s average salary.

SELECT AVG(SALARY) AS AVG_SALARY
FROM employee_data WHERE 
salary > (SELECT AVG(SALARY) AS AVG_SALARY FROM employee_data )

--299...Find the department with the highest number of employees with a salary greater than 80,000.

SELECT dept_name,
COUNT(*) AS TOTAL_COUNT
FROM employee_data WHERE salary > 80000 GROUP BY dept_name;

--300...Calculate the total salary and the average salary of employees hired within the last 2 years.

SELECT 
SUM(salary) AS TOTAL_SALARY,
AVG(salary) AS AVG_salary
FROM employee_data WHERE hire_date >= DATEADD(YEAR,-2,GETDATE())

---301..Find the employee with the highest salary, and calculate the total salary of all employees in the company.
SELECT 
MAX(salary) AS MAX_SALARY,
SUM(salary) AS TOTAL_SALARY
FROM employee_data;

SELECT 
    e.id, 
    e.first_name, 
    e.last_name, 
    e.salary, 
    (SELECT SUM(salary) FROM employee_data) AS Total_Salary
FROM 
    employee_data e
WHERE 
    e.salary = (SELECT MAX(salary) FROM employee_data);  -----SOLVE WITH HELP OF CHAT GPT

---RANKING fUNCATIONS------------

--302...Find the rank of employees based on their salary in descending order.

select * from (
select *,
RANK() OVER(ORDER BY SALARY DESC) AS RANK_salary
from employee_data
) AS A

--303...Use ROW_NUMBER() to assign a unique number to each product based on their price in ascending order.

select * from (
select *,
ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS RANK_salary
from employee_data
) AS A

--304...Find the top 5 highest-paid employees using RANK().

select * from (
select *,
RANK() OVER(ORDER BY SALARY DESC) AS RANK_salary
from employee_data
) AS A  WHERE RANK_salary BETWEEN 1 AND 5

--305...Rank employees in each department based on their joining date.

select * from (
select *,
ROW_NUMBER() OVER( PARTITION BY DEPT_NAME  ORDER BY HIRE_DATE DESC) AS RANK_salary
from employee_data
) AS A

--306...Use DENSE_RANK() to find the salary rank for each employee.

select * from (
select FULL_NAME,salary,
DENSE_RANK() OVER( ORDER BY SALARY DESC) AS RANK_salary
from employee_data
) AS A

--307...Find the employee with the highest salary in each department using RANK().

select * from (
select *,
RANK() OVER( PARTITION BY DEPT_NAME  ORDER BY SALARY DESC) AS RANK_salary
from employee_data
) AS A

--308...Create a query to assign row numbers to students based on their marks in descending order.

/*SELECT 
    student_id,
    student_name,
    marks,
    ROW_NUMBER() OVER (ORDER BY marks DESC) AS Rank
FROM 
    student_data
ORDER BY 
    Rank;*/

--309...Find the nth highest salary using RANK().

select  * from (
select *,
DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RANK_salary
from employee_data
) AS A WHERE RANK_salary = 5

--310...Find the employees with the top 3 salaries using ROW_NUMBER().

select  * from (
select *,
ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS RANK_salary
from employee_data
) AS A WHERE RANK_salary BETWEEN 1 AND 3

--311...Rank employees within each department based on their performance score.

SELECT * FROM (
    SELECT 
        dept_name,
        id,
        first_name,
        last_name,
        salary,
        RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) AS Performance_Rank
    FROM 
        employee_data
) AS A
ORDER BY 
    dept_name, Performance_Rank;

--312...Using DENSE_RANK(), find the top 3 salaries in the company.

SELECT * FROM (
    SELECT 
        dept_name,
        id,
        first_name,
        last_name,
        salary,
        DENSE_RANK() OVER ( ORDER BY salary DESC) AS Salary_Rank
    FROM 
        employee_data
) AS A WHERE Salary_Rank BETWEEN 1 AND 3

--313...Find the first and second highest salary using RANK().

SELECT * FROM (
    SELECT 
        dept_name,
        id,
        first_name,
        last_name,
        salary,
        RANK() OVER ( ORDER BY salary DESC) AS Salary_Rank
    FROM 
        employee_data
) AS A WHERE Salary_Rank BETWEEN 1 AND 2;

--314...Rank all employees based on their salary and return the employee's details with rank = 1.
SELECT TOP 1 * FROM (
    SELECT 
        dept_name,
        id,
        first_name,
        last_name,
        salary,
        DENSE_RANK() OVER ( ORDER BY salary DESC) AS Salary_Rank
    FROM 
        employee_data
) AS A --WHERE Salary_Rank BETWEEN 1 AND 2;

--315...Use ROW_NUMBER() to assign a rank to products based on their quantity sold.

SELECT  * FROM (
    SELECT 
        dept_name,
        id,
        first_name,
        last_name,
        salary,
        ROW_NUMBER() OVER ( PARTITION BY LOCATION ORDER BY salary DESC) AS Salary_Rank
    FROM 
        employee_data
) AS A;

--316...Find the 10 highest-sal products using DENSE_RANK().

SELECT  * FROM (
    SELECT 
        dept_name,
        id,
        first_name,
        last_name,
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS Salary_Rank
    FROM 
        employee_data
) AS A WHERE Salary_Rank = 10

--317...Find all employees with the top 2 ranks based on salary using RANK().

SELECT  * FROM (
    SELECT 
        dept_name,
        id,
        first_name,
        last_name,
        salary,
        RANK() OVER (ORDER BY salary DESC) AS Salary_Rank
    FROM 
        employee_data
) AS A WHERE Salary_Rank = 2;

--318...Use ROW_NUMBER() to rank employees based on their years of experience.
SELECT 
    id,
    first_name,
    last_name,
    hire_date,
    DATEDIFF(YEAR, hire_date, GETDATE()) AS years_of_experience,
    ROW_NUMBER() OVER (ORDER BY DATEDIFF(YEAR, hire_date, GETDATE()) DESC) AS Experience_Rank
FROM 
    employee_data
ORDER BY 
    Experience_Rank;

--319...Find all employees who are tied in the top 3 ranks based on salary using DENSE_RANK().

SELECT * FROM (
SELECT 
first_name,
last_name,
id,
SALARY,
DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RANK_SALARY
FROM employee_data
) AS A WHERE RANK_SALARY BETWEEN 1 AND 2;

--320...Rank employees within each department using ROW_NUMBER().

SELECT * FROM (
SELECT 
id,
first_name,
last_name,
dept_name,
SALARY,
ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY (SELECT NULL) DESC ) AS RANK_SALARY
FROM employee_data
) AS A 

--321...Use DENSE_RANK() to find the highest-paid employee in each department.

SELECT * FROM (
SELECT 
id,
first_name,
last_name,
dept_name,
SALARY,
ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY SALARY DESC ) AS RANK_SALARY
FROM employee_data
) AS A  WHERE RANK_SALARY = 1

--322...Assign ranks to employees within each department based on their salary using RANK().

SELECT * FROM (
SELECT 
id,
first_name,
last_name,
dept_name,
SALARY,
RANK() OVER(PARTITION BY dept_name ORDER BY SALARY DESC ) AS RANK_SALARY
FROM employee_data
) AS A;

--323...Partition employees by department and assign a ROW_NUMBER() based on hire date.

SELECT * FROM (
SELECT 
id,
first_name,
last_name,
dept_name,
hire_date,
SALARY,
ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY hire_date DESC ) AS RANK_SALARY
FROM employee_data
) AS A;

--324...Use RANK() to find employees who have a salary higher than the average salary within their department.

SELECT *
FROM (
    SELECT 
        dept_name,
        id,
        first_name,
        last_name,
        salary,
        AVG(salary) OVER (PARTITION BY dept_name) AS Avg_Department_Salary,
        RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) AS Salary_Rank
    FROM 
        employee_data
) AS ranked_employees
WHERE 
    salary > Avg_Department_Salary
ORDER BY 
    dept_name, Salary_Rank;

SELECT 
    id,
    first_name,
    last_name,
    dept_name,
    salary,
    RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) AS Salary_Rank
FROM 
    employee_data
WHERE 
    salary > (
        SELECT AVG(salary)
        FROM employee_data e
        WHERE e.dept_name = employee_data.dept_name
    );


--325...Use DENSE_RANK() to find employees who are in the top 5 highest-paid employees in each department.

SELECT * FROM(
SELECT id,
    first_name,
    last_name,
    dept_name,
    salary,
DENSE_RANK() OVER(PARTITION BY DEPT_NAME ORDER BY SALARY DESC) AS RANK_SAL_DEPT_WISE
FROM employee_data
) AS A WHERE RANK_SAL_DEPT_WISE BETWEEN 1 AND 5;

--326...Partition products by category and rank them by price using RANK().

/*SELECT 
    category,
    product_id,
    product_name,
    price,
    RANK() OVER (PARTITION BY category ORDER BY price DESC) AS Price_Rank
FROM 
    product_data
ORDER BY 
    category, Price_Rank;
*/

--327...Use ROW_NUMBER() to assign a unique rank to each employee within each department based on their salary.

SELECT * FROM(
SELECT id,
    first_name,
    last_name,
    dept_name,
    salary,
ROW_NUMBER() OVER(PARTITION BY DEPT_NAME ORDER BY SALARY DESC) AS RANK_SAL_DEPT_WISE
FROM employee_data
) AS A ;

--328...Partition students by subject and rank them by their score in descending order.

/*SELECT 
    subject,
    student_id,
    student_name,
    score,
    RANK() OVER (PARTITION BY subject ORDER BY score DESC) AS Score_Rank
FROM 
    student_data
ORDER BY 
    subject, Score_Rank;
*/

--329...Use DENSE_RANK() to rank employees by salary within each department, and break ties with hire date.

SELECT 
    dept_name,
    id,
    first_name,
    last_name,
    salary,
    hire_date,
    DENSE_RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC, hire_date ASC) AS Salary_Rank
FROM 
    employee_data
ORDER BY 
    dept_name, Salary_Rank;

--330...Rank employees by their performance score within each department using ROW_NUMBER().

SELECT 
    dept_name,
    id,
    first_name,
    last_name,
    salary,
    hire_date,
    ROW_NUMBER() OVER (PARTITION BY dept_name ORDER BY salary DESC) AS Salary_Rank
FROM 
    employee_data
ORDER BY 
    dept_name, Salary_Rank;
--331...Partition employees by department and order them by joining date using RANK().

SELECT 
    dept_name,
    id,
    first_name,
    last_name,
    salary,
    hire_date,
    RANK() OVER (PARTITION BY dept_name ORDER BY hire_date DESC) AS Salary_Rank
FROM 
    employee_data
ORDER BY 
    dept_name, Salary_Rank;

--332...Use ROW_NUMBER() to rank orders by total value within each customer.
/*SELECT 
    customer_id,
    order_id,
    total_value,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY total_value DESC) AS Order_Rank
FROM 
    orders_data
ORDER BY 
    customer_id, Order_Rank;
*/

--333...Rank the top 3 employees in each department by their salary using RANK().
SELECT * FROM(SELECT 
    dept_name,
    id,
    first_name,
    last_name,
    salary,
    hire_date,
    RANK() OVER (PARTITION BY dept_name ORDER BY hire_date DESC) AS Salary_Rank
FROM  employee_data) AS A
	WHERE Salary_Rank BETWEEN 1 AND 3
ORDER BY 
    dept_name, Salary_Rank;

--334...Partition products by category and rank them based on sales quantity using DENSE_RANK().

/*SELECT 
    category,
    product_id,
    product_name,
    sales_quantity,
    DENSE_RANK() OVER (PARTITION BY category ORDER BY sales_quantity DESC) AS Sales_Rank
FROM 
    product_data
ORDER BY 
    category, Sales_Rank;
*/
--325...Get the first hired employee in the company.

SELECT 
    id,
    first_name,
    last_name,
    full_name,
    hire_date,
    FIRST_VALUE(id) OVER (ORDER BY hire_date ASC) AS First_Hired_Employee_ID,
    FIRST_VALUE(first_name) OVER (ORDER BY hire_date ASC) AS First_Hired_First_Name,
    FIRST_VALUE(last_name) OVER (ORDER BY hire_date ASC) AS First_Hired_Last_Name,
    FIRST_VALUE(hire_date) OVER (ORDER BY hire_date ASC) AS First_Hired_Date,
	    LAST_VALUE(id) OVER (ORDER BY hire_date ASC) AS LAST_First_Hired_Employee_ID,
    LAST_VALUE(first_name) OVER (ORDER BY hire_date ASC) AS LAST_First_Hired_First_Name,
    LAST_VALUE(last_name) OVER (ORDER BY hire_date ASC) AS LAST_First_Hired_Last_Name,
    LAST_VALUE(hire_date) OVER (ORDER BY hire_date ASC) AS LAST_First_Hired_Date
FROM 
    employee_data
ORDER BY 
    hire_date ASC;

--326...Get the first hired employee within each dept_name.

SELECT 
id,
    first_name,
    last_name,
    full_name,
    hire_date,
	dept_name,
		FIRST_VALUE(first_name) OVER(PARTITION BY dept_name ORDER BY hire_date DESC ) AS FIRST_DEPT_WISE_HIRED_N,
	FIRST_VALUE(last_name) OVER(PARTITION BY dept_name ORDER BY hire_date DESC ) AS FIRST_DEPT_WISE_HIRED_LN,
		FIRST_VALUE(dept_name) OVER(PARTITION BY dept_name ORDER BY hire_date DESC ) AS FIRST_DEPT_WISE_HIRED_DN,
	FIRST_VALUE(hire_date) OVER(PARTITION BY dept_name ORDER BY hire_date DESC ) AS FIRST_DEPT_WISE_HIRED_HR
FROM 
    employee_data;

--327...Get the first employee in each location based on hire_date.
SELECT 
    location,
    id,
    first_name,
    last_name,
    hire_date,
    FIRST_VALUE(id) OVER (PARTITION BY location ORDER BY hire_date ASC) AS First_Employee_ID,
    FIRST_VALUE(first_name) OVER (PARTITION BY location ORDER BY hire_date ASC) AS First_Employee_First_Name,
    FIRST_VALUE(last_name) OVER (PARTITION BY location ORDER BY hire_date ASC) AS First_Employee_Last_Name,
    FIRST_VALUE(hire_date) OVER (PARTITION BY location ORDER BY hire_date ASC) AS First_Employee_Hire_Date
FROM 
    employee_data
ORDER BY 
    location, hire_date ASC;

--328...Find the first employee by salary within each dept_id.


SELECT 
    dept_id,
    id,
    first_name,
    last_name,
    salary,
    FIRST_VALUE(id) OVER (PARTITION BY dept_id ORDER BY salary DESC) AS First_Employee_By_Salary_ID,
    FIRST_VALUE(first_name) OVER (PARTITION BY dept_id ORDER BY salary DESC) AS First_Employee_By_Salary_First_Name,
    FIRST_VALUE(last_name) OVER (PARTITION BY dept_id ORDER BY salary DESC) AS First_Employee_By_Salary_Last_Name,
    FIRST_VALUE(salary) OVER (PARTITION BY dept_id ORDER BY salary DESC) AS First_Employee_By_Salary_Salary
FROM 
    employee_data
ORDER BY 
    dept_id, salary DESC;

--329...Retrieve the earliest dob in the company.
SELECT 
    id,
    first_name,
    last_name,
    dob,
    FIRST_VALUE(id) OVER (ORDER BY dob ASC) AS Earliest_DOB_Employee_ID,
    FIRST_VALUE(first_name) OVER (ORDER BY dob ASC) AS Earliest_DOB_Employee_First_Name,
    FIRST_VALUE(last_name) OVER (ORDER BY dob ASC) AS Earliest_DOB_Employee_Last_Name,
    FIRST_VALUE(dob) OVER (ORDER BY dob ASC) AS Earliest_DOB
FROM 
    employee_data
ORDER BY 
    dob ASC;

--330...Create a pivot table showing total salary by dept_name and location.

SELECT 
    *  
FROM 
    (SELECT 
        dept_name,
        location,
        salary
    FROM 
        employee_data) AS SourceTable
PIVOT
    (SUM(salary) FOR location IN ([West Barbarashire], [New Amy], [Lake Austinstad])) AS PivotTable;

--331...Pivot employee counts by dept_name and location.
SELECT 
    *  
FROM 
    (SELECT 
        dept_name,
        location,
		ID
    FROM 
        employee_data) AS SourceTable
PIVOT
(COUNT(ID) FOR location IN ([West Barbarashire], [New Amy], [Lake Austinstad])) AS PivotTable ;

--332..Pivot salary totals by dept_name and hire_date (yearly view).

SELECT 
    *  
FROM 
    (SELECT 
        dept_name,
YEAR(hire_date) AS hire_year,
salary
    FROM 
        employee_data) AS SourceTable
PIVOT
(SUM(salary) FOR hire_year IN ([2023], [2024], [2025])) AS PivotTable

--333...Pivot average salary by location and dept_name.

SELECT 
    *  
FROM 
    (SELECT 
        dept_name,
location,
salary
    FROM 
        employee_data) AS SourceTable
PIVOT
(AVG(salary) FOR location IN ([West Barbarashire], [New Amy], [Lake Austinstad])) AS PivotTable;

--334...Pivot total salary by dept_name, splitting into genders (if gender exists).
/*
SELECT 
    dept_name,
    [Male],  
    [Female]  
FROM 
    (SELECT 
        dept_name,
        gender,  -- Assuming there's a gender column
        salary
    FROM 
        employee_data) AS SourceTable
PIVOT
    (SUM(salary) FOR gender IN ([Male], [Female])) AS PivotTable; */

--335...Unpivot salary and hire_date into a key-value pair for each employee.

SELECT 
    *
FROM 
    (SELECT 
        id,
        salary,
        hire_date
    FROM 
        employee_data) AS SourceTable
UNPIVOT
    (SALES FOR Attribute IN (salary, hire_date)) AS UnpivotTable;
----------------------------------------------------------------------------------------------------------------------------
/*	USE for_me
		SELECT * FROM  table_pivot

SELECT * FROM table_pivot   ----ROW COVERT INTO  COLUMN
PIVOT
(SUM(SALES) FOR Quarter IN ([Q1],[Q2],[Q3],[Q4])) AS TABLE_NAME

			SELECT * FROM 	table_unoivot
SELECT * FROM 	table_unoivot  --- COLUMN CONVERT INTO ROW
UNPIVOT
(
SALES FOR Quarter IN ([Q1],[Q2],[Q3],[Q4])
) AS TABLE_NAME;*/

----------------------------------------------------------------------------------------------------------------------------

--336...Find the salary of the next highest-paid employee for each employee.


SELECT 
    id,
    first_name,
    last_name,
    salary,
    LEAD(salary,1,0) OVER (ORDER BY salary DESC) AS next_highest_salary,
	    LAG(salary,1,0) OVER (ORDER BY salary DESC) AS LAST_highest_salary

FROM 
    employee_data;

--337...Retrieve the hire date of the next employee hired after each employee, ordered by hire_date.

SELECT 
    id,
    first_name,
    last_name,
    hire_date,
    LEAD(hire_date, 1) OVER (ORDER BY hire_date) AS next_hire_date
FROM 
    employee_data;

--338...Get the dept_id of the next employee within the same dept_name, ordered by hire_date.

SELECT 
    id,
    first_name,
    last_name,
    dept_name,
    dept_id,
    hire_date,
    LEAD(dept_id, 1) OVER (PARTITION BY dept_name ORDER BY hire_date) AS next_dept_id
FROM 
    employee_data;

--339...Find the next employee's location for each employee, ordered by location and salary.

SELECT 
    id,
    first_name,
    last_name,
    location,
    salary,
    LEAD(location, 1) OVER (ORDER BY location, salary DESC) AS next_location
FROM 
    employee_data;

---340...Calculate the difference between an employee's salary and the next employee's salary.
SELECT 
    id,
    first_name,
    last_name,
    salary,
    LEAD(salary, 1) OVER (ORDER BY salary DESC) AS next_salary,
    salary - LEAD(salary, 1) OVER (ORDER BY salary DESC) AS salary_difference
FROM 
    employee_data;

--341...Calculate the difference between an employee's salary and the previous employee's salary.

SELECT 
    id,
    first_name,
    last_name,
    salary,
    LAG(salary, 1) OVER (ORDER BY salary DESC) AS next_salary,
    salary - LAG(salary, 1) OVER (ORDER BY salary DESC) AS salary_difference
FROM 
    employee_data;

--342...Find the employee who was hired immediately before and after each employee, along with their hire dates.

SELECT 
    id,
    first_name,
    last_name,
    hire_date,
    LAG(id, 1) OVER (ORDER BY hire_date) AS previous_employee_id,
    LAG(hire_date, 1) OVER (ORDER BY hire_date) AS previous_hire_date,
    LEAD(id, 1) OVER (ORDER BY hire_date) AS next_employee_id,
    LEAD(hire_date, 1) OVER (ORDER BY hire_date) AS next_hire_date
FROM 
    employee_data;

---343...Compare the hire date difference between the current employee and the next employee.

SELECT 
    id,
    first_name,
    last_name,
    hire_date,
    LEAD(hire_date, 1) OVER (ORDER BY hire_date) AS next_hire_date,
    DATEDIFF(DAY, hire_date, LEAD(hire_date, 1) OVER (ORDER BY hire_date)) AS hire_date_difference
FROM 
    employee_data ORDER BY hire_date_difference DESC;

--343...Retrieve the previous and next employees' full_name for each employee, ordered by hire_date.

SELECT 
    id,
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name,
    LAG(CONCAT(first_name, ' ', last_name), 1) OVER (ORDER BY hire_date) AS previous_full_name,
    LEAD(CONCAT(first_name, ' ', last_name), 1) OVER (ORDER BY hire_date) AS next_full_name
FROM 
    employee_data;

---OPERATOR---

--344...Retrieve all employees who have either first_name as "John" or "Jane".

SELECT * FROM employee_data WHERE first_name IN ('John','Jane') 

--345...Get all distinct employee details based on dept_name and salary.

SELECT distinct dept_name, salary FROM employee_data 

--346...Retrieve all employees who are either from the "Sales" department or have a salary greater than $50,000.

SELECT * FROM employee_data WHERE dept_name = 'Sales' and salary > 50000;

--347...List employees who work in both the "Marketing" department and the "Sales" department.

SELECT * FROM employee_data WHERE dept_name = 'Marketing' and dept_name = 'Sales';

SELECT *
FROM employee_data
WHERE dept_name = 'Marketing'
AND id IN (
    SELECT id
    FROM employee_data
    WHERE dept_name = 'Sales'
);

--348...Retrieve the employees who work in the "HR" department but not in the "Finance" department.

SELECT * FROM employee_data WHERE dept_name = 'HR' and dept_name != 'Finance';

SELECT * FROM employee_data
WHERE dept_name = 'HR' and ID NOT IN (SELECT id
    FROM employee_data
    WHERE dept_name = 'Finance')

--349...Get the employees who were hired in 2023 and also earn a salary of more than $70,000.

SELECT * FROM employee_data WHERE YEAR(hire_date) = 2023 AND salary > 70000;

--350...Retrieve all employees who either work in the "IT" department or have the first name "Michael".

SELECT * FROM employee_data WHERE dept_name = 'IT' AND first_name = 'Michael';

--351...Get the employees who are in the "Accounting" department but not in the "Finance" department.

SELECT * FROM employee_data WHERE dept_name = 'Accounting' AND dept_name <> 'Finance';

SELECT * FROM employee_data WHERE dept_name = 'Accounting' AND ID NOT IN 
(SELECT ID FROM employee_data WHERE dept_name = 'Finance');


--352...List all employees who work in the "IT" department or have a mobile number starting with "+1".

SELECT * FROM employee_data WHERE dept_name = 'IT' OR mobile_no LIKE '+1';

--353...Retrieve the employees who have been hired before 2020 or have a salary higher than $80,000.

SELECT * FROM employee_data WHERE YEAR(hire_date) < 2020 OR salary > 80000;

--354...Get the employees who have either a "Manager" title or have been with the company for more than 5 years.

SELECT *
FROM employee_data
WHERE 
    full_name LIKE '%Manager%'
    OR DATEDIFF(YEAR, hire_date, GETDATE()) > 5;

--355...Retrieve employees who have worked for more than 3 years or have a location in "California".

SELECT *
FROM employee_data
WHERE DATEDIFF(YEAR,hire_date,GETDATE()) > 3 OR location = 'California';

--356...List all employees who are either from the "Marketing" department or have the email "john@example.com".

SELECT *
FROM employee_data
WHERE dept_name = 'Marketing' OR email = 'john@example.com';

--357...Retrieve all employees who are either older than 30 or earn more than $60,000.

SELECT *
FROM employee_data
WHERE DATEDIFF(YEAR,DOB,GETDATE()) > 30 OR salary > 60000;

--358...Get employees who work in the "Finance" department or were hired in 2019.

SELECT *
FROM employee_data
WHERE dept_name = 'Finance' OR YEAR(hire_date) = 2019;

--359...List all employees who have either a salary higher than $90,000 or have been hired after 2020.

SELECT *
FROM employee_data
WHERE salary > 90000 OR YEAR(hire_date) = 2020;

--360...Retrieve all employees who are older than 35 and live in "New York".

SELECT *
FROM employee_data
WHERE DATEDIFF(YEAR,DOB,GETDATE()) > 35 AND location = 'New York';

--361...Find employees who are either located in "Texas" or have a "Manager" role.

SELECT * 
FROM employee_data
WHERE location = 'Texas' OR full_name LIKE'%Manager%';

--362...Retrieve all employees who either belong to the "Sales" department or have the first name "Anna".

SELECT * 
FROM employee_data
WHERE dept_name = 'Sales' OR first_name = 'Anna';

--363...Get all employees who work either in "HR" or "Sales" departments but not both.

SELECT id, first_name, last_name, dept_name
FROM employee_data
WHERE 
    (dept_name = 'HR' AND id NOT IN (
        SELECT id 
        FROM employee_data 
        WHERE dept_name = 'Sales'
    ))
    OR
    (dept_name = 'Sales' AND id NOT IN (
        SELECT id 
        FROM employee_data 
        WHERE dept_name = 'HR'
    ));

----------------------------------------------
-- Employees in HR but not in Sales
SELECT id, first_name, last_name, dept_name
FROM employee_data
WHERE dept_name = 'HR'

EXCEPT

-- Employees in Sales but not in HR
SELECT id, first_name, last_name, dept_name
FROM employee_data
WHERE dept_name = 'Sales'

UNION

-- Employees in Sales but not in HR
SELECT id, first_name, last_name, dept_name
FROM employee_data
WHERE dept_name = 'Sales'

EXCEPT

-- Employees in HR but not in Sales
SELECT id, first_name, last_name, dept_name
FROM employee_data
WHERE dept_name = 'HR';

--364...List employees who were hired after 2020 or who have a salary higher than $65,000.

SELECT * 
FROM employee_data
WHERE YEAR(hire_date) > 2020 OR salary > 65000;

--365...Retrieve all employees who either live in "California" or have a mobile number starting with "+1".

SELECT * 
FROM employee_data
WHERE location = 'California' OR mobile_no LIKE '+1%';

--365...Get all employees who work in "Finance" but do not belong to "HR".

SELECT *
FROM employee_data
WHERE 
    dept_name = 'Finance' 
    AND id NOT IN (
        SELECT id 
        FROM employee_data 
        WHERE dept_name = 'HR'
    );

--366...Retrieve employees who have been hired between 2018 and 2022 and are from the "IT" department.

SELECT *
FROM employee_data
WHERE (YEAR(hire_date) BETWEEN 2018 AND 2020) AND dept_name = 'IT';

--367...List all employees who are either from the "HR" department or have the email "alice@example.com".

SELECT *
FROM employee_data
WHERE dept_name = 'HR' OR email = 'alice@example.com';

--368...Retrieve all employees who either have a "Director" title or are from the "Marketing" department.

SELECT *
FROM employee_data
WHERE 
    full_name LIKE '%Director%'
    OR dept_name = 'Marketing';

--369...Get all employees who are either older than 25 and have a salary of more than $40,000 or are located in "Texas".

SELECT * 
FROM employee_data
WHERE (DATEDIFF(YEAR,DOB,GETDATE()) > 25 AND salary > 40000) OR location = 'Texas';

--370...List employees who have been hired in 2020 or 2021 but do not belong to the "Sales" department.

SELECT * FROM employee_data
WHERE (YEAR(hire_date) BETWEEN 2020 AND 2021) AND ID NOT IN 
(SELECT ID FROM employee_data WHERE dept_name = 'Sales');

SELECT * FROM employee_data
WHERE YEAR(hire_date) IN (2020 , 2021) AND 
 dept_name != 'Sales';

 --371...Retrieve all employees who work in the "Marketing" department and have a salary greater than $50,000.

 SELECT * FROM 
 employee_data WHERE dept_name = 'Marketing' AND salary > 50000;

--372...List employees who either belong to the "IT" department or are from "California".

 SELECT * FROM 
 employee_data WHERE dept_name = 'IT' OR location ='California';

--373...Get the employees who either live in "New York" or have the title "Manager".

SELECT * FROM employee_data
WHERE location = 'New York' OR full_name LIKE '%Manager%';

--374...Retrieve employees who are in the "Sales" department and were hired before 2021.

SELECT * FROM employee_data
WHERE dept_name = 'Sales' AND YEAR(hire_date) < 2021;

--375...Find employees who were hired after 2019 or have a salary higher than $70,000.

SELECT * FROM employee_data
WHERE YEAR(hire_date) > 2019 OR salary >70000;

--376...Retrieve employees who work in both "Marketing" and "Sales" departments.

SELECT * FROM employee_data
WHERE dept_name IN ('Marketing','Sales');
--------------------
SELECT id, first_name, last_name
FROM employee_data
WHERE id IN (
    SELECT id
    FROM employee_data
    WHERE dept_name = 'Marketing'
)
INTERSECT
SELECT id, first_name, last_name
FROM employee_data
WHERE id IN (
    SELECT id
    FROM employee_data
    WHERE dept_name = 'Sales'
);

--377...List employees who are in the "HR" department and live in "New York".

SELECT * FROM employee_data
WHERE dept_name = 'HR' AND location = 'New York';

--378...Get employees who are either from "Texas" or have a salary of more than $55,000.

SELECT * FROM employee_data
WHERE location = 'Texas' OR salary > 55000;

--379...Retrieve employees who were hired between 2020 and 2023 and are from the "IT" department.

SELECT * FROM employee_data
WHERE (YEAR(hire_date) BETWEEN 2020 AND 20203) AND dept_name = 'IT';

--380...Get employees who either work in "Accounting" or are older than 30.

SELECT * FROM employee_data
WHERE dept_name = 'Accounting' OR DATEDIFF(YEAR,DOB,GETDATE()) > 30;

--381...List all employees who have a salary above $80,000 and work in "Finance" or "Sales".

SELECT * FROM employee_data
WHERE salary > 80000 AND dept_name IN ('Finance','Sales');

--382...Retrieve employees who either work in the "IT" department or have a mobile number starting with "+44".

SELECT * FROM employee_data
WHERE dept_name = 'IT' OR mobile_no LIKE '+44%';

--383...List employees who belong to "Sales" and are either older than 30 or have a salary higher than $60,000.

SELECT* FROM employee_data
WHERE dept_name = 'Sales' AND DATEDIFF(YEAR,DOB,GETDATE()) > 30 OR salary > 60000;

--384...Get all employees who are older than 40 or belong to the "Marketing" department.

SELECT* FROM employee_data
WHERE dept_name = 'Marketing' OR DATEDIFF(YEAR,DOB,GETDATE()) > 40;

--385...Retrieve employees who are located in "Texas" and either have the first name "John" or "Jane".

SELECT * FROM employee_data
WHERE location = 'Texas' AND first_name IN('John','Jane');

--386...Find employees who either have a salary higher than $50,000 or work in the "HR" department.

SELECT * FROM employee_data
WHERE salary > 50000 OR dept_name = 'HR';

--387...Get employees who work in "Sales" and have a mobile number starting with "+1".

SELECT * FROM employee_data
WHERE dept_name = 'Sales' AND mobile_no LIKE '+1%';

--388...Retrieve employees who work in the "Finance" department but do not have a salary higher than $70,000.

SELECT  * FROM employee_data
WHERE dept_name = 'Finance' AND salary < 70000;

--389...List employees who have been hired between 2019 and 2022 and live in "New York".

SELECT * FROM employee_data
WHERE YEAR(hire_date) BETWEEN 2019 AND 2022 AND location = 'New York';

--390...Get all employees who have either been hired after 2021 or belong to "Sales".

SELECT * FROM  employee_data
WHERE YEAR(hire_date) > 2021 OR dept_name = 'Sales';

--391...Retrieve employees who are in the "HR" department but are not located in "California".

SELECT * FROM employee_data
WHERE dept_name = 'HR' AND location != 'California';

--392...List employees who belong to the "IT" department and either have a salary higher than $80,000 or are from "New York".

SELECT * FROM employee_data
WHERE dept_name = 'IT' AND salary > 80000 OR location = 'New York';

--393...Retrieve all employees who belong to the "Marketing" department or have a salary lower than $45,000.

SELECT * FROM employee_data
WHERE dept_name = 'Marketing' OR salary < 45000;

--394...Get the employees who belong to "Sales" or are older than 35 years.

SELECT * FROM employee_data
WHERE dept_name = 'Sales' OR DATEDIFF(YEAR,DOB,GETDATE()) > 35;

--395...Retrieve employees who either have a salary higher than $65,000 or work in "Accounting".

SELECT * FROM employee_data 
WHERE salary > 65000 OR dept_name = 'Accounting';

--396...Find all employees who belong to both "HR" and "Finance".

SELECT id, first_name, last_name, dept_name FROM employee_data WHERE dept_name = 'HR' 
INTERSECT
SELECT id, first_name, last_name, dept_name FROM employee_data WHERE dept_name = 'Finance';

------------------------------

SELECT id, first_name, last_name, dept_name
FROM employee_data
WHERE id IN (
    SELECT id
    FROM employee_data
    WHERE dept_name = 'HR'
)
AND id IN (
    SELECT id
    FROM employee_data
    WHERE dept_name = 'Finance'
);

--397...Retrieve employees who work in "Sales" but not in "HR".

SELECT * FROM employee_data
WHERE dept_name = 'Sales' AND ID NOT IN (SELECT ID FROM employee_data WHERE dept_name = 'HR');

--398...Get all employees who belong to "Finance" or were hired before 2020.

SELECT * FROM employee_data
WHERE dept_name = 'Finance' OR YEAR(hire_date) < 2020;

--399...Retrieve employees who work in the "Marketing" department and are older than 25 years.

SELECT * FROM employee_data
WHERE dept_name = 'Marketing' AND DATEDIFF(YEAR,DOB,GETDATE()) > 25;

--400...List employees who have a salary higher than $60,000 or belong to "Accounting".

SELECT * FROM employee_data
WHERE salary > 60000 OR dept_name = 'Accounting';

--401...Get employees who either work in "IT" or live in "Texas".

SELECT  * FROM employee_data
WHERE dept_name = 'IT' OR location = 'Texas';

--402...Retrieve all employees who work in the "HR" department or are located in "New York".

SELECT * FROM employee_data
WHERE dept_name = 'HR' OR location = 'New York';

--403...Find employees who work in the "Sales" department or have the first name "Emily".

SELECT * FROM employee_data
WHERE dept_name = 'Sales' OR first_name = 'Emily';

--404...Retrieve employees who belong to "Finance" and have a salary higher than $70,000.

SELECT * FROM employee_data
WHERE dept_name = 'Finance' AND salary > 70000;

--405...Get all employees who either have a salary lower than $50,000 or belong to the "Marketing" department.

SELECT * FROM employee_data
WHERE salary > 50000 OR dept_name = 'Marketing';

--406...List employees who belong to the "HR" department or are located in "California".

SELECT * FROM employee_data
WHERE dept_name='HR' OR location = 'California';

--407...Retrieve employees who belong to the "IT" department and live in "Texas".

SELECT * FROM employee_data
WHERE dept_name = 'IT' AND location = 'Texas';

--408...Get all employees who either have a mobile number starting with "+44" or belong to the "Accounting" department.

SELECT * FROM employee_data
WHERE mobile_no LIKE '+44%' OR dept_name = 'Accounting';

--409...Retrieve employees who have a salary higher than $90,000 or belong to the "Finance" department.

SELECT * FROM employee_data
WHERE salary > 90000 OR dept_name = 'Finance';

--410...List employees who are older than 30 and belong to the "Sales" department.

SELECT * FROM employee_data
WHERE DATEDIFF(YEAR,DOB,GETDATE()) > 30 AND dept_name = 'Sales';

--411...Get employees who are located in "New York" and have a mobile number starting with "+1".

SELECT * FROM employee_data
WHERE location = 'New York' AND mobile_no LIKE '+1%';

--412...Retrieve all employees who are either older than 40 or work in "IT".

SELECT * FROM employee_data
WHERE DATEDIFF(YEAR,DOB,GETDATE()) > 40 OR dept_name ='IT';

--413...List employees who belong to "HR" or have been hired before 2020.

SELECT * FROM employee_data
WHERE dept_name = 'HR' OR YEAR(hire_date) < 2020;

--414...Retrieve all employees who have been hired between 2018 and 2022 and live in "New York".

SELECT * FROM employee_data
WHERE (YEAR(hire_date) BETWEEN 2018 AND 2022) AND location = 'New York';

--415...Get employees who either belong to "Accounting" or live in "California".

SELECT * FROM employee_data
WHERE dept_name = 'Accounting' OR location = 'California';

--416...List employees who belong to the "Sales" department or have been hired before 2019.

SELECT * FROM employee_data
WHERE dept_name = 'Sales' OR YEAR(hire_date) < 2019;

--417...Retrieve employees who have either been hired in 2021 or belong to "IT".

SELECT * FROM employee_data
WHERE YEAR(hire_date) = 2021 OR dept_name = 'IT';

--418...Find employees who have a salary higher than $60,000 or work in "HR".

SELECT * FROM employee_data
WHERE salary > 60000 OR dept_name = 'HR';

--419...Retrieve employees who belong to the "Accounting" department or work in "Marketing".

SELECT *
FROM employee_data
WHERE dept_name = 'Accounting'
OR dept_name = 'Marketing';

--420...Get all employees who belong to the "Sales" department and are older than 30.

SELECT *
FROM employee_data WHERE dept_name = 'Sales' AND DATEDIFF(YEAR,DOB,GETDATE()) > 30;

--421...List employees who belong to both "HR" and "Finance" departments.

SELECT * FROM employee_data
WHERE dept_name = 'HR' AND ID IN 
(SELECT ID FROM  employee_data WHERE dept_name = 'Finance');

--422...Retrieve the full name of employees from two different departments (combine them using UNION).

SELECT full_name FROM employee_data WHERE dept_name = 'Finance'
UNION
SELECT full_name FROM employee_data WHERE dept_name = 'HR';

--423...Retrieve all employee names and their salaries, and then combine employees from two different departments using UNION ALL.


SELECT salary FROM employee_data WHERE dept_name = 'Finance'
UNION ALL
SELECT salary FROM employee_data WHERE dept_name = 'HR';

--424...List all employees whose first name is "John" or "Jane", and combine the result with those whose location is "New York" using UNION.

SELECT first_name,last_name FROM employee_data WHERE first_name IN('John','Jane')
UNION
SELECT first_name,last_name FROM employee_data WHERE location = 'New York';

--425...Retrieve all employees who have "Manager" as their job title and those who earn above $50,000, combining both using UNION ALL.

SELECT first_name,last_name FROM employee_data WHERE full_name LIKE '%Manager%'
UNION ALL
SELECT first_name,last_name FROM employee_data WHERE salary > 50000;

--426...Combine the names of all employees and their department names, sorted by department name using UNION.

SELECT dept_name FROM employee_data
UNION
SELECT dept_name FROM employee_data;

--427...List the employees' first names from "Sales" department, and combine them with the employees' first names from "HR" using UNION.

SELECT first_name FROM employee_data WHERE dept_name = 'Sales'
UNION
SELECT first_name FROM employee_data WHERE dept_name = 'HR';

--428...Retrieve the names and salaries of employees from the "Marketing" department, and combine them with employees from the "Finance" department using UNION ALL.

SELECT salary FROM employee_data WHERE dept_name = 'Marketing'
UNION ALL
SELECT salary FROM employee_data WHERE dept_name = 'Finance';

--429...List all employees’ first and last names who live in either "London" or "Berlin", using UNION.


SELECT first_name,last_name FROM employee_data WHERE location = 'London'
UNION 
SELECT first_name,last_name FROM employee_data WHERE location = 'Berlin';

--430...Retrieve the location of all employees who have been hired before 2020 and combine with the employees hired in 2021 using UNION.

select location from employee_data WHERE YEAR(hire_date) < 2020
UNION
select location from employee_data WHERE YEAR(hire_date) = 2021;

--431...List the first and last names of employees who have been hired after 2020, and those who have more than 10 years of experience using UNION ALL.

SELECT first_name,last_name FROM employee_data WHERE YEAR(hire_date) > 2020
UNION ALL
SELECT first_name,last_name FROM employee_data WHERE DATEDIFF(YEAR,DOB,GETDATE()) > 10;

--432...Retrieve all employees who are from the "New York" location or have salaries above $60,000 using UNION.

SELECT first_name,last_name FROM employee_data WHERE location = 'New York'
UNION ALL
SELECT first_name,last_name FROM employee_data WHERE salary > 60000;

--433...Retrieve all employees' mobile numbers, and combine it with their email addresses using UNION ALL.

SELECT mobile_no AS CONTACT_INFO FROM employee_data
UNION ALL
SELECT email AS CONTACT_INFO FROM employee_data;

--434...Retrieve all employees’ first names from departments "HR", "Finance", and "IT", using UNION.

SELECT full_name FROM employee_data WHERE dept_name = 'HR'
UNION
SELECT full_name FROM employee_data WHERE dept_name = 'Finance'
UNION
SELECT full_name FROM employee_data WHERE dept_name = 'IT';

--435...Get employees who were hired after 2015, and combine them with those who have salaries above $80,000 using UNION.

SELECT full_name FROM employee_data WHERE YEAR(hire_date) > 2015
UNION
SELECT full_name FROM employee_data WHERE salary > 80000;

--436...Retrieve all employees from the "Sales" department and their hire dates, then combine with employees from "Marketing" department using UNION.

SELECT full_name FROM employee_data WHERE dept_name = 'Sales'
UNION
SELECT full_name FROM employee_data WHERE dept_name = 'Marketing'; 

--437...Retrieve the salary and department name of employees who are from either "Finance" or "IT" departments using UNION ALL.

SELECT dept_id,salary FROM employee_data WHERE dept_name = 'Finance'
UNION ALL
SELECT dept_id,salary FROM employee_data WHERE dept_name = 'IT'; 

--438...Retrieve all employees whose first name starts with "A" and their location, and combine with employees whose first name starts with "J" using UNION.

SELECT location FROM employee_data WHERE first_name LIKE 'A%'
UNION 
SELECT location FROM employee_data WHERE first_name LIKE 'J%'; 

--439...List employees who are in "London" or "New York" locations and their hire dates, combining them with those whose salary is above $100,000 using UNION.

SELECT id,first_name,last_name FROM employee_data WHERE location IN ('London','New York')
UNION 
SELECT id,first_name,last_name FROM employee_data WHERE salary > 100000;

--440...Retrieve employee names and salaries from "HR" and "IT" departments and combine them using UNION ALL.

SELECT id,first_name,last_name,salary FROM employee_data WHERE dept_name = 'HR'
UNION ALL
SELECT id,first_name,last_name,salary FROM employee_data WHERE dept_name = 'IT';

--441...Retrieve all employees' email addresses, and combine them with the employees who have mobile numbers starting with "5" using UNION.

SELECT email FROM employee_data
UNION
SELECT mobile_no FROM employee_data WHERE mobile_no LIKE '5%';

--442..Retrieve all employees from the "Finance" and "Sales" departments and their salaries, then combine with those from "Marketing" department using UNION ALL.

SELECT id,first_name,last_name,salary FROM employee_data WHERE dept_name IN ('Finance','Sales')
UNION ALL
SELECT id,first_name,last_name,salary FROM employee_data WHERE dept_name = 'Marketing';

--443...Combine the employees’ hire date and department name from the "Tech" and "HR" departments using UNION.

SELECT hire_date,dept_name FROM employee_data WHERE dept_name IN ('Tech')
UNION 
SELECT hire_date,dept_name FROM employee_data WHERE dept_name = 'HR';

--444...Retrieve the location of employees from "Berlin" and combine them with those hired after 2018 using UNION ALL.

SELECT full_name FROM employee_data WHERE location IN ('Berlin')
UNION ALL
SELECT full_name FROM employee_data WHERE YEAR(hire_date) > 2018;

--446...Retrieve the first and last names of employees who have salary greater than $70,000, combining with employees whose hire date is before 2019 using UNION.

SELECT first_name,last_name FROM employee_data WHERE salary > 70000
UNION
SELECT first_name,last_name FROM employee_data WHERE YEAR(hire_date) < 2019;

--447...Retrieve employees who are in both the "Sales" and "Marketing" departments using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Sales'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Marketing';

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Marketing' AND ID IN ( SELECT ID FROM employee_data WHERE  dept_name='Sales');

--448...List the names of employees who are in both "Finance" and "IT" departments using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Finance'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'IT';

--449..Retrieve the first names of employees whose salary is greater than $60,000 and who have been hired after 2015, using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE salary > 60000
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) > 2015;

--450...Retrieve the full names of employees who live in both "New York" and "Los Angeles" using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE location = 'New York'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE location = 'Los Angeles';

--451...Get employees who have both "Manager" as their job title and are in the "HR" department using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE full_name LIKE '%Manager%'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'HR';

--452...Retrieve all employees who have worked in both the "Tech" and "Sales" departments using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Tech'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Sales';

--453...Get the first and last names of employees who have salaries higher than $80,000 and work in either "Sales" or "Finance" departments, using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE salary > 80000
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE dept_name IN ( 'Sales','Finance');

--454...Retrieve the first names of employees who are from both "New York" and "Los Angeles" locations using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE location = 'New York'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE location = 'Los Angeles';

--455...Get employees who have both a salary greater than $50,000 and a hire date before 2020, using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE salary >50000 AND YEAR(hire_date) < 2020
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) < 2020;

--456...Retrieve employees whose mobile number starts with "5" and whose hire date is before 2015 using INTERSECT.

SELECT * FROM employee_data WHERE mobile_no LIKE '5%'
INTERSECT
SELECT * FROM employee_data WHERE YEAR(hire_date) < 2015;

--457...Retrieve employees who have both a salary above $70,000 and were hired in 2018 using INTERSECT.

SELECT * FROM employee_data WHERE salary > 70000
INTERSECT
SELECT * FROM employee_data WHERE YEAR(hire_date) < 2018;

--458...List employees who have both been hired after 2015 and have a mobile number starting with "1", using INTERSECT.

SELECT * FROM employee_data WHERE YEAR(hire_date) < 2015
INTERSECT
SELECT * FROM employee_data WHERE mobile_no LIKE '1%' ;

--459...Retrieve the names of employees who work in both the "Sales" and "Finance" departments using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Sales'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Finance' ;

--460...Retrieve the names and locations of employees who are located in both "London" and "New York" using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE location = 'London'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE location = 'New York';

--461...Retrieve employees from both the "Finance" and "HR" departments using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Finance'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'HR';

--462...Get employees who have both a salary above $90,000 and have been hired after 2018, using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE salary > 90000
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) > 2018;

--463...Retrieve the names of employees whose first name starts with "A" and whose last name starts with "B", using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE first_name LIKE 'A%'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE last_name LIKE 'B%';

--464...List employees who are in both the "Sales" department and whose hire date is before 2017, using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE dept_name  = 'Sales'
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) < 2017;

--465...Retrieve all employees who have a salary greater than $100,000 and whose first name starts with "S", using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE salary  > 100000
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE first_name LIKE 'S%';

--466...Retrieve employees who have both been hired in 2018 and work in the "Finance" department, using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) = 2018
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Finance';

--467...Retrieve all employees from the "Sales" department, except those who are from "Marketing".

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Sales'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Marketing';

--468...Retrieve all employees who have a salary greater than $70,000, except those who are from "Finance" department.

SELECT first_name, last_name FROM employee_data WHERE salary > 70000
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Finance';

--469...Retrieve all employees who have been hired after 2020, except those who live in "London".

SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date)= 2020
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE location = 'London';

--470...Get employees who have been hired after 2015, except those whose salary is below $50,000.

SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date)  > 2025
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE salary < 50000;

--471...Retrieve all employees from the "HR" department, except those whose salary is above $100,000.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'HR'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE salary < 100000;

--472...Retrieve all employees whose first name starts with "S", except those whose location is "London".

SELECT first_name, last_name FROM employee_data WHERE first_name LIKE 'S%'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE location = 'London';

--473...Get employees who are from "Berlin", except those from "Los Angeles".

SELECT first_name, last_name FROM employee_data WHERE location = 'Berlin'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE location = 'Los Angeles';

--474...Retrieve all employees who have salaries above $80,000, except those hired in 2019.

SELECT first_name, last_name FROM employee_data WHERE salary > 80000
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) = 2019;

--475...List all employees from the "Tech" department, except those whose hire date is after 2021.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Tech'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) = 2021;

--476...Retrieve all employees whose salary is greater than $60,000, except those who live in "San Francisco".

SELECT first_name, last_name FROM employee_data WHERE salary > 60000
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE location = 'San Francisco';

--478...Retrieve the first and last names of employees who were hired before 2017, except those whose salary is above $70,000.

SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) < 2017
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE salary > 70000;

--479...Get employees who are in "Sales" department, except those whose mobile number starts with "1".

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Sales'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE mobile_no LIKE '1%';

--480...List employees who have been hired before 2020, except those who work in the "IT" department.

SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) < 2020
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'IT';

--481..Retrieve all employees whose salary is below $50,000, except those hired after 2018.

SELECT first_name, last_name FROM employee_data WHERE salary < 50000
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) > 2018;

--482...Retrieve all employees who are from "London", except those who are from "Berlin".

SELECT first_name, last_name FROM employee_data WHERE location ='London'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE location ='Berlin';

--483...Get employees who are from the "HR" department, except those hired before 2018.

SELECT first_name, last_name FROM employee_data WHERE dept_name ='HR'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) < 2018;

--484...Retrieve the names of employees who are from "New York", except those who work in "Finance".

SELECT first_name, last_name FROM employee_data WHERE location ='New York'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Finance';

--485...List all employees from the "Sales" department, except those whose hire date is in 2019.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Sales'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) = 2019 ;

--486...Retrieve employees whose first name starts with "J", except those who work in "HR".

SELECT first_name, last_name FROM employee_data WHERE first_name LIKE 'J%'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'HR';

--487...Retrieve all employees who are from "Berlin", except those whose salary is greater than $100,000.

SELECT first_name, last_name FROM employee_data WHERE location = 'Berlin'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE salary > 100000;

--488...Retrieve all employees who have a salary above $50,000, except those who were hired in 2020.

SELECT first_name, last_name FROM employee_data WHERE salary > 50000
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) = 2020 ;

--489...Retrieve the full name of employees from "Marketing", except those who live in "San Francisco".

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Marketing'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE location = 'San Francisco' ;

--490...Retrieve all employees who are from "Finance", except those who are from "Sales".

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Finance'
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Sales';

--491...List employees who work in both "Finance" and "Sales", except those whose salary is below $60,000.

SELECT first_name, last_name FROM employee_data WHERE dept_name IN( 'Finance','Sales')
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE salary < 60000;

--492...Retrieve all employees whose salary is below $60,000, except those whose first name starts with "A".

SELECT first_name, last_name FROM employee_data WHERE salary < 60000
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE first_name LIKE 'A%';

--493...Retrieve all employees from the "Tech" and "Finance" departments, and combine the results with those from the "Sales" department using UNION.

SELECT first_name, last_name FROM employee_data WHERE dept_name =  'Finance' AND ID IN (SELECT ID FROM employee_data WHERE dept_name =  'Tech')
UNION
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Sales';

--494...Get the names of employees from the "Marketing" department, whose salary is above $60,000, using INTERSECT with employees from "HR".

SELECT first_name, last_name FROM employee_data WHERE dept_name =  'Marketing' 
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE dept_name = 'HR';

--495...Retrieve all employees whose salary is above $80,000, except those whose location is "New York", using EXCEPT.

SELECT first_name, last_name FROM employee_data WHERE salary >  80000
EXCEPT
SELECT first_name, last_name FROM employee_data WHERE location = 'New York';

--496...Combine employees from the "HR" and "Finance" departments using UNION, and then find employees whose salary is above $60,000 using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'HR' AND ID IN (SELECT ID FROM employee_data WHERE dept_name = 'Finance')
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE salary >  60000;

--497...Retrieve all employees hired after 2018 and those who are from "London", and find the common employees using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) > 2018
INTERSECT
SELECT first_name, last_name FROM employee_data WHERE location = 'London';

--498...Retrieve employees from the "Tech" department, and those hired after 2018, using UNION ALL.

SELECT first_name, last_name FROM employee_data WHERE dept_name = 'Tech'
UNION ALL
SELECT first_name, last_name FROM employee_data WHERE YEAR(hire_date) > 2018;

--499...List employees who have salaries above $70,000, and those whose first name starts with "S", using UNION.

SELECT first_name, last_name FROM employee_data WHERE salary > 70000
UNION
SELECT first_name, last_name FROM employee_data WHERE first_name LIKE 'S%';

--500...Retrieve all employees who are from "San Francisco" and "Berlin", using INTERSECT.

SELECT first_name, last_name FROM employee_data WHERE location = 'Francisco'
UNION
SELECT first_name, last_name FROM employee_data WHERE location = 'Berlin';

----------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE EMP_DATA
(
Emp_id VARCHAR(100),
First_name VARCHAR(100),
Last_Name VARCHAR(100),
Department_id INT,
Email_id VARCHAR(100),
Salary FLOAT,
Gender VARCHAR(100),
Hire_Date DATE,
Employment_status VARCHAR(100),
Manager_id INT
);

CREATE TABLE CUTOMER_DATA
(
Cust_id VARCHAR(100),
First_name VARCHAR(100),
Last_Name VARCHAR(100),
Product_id INT,
 Quantity INT,
 Purchase_Date DATE
);

CREATE TABLE PROD_DATA
(
Product_ID int,
Company_Name VARCHAR(100),
Product_Type VARCHAR(100),
Product_Name VARCHAR(100),
Prod_Price FLOAT
);
alter table PROD_DATA
alter column Product_ID int;
----------------------------------------------------------------------------------------------------------------------------------------------------------
--501...Retrieve all employees and the products purchased by their customers.

SELECT * FROM EMP_DATA AS E INNER JOIN  CUTOMER_DATA AS C ON E.First_name = C.First_name 
INNER JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id;

--502...Get the employee names and their department IDs for employees managing customers who purchased a specific product.

SELECT * FROM EMP_DATA AS E INNER JOIN  CUTOMER_DATA AS C ON E.First_name = C.First_name 
INNER JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id WHERE P.Product_Type = 'Toys';

--503...List customer names along with the product names they purchased.

SELECT C.First_name,C.Last_Name,P.Product_Name FROM CUTOMER_DATA AS C INNER JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id ;

--504...Find the product name and company name for products purchased by customers.

SELECT 
    P.Product_Name AS Product_Name,
    P.Company_Name AS Company_Name
FROM 
    CUTOMER_DATA C
INNER JOIN 
    PROD_DATA P ON C.Product_id = P.Product_ID;

--505...Show the details of employees managing departments where specific products are sold.

SELECT E.* FROM EMP_DATA AS E INNER JOIN  CUTOMER_DATA AS C ON E.First_name = C.First_name 
INNER JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id WHERE P.Product_Type = 'Books';

--506...Find all employees and their managed customer details (if any).

SELECT * FROM EMP_DATA AS E LEFT OUTER JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name

--507...List all customers and the product details they purchased (if any).

SELECT * FROM CUTOMER_DATA AS C LEFT OUTER JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID

--508...Retrieve all columns from the EMP_DATA table.
SELECT * FROM EMP_DATA

--509...Retrieve only Emp_id, First_name, and Last_name from the EMP_DATA table.
SELECT Emp_id,First_name,Last_Name FROM EMP_DATA;

--510...Display unique department IDs in the EMP_DATA table.

SELECT distinct Department_id FROM EMP_DATA;

--511...List all Email_id values without duplicates.
SELECT distinct Email_id FROM EMP_DATA;

--512...Find all products whose Product_Type is 'Electronics'.

SELECT * FROM PROD_DATA WHERE Product_Type = 'Electronics';

--513...Retrieve employees whose Salary is greater than 50,000.
SELECT * FROM  EMP_DATA WHERE Salary > 50000;

--514...Find customers who purchased a product with a quantity greater than 10.
SELECT Product_Type, COUNT(*) AS PROD_COUNT FROM  PROD_DATA GROUP BY Product_Type HAVING COUNT(*) > 10;

--515...Retrieve employees in the "HR" department.
SELECT * FROM employee_data WHERE dept_name = 'HR';

--516...List all products with a Prod_Price between 100 and 500.
SELECT * FROM PROD_DATA WHERE Prod_Price BETWEEN 100 AND 150;

--517...Find employees hired after 2022-01-01.
SELECT * FROM EMP_DATA WHERE Hire_Date > '2022-01-01';

--518...Retrieve all employees and order them by Hire_Date in ascending order.
SELECT * FROM EMP_DATA ORDER BY Hire_Date ASC; 

--519...List all products sorted by Prod_Price in descending order.
SELECT * FROM PROD_DATA ORDER BY Prod_Price DESC;

--520...Find the total salary of all employees.
SELECT SUM(Salary) AS TOTAL_SALARY FROM EMP_DATA

--521...Calculate the average salary of employees in the "IT" department.
SELECT dept_name , AVG(Salary) AS AVG_SALARY FROM employee_data WHERE dept_name = 'IT' GROUP BY dept_name;

--522...Count the total number of employees in the EMP_DATA table.
SELECT COUNT(*) AS TOTAL_COUNT FROM EMP_DATA

--523...Find the maximum salary in the company.
SELECT MAX(Salary) AS MAX_SALARY FROM EMP_DATA

--524...Determine the minimum product price.
SELECT MIN(Prod_Price) AS MIN_PRICE FROM PROD_DATA

--525...Group employees by Department_id and calculate the total salary for each department.
SELECT Department_id,SUM(Salary) AS TOTAL_SALATRY FROM EMP_DATA GROUP BY Department_id;

--526...Count the number of employees in each department.
SELECT dept_name, COUNT(*) AS TOTAL_COUNT FROM employee_data GROUP BY dept_name;

--527...Group products by Product_Type and find the average price.

SELECT Product_Type,AVG(Prod_Price) AS PROD_PRICE FROM PROD_DATA GROUP BY Product_Type;

--528...Find departments where the total salary exceeds 100,000.
SELECT dept_name,SUM(salary) AS TOTAL_SALARY FROM employee_data GROUP BY dept_name HAVING SUM(salary) > 100000;

--529...Retrieve products grouped by Company_Name where the average price is greater than 200.
SELECT Company_Name,AVG(Prod_Price) AS AVG_PROD FROM  PROD_DATA GROUP BY Company_Name HAVING AVG(Prod_Price) > 2500;

--530...Retrieve employee details along with their manager’s Emp_id.
SELECT 
    e.Emp_id AS Employee_ID,
    e.First_name AS Employee_FirstName,
    e.Last_Name AS Employee_LastName,
    e.Department_id,
    e.Salary,
    e.Manager_id AS Manager_ID,
    m.First_name AS Manager_FirstName,
    m.Last_Name AS Manager_LastName
FROM 
    EMP_DATA e
LEFT JOIN 
    EMP_DATA m
ON 
    e.Manager_id = m.Emp_id;

--531...Fetch customer data along with the details of the product they purchased.
SELECT 
    c.Cust_id AS Customer_ID,
    c.First_name AS Customer_FirstName,
    c.Last_Name AS Customer_LastName,
    c.Product_id AS Product_ID,
    c.Quantity,
    c.Purchase_Date,
    p.Company_Name,
    p.Product_Type,
    p.Product_Name,
    p.Prod_Price
FROM 
    CUTOMER_DATA c
JOIN 
    PROD_DATA p
ON 
    c.Product_id = p.Product_ID;

--532...Find all employees and the department details where they work.
/*SELECT 
    e.Emp_id AS Employee_ID,
    e.First_name AS Employee_FirstName,
    e.Last_Name AS Employee_LastName,
    e.Department_id,
    d.Department_Name,
    d.Department_Location -- Assuming this column exists
FROM 
    EMP_DATA e
JOIN 
    DEPARTMENT d
ON 
    e.Department_id = d.Department_id;*/

--533...Find employees whose salary is above the average salary.
SELECT * FROM EMP_DATA WHERE Salary > (SELECT AVG(Salary) FROM EMP_DATA);

--534...Retrieve products with a price lower than the average product price.
SELECT * FROM PROD_DATA WHERE Prod_Price < (SELECT AVG(Prod_Price) FROM PROD_DATA);

--535...List employees who are not managers.
SELECT * FROM EMP_DATA WHERE Manager_id = 215

--536...Retrieve First_name and Last_name of employees and customers (Union).
SELECT First_name,Last_Name FROM EMP_DATA
UNION
SELECT First_name,Last_Name FROM CUTOMER_DATA;

--537...Find First_name and Last_name common between employees and customers (Intersect).
SELECT First_name,Last_Name FROM EMP_DATA
INTERSECT
SELECT First_name,Last_Name FROM CUTOMER_DATA;

--538...Retrieve employees not present in the customer list (Except/Minus).
SELECT First_name,Last_Name FROM CUTOMER_DATA
EXCEPT
SELECT First_name,Last_Name FROM EMP_DATA;

SELECT First_name,Last_Name FROM EMP_DATA
EXCEPT
SELECT First_name,Last_Name FROM CUTOMER_DATA;

--539...Convert all First_name in the EMP_DATA table to uppercase.
SELECT UPPER(First_name) AS UPPER_CASE FROM EMP_DATA;

--540...Find the length of each Last_name in the CUTOMER_DATA table.
SELECT LEN(Last_Name) AS UPPER_CASE FROM CUTOMER_DATA;

--541...Concatenate First_name and Last_name for all employees.
SELECT CONCAT(First_name,' ',Last_Name) AS FULL_NAME FROM EMP_DATA;

--542...Replace all occurrences of "Inc" in Company_Name with "Ltd".
UPDATE PROD_DATA
SET Company_Name = REPLACE(Company_Name, 'Inc', 'Ltd')
WHERE Company_Name LIKE '%Inc%';

SELECT 
    Product_ID,
    REPLACE(Company_Name, 'Inc', 'Ltd') AS Updated_Company_Name,
    Product_Type,
    Product_Name,
    Prod_Price
FROM 
    PROD_DATA;

--543...Extract the first 3 characters of the Product_Name.
SELECT Product_Name,  SUBSTRING(Product_Name,1,3) AS FIRST_THREE, LEFT(Product_Name,3) AS THREE_CHAR,
SUBSTRING(Product_Name,LEN(Product_Name)-2,3) AS LAST_THREE
FROM PROD_DATA;

--545...Retrieve employees hired in the year 2020.
SELECT * FROM EMP_DATA WHERE YEAR(Hire_Date) = 2020;
SELECT * FROM EMP_DATA WHERE DATEPART(YEAR,Hire_Date) = 2020;
SELECT * FROM EMP_DATA WHERE DATENAME(YEAR,Hire_Date) = 2020;

--546...Calculate the number of years each employee has worked.
SELECT 
    Emp_id,
    First_name,
    Last_Name,
    DATEDIFF(YEAR, Hire_Date, GETDATE()) AS Years_Worked
FROM 
    EMP_DATA;

--547...Format the Hire_Date in 'MM/DD/YYYY' format.

SELECT 
    Emp_id,
    First_name,
    Last_Name,
    CONVERT(VARCHAR, Hire_Date, 10) AS Formatted_Hire_Date
FROM 
    EMP_DATA;

--548...Add 30 days to all Hire_Date values.
SELECT Hire_Date, DATEADD(DAY,30,Hire_Date) AS ADD_DAY  FROM EMP_DATA;

--549...Retrieve all customers who made a purchase last month.

SELECT 
    Cust_id,
    First_name,
    Last_Name,
    Product_id,
    Quantity,
    Purchase_Date
FROM 
    CUTOMER_DATA
WHERE 
    Purchase_Date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)  -- First day of the last month
    AND Purchase_Date < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0);  -- First day of the current month
----
SELECT 
    Cust_id,
    First_name,
    Last_Name,
    Product_id,
    Quantity,
    Purchase_Date
FROM 
    CUTOMER_DATA
WHERE 
    YEAR(Purchase_Date) = YEAR(DATEADD(MONTH, -1, GETDATE())) 
    AND MONTH(Purchase_Date) = MONTH(DATEADD(MONTH, -1, GETDATE()));

--550...Calculate the square root of all product prices.
SELECT ROUND(SQRT(Prod_Price),2) AS SQURE_ROOT FROM PROD_DATA;
SELECT ROUND(SQUARE(Prod_Price),2) AS SQURE_PRICE  FROM PROD_DATA;

--551...Round off the Salary to 2 decimal places.
SELECT Salary, ROUND(Salary,2) FROM EMP_DATA 

--552...Find the absolute difference between the highest and lowest salary.
SELECT Department_id, (MAX(Salary) - MIN(Salary)) AS DIFFERANCE FROM EMP_DATA GROUP BY Department_id;

--553...Convert Salary to a string and concatenate with " USD".
SELECT 
    Emp_id,
    First_name,
    Last_Name,
    CONCAT(CONVERT(VARCHAR(20), Salary),'_','USD') AS Salary_With_Currency
FROM 
    EMP_DATA;

--554...Cast Hire_Date as a string in 'YYYY-MM-DD' format.

SELECT * FROM EMP_DATA
--555...Convert Prod_Price from float to integer.

SELECT 
    Product_ID,
    Company_Name,
    Product_Name,
	Prod_Price,
    CAST(Prod_Price AS INT) AS Prod_Price_Integer
FROM 
    PROD_DATA;

--556...Assign a rank to employees based on their Salary in descending order.
SELECT * FROM (
SELECT *,
RANK() OVER(ORDER BY SALARY DESC) AS RANK_SALARY FROM EMP_DATA
) AS A;

SELECT * FROM (
SELECT *,
DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RANK_SALARY FROM EMP_DATA
) AS A 

--557...Assign a dense rank to products based on their price.

SELECT * FROM (
SELECT * ,  
DENSE_RANK() OVER(ORDER BY PROD_PRICE) AS RANK_PRICE
FROM PROD_DATA
) AS A;

--558...Find the Nth highest salary in the company using the rank function.

SELECT * FROM (
SELECT *,
DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RANK_SALARY FROM EMP_DATA
) AS A WHERE RANK_SALARY = 7;

--559...Calculate the running total of salaries for employees.

SELECT SUM(Salary) AS TOTAL_SALARY FROM EMP_DATA

--560...Find the average Salary for each department using a window function.
SELECT Department_id, AVG(Salary) AS AVG_SALARY FROM EMP_DATA GROUP BY Department_id ORDER BY Department_id ;
SELECT * FROM (SELECT *,
AVG(Salary) OVER(PARTITION BY Department_id ) AS ABG_SALARY FROM EMP_DATA) AS A;

--561...Retrieve the top 3 highest-paid employees from each department.

SELECT TOP 3 * FROM EMP_DATA ORDER BY Salary DESC;

--562...Fetch customers along with product details and employee details who sold them the product.
SELECT * FROM EMP_DATA AS E INNER JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name INNER JOIN PROD_DATA AS P
ON C.Product_id = P.Product_ID 

--563...Find all employees who have the same manager.
/*SELECT 
    e.Emp_id,
    e.First_name,
    e.Last_Name,
    e.Manager_id,
    m.First_name AS Manager_First_Name,
    m.Last_Name AS Manager_Last_Name
FROM 
    EMP_DATA e
LEFT JOIN 
    EMP_DATA m ON e.Manager_id = m.Emp_id
WHERE 
    e.Manager_id IS NOT NULL
ORDER BY 
    e.Manager_id, e.Emp_id;
*/

--564...Create a report showing total sales (Quantity * Prod_Price) for each product.
SELECT C.*,P.*,(C.Quantity * P.Prod_Price) AS TOTAL_SALES FROM CUTOMER_DATA AS C INNER JOIN  PROD_DATA AS P ON C.Product_id = P.Product_ID;

--565...Calculate the percentage of each department’s total salary out of the company’s total salary.

SELECT  Department_id , (Salary/SUM(Salary) * 100) AS PERCENTAGE_OF_SALARY FROM EMP_DATA AS E GROUP BY Department_id ;

SELECT 
    Department_id,
    SUM(Salary) AS Total_Department_Salary,
    ROUND((SUM(Salary) * 100.0 / (SELECT SUM(Salary) FROM EMP_DATA)), 2) AS Percentage_Of_Total_Salary
FROM 
    EMP_DATA
GROUP BY 
    Department_id
ORDER BY 
    Percentage_Of_Total_Salary DESC;

--566...Find employees who earn more than their managers.

/*SELECT 
    e.Emp_id AS Employee_ID,
    e.First_name AS Employee_First_Name,
    e.Last_Name AS Employee_Last_Name,
    e.Salary AS Employee_Salary,
    m.Emp_id AS Manager_ID,
    m.First_name AS Manager_First_Name,
    m.Last_Name AS Manager_Last_Name,
    m.Salary AS Manager_Salary
FROM 
    EMP_DATA e
JOIN 
    EMP_DATA m ON e.Manager_id = m.Emp_id
WHERE 
    e.Salary > m.Salary;
*/

--567...Retrieve the top 5 products with the highest total sales.

SELECT TOP 5 C.*,P.*,(C.Quantity * P.Prod_Price) AS TOTAL_SALES FROM CUTOMER_DATA AS C INNER JOIN  PROD_DATA AS P ON C.Product_id = P.Product_ID
ORDER BY TOTAL_SALES DESC;

--568...Generate a report of employees who have the same last name as customers.

SELECT * FROM EMP_DATA AS E INNER JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
WHERE E.Last_Name = C.Last_Name;

--569...Add a column categorizing employees as "High Earner" or "Low Earner" based on Salary.

SELECT 
    Emp_id,
    First_name,
    Last_Name,
    Salary,
    CASE 
        WHEN Salary >= 50000 THEN 'High Earner'
        ELSE 'Low Earner'
    END AS Salary_Category
FROM 
    EMP_DATA;

--570...Categorize products into "Expensive", "Moderate", and "Cheap" based on their price.

SELECT 
    Product_ID,
    Product_Name,
    Prod_Price,
    CASE
        WHEN Prod_Price >= 1000 THEN 'Expensive'
        WHEN Prod_Price >= 500 THEN 'Moderate'
        ELSE 'Cheap'
    END AS Price_Category
FROM 
    PROD_DATA;

--571...Retrieve employees with a Salary greater than 50,000.
SELECT * FROM EMP_DATA WHERE Salary > 50000;

--572...Find employees in the "HR" department.
SELECT * FROM employee_data WHERE dept_name = 'HR';

--573...List customers who purchased a quantity of more than 5.
SELECT * FROM CUTOMER_DATA WHERE Quantity > 5;

--574...Find products with a price less than 100.
SELECT * FROM PROD_DATA WHERE Prod_Price < 100;

--575...Retrieve employees whose Gender is 'Male'.

SELECT * FROM EMP_DATA WHERE Gender = 'Male';

--576...Find employees with a Salary between 30,000 and 70,000.
SELECT * FROM EMP_DATA WHERE Salary BETWEEN 30000 AND 70000;

--577...Retrieve products that are either "Electronics" or "Furniture".
SELECT * FROM PROD_DATA WHERE Product_Type IN ('Electronics','Furniture');

--578...Retrieve employees whose Last_name starts with "S".
SELECT * FROM EMP_DATA WHERE Last_Name LIKE 'S%';

--579...List customers whose Purchase_Date is in the year 2023.
SELECT * FROM CUTOMER_DATA WHERE YEAR(Purchase_Date) = 2023;

--580...Find employees who are not in the "Finance" department.
SELECT * FROM employee_data WHERE dept_name = 'Finance';

--581...Retrieve employees hired after 2022-01-01 but before 2023-01-01.
SELECT * FROM EMP_DATA WHERE Hire_Date > '2022-01-01' AND Hire_Date < '2023-01-01';

SELECT * FROM EMP_DATA WHERE Hire_Date BETWEEN '2022-01-01' AND '2023-01-01';

--582...Find customers who purchased products with a quantity greater than 5 and less than 20.
SELECT * FROM CUTOMER_DATA WHERE Quantity BETWEEN 5 AND 20;
SELECT * FROM CUTOMER_DATA WHERE Quantity > 5 AND Quantity < 20;

--583...Retrieve employees whose Salary is either greater than 70,000 or less than 20,000.
SELECT * FROM EMP_DATA WHERE Salary > 70000 AND Salary < 20000;
SELECT * FROM EMP_DATA WHERE Salary BETWEEN 70000 AND 20000;

--584...Find products whose Company_Name does not contain "Tech".
SELECT * FROM PROD_DATA WHERE Company_Name LIKE '%TECH%';

--585...Retrieve customers whose Last_Name ends with "son".

SELECT * FROM EMP_DATA WHERE Last_Name LIKE '%SON';
SELECT * FROM CUTOMER_DATA WHERE Last_Name LIKE '%SON';

--586...Find employees in the "IT" department with a Salary greater than 60,000.
SELECT * FROM employee_data WHERE dept_name = 'IT' AND salary >60000;

--587...Retrieve employees who are either in the "Sales" department or have a Salary above 80,000.
SELECT * FROM employee_data WHERE dept_name = 'Sales' AND salary >80000;

--589...List products where Product_Type is "Clothing" and Prod_Price is less than 50.
SELECT * FROM PROD_DATA WHERE Product_Type = 'Clothing' AND Prod_Price < 50;

--590...Retrieve customers who purchased a quantity of more than 10 and their Purchase_Date is after 2023-01-01.

SELECT * FROM CUTOMER_DATA WHERE Quantity > 10 AND Purchase_Date  > '2023-01-01';

--591...Find employees whose Gender is 'Female' and who were hired after 2021-01-01.

SELECT * FROM EMP_DATA WHERE Gender = 'Female' AND Hire_Date > '2021-01-01';

--592...Find employees whose First_name contains the letter "a".
SELECT * FROM EMP_DATA WHERE First_name LIKE '%A%';

--593...Retrieve products where Product_Name ends with "Pro".
SELECT * FROM PROD_DATA WHERE Product_Name LIKE '%PRO';

--594...List employees whose Email_id starts with "admin".
SELECT * FROM EMP_DATA WHERE Email_id LIKE 'admin%';

--595...Find customers whose First_name is exactly 5 characters long.
SELECT First_name,SUBSTRING(First_name,1,5) AS FIVE_characters FROM EMP_DATA ;
SELECT First_name,LEFT(First_name,5) AS FIVE_characters FROM EMP_DATA ;

--596...Retrieve products where Company_Name has "Inc" anywhere in the name.

SELECT * FROM PROD_DATA WHERE Company_Name LIKE '%Inc%';

--597...Find employees hired in the last 6 months.
SELECT * FROM EMP_DATA WHERE Hire_Date >= DATEADD(MONTH,-6,CAST(GETDATE() AS DATE))

--598...Retrieve customers who purchased products in the last year.
SELECT * FROM CUTOMER_DATA WHERE Purchase_Date >= DATEADD(YEAR,-1,CAST(GETDATE() AS DATE));

--599...List employees whose Hire_Date is on a weekend.
SELECT E.* ,DATENAME(WEEKDAY,Hire_Date) AS DAY_NAME FROM EMP_DATA AS E WHERE DATENAME(WEEKDAY,Hire_Date) IN ('Saturday','Sunday');

--600...Retrieve customers whose Purchase_Date falls in the first quarter of the year.
SELECT * FROM CUTOMER_DATA WHERE DATEPART(QUARTER, Purchase_Date) = 1;

--601...Find employees hired before the year 2000.

SELECT * FROM EMP_DATA WHERE YEAR(Hire_Date) < 2000;

--602...Find employees in "HR" or "Finance" departments with a Salary above 40,000.
SELECT * FROM employee_data WHERE dept_name IN ('HR','Finance') AND salary > 40000;

--603...Retrieve products with a Prod_Price greater than 500 but less than 1,000 and whose Product_Type is "Electronics".
SELECT * FROM  PROD_DATA WHERE (Prod_Price BETWEEN 500 AND 1000)  AND Product_Type = 'Electronics';

--604...List customers who purchased products with a Quantity greater than 5, whose First_name starts with "J".
SELECT * FROM CUTOMER_DATA WHERE Quantity > 5 AND First_name LIKE 'J%';

--605...Retrieve employees who are either managers (Manager_id IS NOT NULL) or have a Salary above 70,000.
SELECT * FROM EMP_DATA WHERE Manager_id IS NOT NULL OR Salary > 70000;

--606...Find products where Product_Name starts with "Ultra" and Prod_Price is less than 500.

SELECT * FROM PROD_DATA WHERE Product_Name LIKE 'Ultra%' AND Prod_Price < 500;

--607...Find the total salary paid to employees hired in the current year.
SELECT * FROM EMP_DATA WHERE YEAR(GETDATE()) = YEAR(Hire_Date);

--608...Calculate the average salary of employees hired in the last three months.
SELECT AVG(Salary) AS AVG_SALRY FROM EMP_DATA WHERE Hire_Date>= DATEADD(MONTH,-3,CAST(GETDATE() AS DATE));

--609..Count the number of employees hired in each month of the current year.
SELECT DATENAME(MONTH,Hire_Date) ,COUNT(*) AS TOTAL_COUNT FROM EMP_DATA GROUP BY DATENAME(MONTH,Hire_Date);

--610...Retrieve the maximum and minimum salary of employees hired after January 1st of this year.
SELECT MAX(Salary) AS Max_Salary,
    MIN(Salary) AS Min_Salary FROM EMP_DATA WHERE Hire_Date > '2025-01-01';

--611...Find the total number of employees hired in the past six months.

SELECT COUNT(*) AS TOTAL_COUNT FROM EMP_DATA WHERE Hire_Date >= DATEADD(MONTH,-6,GETDATE());

--612...Calculate the total salary of employees grouped by the year of their hiring date.

SELECT YEAR(Hire_Date) AS YEAR,SUM(Salary) AS TOTAL_SALARY FROM EMP_DATA GROUP BY YEAR(Hire_Date) ORDER BY YEAR;

--613...Find the average product price of all products added to the system in the last year.
/*
SELECT 
    AVG(Prod_Price) AS Average_Product_Price_Last_Year
FROM 
    PROD_DATA
WHERE 
    Product_Add_Date >= DATEADD(YEAR, -1, GETDATE());
*/
--614...Retrieve the count of customers who made purchases in the last week.
SELECT COUNT(*) AS TOTAL_COUNT FROM CUTOMER_DATA WHERE Purchase_Date >= DATEADD(DAY,-7,CAST(GETDATE() AS DATE));

--615...Calculate the sum of salaries for employees hired between two specific dates.
SELECT SUM(SALARY) FROM EMP_DATA WHERE Hire_Date BETWEEN '2015-02-27' AND '2025-01-01';

--616...Find the highest-paid employee who was hired within the last 2 years.
SELECT E.*, MAX(Salary) AS MAX_SALARY FROM EMP_DATA AS E WHERE Hire_Date >= DATEADD(YEAR,-2,CAST(GETDATE() AS DATE));

SELECT TOP 1 
    E.*,
    E.Salary AS MAX_SALARY
FROM 
    EMP_DATA AS E
WHERE 
    Hire_Date >= DATEADD(YEAR, -2, CAST(GETDATE() AS DATE))
ORDER BY 
    E.Salary DESC;

--617...Calculate the total salary paid to employees grouped by the month and year of their hiring date.
SELECT MONTH(Hire_Date) AS HIRE_MONTH , YEAR(Hire_Date) AS HIRE_YEAR, SUM(Salary) AS TOTAL_SALARY FROM EMP_DATA 
GROUP BY MONTH(Hire_Date) , YEAR(Hire_Date);

--618...Find the department-wise average salary for employees hired in the last 5 years.
SELECT dept_name,AVG(salary) AS AVG_SALARY FROM employee_data WHERE hire_date >= DATEADD(YEAR,-5,CAST(GETDATE() AS DATE))
GROUP BY dept_name;

--619...Retrieve the count of employees for each day of the week (e.g., Monday, Tuesday) they were hired.
SELECT DATENAME(WEEKDAY,Hire_Date) AS HIRE_DAY,COUNT(*) AS TOTAL_COUNT FROM EMP_DATA GROUP BY DATENAME(WEEKDAY,Hire_Date);

--620...Calculate the percentage contribution of employees hired in the last 6 months to the total salary of the company.
SELECT 
    ROUND(
        (SUM(CASE WHEN Hire_Date >= DATEADD(MONTH, -6, GETDATE()) THEN Salary ELSE 0 END) 
        / 
        NULLIF(SUM(Salary), 0)) * 100, 
        2
    ) AS Percentage_Contribution_Last_6_Months
FROM 
    EMP_DATA;

--621...Determine the total number of products sold last month and the revenue generated from them.
SELECT DATENAME(MONTH,DATEADD(MONTH,-1,GETDATE())) AS MONTH_NAME , COUNT(Quantity) AS SALES_QUANTITY FROM CUTOMER_DATA
GROUP BY DATENAME(MONTH, Purchase_Date);

SELECT 
    DATENAME(MONTH, DATEADD(MONTH, -1, GETDATE())) AS MONTH_NAME, 
    COUNT(Quantity) AS SALES_QUANTITY
FROM 
    CUTOMER_DATA
WHERE 
    Purchase_Date >= DATEADD(MONTH, -1, GETDATE()) AND 
    Purchase_Date < GETDATE()
GROUP BY 
    DATENAME(MONTH, Purchase_Date);

--622...Find the month in which the company spent the most on salaries for employees hired in that month.
SELECT 
    YEAR(Hire_Date) AS Hire_Year,
    MONTH(Hire_Date) AS Hire_Month,
    SUM(Salary) AS Total_Salary
FROM 
    EMP_DATA
GROUP BY 
    YEAR(Hire_Date),
    MONTH(Hire_Date)
ORDER BY 
    Total_Salary DESC;
--623...Calculate the average time (in years) employees have worked in the company, grouped by their hiring year.
SELECT 
    YEAR(Hire_Date) AS Hire_Year,
    AVG(DATEDIFF(YEAR, Hire_Date, GETDATE())) AS Average_Years_Worked
FROM 
    EMP_DATA
GROUP BY 
    YEAR(Hire_Date)
ORDER BY 
    Hire_Year DESC;

--624...Retrieve the total revenue generated in the last quarter of the previous year and compare it with the same quarter of the current year.

SELECT 
    YEAR(Purchase_Date) AS Year,
    CASE 
        WHEN MONTH(Purchase_Date) BETWEEN 10 AND 12 THEN 'Q4' 
        ELSE NULL 
    END AS Quarter,
    SUM(Quantity * Prod_Price) AS Total_Revenue
FROM 
    CUTOMER_DATA
JOIN 
    PROD_DATA ON CUTOMER_DATA.Product_id = PROD_DATA.Product_ID
WHERE 
    (Purchase_Date >= DATEADD(QUARTER, -1, CAST(GETDATE() AS DATE)) AND MONTH(Purchase_Date) BETWEEN 10 AND 12)
    OR 
    (Purchase_Date >= DATEADD(QUARTER, -5, CAST(GETDATE() AS DATE)) AND MONTH(Purchase_Date) BETWEEN 10 AND 12)
GROUP BY 
    YEAR(Purchase_Date),
    CASE 
        WHEN MONTH(Purchase_Date) BETWEEN 10 AND 12 THEN 'Q4' 
        ELSE NULL 
    END
ORDER BY 
    Year DESC;


--625...Find the total salary of employees grouped by department and hiring quarter, sorted in descending order of salary.
SELECT 
    Department_id,
    CASE 
        WHEN MONTH(Hire_Date) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(Hire_Date) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(Hire_Date) BETWEEN 7 AND 9 THEN 'Q3'
        WHEN MONTH(Hire_Date) BETWEEN 10 AND 12 THEN 'Q4'
    END AS Hiring_Quarter,
    SUM(Salary) AS Total_Salary
FROM 
    EMP_DATA
GROUP BY 
    Department_id,
    CASE 
        WHEN MONTH(Hire_Date) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(Hire_Date) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(Hire_Date) BETWEEN 7 AND 9 THEN 'Q3'
        WHEN MONTH(Hire_Date) BETWEEN 10 AND 12 THEN 'Q4'
    END
ORDER BY 
    Total_Salary DESC;

--626...Calculate the rolling 12-month total salary for employees based on their hiring date.
SELECT 
    Emp_id,
    First_name,
    Last_Name,
    Hire_Date,
    Salary,
    SUM(Salary) OVER (PARTITION BY Emp_id ORDER BY Hire_Date ROWS BETWEEN 365 PRECEDING AND CURRENT ROW) AS Rolling_12_Month_Salary
FROM 
    EMP_DATA
WHERE 
    Hire_Date >= DATEADD(MONTH, -12, GETDATE());

--627...Retrieve the Emp_id and First_name of all employees.

SELECT Emp_id,First_name FROM EMP_DATA;

--628...List all customers and their respective product names.

SELECT C.First_name, C.Last_Name, P.Product_Name
FROM     CUTOMER_DATA AS C INNER JOIN
                  PROD_DATA AS P ON C.Product_id = P.Product_ID;

--629...Find employees and their departments, showing the Emp_id, First_name, and Department_id.

SELECT Emp_id,First_name,Last_Name, Department_id FROM EMP_DATA;

--630...Get the names and salaries of all employees who earn more than $60,000.

SELECT First_name,Last_Name FROM EMP_DATA WHERE Salary > 60000;

--631...List customers who purchased products after 2023-01-01.

SELECT * FROM CUTOMER_DATA WHERE Purchase_Date = '2023-01-01';

--632...Find products purchased by employees in the "HR" department.

SELECT * FROM employee_data WHERE dept_name = 'HR';

--633...Retrieve all employees who joined after January 1, 2022.

SELECT *
FROM     EMP_DATA
WHERE  (DATENAME(MONTH, Hire_Date) = 'January') 
AND (DAY(Hire_Date) = 01)
AND (YEAR(Hire_Date) = 2022);

--634...Find customers who bought products with a price greater than $100.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE P.Prod_Price > 100 ORDER BY P.Prod_Price DESC;

--635...List employees and the products they purchased, if any.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID;

--636...Get the total number of customers who bought each product.

SELECT 
    p.Product_Name,
	COUNT(*) AS ALL_COUNT,
    COUNT(DISTINCT c.Cust_id) AS Total_Customers
FROM 
    CUTOMER_DATA c
INNER JOIN 
    PROD_DATA p
    ON c.Product_id = p.Product_ID
GROUP BY 
    p.Product_Name;

--636...Find the number of employees hired in 2022.

SELECT * FROM EMP_DATA WHERE YEAR(Hire_Date) = 2022;

--637...Retrieve products that were purchased in 2023.

SELECT * FROM CUTOMER_DATA WHERE YEAR(Purchase_Date) = 2023;

--638...Find customers who bought a product costing more than $500 and list the Product_Name and Product_Price.

SELECT P.Product_Name,P.Prod_Price FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE P.Prod_Price > 500;

--639...Get the total number of purchases made by each customer.

SELECT 
    Cust_id, 
    COUNT(*) AS Total_Purchases
FROM 
    CUTOMER_DATA
GROUP BY 
    Cust_id;

--640...List employees whose first names start with "A."

SELECT * FROM EMP_DATA WHERE First_name LIKE 'A%' AND Last_Name LIKE 'A%' ;

--641...Show the total quantity of products purchased by each employee.

SELECT C.First_name, C.Last_Name, COUNT(C.Quantity) AS TOTAL_QUANTITY
FROM     CUTOMER_DATA AS C INNER JOIN
                  PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY C.First_name, C.Last_Name ORDER BY TOTAL_QUANTITY DESC;

--642...Retrieve all products sold in 2023.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE YEAR(C.Purchase_Date) = 2023;

--643...Get the total number of products purchased by each customer, grouped by product name.

SELECT A.Product_Name, SUM(A.TOTAL_QUANTITY) AS ALL_QUNTITY FROM
(SELECT  P.Product_Name, count(C.Quantity) AS TOTAL_QUANTITY
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY  P.Product_Name ) AS A GROUP BY A.Product_Name ;

SELECT 
    A.Product_Name, 
    SUM(A.TOTAL_QUANTITY) AS ALL_QUANTITY
FROM (
    SELECT  
        P.Product_Name, 
        SUM(C.Quantity) AS TOTAL_QUANTITY
    FROM 
        CUTOMER_DATA AS C 
    JOIN 
        PROD_DATA AS P 
        ON C.Product_id = P.Product_ID
    GROUP BY  
        P.Product_Name
) AS A
GROUP BY 
    A.Product_Name
ORDER BY 
    ALL_QUANTITY DESC;

--644...List all employees whose salary is greater than the average salary in the company.

SELECT * FROM EMP_DATA WHERE Salary > 
(SELECT AVG(Salary) AS AVG_SALARY  FROM EMP_DATA );

--645...Get the products that were purchased more than five times.

SELECT  P.Product_Name, count(P.Product_ID) AS TOTAL_QUANTITY
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY P.Product_Name HAVING count(P.Product_ID) > 5;

--646...Find employees who purchased a product from the "Tech" category.

SELECT *
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE P.Product_Type = '%Tech%';

--647...List customers and the products they purchased, with the total quantity for each product.

SELECT P.Product_Type, SUM(C.Quantity) AS TOTAL_QUANTITY
FROM     CUTOMER_DATA AS C INNER JOIN
                  PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY P.Product_Type;

--648...Retrieve the top 3 highest-paid employees.

SELECT TOP 3 * FROM EMP_DATA ORDER BY Salary DESC;

SELECT * FROM 
(
SELECT * ,
DENSE_RANK() OVER(ORDER BY Salary DESC) AS RANK_SALARY
FROM EMP_DATA
) AS A   WHERE RANK_SALARY BETWEEN 1 AND 3;

--649...Find the average salary of employees who bought products.

SELECT AVG(E.Salary) AS AVG_SALARY
FROM     CUTOMER_DATA AS C INNER JOIN
                  PROD_DATA AS P ON C.Product_id = P.Product_ID 
				  JOIN EMP_DATA AS E ON C.First_name = E.First_name;

--650...Retrieve all products and the customers who bought them, showing the Customer_name and Product_name.

SELECT 
    CONCAT(c.First_name, ' ', c.Last_Name) AS Customer_Name, 
    p.Product_Name
FROM 
    CUTOMER_DATA c
INNER JOIN 
    PROD_DATA p
    ON c.Product_id = p.Product_ID;

--651...List employees and their departments, showing only employees hired in 2021.

SELECT full_name,dept_id,dept_name FROM employee_data WHERE YEAR(hire_date) = 2021;

--652...Find the total number of products purchased by each employee in 2023.

SELECT E.First_name, E.Last_Name, SUM(C.Quantity) AS TOTAL_QUANTITY
FROM     EMP_DATA AS E FULL OUTER JOIN
                  CUTOMER_DATA AS C ON E.First_name = C.First_name
WHERE  (YEAR(C.Purchase_Date) = 2023)
GROUP BY E.First_name, E.Last_Name;

--653...List employees who bought products worth more than $1,000.

SELECT E.First_name, E.Last_Name, SUM(C.Quantity * P.Prod_Price) AS TOTAL_PRICE
FROM     EMP_DATA AS E INNER JOIN
                  CUTOMER_DATA AS C ON E.First_name = C.First_name INNER JOIN
                  PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY E.First_name, E.Last_Name
HAVING (SUM(C.Quantity * P.Prod_Price) > 1000)
ORDER BY TOTAL_PRICE DESC;

SELECT P.*, (Prod_Price * 83.33) AS DOLLER_CONVERT_INTO_RUPESS 
FROM PROD_DATA AS P WHERE (Prod_Price * 83.33) > (1000*83);

--654...Retrieve customers who made purchases in both January and December 2023.


SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE
YEAR(C.Purchase_Date) = 2023
AND 
DATENAME(MONTH,C.Purchase_Date) IN ('January', 'December')
;

SELECT * 
FROM CUTOMER_DATA AS C 
JOIN PROD_DATA AS P 
    ON C.Product_id = P.Product_ID
WHERE 
    YEAR(C.Purchase_Date) = 2023
    AND (DATENAME(MONTH, C.Purchase_Date) BETWEEN 'January' AND 'December');

SELECT 
    * 
FROM 
    CUTOMER_DATA AS C 
JOIN 
    PROD_DATA AS P 
    ON C.Product_id = P.Product_ID
WHERE 
    YEAR(C.Purchase_Date) = 2023
    AND MONTH(C.Purchase_Date) BETWEEN 1 AND 12;

--655...Find the products purchased by customers with a total purchase value greater than $500.

SELECT 
    c.Cust_id, 
    CONCAT(c.First_name, ' ', c.Last_Name) AS Customer_Name, 
    p.Product_Name, 
    SUM(c.Quantity * p.Prod_Price) AS Total_Purchase_Value
FROM 
    CUTOMER_DATA c
JOIN 
    PROD_DATA p 
    ON c.Product_id = p.Product_ID
GROUP BY 
    c.Cust_id, c.First_name, c.Last_Name, p.Product_Name
HAVING 
    SUM(c.Quantity * p.Prod_Price) > 500
ORDER BY 
    Total_Purchase_Value DESC;

--656...Get the total number of employees hired by month in 2022.

SELECT 
    DATENAME(MONTH, e.Hire_Date) AS Month_Name, 
    COUNT(e.id) AS Total_Employees_Hired
FROM 
    employee_data e
WHERE 
    YEAR(e.Hire_Date) = 2022
GROUP BY 
    DATENAME(MONTH, e.Hire_Date);

SELECT 
    DATENAME(MONTH, e.Hire_Date) AS Month_Name, 
    COUNT(e.Emp_id) AS Total_Employees_Hired
FROM 
    EMP_DATA e
WHERE 
    YEAR(e.Hire_Date) = 2022
GROUP BY 
    DATENAME(MONTH, e.Hire_Date)
ORDER BY 
    Month_Name;

--657...Find the average price of products bought by employees in the "Finance" department.

SELECT P.Product_Type, AVG(P.Prod_Price) AS AVG_PROD_PRICE FROM employee_data AS E JOIN CUTOMER_DATA AS C ON E.first_name = C.First_name JOIN PROD_DATA AS P
ON P.Product_ID = C.Product_id
WHERE E.dept_name = 'Finance'
GROUP BY P.Product_Type;

--658...Retrieve the products that were purchased by employees whose first name starts with "J."

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE C.First_name LIKE 'J%';

--659...List the products bought by employees who joined the company after 2020.

SELECT E.Emp_id,C.First_name,C.Last_Name,P.Product_Name
FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id
WHERE YEAR(E.Hire_Date) >= 2020;

--660...Find the employees whose salaries are higher than the average salary of employees in the same department.

SELECT 
    e.Emp_id, 
    CONCAT(e.First_name, ' ', e.Last_name) AS Employee_Name, 
    e.Salary, 
    e.Department_id
FROM 
    EMP_DATA e
WHERE 
    e.Salary > (
        SELECT AVG(e2.Salary)
        FROM EMP_DATA e2
        WHERE e2.Department_id = e.Department_id
    )
ORDER BY 
    e.Department_id, e.Salary DESC;

--661...List the products bought by employees in the "Sales" department, showing the total quantity purchased.

SELECT 
    e.id, 
    e.First_name, e.Last_name, 
    p.Product_Name,
    SUM(c.Quantity) AS TOTAL_Quantity
FROM 
    employee_data AS e
JOIN 
    CUTOMER_DATA AS c 
    ON e.first_name = c.First_name
JOIN 
    PROD_DATA AS p 
    ON p.Product_ID = c.Product_id
WHERE 
    e.dept_name = 'Sales'
GROUP BY 
    e.id, 
    e.First_name, 
    e.Last_name, 
    p.Product_Name
ORDER BY 
    TOTAL_Quantity DESC;

--662...Get the names of customers who purchased products in both January and February.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE DATENAME(MONTH,C.Purchase_Date) IN ('January','February');

--663...Find all employees who made purchases in the last 6 months.

SELECT * FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
WHERE C.Purchase_Date >= DATEADD(MONTH,-6,CAST(GETDATE() AS DATE));

--664...Retrieve employees who have a salary greater than the average salary in their department.

SELECT * FROM employee_data AS E WHERE E.salary > 
(SELECT AVG(salary) FROM employee_data WHERE E.dept_id = dept_id );

--665...List customers who bought products on weekends.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE DATENAME(WEEKDAY,C.Purchase_Date) IN ('Saturday','Sunday');

--666...Retrieve employees hired in the last 3 years and their managers.

SELECT E.*,dept_id FROM employee_data AS E WHERE E.hire_date >= DATEADD(YEAR,-3,CAST(GETDATE() AS DATE));

--667...Get the total purchase value by customer for products purchased in the year 2023.

SELECT 
    c.Cust_id, 
    CONCAT(c.First_name, ' ', c.Last_name) AS Customer_Name, 
    SUM(c.Quantity * p.Prod_Price) AS Total_Purchase_Value
FROM 
    CUTOMER_DATA c
JOIN 
    PROD_DATA p 
    ON c.Product_id = p.Product_ID
WHERE 
    YEAR(c.Purchase_Date) = 2023
GROUP BY 
    c.Cust_id, c.First_name, c.Last_name
ORDER BY 
    Total_Purchase_Value DESC;

--668...Find the employees who purchased the most expensive product.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
ORDER BY P.Prod_Price DESC;


SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE P.Prod_Price =
(SELECT MAX(Prod_Price) FROM PROD_DATA);

SELECT * 
FROM CUTOMER_DATA AS C 
JOIN PROD_DATA AS P 
    ON C.Product_id = P.Product_ID
ORDER BY 
    P.Prod_Price DESC;

--669...Retrieve employees who have bought products priced below $200.

SELECT * 
FROM CUTOMER_DATA AS C 
JOIN PROD_DATA AS P 
    ON C.Product_id = P.Product_ID  WHERE P.Prod_Price < 200;

--670...List customers who purchased more than 5 products in total.

SELECT 
    c.Cust_id, 
    CONCAT(c.First_name, ' ', c.Last_name) AS Customer_Name, 
    SUM(c.Quantity) AS Total_Products_Purchased
FROM 
    CUTOMER_DATA c
GROUP BY 
    c.Cust_id, c.First_name, c.Last_name
HAVING 
    SUM(c.Quantity) > 5
ORDER BY 
    Total_Products_Purchased DESC;

--671...Retrieve the department-wise average salary of employees who bought products.

SELECT E.dept_name,P.Product_Name,P.Product_Type,AVG(E.salary) AS AVG_SALARY FROM employee_data AS E JOIN CUTOMER_DATA AS C ON E.first_name = C.First_name
JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id
GROUP BY E.dept_name,P.Product_Name,P.Product_Type;

--672...Find the products that have been purchased more than 10 times in 2023.

SELECT P.Product_Type, P.Product_Name, SUM(C.Quantity) AS TOTAL_QUANTITY
FROM     CUTOMER_DATA AS C INNER JOIN
                  PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE  (YEAR(C.Purchase_Date) = 2023)
GROUP BY P.Product_Type, P.Product_Name
HAVING (SUM(C.Quantity) > 10);

--673...Retrieve the top 5 employees with the highest salary in each department.

SELECT TOP 5 * FROM EMP_DATA ORDER BY Salary DESC;

SELECT * FROM 
(
SELECT *,
DENSE_RANK() OVER(ORDER BY Salary DESC) AS SALARY_RANK
FROM EMP_DATA
) AS A WHERE SALARY_RANK BETWEEN 1 AND 5;

--674...Find employees who purchased products from companies that also supply products in the "Electronics" category.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P  ON C.Product_id = P.Product_ID
WHERE P.Product_Type = 'Electronics';

--675...Retrieve customers who made purchases during their birthday month.

SELECT E.full_name,C.Cust_id,E.DOB,C.Purchase_Date 
FROM employee_data AS E JOIN CUTOMER_DATA AS C ON E.first_name = C.First_name
WHERE 
DATENAME(MONTH,E.DOB) = DATENAME(MONTH,C.Purchase_Date);

--676...List the number of products purchased by employees in each department, sorted by department.

SELECT 
    e.Department_id, 
    COUNT(c.Product_id) AS Total_Products_Purchased
FROM 
    EMP_DATA e
JOIN 
    CUTOMER_DATA c 
    ON e.First_name = c.First_name
GROUP BY 
    e.Department_id
ORDER BY 
    e.Department_id;

--677...Retrieve the total salary of employees in each department who bought products from "AutoWorks."

SELECT E.dept_name, SUM(E.salary) AS TOTAL_SALARY
FROM     employee_data AS E INNER JOIN
                  CUTOMER_DATA AS C ON E.first_name = C.First_name INNER JOIN
                  PROD_DATA AS P ON P.Product_ID = C.Product_id
WHERE  (P.Company_Name = 'CompanyB')
GROUP BY E.dept_name;

--678...Get the names of employees who purchased the most expensive product per department.

----------

SELECT 
    e.Department_id, 
    CONCAT(e.First_name, ' ', e.Last_name) AS Employee_Name, 
    p.Product_Name, 
    p.Prod_Price
FROM 
    EMP_DATA e
JOIN 
    CUTOMER_DATA c 
    ON e.First_name = c.First_name
JOIN 
    PROD_DATA p 
    ON c.Product_id = p.Product_ID
JOIN 
    (SELECT 
         e.Department_id, 
         MAX(p.Prod_Price) AS Max_Product_Price
     FROM 
         EMP_DATA e
     JOIN 
         CUTOMER_DATA c 
         ON e.Emp_id = c.Cust_id
     JOIN 
         PROD_DATA p 
         ON c.Product_id = p.Product_ID
     GROUP BY 
         e.Department_id) AS dmp
    ON e.Department_id = dmp.Department_id 
       AND p.Prod_Price = dmp.Max_Product_Price
ORDER BY 
    e.Department_id, Employee_Name;

--679...Find customers who bought products in a category they had not bought before.


SELECT DISTINCT 
    c1.Cust_id, 
    CONCAT(c1.First_name, ' ', c1.Last_name) AS Customer_Name, 
    p1.Product_Type AS New_Category, 
    c1.Purchase_Date
FROM 
    CUTOMER_DATA c1
JOIN 
    PROD_DATA p1 
    ON c1.Product_id = p1.Product_ID
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM CUTOMER_DATA c2
        JOIN PROD_DATA p2 
        ON c2.Product_id = p2.Product_ID
        WHERE 
            c1.Cust_id = c2.Cust_id
            AND p1.Product_Type = p2.Product_Type
            AND c2.Purchase_Date < c1.Purchase_Date
    )
ORDER BY 
    c1.Cust_id, c1.Purchase_Date;

--680...List employees who made purchases in the same month as their hire date.

SELECT 
E.Emp_id,
CONCAT(E.First_name,' ', E.Last_Name) AS CUTOMER_NAME,
CASE 
    WHEN MONTH(E.Hire_Date) = MONTH(C.Purchase_Date) THEN 'Yes'
    ELSE 'No'
END AS SAME_MONTH,
E.Hire_Date,
C.Purchase_Date
FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
WHERE MONTH(E.Hire_Date) = MONTH(C.Purchase_Date);

--681...Retrieve products purchased by customers in the last quarter of 2023.

SELECT DATEPART(QUARTER,C.Purchase_Date) AS QUARTER_NAME , C.*, P.* FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P 
ON C.Product_id = P.Product_ID 
WHERE YEAR(C.Purchase_Date) = 2023
AND DATEPART(QUARTER,C.Purchase_Date) = 4;

--682...Find the employees who purchased products with a total value higher than the average for their department.

SELECT 
    e.Emp_id, 
    CONCAT(e.First_name, ' ', e.Last_Name) AS Employee_Name, 
    e.Department_id, 
    SUM(c.Quantity * p.Prod_Price) AS Total_Purchase_Value
FROM 
    EMP_DATA e
JOIN 
    CUTOMER_DATA c 
    ON e.First_name = c.First_name
JOIN 
    PROD_DATA p 
    ON c.Product_id = p.Product_ID
GROUP BY 
    e.Emp_id, 
    e.First_name, 
    e.Last_Name, 
    e.Department_id
HAVING 
    SUM(c.Quantity * p.Prod_Price) > (
        SELECT 
            AVG(Department_Total.Total_Purchase_Value)
        FROM (
            SELECT 
                e.Department_id, 
                SUM(c.Quantity * p.Prod_Price) AS Total_Purchase_Value
            FROM 
                EMP_DATA e
            JOIN 
                CUTOMER_DATA c 
                ON e.First_name = c.First_name
            JOIN 
                PROD_DATA p 
                ON c.Product_id = p.Product_ID
            GROUP BY 
                e.Department_id
        ) AS Department_Total
        WHERE Department_Total.Department_id = e.Department_id
    )
ORDER BY 
    e.Department_id, Total_Purchase_Value DESC;

--683...List products that have not been purchased since 2022.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE YEAR(C.Purchase_Date) != 2022;

--684...Find the number of products sold by each company in 2023.

SELECT 
    p.Company_Name, 
    COUNT(c.Product_id) AS Total_Products_Sold
FROM 
    PROD_DATA p
JOIN 
    CUTOMER_DATA c 
    ON p.Product_ID = c.Product_id
WHERE 
    YEAR(c.Purchase_Date) = 2023
GROUP BY 
    p.Company_Name
ORDER BY 
    Total_Products_Sold DESC;

--685...Retrieve employees who bought the same product more than once.

SELECT 
    e.Emp_id, 
    CONCAT(e.First_name, ' ', e.Last_Name) AS Employee_Name, 
    p.Product_Name, 
    COUNT(c.Product_id) AS Purchase_Count
FROM 
    EMP_DATA e
JOIN 
    CUTOMER_DATA c 
    ON e.First_name = c.First_name
JOIN 
    PROD_DATA p 
    ON c.Product_id = p.Product_ID
GROUP BY 
    e.Emp_id, e.First_name, e.Last_Name, p.Product_Name
HAVING 
    COUNT(c.Product_id) > 1
ORDER BY 
    e.Emp_id, Purchase_Count DESC;

--686...Find employees who bought products costing more than the average salary in their department.

SELECT 
    e.Emp_id, 
    CONCAT(e.First_name, ' ', e.Last_Name) AS Employee_Name, 
    e.Department_id, 
    p.Product_Name, 
    p.Prod_Price, 
    AVG(e.Salary) OVER (PARTITION BY e.Department_id) AS Avg_Department_Salary
FROM 
    EMP_DATA e
JOIN 
    CUTOMER_DATA c 
    ON e.First_name = c.First_name
JOIN 
    PROD_DATA p 
    ON c.Product_id = p.Product_ID
WHERE 
    p.Prod_Price > (
        SELECT AVG(e1.Salary)
        FROM EMP_DATA e1
        WHERE e1.Department_id = e.Department_id
    )
ORDER BY 
    e.Department_id, e.Emp_id, p.Prod_Price DESC;

--687...List customers who made purchases on the last day of the month in 2023.

SELECT 
    c.Cust_id, 
    CONCAT(c.First_name, ' ', c.Last_Name) AS Customer_Name, 
    c.Purchase_Date, 
    p.Product_Name
FROM 
    CUTOMER_DATA c
JOIN 
    PROD_DATA p 
    ON c.Product_id = p.Product_ID
WHERE 
    YEAR(c.Purchase_Date) = 2023
    AND c.Purchase_Date = EOMONTH(c.Purchase_Date)
ORDER BY 
    c.Purchase_Date DESC;

--688...Retrieve employees whose salary is within the top 10% in their department.

WITH Salary_Rank AS (
    SELECT 
        e.Emp_id, 
        CONCAT(e.First_name, ' ', e.Last_Name) AS Employee_Name, 
        e.Department_id, 
        e.Salary, 
        RANK() OVER (PARTITION BY e.Department_id ORDER BY e.Salary DESC) AS Rank_Salary
    FROM 
        EMP_DATA e
)
SELECT 
    Emp_id, 
    Employee_Name, 
    Department_id, 
    Salary
FROM 
    Salary_Rank
WHERE 
    Rank_Salary <= (SELECT CEILING(COUNT(*) * 0.10) FROM EMP_DATA WHERE Department_id = Salary_Rank.Department_id)
ORDER BY 
    Department_id, Rank_Salary;

--689...Find employees who were hired between their first purchase and the last product they bought.

WITH Employee_Purchases AS (
    SELECT 
        e.Emp_id, 
        CONCAT(e.First_name, ' ', e.Last_Name) AS Employee_Name, 
        MIN(c.Purchase_Date) AS First_Purchase_Date, 
        MAX(c.Purchase_Date) AS Last_Purchase_Date
    FROM 
        EMP_DATA e
    JOIN 
        CUTOMER_DATA c 
        ON e.First_name = c.First_name
    GROUP BY 
        e.Emp_id, e.First_name, e.Last_Name
)
SELECT 
    ep.Emp_id, 
    ep.Employee_Name, 
    ep.First_Purchase_Date, 
    ep.Last_Purchase_Date, 
    e.Hire_Date
FROM 
    Employee_Purchases ep
JOIN 
    EMP_DATA e 
    ON ep.Emp_id = e.Emp_id
WHERE 
    e.Hire_Date BETWEEN ep.First_Purchase_Date AND ep.Last_Purchase_Date
ORDER BY 
    ep.Emp_id;

--690...Retrieve the most popular product for each department based on the number of employees who purchased it.

WITH Product_Purchase_Count AS (
    SELECT 
        e.Department_id,
        p.Product_Name, 
        COUNT(DISTINCT e.Emp_id) AS Num_Employees_Purchased
    FROM 
        EMP_DATA e
    JOIN 
        CUTOMER_DATA c ON e.First_name = c.First_name
    JOIN 
        PROD_DATA p ON c.Product_id = p.Product_ID
    GROUP BY 
        e.Department_id, p.Product_Name
)
SELECT 
    Department_id, 
    Product_Name, 
    Num_Employees_Purchased
FROM 
    Product_Purchase_Count
WHERE 
    (Department_id, Num_Employees_Purchased) IN (
        SELECT 
            Department_id, 
            MAX(Num_Employees_Purchased) 
        FROM 
            Product_Purchase_Count
        GROUP BY 
            Department_id
    )
ORDER BY 
    Department_id;

--691...Find the product category with the highest sales for customers in the "Marketing" department.

WITH Department_Purchases AS (
    SELECT 
        e.id,
        p.Product_Type, 
        SUM(p.Prod_Price * c.Quantity) AS Total_Sales
    FROM 
        employee_data e
    JOIN 
        CUTOMER_DATA c ON e.First_name = c.First_name
    JOIN 
        PROD_DATA p ON c.Product_id = p.Product_ID
    WHERE 
        e.id IN (SELECT Department_id FROM EMP_DATA WHERE dept_name = 'Marketing')
    GROUP BY 
        e.id, p.Product_Type
)
SELECT 
    id, 
    Product_Type, 
    Total_Sales
FROM 
    Department_Purchases
WHERE 
    Total_Sales IN (SELECT MAX(Total_Sales) FROM Department_Purchases WHERE id = Department_Purchases.id)
ORDER BY 
    Total_Sales DESC;

--692...List the employees who spent the most on products in 2023.

SELECT * FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
WHERE YEAR(C.Purchase_Date) = 2023;

WITH Employee_Spend AS (
    SELECT 
        e.Emp_id, 
        CONCAT(e.First_name, ' ', e.Last_Name) AS Employee_Name, 
        SUM(p.Prod_Price * c.Quantity) AS Total_Spent
    FROM 
        EMP_DATA e
    JOIN 
        CUTOMER_DATA c ON e.First_name = c.First_name
    JOIN 
        PROD_DATA p ON c.Product_id = p.Product_ID
    WHERE 
        YEAR(c.Purchase_Date) = 2023
    GROUP BY 
        e.Emp_id, e.First_name, e.Last_Name
)
SELECT 
    Emp_id, 
    Employee_Name, 
    Total_Spent
FROM 
    Employee_Spend
WHERE 
    Total_Spent = (SELECT MAX(Total_Spent) FROM Employee_Spend)
ORDER BY 
    Total_Spent DESC;

--693...Retrieve the most purchased product for each employee.

WITH Employee_Purchase_Count AS (
    SELECT 
        e.Emp_id, 
        CONCAT(e.First_name, ' ', e.Last_Name) AS Employee_Name, 
        p.Product_Name, 
        SUM(c.Quantity) AS Total_Quantity
    FROM 
        EMP_DATA e
    JOIN 
        CUTOMER_DATA c ON e.First_name = c.First_name
    JOIN 
        PROD_DATA p ON c.Product_id = p.Product_ID
    GROUP BY 
        e.Emp_id, e.First_name, e.Last_Name, p.Product_Name
)
SELECT 
    Emp_id, 
    Employee_Name, 
    Product_Name, 
    Total_Quantity
FROM 
    Employee_Purchase_Count epc
WHERE 
    (Emp_id, Total_Quantity) IN (
        SELECT 
            Emp_id, 
            MAX(Total_Quantity) 
        FROM 
            Employee_Purchase_Count
        GROUP BY 
            Emp_id
    )
ORDER BY 
    Emp_id;

--694...Find employees whose total purchase amount is greater than their salary.

WITH CTE AS (
SELECT 
E.Emp_id,
CONCAT(E.First_name,' ',E.Last_Name) AS FULL_NAME,
SUM(C.Quantity * P.Prod_Price) AS Total_Purchase_Amount
FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id
GROUP BY 
        E.Emp_id, E.First_name, E.Last_Name
)
SELECT C.* FROM CTE AS C JOIN EMP_DATA  AS A
ON C.Emp_id = A.Emp_id
WHERE C.Total_Purchase_Amount > A.Salary;

--695...List the departments with the highest average employee salary who purchased products from "Gizmo Inc."
WITH CTE AS (
SELECT 
E.dept_id,
E.dept_name,
AVG(E.salary) AS avg_salary
FROM employee_data AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id
WHERE P.Company_Name = 'CompanyB'
GROUP BY 
E.dept_id,
E.dept_name
)

SELECT * FROM CTE 
WHERE avg_salary = (SELECT MAX(avg_salary) FROM CTE)

--696...Retrieve customers who bought products from the same company multiple times in 2023.

WITH CTE AS (
SELECT 
C.Cust_id,
        P.Company_Name,
        COUNT(*) AS Purchase_Count
FROM employee_data AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id
WHERE YEAR(C.Purchase_Date) = 2023
GROUP BY 
C.Cust_id,
        P.Company_Name
)
SELECT CP.Cust_id,
    CP.First_name,
    CP.Last_Name ,C.* FROM CTE AS C JOIN CUTOMER_DATA AS CP
ON C.Cust_id = CP.Cust_id
WHERE Purchase_Count > 1;

--697...Find the top 3 most expensive products bought by employees in each department.

WITH CTE AS (
SELECT 
E.dept_id,
E.dept_name,
P.Product_Name,
P.Prod_Price,
ROW_NUMBER() OVER(PARTITION BY E.dept_id ORDER BY P.Prod_Price DESC) AS RANK_SALARY
FROM employee_data AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id
)
SELECT * FROM CTE AS C WHERE C.RANK_SALARY < = 3
ORDER BY dept_id,RANK_SALARY;

--698...Retrieve the total purchase amount for each employee, including only purchases made after they were hired.

WITH CTE AS (
SELECT 
E. Emp_id,
E.First_name,
E.Last_Name,
SUM(C.Quantity * P.Prod_Price) AS TOTAL_PURCHASE_COUNT
FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id
WHERE 
C.Purchase_Date > E.Hire_Date
GROUP BY 
E. Emp_id,
E.First_name,
E.Last_Name
)
SELECT * FROM CTE
ORDER BY TOTAL_PURCHASE_COUNT DESC;

--699...Find employees who bought products that cost more than their salary.

WITH CTE AS (
SELECT 
E. Emp_id,
E.First_name,
E.Last_Name,
SUM(C.Quantity * P.Prod_Price) AS TOTAL_PURCHASE_COUNT
FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id
GROUP BY E. Emp_id,
E.First_name,
E.Last_Name
)
SELECT C.*, EP.Salary, EP.Emp_id FROM CTE AS C JOIN EMP_DATA AS EP
ON C.Emp_id = EP.Emp_id
WHERE C.TOTAL_PURCHASE_COUNT > EP.Salary;

--700...List customers who purchased products from both "Tech" and "Auto" companies in the same year.

WITH CustomerCompanies AS (
    SELECT 
        C.Cust_id,
        P.Company_Name,
        YEAR(C.Purchase_Date) AS Purchase_Year
    FROM 
        CUTOMER_DATA AS C
    JOIN 
        PROD_DATA AS P ON C.Product_id = P.Product_ID
    WHERE 
        P.Company_Name IN ('CompanyC', 'CompanyD')
)
SELECT 
    C.Cust_id,
    C.First_name,
    C.Last_Name
FROM 
    CUTOMER_DATA AS C
JOIN 
    CustomerCompanies AS CC ON C.Cust_id = CC.Cust_id
GROUP BY 
    C.Cust_id, C.First_name, C.Last_Name
HAVING 
    COUNT(DISTINCT CC.Company_Name) = 2
ORDER BY 
    C.Cust_id;

--701...Retrieve the products with the highest total sales, grouped by product type.

WITH ProductSales AS (
    SELECT 
        P.Product_ID,
        P.Product_Name,
        P.Product_Type,
        SUM(P.Prod_Price * C.Quantity) AS Total_Sales
    FROM 
        CUTOMER_DATA AS C
    JOIN 
        PROD_DATA AS P ON C.Product_id = P.Product_ID
    GROUP BY 
        P.Product_ID, P.Product_Name, P.Product_Type
)
SELECT 
    Product_Type,
    Product_Name,
    Total_Sales
FROM 
    ProductSales
WHERE 
    Total_Sales = (SELECT MAX(Total_Sales) FROM ProductSales WHERE Product_Type = ProductSales.Product_Type)
ORDER BY 
    Product_Type, Total_Sales DESC;

--702...Find employees whose purchase pattern matches the most frequent purchase pattern among all employees.
/*
WITH EmployeePurchases AS (
    SELECT 
        E.Emp_id,
        CONCAT(E.First_name, ' ', E.Last_Name) AS Employee_Name,
        P.Product_Type,
        COUNT(*) AS Purchase_Count
    FROM 
        EMP_DATA AS E
    JOIN 
        CUTOMER_DATA AS C ON E.First_name = C.First_name
    JOIN 
        PROD_DATA AS P ON C.Product_id = P.Product_ID
    GROUP BY 
        E.Emp_id, E.First_name, E.Last_Name, P.Product_Type
),
MostFrequentPattern AS (
    SELECT 
        Product_Type,
        MAX(Purchase_Count) AS Max_Purchase_Count
    FROM 
        EmployeePurchases
    GROUP BY 
        Product_Type
)
SELECT 
    E.Emp_id,
    E.First_name,
    E.Last_Name,
    EP.Product_Type,
    EP.Purchase_Count
FROM 
    EmployeePurchases AS EP
JOIN 
    MostFrequentPattern AS MFP ON EP.Product_Type = MFP.Product_Type
WHERE 
    EP.Purchase_Count = MFP.Max_Purchase_Count
ORDER BY 
    E.Emp_id, EP.Product_Type;

*/

--703...Retrieve employees who have a higher salary than the average salary of employees who purchased the same product.


WITH ProductEmployeeSalaries AS (
    SELECT 
        E.Emp_id,
        E.First_name,
        E.Last_Name,
        E.Salary,
        P.Product_ID,
        AVG(E.Salary) OVER (PARTITION BY P.Product_ID) AS Avg_Salary_For_Product
    FROM 
        EMP_DATA AS E
    JOIN 
        CUTOMER_DATA AS C ON E.First_name = C.First_name
    JOIN 
        PROD_DATA AS P ON C.Product_id = P.Product_ID
)
SELECT 
    Emp_id,
    First_name,
    Last_Name,
    Salary,
    Avg_Salary_For_Product
FROM 
    ProductEmployeeSalaries
WHERE 
    Salary > Avg_Salary_For_Product
ORDER BY 
    Salary DESC;

--704...List customers who bought products that were purchased less than 5 times in total.

WITH ProductPurchaseCount AS (
    SELECT 
        C.Product_id,
        COUNT(*) AS Total_Purchases
    FROM 
        CUTOMER_DATA AS C
    GROUP BY 
        C.Product_id
    HAVING 
        COUNT(*) < 5
)
SELECT 
    C.Cust_id,
    C.First_name,
    C.Last_Name,
    P.Product_Name
FROM 
    CUTOMER_DATA AS C
JOIN 
    ProductPurchaseCount AS PPC ON C.Product_id = PPC.Product_id
JOIN 
    PROD_DATA AS P ON C.Product_id = P.Product_ID
ORDER BY 
    C.Cust_id;

----------------------------------------------CTE-----------------------------------------------------------------------------------------
--705...Write a CTE to find the total salary of all employees.

WITH CTE AS 
(
SELECT SUM(Salary) AS TOTAL_SALARY FROM EMP_DATA
)
SELECT * FROM CTE;


----------------------------------------------CASE STATEMENT-----------------------------------------------------------------------------------------
--706...Classify employees based on salary into three categories: Low, Medium, and High.

SELECT First_name,Last_Name,Salary,
CASE
WHEN Salary > 100000 THEN 'HIGH'
WHEN Salary >= 50000 AND Salary<= 99999 THEN 'Medium'
ELSE 'Low'
END categories
FROM EMP_DATA;

--707...Create a query to categorize employees based on their age: Young, Middle-aged, and Senior.

SELECT First_name,Last_Name,Salary,DOB,
CASE
WHEN DATEDIFF(YEAR,DOB,GETDATE()) < 30 THEN 'Young'
WHEN DATEDIFF(YEAR,DOB,GETDATE()) BETWEEN 30 AND 50 THEN 'Middle-aged'
ELSE 'Senior'
END age
FROM employee_data;


--708...Retrieve a list of customers and show if their total purchase is above or below $500 using a CASE statement.

SELECT 
    C.Cust_id,
    C.First_name, C.Last_Name,
    SUM(P.Prod_Price * C.Quantity) AS Total_Purchase,
    CASE 
        WHEN SUM(P.Prod_Price * C.Quantity) > 500 THEN 'Above $500'
        ELSE 'Below $500'
    END AS Purchase_Category
FROM 
    CUTOMER_DATA AS C
JOIN 
    PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY 
    C.Cust_id, C.First_name, C.Last_Name;

--709...Display the department names and a case statement to show if the department has more than 50 employees.

SELECT 
    dept_name AS Department_Name,
    CASE 
        WHEN COUNT(E.id) > 50 THEN 'More than 50 employees'
        ELSE '50 or fewer employees'
    END AS Employee_Count_Category
FROM 
    employee_data AS E
GROUP BY 
    dept_name;

--710...Classify products as 'On Sale' or 'Full Price' based on whether their price is below $100.

SELECT 
    Product_Name,
    CASE 
        WHEN Prod_Price < 100 THEN 'On Sale'
        ELSE 'Full Price'
    END AS Price_Category
FROM 
    PROD_DATA;

--711...Retrieve orders and categorize them as 'Urgent' if the delivery date is within the next 3 days.

SELECT 
   c.*,
    CASE 
        WHEN DATEDIFF(DAY, GETDATE(), c.Purchase_Date) <= 3 THEN 'Urgent'
        ELSE 'Standard'
    END AS Order_Category
FROM 
    CUTOMER_DATA as c;

--712...Use CASE to calculate the tax rate based on different countries for products purchased internationally.

select 
P.Product_Name,
E.location,
P.Prod_Price,
CASE
WHEN E.location = 'Victoriatown' THEN P.Prod_Price * 0.07
WHEN E.location = 'North Jasonside' THEN P.Prod_Price * 0.2
WHEN E.location = 'Lake Crystal' THEN P.Prod_Price * 0.05
WHEN E.location = 'Nixonstad' THEN P.Prod_Price * 0.18
ELSE P.Prod_Price * 0.1
END TAX_AMOUT
from employee_data as e join CUTOMER_DATA as c on E.first_name = C.First_name
JOIN PROD_DATA AS P ON P.Product_ID = C.Product_id;

--713...Generate a report showing employees and whether they received a bonus, based on their performance rating.

/*SELECT 
    Emp_id,
    CONCAT(First_name, ' ', Last_name) AS Employee_Name,
    Performance_Rating,
    CASE
        WHEN Performance_Rating >= 4.5 THEN 'Bonus Received'
        ELSE 'No Bonus'
    END AS Bonus_Status
FROM 
    employee_data;
*/

--714...Use CASE to display employee names with a label based on their performance: 'Excellent', 'Good', 'Needs Improvement'.

/*SELECT 
    Emp_id,
    CONCAT(First_name, ' ', Last_name) AS Employee_Name,
    Performance_Rating,
    CASE
        WHEN Performance_Rating >= 4.5 THEN 'Excellent'
        WHEN Performance_Rating BETWEEN 3.0 AND 4.4 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS Performance_Label
FROM 
    employee_data;
*/

--715...Determine the sales tax percentage based on order amount: 5% for < $100, 10% for $100-$500, 15% for > $500.

SELECT 
    c.Cust_id,
    CONCAT(c.First_name, ' ', c.Last_name) AS Customer_Name,
    p.Product_Name,
    (c.Quantity * p.Prod_Price) AS Total_Order_Amount,
    CASE
        WHEN (c.Quantity * p.Prod_Price) < 100 THEN 5
        WHEN (c.Quantity * p.Prod_Price) BETWEEN 100 AND 500 THEN 10
        ELSE 15
    END AS Tax_Percentage
FROM 
    CUTOMER_DATA c
JOIN 
    PROD_DATA p ON c.Product_id = p.Product_ID;

--716...Show product names and apply a discount: 10% for 'Electronics', 5% for 'Clothing', and no discount for others.

SELECT P.*,
CASE
WHEN P.Product_Type = 'Electronics' THEN P.PROD_PRICE * 0.10
WHEN P.Product_Type = 'Clothing' THEN P.PROD_PRICE *0.95
ELSE P.PROD_PRICE
END AS Discounted_Price
FROM  PROD_DATA AS P ;

--717...Display orders with a status of 'Completed', 'Pending', or 'Cancelled' using CASE.

/*SELECT 
    Order_ID,
    Customer_ID,
    Product_ID,
    Order_Status,
    CASE
        WHEN Order_Status = 'Completed' THEN 'Order Completed'
        WHEN Order_Status = 'Pending' THEN 'Order Pending'
        WHEN Order_Status = 'Cancelled' THEN 'Order Cancelled'
        ELSE 'Unknown Status'
    END AS Status_Description
FROM 
    Orders;
*/

--718...Group products by their category and display a label for each category using CASE.

SELECT 
    Product_Name,
    Product_Type,
    CASE
        WHEN Product_Type = 'Electronics' THEN 'Technology Category'
        WHEN Product_Type = 'Clothing' THEN 'Fashion Category'
        WHEN Product_Type = 'Furniture' THEN 'Home & Living'
        WHEN Product_Type = 'Grocery' THEN 'Food & Essentials'
        ELSE 'Other Category'
    END AS Category_Label
FROM 
    PROD_DATA
GROUP BY 
    Product_Name, Product_Type;

--719...Calculate the final price for customers based on whether they are a 'Premium' or 'Regular' member.

/*
SELECT 
    Customer_ID,
    Product_ID,
    Prod_Price,
    Membership_Type,
    CASE
        WHEN Membership_Type = 'Premium' THEN Prod_Price * 0.85  -- 15% discount for Premium members
        WHEN Membership_Type = 'Regular' THEN Prod_Price         -- No discount for Regular members
        ELSE Prod_Price                                          -- No discount if no membership type
    END AS Final_Price
FROM 
    CUSTOMER_DATA;
*/

--720...Find out if each product’s price is above or below the average product price.

SELECT P.*,
CASE
WHEN P.Prod_Price > (SELECT AVG(Prod_Price) FROM PROD_DATA) THEN 'Above Average'
WHEN P.Prod_Price < (SELECT AVG(Prod_Price) FROM PROD_DATA) THEN 'Below Average'
ELSE 'Average'
END ALL_RECORD
FROM PROD_DATA AS P;

--721...Group employees by their department and assign a label: 'HR', 'Finance', 'Engineering', etc.

SELECT 
    Dept_name,
    COUNT(id) AS Employee_Count,
    CASE
        WHEN Dept_name = 'HR' THEN 'Human Resources'
        WHEN Dept_name = 'Finance' THEN 'Finance Department'
        WHEN Dept_name = 'Engineering' THEN 'Engineering Department'
        WHEN Dept_name = 'Sales' THEN 'Sales Department'
        WHEN Dept_name = 'Marketing' THEN 'Marketing Department'
        ELSE 'Other Department'
    END AS Department_Label
FROM 
    employee_data
GROUP BY 
    Dept_name;

--722...Use CASE to show whether customers made a purchase in the past 30 days or not.

SELECT 
    First_name,
	Last_Name,
    Purchase_Date,
    CASE
        WHEN Purchase_Date >= DATEADD(DAY, -30, GETDATE()) THEN 'Made Purchase in Last 30 Days'
        ELSE 'No Purchase in Last 30 Days'
    END AS Purchase_Status
FROM 
    CUTOMER_DATA;

SELECT 
    First_name,
	Last_Name,
    Purchase_Date,
    CASE
        WHEN DATEDIFF(DAY, Purchase_Date, GETDATE()) <= 30 THEN 'Made Purchase in Last 30 Days'
        ELSE 'No Purchase in Last 30 Days'
    END AS Purchase_Status
FROM 
    CUTOMER_DATA;

--723...Calculate employee bonus based on their sales performance: 5% for < $10,000, 10% for $10,000-$50,000, and 15% for > $50,000.

SELECT C.*,P.Prod_Price,
CASE
WHEN (C.Quantity * P.Prod_Price) < 1000 THEN P.Prod_Price*0.05
WHEN (C.Quantity * P.Prod_Price) BETWEEN  1000 AND 5000 THEN P.Prod_Price*0.10
WHEN (C.Quantity * P.Prod_Price) > 5000 THEN P.Prod_Price*0.15
ELSE 0
END BONUS
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P 
ON C.Product_id = P.Product_ID

--724...Retrieve customer orders and categorize them based on the payment method: 'Credit', 'Debit', or 'Cash'.

/*
SELECT 
    Order_ID,
    Customer_Name,
    Order_Date,
    Payment_Method,
    CASE
        WHEN Payment_Method = 'Credit' THEN 'Credit'
        WHEN Payment_Method = 'Debit' THEN 'Debit'
        WHEN Payment_Method = 'Cash' THEN 'Cash'
        ELSE 'Other'
    END AS Payment_Category
FROM 
    CUSTOMER_ORDERS;
*/

--725...Count the number of employees who belong to each salary category (Low, Medium, High).

SELECT E.id,
E.first_name,
E.last_name,
COUNT(*) AS ALL_COUNT,
CASE
WHEN E.salary > 100000 THEN 'High'
WHEN E.salary BETWEEN 50000 AND 100000 THEN 'Medium'
WHEN E.salary < 50000 THEN 'Low'
END AS salary_category
FROM employee_data AS E
GROUP BY 
E.id,
E.first_name,
E.last_name,
E.salary
 ORDER BY ALL_COUNT DESC;
---------------------
SELECT 
    CASE
        WHEN E.salary > 100000 THEN 'High'
WHEN E.salary BETWEEN 50000 AND 100000 THEN 'Medium'
WHEN E.salary < 50000 THEN 'Low'
        ELSE 'Unknown'
    END AS Salary_Category,
    COUNT(*) AS Employee_Count
FROM 
    EMP_DATA AS E
GROUP BY 
    CASE
        WHEN E.salary > 100000 THEN 'High'
WHEN E.salary BETWEEN 50000 AND 100000 THEN 'Medium'
WHEN E.salary < 50000 THEN 'Low'
        ELSE 'Unknown'
    END;

--726...Calculate the total sales for each product type and categorize the sales into ranges (low, medium, high).

SELECT 
    P.Product_Type,
    SUM(C.Quantity * P.Prod_Price) AS Total_Sales,
    CASE
        WHEN SUM(C.Quantity * P.Prod_Price) < 1000 THEN 'Low'
        WHEN SUM(C.Quantity * P.Prod_Price) BETWEEN 1000 AND 5000 THEN 'Medium'
        WHEN SUM(C.Quantity * P.Prod_Price) > 5000 THEN 'High'
    END AS Sales_Category
FROM 
    CUTOMER_DATA AS C
JOIN 
    PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY 
    P.Product_Type;

--727...Sum the total number of orders placed by each customer based on product category using CASE.

SELECT 
    C.Cust_id,
    C.First_name,
    C.Last_Name,
    SUM(CASE
            WHEN P.Product_Type = 'Electronics' THEN C.Quantity
            WHEN P.Product_Type = 'Clothing' THEN C.Quantity
            WHEN P.Product_Type = 'Furniture' THEN C.Quantity
            ELSE 0
        END) AS Total_Orders
FROM 
    CUTOMER_DATA AS C
JOIN 
    PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY 
    C.Cust_id, C.First_name, C.Last_Name;

--728...Find the average salary for each department and classify the salary range: 'Below Average', 'Average', 'Above Average'.

SELECT 
    E.Dept_name,
    AVG(E.Salary) AS Avg_Salary,
    CASE
        WHEN AVG(E.Salary) < (SELECT AVG(Salary) FROM EMP_DATA) THEN 'Below Average'
        WHEN AVG(E.Salary) = (SELECT AVG(Salary) FROM EMP_DATA) THEN 'Average'
        WHEN AVG(E.Salary) > (SELECT AVG(Salary) FROM EMP_DATA) THEN 'Above Average'
    END AS Salary_Range
FROM 
    employee_data AS E
GROUP BY 
    E.Dept_name;

--729...Classify the total revenue from each product as 'Low', 'Medium', or 'High' based on the total sales.

SELECT 
    P.Product_Name,
    SUM(P.Prod_Price * C.Quantity) AS Total_Revenue,
    CASE
        WHEN SUM(P.Prod_Price * C.Quantity) < 500 THEN 'Low'
        WHEN SUM(P.Prod_Price * C.Quantity) BETWEEN 500 AND 5000 THEN 'Medium'
        WHEN SUM(P.Prod_Price * C.Quantity) > 5000 THEN 'High'
    END AS Revenue_Category
FROM 
    CUTOMER_DATA AS C
JOIN 
    PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY 
    P.Product_Name;

--730...Count the number of employees who fall into each grade level (e.g., 'Manager', 'Senior', 'Junior') based on their years of experience.

SELECT 
CASE 
  WHEN DATEDIFF(YEAR,DOB,GETDATE()) > 35 THEN 'Manager'
    WHEN DATEDIFF(YEAR,DOB,GETDATE()) BETWEEN 25 AND 35 THEN 'Senior'
	    WHEN DATEDIFF(YEAR,DOB,GETDATE()) < 25 THEN 'Junior'
		ELSE 'NOTHING'
		END Grade_Level,
		COUNT(*) AS TOTAL_COUNT
FROM employee_data
GROUP BY 
CASE 
  WHEN DATEDIFF(YEAR,DOB,GETDATE()) > 35 THEN 'Manager'
    WHEN DATEDIFF(YEAR,DOB,GETDATE()) BETWEEN 25 AND 35 THEN 'Senior'
	    WHEN DATEDIFF(YEAR,DOB,GETDATE()) < 25 THEN 'Junior'
		ELSE 'NOTHING'
		END;

--731...Sum the product sales and categorize them as 'Low Revenue', 'Moderate Revenue', and 'High Revenue'.

SELECT 
    P.Product_Name,
    SUM(C.Quantity * P.Prod_Price) AS Total_Revenue,
    CASE
        WHEN SUM(C.Quantity * P.Prod_Price) < 500 THEN 'Low Revenue'
        WHEN SUM(C.Quantity * P.Prod_Price) BETWEEN 500 AND 1000 THEN 'Moderate Revenue'
        WHEN SUM(C.Quantity * P.Prod_Price) > 1000 THEN 'High Revenue'
    END AS Revenue_Category
FROM 
    PROD_DATA AS P
JOIN 
    CUTOMER_DATA AS C ON P.Product_ID = C.Product_id
GROUP BY 
    P.Product_Name;

--732...Group the employees by department and categorize their salary into ranges using CASE.

SELECT
dept_name,
CASE
WHEN salary < 50000 THEN 'LOW_SAL'
WHEN salary BETWEEN 50000 AND 100000 THEN 'MED_SALARY'
WHEN salary > 100000 THEN 'HIGH_SAL'
END SALARY_RANG
FROM employee_data

--733...Aggregate product sales by region and categorize them into 'High' and 'Low' based on total sales.

SELECT 
E.location,
SUM(C.Quantity * P.Prod_Price) AS TOTAL_SALES,
CASE
    WHEN 
          SUM(C.Quantity * P.Prod_Price)  >= 10000 THEN 'HIGH' 
		  ELSE 'LOW'
END 'Sales_Category'
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
JOIN employee_data AS E ON E.first_name = C.First_name
GROUP BY E.location;

--734...Retrieve and count how many products have been sold more than 10 times, less than 10 times, or never sold.

SELECT 
CASE
 WHEN SUM(C.Quantity) > 10 THEN 'MORE THAN 10 TIMES'
  WHEN SUM(C.Quantity) BETWEEN 1 AND 10 THEN 'LESS THAN 10 TIMES'
  ELSE 'NEVER SOLD'
END Sale_Category,
    COUNT(P.Product_ID) AS Product_Count
FROM PROD_DATA AS P JOIN CUTOMER_DATA AS C ON P.Product_ID = C.Product_id
GROUP BY 
CASE
 WHEN SUM(C.Quantity) > 10 THEN 'MORE THAN 10 TIMES'
  WHEN SUM(C.Quantity) < 10 THEN 'LESS THAN 10 TIMES'
  ELSE 'NEVER SOLD'
END;

--735...Use CASE to label employees as 'New Hire' if they joined in the last 6 months, else 'Experienced'.

SELECT 
full_name,
id,
salary,
hire_date
,
CASE
WHEN hire_date >= DATEADD(MONTH,-6,GETDATE()) THEN 'NEW_JOIN'
ELSE 'Experienced'
END Employee_Status
FROM employee_data;
--DATEDIFF(MONTH, E.Hire_Date, GETDATE()) <= 6;

--736...Display employee names along with their employment status as 'Active' or 'Inactive' based on their last login date.
/*SELECT 
    E.id,
    CONCAT(E.First_name, ' ', E.Last_name) AS Employee_Name,
    E.Last_Login_Date,
    CASE 
        WHEN E.Last_Login_Date >= DATEADD(DAY, -30, GETDATE()) THEN 'Active'
        ELSE 'Inactive'
    END AS Employment_Status
FROM 
    employee_data AS E;
*/

--737...Show product discounts based on the order date: 10% for orders placed within the last 7 days, no discount otherwise.

SELECT 
P.Product_ID,
P.Product_Name,
C.Purchase_Date,
P.Prod_Price,
CASE
WHEN C.Purchase_Date >= DATEADD(DAY,-7,GETDATE()) THEN P.Prod_Price*0.10
ELSE 0
END Discount_Amount,
CASE
WHEN C.Purchase_Date >= DATEADD(DAY,-7,GETDATE()) THEN P.Prod_Price*0.90
ELSE P.Prod_Price
END Final_Price
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID;

--738...Display products and categorize their availability based on how long they have been in stock: 'New', 'Old', 'Very Old'.

SELECT 
    P.Product_ID,
    P.Product_Name,
    C.Purchase_Date,
    CASE
        WHEN DATEDIFF(DAY, C.Purchase_Date, GETDATE()) <= 30 THEN 'New'
        WHEN DATEDIFF(DAY, C.Purchase_Date, GETDATE()) BETWEEN 31 AND 180 THEN 'Old'
        ELSE 'Very Old'
    END AS Availability_Status,
CASE
        WHEN C.Purchase_Date >= DATEADD(DAY,-30 , GETDATE())  THEN 'New'
        WHEN C.Purchase_Date BETWEEN DATEADD(DAY,-180, GETDATE()) AND DATEADD(DAY,-31, GETDATE())   THEN 'Old'
        ELSE 'Very Old'
    END AS Availability_Status_DATEADD

FROM 
    PROD_DATA AS P JOIN CUTOMER_DATA AS C ON P.Product_ID = C.Product_id;

--738...Use CASE to show 'On Time' or 'Late' for orders based on whether the delivery date has passed.
/*SELECT 
    O.Order_ID,
    O.Customer_ID,
    O.Order_Date,
    O.Delivery_Date,
    CASE
        WHEN O.Delivery_Date >= CAST(GETDATE() AS DATE) THEN 'On Time'
        ELSE 'Late'
    END AS Delivery_Status
FROM 
    Orders AS O;
*/

--739...Classify customers based on the month of their 
--first purchase: 'Early Year' for January to March, 'Mid Year' for April to June, and 'Late Year' for July to December.

SELECT 
C.*,
CASE 
WHEN MONTH(C.Purchase_Date) BETWEEN 1 AND 3 THEN 'Early Year'
WHEN MONTH(C.Purchase_Date) BETWEEN 4 AND 6 THEN 'MID Year'
WHEN MONTH(C.Purchase_Date) BETWEEN 7 AND 12 THEN 'LATE Year'
END Purchase_Classification
FROM CUTOMER_DATA AS C;

--740...Display the number of days an employee has been employed and label them as 'Probation' or 'Permanent' based on their employment duration.

SELECT 
    E.ID,
    E.First_Name,
    E.Last_Name,
    DATEDIFF(DAY, E.Hire_Date, GETDATE()) AS Days_Employed,
    CASE
        WHEN DATEDIFF(DAY, E.Hire_Date, GETDATE()) <= 180 THEN 'Probation'
        ELSE 'Permanent'
    END AS Employment_Status
FROM 
    Employee_Data AS E;

--741..Show the status of orders placed within the past week, showing 'Recent' or 'Older'.
/*
SELECT 
    O.Order_ID,
    O.Customer_ID,
    O.Order_Date,
    CASE
        WHEN DATEDIFF(DAY, O.Order_Date, GETDATE()) <= 7 THEN 'Recent'
        ELSE 'Older'
    END AS Order_Status
FROM 
    Order_Data AS O;
*/

--742...Display employee hire status as 'Recently Hired' for those hired in the last 90 days and 'Long-Term' for others.

SELECT 
E.id,
E.first_name,
CASE
WHEN hire_date >= DATEADD(DAY,-90,CAST(GETDATE() AS DATE)) THEN 'Recently Hired'
ELSE 'Long-Term'
END AS HIRE_STATUS,
CASE
WHEN  DATEDIFF(DAY,E.hire_date,CAST(GETDATE() AS DATE)) <= 90 THEN 'Recently Hired'
ELSE 'Long-Term'
END AS HIRE_STATUS_NEXT
FROM employee_data AS E;

--743...Calculate how many days ago each order was placed and classify the orders as 'Recent', 'Old', or 'Very Old'.

SELECT 
CONCAT(C.First_name,' ',C.Last_Name) AS CUTOMER_NAME,
C.Quantity,
C.Purchase_Date,
CASE
WHEN C.Purchase_Date >= DATEADD(DAY,-7,CAST(GETDATE() AS DATE)) THEN 'Recent'
WHEN C.Purchase_Date >= DATEADD(DAY,-37,CAST(GETDATE() AS DATE)) THEN 'Old'
ELSE 'Very Old'
END  classify_the_orders
FROM CUTOMER_DATA AS C
ORDER BY classify_the_orders ASC;

--744...Display product names and categorize them as 'Electronics', 'Furniture', 'Clothing', etc., based on product categories.

SELECT 
    P.Product_Name,
    P.PRODUCT_ID,
    CASE
        WHEN P.PRODUCT_ID = 1 THEN 'Electronics'
        WHEN P.PRODUCT_ID = 2 THEN 'Furniture'
        WHEN P.PRODUCT_ID = 3 THEN 'Clothing'
        WHEN P.PRODUCT_ID = 4 THEN 'Groceries'
        WHEN P.PRODUCT_ID = 5 THEN 'Books'
        ELSE 'Other'
    END AS Product_Category
FROM 
    PROD_DATA AS P;

--745...Categorize customer feedback as 'Positive', 'Neutral', or 'Negative' based on certain keywords in the feedback.

/*SELECT 
    C.Customer_ID,
    C.Feedback,
    CASE
        WHEN C.Feedback LIKE '%excellent%' OR C.Feedback LIKE '%great%' OR C.Feedback LIKE '%satisfied%' THEN 'Positive'
        WHEN C.Feedback LIKE '%okay%' OR C.Feedback LIKE '%average%' OR C.Feedback LIKE '%neutral%' THEN 'Neutral'
        WHEN C.Feedback LIKE '%poor%' OR C.Feedback LIKE '%bad%' OR C.Feedback LIKE '%unsatisfied%' THEN 'Negative'
        ELSE 'Uncategorized'
    END AS Feedback_Category
FROM 
    Customer_Feedback AS C;
*/

--746...List employees and classify them based on their job title: 'Manager', 'Developer', 'Analyst', etc.

/*SELECT 
    E.Employee_ID,
    E.First_Name,
    E.Last_Name,
    E.Job_Title,
    CASE
        WHEN E.Job_Title LIKE '%Manager%' THEN 'Manager'
        WHEN E.Job_Title LIKE '%Developer%' THEN 'Developer'
        WHEN E.Job_Title LIKE '%Analyst%' THEN 'Analyst'
        WHEN E.Job_Title LIKE '%Engineer%' THEN 'Engineer'
        ELSE 'Other'
    END AS Job_Classification
FROM 
    Employee_Data AS E;
*/

--747...Classify orders as 'International' or 'Domestic' based on the shipping country.

/*SELECT 
    O.Order_ID,
    O.Customer_ID,
    O.Shipping_Country,
    CASE
        WHEN O.Shipping_Country = 'USA' THEN 'Domestic'
        ELSE 'International'
    END AS Order_Type
FROM 
    Orders_Data AS O;
*/

--748...Display employees and categorize them by their department: 'Sales', 'HR', 'Finance', etc.

SELECT 
    E.ID,
    E.First_Name,
    E.Last_Name,
    E.dept_name,
    CASE 
        WHEN E.dept_name = 'Sales' THEN 'Sales'
        WHEN E.dept_name = 'HR' THEN 'Human Resources'
        WHEN E.dept_name = 'Finance' THEN 'Finance'
        WHEN E.dept_name = 'IT' THEN 'Information Technology'
        WHEN E.dept_name = 'Operations' THEN 'Operations'
        ELSE 'Other'
    END AS Department_Category
FROM 
    Employee_Data AS E;

--749...Create a report that classifies employees based on their job level: 'Senior', 'Mid-Level', and 'Junior'.

SELECT
E.id,
E.full_name,
E.DOB,
CASE
WHEN DATEDIFF(YEAR,hire_date,CAST(GETDATE()AS DATE)) <=5 THEN 'Junior'
WHEN DATEDIFF(YEAR,hire_date,CAST(GETDATE()AS DATE)) BETWEEN 5 AND 10 THEN 'Mid-Level'
WHEN DATEDIFF(YEAR,hire_date,CAST(GETDATE()AS DATE)) >=11 THEN 'Senior'
ELSE 'NOTHING'
END AS job_level
FROM employee_data AS E

--750...Calculate a dynamic bonus based on performance: 5% for sales between $10,000-$20,000, 10% for 
--sales between $20,001-$50,000, and 15% for above $50,000.


SELECT A.*,ROUND((A.SALES_AMOUNT-A.DISCOUNT),2) AS TOTAL_PAY_AMOUNT_AFTER_DISCOUNT FROM (
SELECT 
C.Product_id,
CONCAT(C.First_name,' ',C.Last_Name) AS CUSTOMER_NAME,
C.Quantity,
P.Prod_Price,
(C.Quantity * P.Prod_Price) AS SALES_AMOUNT,

CASE
WHEN (C.Quantity * P.Prod_Price) BETWEEN 10000 AND 20000 THEN (C.Quantity * P.Prod_Price) * 0.05
WHEN (C.Quantity * P.Prod_Price) BETWEEN 20001 AND 50000 THEN (C.Quantity * P.Prod_Price) * 0.10
WHEN (C.Quantity * P.Prod_Price) > 50001 THEN (C.Quantity * P.Prod_Price) * 0.15
ELSE 0
END AS DISCOUNT
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P
ON C.Product_id = P.Product_ID
) AS A;

--751...Calculate a discount for customers based on their loyalty: 10% for customers with 1-3 years, 15% for 4-6 years, and 20% for 7+ years.

SELECT 
CONCAT(E.First_name,' ',E.Last_Name) AS EMP_NAME,
CONCAT(C.First_name,' ',C.Last_Name) AS CUST_EMP_NAME,
E.Emp_id,
C.Quantity,
P.Prod_Price,
(C.Quantity * P.Prod_Price) AS SALES_AMOUNT,
CASE
WHEN DATEDIFF(YEAR,E.Hire_Date,CAST(GETDATE()AS DATE)) BETWEEN 1 AND 3 THEN (C.Quantity * P.Prod_Price) * 0.10
WHEN DATEDIFF(YEAR,E.Hire_Date,CAST(GETDATE()AS DATE)) BETWEEN 4 AND 6 THEN (C.Quantity * P.Prod_Price) * 0.15
WHEN DATEDIFF(YEAR,E.Hire_Date,CAST(GETDATE()AS DATE)) >7 THEN (C.Quantity * P.Prod_Price) * 0.20
ELSE 0
END AS DISCOUNT_AMOUNT
FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name
JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID;

--752...Classify products into three categories based on sales volume and apply different 
--tax rates: 5% for low, 10% for medium, and 15% for high sales.

SELECT 
    P.Product_ID,
    P.Product_Name,
    SUM(C.Quantity) AS Total_Sales_Volume,
    CASE
        WHEN SUM(C.Quantity) < 100 THEN 'Low Sales'
        WHEN SUM(C.Quantity) BETWEEN 100 AND 500 THEN 'Medium Sales'
        ELSE 'High Sales'
    END AS Sales_Category,
    CASE
        WHEN SUM(C.Quantity) < 100 THEN SUM(C.Quantity * P.Prod_Price) * 0.05
        WHEN SUM(C.Quantity) BETWEEN 100 AND 500 THEN SUM(C.Quantity * P.Prod_Price) * 0.10
        ELSE SUM(C.Quantity * P.Prod_Price) * 0.15
    END AS Tax_Amount
FROM 
    PROD_DATA AS P
JOIN 
    CUTOMER_DATA AS C ON P.Product_ID = C.Product_id
GROUP BY 
    P.Product_ID, P.Product_Name;

--753...Use CASE to show how much discount a product should receive: 10% for old stock, 20% for seasonal, and 30% for clearance.

/*SELECT 
    P.Product_ID,
    P.Product_Name,
    P.Prod_Price,
    P.Stock_Type, -- Assuming 'Stock_Type' indicates old stock, seasonal, or clearance
    CASE 
        WHEN P.Stock_Type = 'Old Stock' THEN P.Prod_Price * 0.10
        WHEN P.Stock_Type = 'Seasonal' THEN P.Prod_Price * 0.20
        WHEN P.Stock_Type = 'Clearance' THEN P.Prod_Price * 0.30
        ELSE 0
    END AS Discount_Amount,
    CASE 
        WHEN P.Stock_Type = 'Old Stock' THEN P.Prod_Price - (P.Prod_Price * 0.10)
        WHEN P.Stock_Type = 'Seasonal' THEN P.Prod_Price - (P.Prod_Price * 0.20)
        WHEN P.Stock_Type = 'Clearance' THEN P.Prod_Price - (P.Prod_Price * 0.30)
        ELSE P.Prod_Price
    END AS Final_Price
FROM 
    PROD_DATA AS P;
*/

--754...Show the shipping cost based on the total price of an order: $5 for orders below $50, $10 for orders $50-$100, $15 for orders above $100.
/*SELECT 
    O.Order_ID,
    O.Customer_ID,
    O.Total_Price,
    CASE
        WHEN O.Total_Price < 50 THEN 5
        WHEN O.Total_Price BETWEEN 50 AND 100 THEN 10
        WHEN O.Total_Price > 100 THEN 15
        ELSE 0
    END AS Shipping_Cost
FROM 
    Orders_Data AS O;
*/
--755...Assign a membership level to customers based on their 
--total purchase amount: 'Gold' for > $10,000, 'Silver' for $5,000-$10,000, 'Bronze' for < $5,000.

SELECT A.membership_level,COUNT(membership_level) AS MEMBERSHIP_COUNT  FROM (
SELECT 
CONCAT(C.First_name,' ',C.Last_Name) AS CUTOMER_NAME,
C.Quantity,P.Prod_Price,
(C.Quantity * P.Prod_Price) AS TOTAL_SALES_AMOUNT,
CASE
WHEN (C.Quantity * P.Prod_Price) > 10000 THEN 'Gold'
WHEN (C.Quantity * P.Prod_Price) BETWEEN 5000 AND 10000 THEN 'Silver'
WHEN (C.Quantity * P.Prod_Price) < 5000 THEN 'Bronze'
END AS membership_level
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID) AS A
GROUP BY A.membership_level;

--756...Determine whether an employee is eligible for promotion based on years of service and performance rating.

SELECT 
E.id,
E.full_name,
E.dept_name,
DATEDIFF(YEAR,E.hire_date,CAST(GETDATE() AS DATE)) AS YAER_OF_EXPERIENCE,
CASE
WHEN DATEDIFF(YEAR,E.hire_date,CAST(GETDATE() AS DATE)) BETWEEN 5 AND 10 THEN 'Eligible for Promotion'
ELSE 'NOT Eligible'
END AS promotion_eligible
FROM employee_data AS E;

--757...Display whether an order qualifies for a free gift: 'Yes' for orders above $200, 'No' otherwise.

SELECT P.*,C.*,
CONCAT(C.First_name,' ',C.Last_Name) AS CUSTOMER_NAME,
CASE
WHEN (C.Quantity * P.Prod_Price) > (200*83.33) THEN 'YES'
ELSE 'NO'
END FREE_GIFT
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P
ON C.Product_id = P.Product_ID;

--758...Show the customer’s loyalty tier based on their total number of purchases: 'Gold', 'Silver', or 'Bronze'.

/*SELECT 
    C.Customer_ID,
    C.First_Name,
    C.Last_Name,
    COUNT(O.Order_ID) AS Total_Purchases,
    CASE
        WHEN COUNT(O.Order_ID) >= 50 THEN 'Gold'
        WHEN COUNT(O.Order_ID) BETWEEN 20 AND 49 THEN 'Silver'
        WHEN COUNT(O.Order_ID) BETWEEN 1 AND 19 THEN 'Bronze'
        ELSE 'No Tier'
    END AS Loyalty_Tier
FROM 
    Customer_Data AS C
LEFT JOIN 
    Orders_Data AS O
ON 
    C.Customer_ID = O.Customer_ID
GROUP BY 
    C.Customer_ID, C.First_Name, C.Last_Name;
*/
----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------NEW_QUESTION-----------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--759...Find employees hired after 2020-01-01 in EMP_DATA.

SELECT * FROM EMP_DATA WHERE Hire_Date > '2020-01-01';

--760...Retrieve all employees who are in the "IT" department.

SELECT * FROM employee_data WHERE dept_name = 'IT';

--761...Find employees whose salary is between 40,000 and 60,000.

SELECT * FROM EMP_DATA WHERE Salary BETWEEN 40000 AND 60000;

--762...Display employees who are not in the "HR" department.

SELECT * FROM employee_data WHERE dept_name != 'HR';

--763...List employees whose location is either "New York" or "Los Angeles".

SELECT * FROM employee_data WHERE location IN ('New York','Los Angeles');

--764...Find the total number of employees.
SELECT COUNT(*) AS TOTAL_COUNT FROM EMP_DATA;

--765...Calculate the average salary of employees.
SELECT avg(Salary) AS AVG_SALARY FROM EMP_DATA;

--766...Find the maximum salary and the employee who earns it.

SELECT TOP (1) * FROM EMP_DATA ORDER BY Salary DESC ;

--767...Count the number of employees in each dept_name.
SELECT Department_id,COUNT(*) AS TOTAL_COUNT FROM EMP_DATA GROUP BY Department_id ;
SELECT dept_name,COUNT(*) AS TOTAL_COUNT FROM employee_data GROUP BY dept_name ;

--768...Calculate the sum of salaries for the "Finance" department.

SELECT dept_name,SUM(salary) AS TOTAL_SALARY FROM employee_data WHERE dept_name = 'Finance'  GROUP BY dept_name ;

--769...Write a query to find common dept_id between EMP_DATA and CUSTOMER_TABLE using INTERSECT.

SELECT First_name,Last_Name FROM EMP_DATA
INTERSECT
SELECT First_name,Last_Name FROM CUTOMER_DATA;

--770...Write a query to find all distinct Product_id from CUSTOMER_TABLE and PROD_DATA using UNION.

SELECT Product_id FROM CUTOMER_DATA
UNION
SELECT Product_ID FROM PROD_DATA;

--771...Find all Product_id present in CUSTOMER_TABLE but not in PROD_DATA using EXCEPT.

SELECT Product_id FROM CUTOMER_DATA
EXCEPT
SELECT Product_ID FROM PROD_DATA;

--772...Perform an INNER JOIN between EMP_DATA and CUSTOMER_TABLE on first_name and last_name.

SELECT * FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name AND E.Last_Name = C.Last_Name;

--773...Perform a LEFT JOIN between CUSTOMER_TABLE and PROD_DATA on Product_id.

SELECT * FROM CUTOMER_DATA AS C LEFT OUTER JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID;

--774...Write a query for a RIGHT JOIN between EMP_DATA and PROD_DATA to list employees associated with products.

SELECT * FROM EMP_DATA AS E RIGHT OUTER JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name AND E.Last_Name = C.Last_Name;

--775...Write a query for a FULL OUTER JOIN between EMP_DATA and CUSTOMER_TABLE on dept_id.

SELECT * FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name AND E.Last_Name = C.Last_Name;

--776...Convert all first_name values in EMP_DATA to uppercase.
SELECT E.*,UPPER(E.First_name) AS UPPER_CASE FROM EMP_DATA AS E;

--777...Extract the first three characters of last_name in EMP_DATA.

SELECT SUBSTRING(First_name,1,3) AS THREE_CHAR, LEFT(First_name,3) AS THREE_CHAR FROM EMP_DATA;
SELECT First_name, SUBSTRING(First_name,LEN(First_name)-3,4) AS LAST_THREE_CHAR  FROM EMP_DATA;

--778...Concatenate first_name and last_name with a space in between as Full_Name.

SELECT CONCAT(First_name,' ',Last_Name) AS FULL_NAME FROM EMP_DATA

--779...Find the length of email for each employee.

SELECT email, LEN(email) AS LENGTH_EMAIL FROM employee_data;

--800...Replace all occurrences of "Inc" with "Ltd" in Company_Name from PROD_DATA.

SELECT Company_Name, REPLACE(Company_Name, 'Inc', 'Ltd') AS Updated_Company_Name
FROM PROD_DATA;

--801...Retrieve the current date.
SELECT CURRENT_TIMESTAMP

--802...Calculate the age of each employee based on DOB.

SELECT E.*,DATEDIFF(YEAR,DOB,GETDATE()) AS AGE_OF FROM employee_data AS E;

--803...Find the difference in years between hire_date and Purchase_Date for each customer.

SELECT E.*,C.*,
(YEAR(E.Hire_Date) - YEAR(C.Purchase_Date)) AS DIFF_IN_YEAR,
DATEDIFF(YEAR, E.hire_date, C.Purchase_Date) AS FINAL_DATE_AGG
FROM EMP_DATA AS E JOIN CUTOMER_DATA AS C ON E.First_name = C.First_name;

--804...Add 5 years to each employee's hire_date.
SELECT Hire_Date, DATEADD(YEAR,5,Hire_Date) AS ADD_YEAR FROM EMP_DATA

--805...Extract the month and year from Purchase_Date in CUSTOMER_TABLE.

SELECT A.YEAR,COUNT(A.YEAR) AS YEAR_WISE_COUNT FROM (
SELECT C.*,YEAR(C.Purchase_Date) AS YEAR FROM CUTOMER_DATA AS C) AS A
GROUP BY A.YEAR ORDER BY A.YEAR ASC;

--806...Write a subquery to find employees with the second-highest salary.

SELECT * FROM EMP_DATA AS E WHERE 2 = 
(SELECT COUNT(DISTINCT Salary) FROM EMP_DATA AS B WHERE E.Salary <= B.Salary );

SELECT TOP 2 * FROM EMP_DATA ORDER BY Salary DESC;
--807...Use a subquery to find dept_id where the average salary is greater than 60,000.

SELECT * FROM EMP_DATA AS E WHERE E.Department_id IN 
(SELECT Department_id FROM EMP_DATA GROUP BY Department_id HAVING AVG(Salary) > 60000 );

--808...Find the first_name of employees who have purchased more than 5 products.

SELECT C.First_name FROM CUTOMER_DATA  AS C JOIN PROD_DATA AS P
ON C.Product_id = P.Product_ID
GROUP BY C.First_name
HAVING COUNT(C.Quantity) > 5;

--809...Retrieve all employees whose first_name starts with 'A' and ends with 'n'.

SELECT * FROM EMP_DATA AS E WHERE E.First_name LIKE 'A%N';
SELECT * FROM EMP_DATA AS E WHERE E.First_name LIKE 'A%' AND E.First_name LIKE '%N';

--810...List products purchased by employees from the "Sales" department.

SELECT C.*,P.Product_Name FROM employee_data AS E INNER JOIN CUTOMER_DATA AS C ON E.first_name = C.First_name
INNER JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE E.dept_name = 'Sales'

--811...Identify customers who have purchased products worth more than $1000.

SELECT C.*, (C.Quantity * P.Prod_Price) AS TOTAL_AMOUNT FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P 
ON C.Product_id = P.Product_ID
WHERE (C.Quantity * P.Prod_Price)  > (1000*83.33);


--812...Find the Product_Name of products purchased in the last 30 days.

SELECT C.*, P.Product_Name FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P 
ON C.Product_id = P.Product_ID WHERE C.Purchase_Date >= DATEADD(DAY,-30,CAST(GETDATE()AS DATE));

SELECT * FROM CUTOMER_DATA AS C WHERE DATEDIFF(DAY,C.Purchase_Date,CAST(GETDATE()AS DATE)) <= 30;

--813...Write a query to display "High" if the salary is greater than 70,000, "Medium" for 40,000–70,000, and "Low" otherwise.

SELECT First_name,Last_Name,Salary,
CASE
WHEN Salary > 70000 THEN 'High'
WHEN Salary BETWEEN 40000 AND 70000 THEN 'Medium'
ELSE 'Low'
END AS SALARY_POSITION
FROM EMP_DATA;

--814...Add a column Age_Group in the result, categorizing employees as "Young", "Middle-Aged", or "Senior" based on their age.

SELECT full_name,
CASE
WHEN DATEDIFF(YEAR,DOB,CAST( GETDATE() AS DATE)) > 55 THEN 'Senior'
WHEN DATEDIFF(YEAR,DOB,CAST( GETDATE() AS DATE)) BETWEEN 30 AND 55 THEN 'Middle-Aged'
WHEN DATEDIFF(YEAR,DOB,CAST( GETDATE() AS DATE)) < 30 THEN 'Young'
END categorizing_employees
FROM employee_data ;

--815...Use RANK() to rank employees based on their salary.

SELECT * FROM
(SELECT Salary,
DENSE_RANK() OVER( ORDER BY Salary DESC) AS RANK_OF_SALARY
FROM EMP_DATA) AS S ;
----------------
SELECT 
    P.Salary, 
    COUNT(P.RANK_OF_SALARY) AS TOTAL_COUNT
FROM (
    SELECT 
        Salary, 
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS RANK_OF_SALARY
    FROM EMP_DATA
) AS P
GROUP BY P.Salary
HAVING COUNT(P.RANK_OF_SALARY) > 1;

--816...Use ROW_NUMBER() to assign a unique number to each row.
SELECT * FROM
(SELECT Salary,
ROW_NUMBER() OVER( ORDER BY Salary DESC) AS RANK_OF_SALARY
FROM EMP_DATA) AS S ;

--817...Use NTILE(3) to divide employees into three groups based on their salary.

SELECT 
    id, 
    full_name, 
    salary, 
    NTILE(3) OVER (ORDER BY salary DESC) AS salary_group
FROM employee_data;

--818...Find all employees in the "HR" department using ALL.

SELECT id, full_name, dept_name
FROM employee_data
WHERE dept_name = 'HR';

SELECT id, full_name, dept_name
FROM employee_data
WHERE dept_name = ALL (
    SELECT dept_name
    FROM employee_data
    WHERE dept_name = 'HR'
);


--819...Compare salaries to find employees earning more than all employees in the "Finance" department.

SELECT id, full_name, dept_name
FROM employee_data
WHERE dept_name = 'Finance';

SELECT id, full_name, salary
FROM employee_data
WHERE salary > ALL (
    SELECT salary
    FROM employee_data
    WHERE dept_name = 'Finance'
);

--820...Retrieve employees who joined earlier than all employees in the "IT" department.

SELECT id, full_name, hire_date
FROM employee_data
WHERE hire_date < ALL (
    SELECT hire_date
    FROM employee_data
    WHERE dept_name = 'IT'
);

--821...
/*Use a CASE statement to display the dept_name as:
"Technical" for "IT"
"Human Resources" for "HR"
"Finance Team" for "Finance"
"Other" for any other department.*/

SELECT 
dept_name,
CASE
WHEN dept_name = 'IT' THEN 'Technical'
WHEN dept_name = 'HR' THEN 'Human Resources'
WHEN dept_name = 'Finance' THEN 'Finance'
ELSE 'OTHER DEPARTMENT'
END dept_name
FROM employee_data;

--822...
/*
Add a column Tenure_Category:

"New Hire" for employees hired in the last year
"Experienced" for employees with 1–5 years
"Veteran" for more than 5 years.*/

SELECT First_name, Last_Name,Hire_Date,
CASE
WHEN DATEDIFF(YEAR,Hire_Date,GETDATE()) < 1 THEN 'New Hire'
WHEN DATEDIFF(YEAR,Hire_Date,GETDATE()) BETWEEN 1 AND 3 THEN 'Experienced'
WHEN DATEDIFF(YEAR,Hire_Date,GETDATE()) >5 THEN 'Veteran'
ELSE '-06 MONRH'
END AS Tenure_Category
FROM EMP_DATA;

--823...
/*SELECT customer_id,
       product_count,
       CASE
           WHEN product_count > 10 THEN 0.20  -- 20% discount
           WHEN product_count BETWEEN 5 AND 10 THEN 0.10  -- 10% discount
           ELSE 0.05  -- 5% discount
       END AS discount
FROM customer_purchases;
*/

--824...Use CASE to format a Full_Name column:
--Capitalize the first letter of first_name and last_name, leaving other letters in lowercase.

SELECT 
UPPER(LEFT(First_name,1)) + LOWER(SUBSTRING(First_name,2,LEN(First_name)-1)) AS FIRST_NAME,
UPPER(LEFT(Last_Name,1)) + LOWER(SUBSTRING(Last_Name,2,LEN(Last_Name)-1)) AS Last_Name
FROM CUTOMER_DATA;

--825...Write a query to find the employee who was hired first in each department.

SELECT id, full_name, dept_name, hire_date
FROM (
    SELECT id, full_name, dept_name, hire_date,
           FIRST_VALUE(id) OVER (PARTITION BY dept_name ORDER BY hire_date) AS first_employee_id,
           FIRST_VALUE(full_name) OVER (PARTITION BY dept_name ORDER BY hire_date) AS first_employee_name,
           FIRST_VALUE(hire_date) OVER (PARTITION BY dept_name ORDER BY hire_date) AS first_hire_date
    FROM employee_data
) AS RankedEmployees
WHERE id = first_employee_id;

--826...Retrieve the first product purchased by each customer based on Purchase_Date.
/*SELECT customer_id, product_id, purchase_date, product_name
FROM (
    SELECT customer_id, product_id, purchase_date, product_name,
           FIRST_VALUE(product_id) OVER (PARTITION BY customer_id ORDER BY purchase_date) AS first_product_id,
           FIRST_VALUE(product_name) OVER (PARTITION BY customer_id ORDER BY purchase_date) AS first_product_name,
           FIRST_VALUE(purchase_date) OVER (PARTITION BY customer_id ORDER BY purchase_date) AS first_purchase_date
    FROM customer_purchases
) AS RankedPurchases
WHERE product_id = first_product_id;
*/
--827...Find the first_name of the highest-paid employee using FIRST_VALUE ordered by salary.

SELECT first_name
FROM (
    SELECT first_name, salary,
           FIRST_VALUE(first_name) OVER (ORDER BY salary DESC) AS highest_paid_employee
    FROM employee_data
) AS RankedEmployees
WHERE first_name = highest_paid_employee;

--828...Use RANK() with a CASE statement to assign a "Gold", "Silver", or "Bronze" badge to employees based on their salary rank.
SELECT first_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank,
       CASE 
           WHEN RANK() OVER (ORDER BY salary DESC) = 1 THEN 'Gold'
           WHEN RANK() OVER (ORDER BY salary DESC) = 2 THEN 'Silver'
           WHEN RANK() OVER (ORDER BY salary DESC) = 3 THEN 'Bronze'
           ELSE 'No Badge'
       END AS badge
FROM employee_data;

--829...Write a query to find all employees whose salary is greater than the average salary.

SELECT * FROM EMP_DATA AS A WHERE A.Salary >
(SELECT AVG(Salary) FROM EMP_DATA AS B);

--830...List all employees who have a salary greater than the salary of employee "John".

SELECT * FROM EMP_DATA AS A WHERE A.Salary > 
(SELECT TOP 1 B.Salary FROM EMP_DATA AS B WHERE B.First_name = 'John');

SELECT First_name, Last_name, salary
FROM EMP_DATA
WHERE salary > ALL (SELECT salary FROM EMP_DATA WHERE First_name = 'John');


--831...Find the employees who are working in the same department as "Alice".

SELECT * FROM EMP_DATA WHERE Department_id IN
(SELECT Department_id FROM EMP_DATA WHERE First_name = 'Alice');

--832...List all employees whose hire_date is earlier than the hire date of employee "James".

SELECT * FROM employee_data WHERE hire_date < ALL
(SELECT hire_date FROM employee_data WHERE first_name = 'James');

--833...Find all customers who have made purchases greater than the average purchase amount.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P
ON C.Product_id = P.Product_ID
WHERE (C.Quantity * P.Prod_Price) > 
(SELECT AVG(C.Quantity * P.Prod_Price) FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P
ON C.Product_id = P.Product_ID);

--834...Write a query to list products with a price greater than the average product price.

SELECT * FROM PROD_DATA AS P
WHERE P.Prod_Price >
(SELECT AVG(Prod_Price) FROM PROD_DATA);

--835...Find the Employee_ID of the employee with the highest salary.

SELECT *
FROM EMP_DATA
WHERE salary = (SELECT MAX(salary) FROM EMP_DATA);

--836...Retrieve the First_name of employees whose salary is lower than the highest salary in the company.

SELECT First_name
FROM EMP_DATA
WHERE salary < (SELECT MAX(salary) FROM EMP_DATA);

--837...Display employees whose hire_date is later than the hire_date of employee "David".

SELECT * FROM EMP_DATA WHERE Hire_Date > ALL
(SELECT Hire_Date FROM EMP_DATA WHERE First_name = 'David');

SELECT * 
FROM EMP_DATA 
WHERE Hire_Date > (SELECT TOP 1 Hire_Date FROM EMP_DATA WHERE First_name = 'David' ORDER BY Hire_Date);

--838...List all products that are more expensive than the product with ID 101.

SELECT Product_ID, Product_Name, Prod_Price
FROM PROD_DATA
WHERE Prod_Price > (SELECT Prod_Price FROM PROD_DATA WHERE Product_ID = 101);

--839...Retrieve all employees who earn more than the average salary in their department.

SELECT * FROM EMP_DATA AS A
WHERE A.Salary > 
(
SELECT AVG(B.Salary) AS AVG_SALARY FROM EMP_DATA AS B
WHERE A.Department_id = B.Department_id
GROUP BY B.Department_id
);

--840...Write a query to display the employees whose salary is higher than the average salary of their department.

SELECT * FROM employee_data AS A
WHERE A.Salary > 
(
SELECT AVG(B.Salary) AS AVG_SALARY FROM employee_data AS B
WHERE A.dept_name = B.dept_name
GROUP BY B.dept_name
);

--841...List all customers who have purchased more than the average quantity of products.

SELECT Cust_id, First_name, Last_Name, SUM(Quantity) AS Total_Quantity
FROM CUTOMER_DATA AS C
JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
GROUP BY Cust_id, First_name, Last_Name
HAVING SUM(Quantity) > (SELECT AVG(Total_Quantity) 
                         FROM (SELECT SUM(Quantity) AS Total_Quantity 
                               FROM CUTOMER_DATA C2 
                               GROUP BY C2.Cust_id) AS Avg_Quantity);

--842...Find employees whose salary is greater than the average salary of employees in the same department.

SELECT Emp_id, First_name, Last_name, salary, Department_id
FROM EMP_DATA e
WHERE salary > (
    SELECT AVG(salary)
    FROM EMP_DATA
    WHERE Department_id = e.Department_id
    GROUP BY Department_id
);

--843...Retrieve employees who have been hired later than the average hire date in their department.

SELECT Emp_id, First_name, Last_name, hire_date, Department_id
FROM EMP_DATA e
WHERE hire_date > (
    SELECT AVG(hire_date)
    FROM EMP_DATA
    WHERE Department_id = e.Department_id
    GROUP BY Department_id
);
----
SELECT Emp_id, First_name, Last_name, hire_date, Department_id
FROM EMP_DATA e
WHERE hire_date > (
    SELECT CONVERT(date, DATEADD(day, AVG(DATEDIFF(day, '19000101', hire_date)), '19000101'))
    FROM EMP_DATA
    WHERE Department_id = e.Department_id
);

--844...List products that have a price greater than the average price of the products in the same category.

SELECT * FROM PROD_DATA AS A WHERE A.Prod_Price >
(SELECT AVG(Prod_Price) FROM PROD_DATA AS B WHERE A.Product_Type = B.Product_Type);

--845...Find all employees who have more than one project assigned.

/*SELECT e.Emp_id, e.First_name, e.Last_name
FROM EMP_DATA e
JOIN EMP_PROJECT ep ON e.Emp_id = ep.Emp_id
GROUP BY e.Emp_id, e.First_name, e.Last_name
HAVING COUNT(ep.Project_id) > 1;
*/

--846...Write a query to find customers who made purchases larger than the average purchase amount in their city.

SELECT * FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P 
ON C.Product_id = P.Product_ID
WHERE (C.Quantity * P.Prod_Price) > 
(SELECT AVG(C.Quantity * P.Prod_Price) FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P 
ON C.Product_id = P.Product_ID);

--847...List employees whose salary is greater than the average salary of employees in the same location.

SELECT * FROM employee_data AS A WHERE A.salary > 
(SELECT AVG(B.salary) FROM employee_data AS B WHERE A.location = B.location);

--848...Retrieve employees who are earning more than the maximum salary of employees in the "HR" department.

SELECT * FROM employee_data AS A WHERE A.salary > 
(SELECT MAX(B.salary) FROM employee_data AS B WHERE B.dept_name = 'HR' );

--849...List employees who work in departments that have more than 5 employees.

SELECT * FROM EMP_DATA AS A
WHERE A.Department_id IN 
(SELECT B.Department_id FROM EMP_DATA AS B
GROUP BY B.Department_id
HAVING COUNT(B.Emp_id) > 5
);

--850...Find employees who are earning a salary that is in the list of the top 10 highest salaries.

SELECT Emp_id, First_name, Last_name, Salary
FROM EMP_DATA
WHERE Salary IN (
    SELECT DISTINCT TOP 10 Salary
    FROM EMP_DATA
    ORDER BY Salary DESC
);

--851...Write a query to find all customers who have purchased products with ID 101 or 102.

SELECT c.Cust_id, c.First_name, c.Last_name, p.Product_id, C.Quantity, C.Purchase_Date
FROM CUTOMER_DATA c
JOIN PROD_DATA p ON c.Product_id = p.Product_ID
WHERE p.Product_id IN (101, 102);

--852...List products whose Product_ID is present in the CUSTOMER_TABLE.

SELECT * FROM PROD_DATA AS P WHERE P.Product_ID IN 
(SELECT C.Product_id FROM CUTOMER_DATA AS C );

SELECT DISTINCT p.Product_ID, p.Product_Name
FROM PROD_DATA AS p
INNER JOIN CUTOMER_DATA AS c ON p.Product_ID = c.Product_ID;

--853...Find customers who made purchases of any product that costs more than $500.

SELECT * FROM CUTOMER_DATA AS C WHERE 
C.Product_id IN
(SELECT Product_ID FROM PROD_DATA AS P WHERE P.Prod_Price > 500)

SELECT * FROM CUTOMER_DATA AS C WHERE 
EXISTS
(SELECT Product_ID FROM PROD_DATA AS P WHERE C.Product_id = P.Product_ID AND P.Prod_Price > 500);

--854...Retrieve employees working in departments located in "New York".

SELECT * FROM employee_data AS A WHERE EXISTS
(SELECT ID FROM employee_data AS B WHERE A.dept_id = B.dept_id AND location = 'Schmitthaven');

--855...Find all products that are available in the stores located in "Los Angeles".

SELECT * FROM PROD_DATA AS P
WHERE P.Product_id IN
(
SELECT P.Product_ID FROM CUTOMER_DATA AS C
WHERE C.First_name IN 
(SELECT E.First_name FROM employee_data AS E
WHERE E.location = 'Lynnfurt'
)
);

--856...List employees working in departments that have a salary greater than the average salary of the company.

SELECT * FROM EMP_DATA AS A
WHERE A.Department_id IN 
(SELECT B.Department_id FROM EMP_DATA AS B
GROUP BY B.Department_id
HAVING AVG(B.Salary) > (SELECT AVG(Salary) FROM EMP_DATA)
);

--857...Write a query to find customers who have purchased products in both the "Electronics" and "Clothing" categories.

SELECT * FROM CUTOMER_DATA AS C
WHERE EXISTS
(SELECT * FROM PROD_DATA AS P WHERE C.Product_id = P.Product_ID AND P.Product_Type IN ('Electronics','Clothing')
);

--858...Find employees who are earning a salary that is higher than the average salary for their respective department.

SELECT * FROM employee_data AS A
WHERE A.salary >
(SELECT AVG(B.salary) AS AVG_SALARY FROM employee_data AS B
WHERE A.dept_name = B.dept_name GROUP BY B.dept_name
);

--859...Find all departments that have employees earning more than $60,000.

SELECT * FROM employee_data AS E WHERE EXISTS
(SELECT * FROM employee_data AS A WHERE E.dept_name = A.dept_name AND E.salary > 60000 );

--860...Retrieve customers who have purchased more than 5 items.

SELECT * FROM CUTOMER_DATA AS A 
WHERE EXISTS
(SELECT * FROM CUTOMER_DATA AS B WHERE B.Quantity > 5);

--861...List all employees who have at least one department with more than 10 employees.

SELECT * FROM employee_data AS A
WHERE EXISTS 
(SELECT * FROM employee_data AS B WHERE A.dept_id = B.dept_id 
GROUP BY B.dept_id
HAVING COUNT(B.id) > 10
);

--862...Write a query to find products that have been purchased at least once.

SELECT product_id, product_name, product_type
FROM PROD_DATA
WHERE product_id IN (
    SELECT DISTINCT product_id
    FROM CUTOMER_DATA
);

--863...List all customers who have purchased products from the "Electronics" category.

SELECT * FROM CUTOMER_DATA AS C
WHERE EXISTS 
(SELECT * FROM PROD_DATA AS P 
WHERE C.Product_id = P.Product_ID AND P.Product_Type = 'Electronics'
);

--864...Find employees who are part of any department that has made more than 100 purchases.

SELECT * FROM CUTOMER_DATA AS C
WHERE EXISTS 
(SELECT * FROM PROD_DATA AS P 
WHERE C.Product_id = P.Product_ID 
GROUP BY P.Product_ID
HAVING COUNT(C.Product_id) > 100
);

/*
SELECT e.*
FROM EMP_DATA AS e
WHERE e.Department_id IN (
    SELECT c.dept_id
    FROM CUSTOMER_DATA AS c
    GROUP BY c.dept_id
    HAVING COUNT(c.purchase_id) > 100
);
*/

--865...List departments that have employees who are making more than the average salary of the department.

SELECT * FROM employee_data AS A
WHERE EXISTS
(SELECT * FROM employee_data AS B 
WHERE A.dept_id = B.dept_id AND 
B.salary > (SELECT AVG(salary) FROM employee_data)
);

SELECT * FROM employee_data AS A
WHERE A.salary >
(SELECT AVG(salary) FROM employee_data AS B 
WHERE A.dept_id = B.dept_id
);

SELECT *
FROM EMP_DATA e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM EMP_DATA e2
    WHERE e2.Department_id = e.Department_id
);

--866...Write a query to find employees who have worked for at least one department with more than 5 employees.

SELECT e.*
FROM EMP_DATA e
WHERE e.Department_id
IN (
    SELECT Department_id
    FROM EMP_DATA
    GROUP BY Department_id
    HAVING COUNT(Emp_id) > 5
);

--867...List customers who have purchased products that have been in stock for more than 30 days.

SELECT * FROM CUTOMER_DATA AS C
JOIN PROD_DATA AS P
ON C.Product_id = P.Product_ID
WHERE DATEDIFF(DAY,C.Purchase_Date,GETDATE()) > 30;

--868...Retrieve all employees who are assigned to a department with a budget greater than $1 million.

SELECT * FROM employee_data AS E
JOIN CUTOMER_DATA AS C
ON E.first_name = C.First_name
WHERE (E.salary * C.Quantity) > 1000000;

SELECT * FROM employee_data AS E
WHERE EXISTS 
(SELECT * FROM CUTOMER_DATA AS C 
WHERE E.first_name = C.First_name
AND (E.salary * C.Quantity) > 1000000
);

--869...Find employees whose salary is greater than all the salaries in the "HR" department.

SELECT * FROM employee_data
WHERE salary > ALL
(SELECT salary FROM employee_data 
WHERE dept_name = 'HR'
);

--870...Retrieve customers who have purchased a product with a price greater than any product in the "Clothing" category.

SELECT c.*
FROM CUTOMER_DATA c
WHERE c.product_id IN (
    SELECT p.product_id
    FROM PROD_DATA p
    WHERE p.Prod_Price > ALL (
        SELECT Prod_Price
        FROM PROD_DATA
        WHERE product_type = 'Clothing'
    )
);

--871...Find products that are more expensive than all products in the "Furniture" category.

SELECT * FROM PROD_DATA AS P
WHERE P.Prod_Price > ALL
(
SELECT Prod_Price FROM PROD_DATA
WHERE Product_Type = 'Furniture'
);

--872...Write a query to find employees whose salary is greater than any employee in the "Marketing" department.

SELECT * FROM employee_data AS A
WHERE A.salary > ALL
(SELECT B.salary FROM employee_data AS B
WHERE B.dept_name = 'Marketing'
);

--873...List employees whose salary is greater than or equal to all employees in the "Finance" department.

SELECT * FROM employee_data AS A
WHERE A.salary >= ALL
(SELECT B.salary FROM employee_data AS B
WHERE B.dept_name = 'Finance'
);

--874...Find employees who are earning more than any employee in the "Sales" department.

SELECT * FROM employee_data AS A
WHERE A.salary > ALL
(SELECT B.salary FROM employee_data AS B
WHERE B.dept_name = 'Sales'
);

--875...Write a query to find products whose price is less than or equal to the price of any product from the "Electronics" category.

SELECT * FROM PROD_DATA AS P
WHERE P.Prod_Price <= ALL
(SELECT B.Prod_Price FROM PROD_DATA AS B
WHERE B.Product_Type = 'Electronics'
);

--876...List employees whose salary is higher than any employee in the "IT" department.

SELECT e.*
FROM employee_data e
WHERE e.salary >= ALL (
    SELECT salary
    FROM employee_data
    WHERE  dept_name = 'IT'
);

--877...Find employees who are making more than all employees in the "Operations" department.

SELECT e.*
FROM employee_data e
WHERE e.salary >= ALL (
    SELECT salary
    FROM employee_data
    WHERE  dept_name = 'Operations'
);

SELECT e.*
FROM employee_data e
WHERE e.salary > ALL (
    SELECT salary
    FROM employee_data
    WHERE dept_id = (SELECT dept_id FROM employee_data WHERE dept_name = 'Operations')
);

--878...Write a query to find customers who made a purchase greater than any purchase in the "Electronics" category.

SELECT * FROM CUTOMER_DATA AS C
WHERE EXISTS
(SELECT * FROM PROD_DATA AS P
WHERE C.Product_id = P.Product_ID AND P.Product_Type = 'Electronics'
);

SELECT * FROM CUTOMER_DATA AS C
WHERE C.Product_id > ALL 
(SELECT P.Product_ID FROM PROD_DATA AS P
WHERE  P.Prod_Price > ALL ( SELECT Prod_Price FROM PROD_DATA WHERE   Product_Type = 'Electronics')
);

--879...Write a query to find employees who are earning more than the average salary in the company, using a nested subquery.

SELECT * FROM employee_data AS E 
WHERE E.salary > 
(SELECT AVG(A.salary) AS AVG_SALARY FROM employee_data AS A );

--880...Find customers who purchased products with a price higher than the average price of all products.

SELECT * FROM CUTOMER_DATA AS C
WHERE C.Product_id IN 
(SELECT P.Product_ID FROM PROD_DATA AS P
WHERE P.Prod_Price > (SELECT AVG(Prod_Price) AS AVG_PRICE FROM PROD_DATA)
);

--881...Write a query to find the highest salary in each department.

SELECT dept_name, MAX(salary) AS MAX_SALARY FROM employee_data GROUP BY dept_name;

--882...List employees who are earning a salary greater than the department’s average salary, using a nested subquery.

SELECT * FROM employee_data AS E WHERE E.salary >
(SELECT AVG(salary) FROM employee_data AS A
WHERE E.dept_name = A.dept_name
);

--883...Retrieve employees who were hired before the latest employee hired in the company.

SELECT * 
FROM employee_data 
WHERE hire_date < (
    SELECT MAX(hire_date)
    FROM employee_data
);
-----------------
SELECT * 
FROM employee_data 
WHERE hire_date < (
    SELECT TOP 1 hire_date
    FROM employee_data ORDER BY  hire_date DESC
);

--884...List all products whose price is higher than the average price of the product in their category.

SELECT * FROM PROD_DATA AS P
WHERE P.Prod_Price > 
(SELECT AVG(A.Prod_Price) FROM PROD_DATA AS A
WHERE P.Product_Type = A.Product_Type
);

--885...Find all customers who have purchased a product with a price higher than the average purchase amount for their city.

SELECT * FROM CUTOMER_DATA AS C
WHERE C.Product_id IN 
(
SELECT P.Product_ID FROM PROD_DATA AS P
WHERE P.Prod_Price >
(SELECT AVG(A.Prod_Price) FROM PROD_DATA AS A )
);

--886...Retrieve the employee with the highest salary in each department.

SELECT * FROM (
SELECT *,
DENSE_RANK() OVER(PARTITION BY DEPT_NAME ORDER BY SALARY DESC) AS RANK_SALARY
FROM employee_data
) AS C
WHERE C.RANK_SALARY = 1;
-------
SELECT e.*
FROM employee_data e
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employee_data
    WHERE dept_name = e.dept_name
);
----------------------------------------

SELECT e.*
FROM employee_data e
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employee_data
    WHERE dept_name = e.dept_name
      AND salary < (
          SELECT MAX(salary)
          FROM employee_data
          WHERE dept_name = e.dept_name
      )
);
----
SELECT * FROM (
SELECT *,
DENSE_RANK() OVER(PARTITION BY DEPT_NAME ORDER BY SALARY DESC) AS RANK_SALARY
FROM employee_data
) AS C
WHERE C.RANK_SALARY = 2;

--887...List products whose price is less than the price of the most expensive product in the database.

SELECT *
FROM prod_data
WHERE Prod_Price < (
    SELECT MAX(Prod_Price)
    FROM prod_data
);

--889...Find employees who have a higher salary than the average salary of employees in the company.

SELECT *
FROM employee_data
WHERE salary > (
    SELECT AVG(salary)
    FROM employee_data
);

--890...Write a query to find the department that has the highest average salary.

SELECT *
FROM employee_data
WHERE dept_id =  (
    SELECT TOP 1  dept_id
    FROM employee_data
    GROUP BY dept_id
    ORDER BY AVG(salary) DESC
);

----
SELECT *
FROM employee_data
WHERE dept_id IN (
    SELECT dept_id
    FROM employee_data
    GROUP BY dept_id
    HAVING AVG(salary) = (
        SELECT MAX(avg_salary)
        FROM (
            SELECT AVG(salary) AS avg_salary
            FROM employee_data
            GROUP BY dept_id
        ) AS subquery
    )
);

--891...List departments that have more employees than the average number of employees per department.

SELECT dept_name,AVG(A.TOTAL_COUNT) AS AVG_COUNT  FROM (
SELECT dept_id,dept_name,COUNT(*) AS TOTAL_COUNT FROM employee_data
GROUP BY dept_id,dept_name
) AS A GROUP BY dept_name;

--892...Find the department with the most employees.

SELECT dept_name,COUNT(*) AS ALL_COUNT
FROM employee_data
GROUP BY dept_name;

--893...Retrieve products that have a higher total purchase quantity than the average total purchase quantity of all products.

SELECT 
    P.Product_ID,
    P.Product_Name,
    SUM(C.Quantity) AS Total_Purchase_Quantity
FROM 
    PROD_DATA AS P
JOIN 
    CUTOMER_DATA AS C
ON 
    P.Product_ID = C.Product_ID
GROUP BY 
    P.Product_ID, P.Product_Name
HAVING 
    SUM(C.Quantity) > (
        SELECT 
            AVG(Total_Quantity)
        FROM (
            SELECT 
                SUM(C2.Quantity) AS Total_Quantity
            FROM 
                PROD_DATA AS P2
            JOIN 
                CUTOMER_DATA AS C2
            ON 
                P2.Product_ID = C2.Product_ID
            GROUP BY 
                P2.Product_ID
        ) AS Subquery
    );

--894...Write a query to find employees who have the highest salary within their department.

SELECT * FROM employee_data AS E 
WHERE E.salary = 
(SELECT MAX(salary) AS MAX_SALALRY FROM employee_data AS C
WHERE E.dept_name = C.dept_name
GROUP BY C.dept_name
);

--895...List all departments that have an average salary above the company’s average salary.

SELECT 
E.dept_id,
E.dept_name,
AVG(E.salary) AS AVG_SALARY
FROM employee_data AS E
JOIN 
CUTOMER_DATA AS C ON e.first_name = C.First_name

GROUP BY 
E.dept_id,
E.dept_name

HAVING AVG(E.salary) >
(SELECT AVG(salary) FROM employee_data);

--896...Find employees whose salary is greater than the average salary in their department.

SELECT * FROM employee_data AS E
WHERE E.salary >
(SELECT AVG(salary) FROM employee_data AS C 
WHERE E.dept_name = C.dept_name);

--897...Write a query to find departments where the total salary of employees exceeds the average total salary.

SELECT A.dept_id,
A.dept_name,
SUM(A.salary) AS TOTAL_SALARY
FROM employee_data AS A

GROUP BY 
A.dept_id,
A.dept_name

HAVING SUM(A.salary) >
(
SELECT AVG(TOTAL_SALARY) FROM (
SELECT SUM(B.salary) AS TOTAL_SALARY FROM employee_data AS B 
GROUP BY B.dept_id
) AS DEPT_SALARY
);

--898...Find employees who have the most years of service in the company based on hire_date.

SELECT 
    ID,
    First_Name,
    Last_Name,
    Hire_Date,
    DATEDIFF(YEAR, Hire_Date, GETDATE()) AS Years_of_Service
FROM 
    Employee_Data
WHERE 
    DATEDIFF(YEAR, Hire_Date, GETDATE()) = (
        SELECT 
            MAX(DATEDIFF(YEAR, Hire_Date, GETDATE()))
        FROM 
            Employee_Data
    );

--899...List products whose total quantity sold exceeds the average total quantity sold of all products.

SELECT 
P.Product_Type,
P.Company_Name,
C.Quantity,
SUM(C.Quantity) AS TOTAL_QUANTETY

FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P 
ON C.Product_id = P.Product_ID

GROUP BY 
P.Product_Type,
P.Company_Name,
C.Quantity

HAVING SUM(C.Quantity) >
(
SELECT AVG(TOTAL_SALES) AS AVG_SALES FROM (
SELECT SUM(A.Quantity) AS TOTAL_SALES FROM CUTOMER_DATA AS A
GROUP BY A.Product_id
) AS ALL_QUERY
);

--900...Find all employees who have worked for more than 5 years.

SELECT * FROM employee_data WHERE hire_date >= DATEADD(YEAR,-5,hire_date);---------USE THE DATEDIFF
SELECT * FROM employee_data WHERE  DATEDIFF(YEAR,hire_date,CAST(GETDATE() AS DATE)) >=5;

--901...Write a query to find customers who have purchased products worth more than the average amount spent by customers.

SELECT 
    C.Product_id,
    C.First_Name,
    C.Last_Name,
    SUM(P.Prod_Price * C.Quantity) AS Total_Spent
FROM 
    CUTOMER_DATA AS C
JOIN 
    PROD_DATA AS P ON C.Product_ID = P.Product_ID
GROUP BY 
    C.Product_id, C.First_Name, C.Last_Name
HAVING 
    SUM(P.Prod_Price * C.Quantity) > (
        SELECT AVG(P.Prod_Price * C.Quantity)
        FROM CUTOMER_DATA AS C
        JOIN PROD_DATA AS P ON C.Product_ID = P.Product_ID
    );

--902...List employees who work in departments where the average salary is greater than $50,000.

SELECT 
E.full_name,
E.dept_name,
E.salary
FROM employee_data AS E 
GROUP BY E.dept_name,E.salary,E.full_name

HAVING AVG(E.salary) > 50000
ORDER BY E.salary DESC;

--903...Retrieve products that have been purchased more than the average number of times.

SELECT 
    P.Product_ID,
    P.Product_Name,
    SUM(C.Quantity) AS Total_Purchases
FROM 
    PROD_DATA AS P
JOIN 
    CUTOMER_DATA AS C ON P.Product_ID = C.Product_ID
GROUP BY 
    P.Product_ID, P.Product_Name
HAVING 
    SUM(C.Quantity) > (
        SELECT 
            AVG(Total_Purchases)
        FROM (
            SELECT 
                P.Product_ID,
                SUM(C.Quantity) AS Total_Purchases
            FROM 
                PROD_DATA AS P
            JOIN 
                CUTOMER_DATA AS C ON P.Product_ID = C.Product_ID
            GROUP BY 
                P.Product_ID
        ) AS AvgPurchases
    );

--904...List employees who have been hired after the most recent employee.

SELECT *
FROM employee_data AS E
WHERE E.hire_date > (
    SELECT MAX(hire_date)
    FROM employee_data
);

--905...Write a query to find departments with more employees than the company’s average number of employees per department.

SELECT dept_name, COUNT(*) AS Employee_Count
FROM employee_data
GROUP BY dept_name
HAVING COUNT(*) > (
    SELECT AVG(Employee_Count)
    FROM (
        SELECT dept_name, COUNT(*) AS Employee_Count
        FROM employee_data
        GROUP BY dept_name
    ) AS DepartmentCounts
);

--906...Find employees who are assigned to projects with a budget greater than the average project budget.

/*
SELECT e.Employee_ID, e.First_Name, e.Last_Name, p.Project_ID, p.Project_Name, p.Budget
FROM employee_data AS e
JOIN project_assignment AS pa ON e.Employee_ID = pa.Employee_ID
JOIN project_data AS p ON pa.Project_ID = p.Project_ID
WHERE p.Budget > (
    SELECT AVG(Budget)
    FROM project_data
);
*/

--907...Write a query to find customers who made purchases after the average Purchase_Date.

SELECT * FROM CUTOMER_DATA AS C 
WHERE C.Purchase_Date > 
(SELECT AVG(Purchase_Date) FROM CUTOMER_DATA);



SELECT * 
FROM CUTOMER_DATA AS C 
WHERE C.Purchase_Date > 
(
    SELECT CAST(AVG(DATEDIFF(DAY, '1900-01-01', Purchase_Date)) AS DATETIME) 
    FROM CUTOMER_DATA
);

--908...List employees whose salary is less than the highest salary in their department.

SELECT * FROM employee_data AS A WHERE 
A.salary < 
(SELECT MAX(salary) FROM employee_data  AS B
WHERE A.dept_name = B.dept_name
GROUP BY B.dept_name);

--909...Find employees who were hired after the average hire date of all employees in their department.

SELECT * FROM employee_data AS A
WHERE A.hire_date >
(SELECT AVG(B.hire_date) FROM employee_data AS B
WHERE A.dept_name = B.dept_name);

---------

SELECT * 
FROM employee_data AS A
WHERE A.hire_date > 
(
    SELECT DATEADD(DAY, AVG(DATEDIFF(DAY, '1900-01-01', B.hire_date)), '1900-01-01')
    FROM employee_data AS B
    WHERE A.dept_name = B.dept_name
);

--910...Write a query to find the second-highest salary in the company using a subquery.

SELECT * FROM employee_data AS A WHERE 2 =
(SELECT COUNT(DISTINCT salary) FROM employee_data AS B WHERE A.salary <= B.salary );

SELECT MAX(salary) AS Second_Highest_Salary
FROM employee_data
WHERE salary < (SELECT MAX(salary) FROM employee_data);

SELECT MAX(salary) AS Second_Highest_Salary
FROM employee_data
WHERE salary < (SELECT MAX(salary) FROM employee_data);

SELECT MAX(salary) AS Third_Highest_Salary
FROM employee_data
WHERE salary < (SELECT MAX(salary) FROM employee_data WHERE salary < (SELECT MAX(salary) FROM employee_data));

--911...List all products with a price greater than the price of the least expensive product in their category.

SELECT * FROM PROD_DATA AS A
WHERE A.Prod_Price>
(SELECT MIN(B.Prod_Price) FROM PROD_DATA AS B
WHERE A.Product_Type = B.Product_Type
GROUP BY B.Product_Type
);

--912...Retrieve employees who have the same salary as the employee who has the highest salary in the company.

SELECT * FROM employee_data AS A WHERE A.salary = 
(SELECT MAX(B.salary) FROM employee_data AS B);

--913...Write a query to find all employees who have been hired before any employee with the highest salary.

SELECT * FROM EMP_DATA AS A WHERE A.Hire_Date  <
(SELECT B.Hire_Date FROM EMP_DATA AS B
WHERE B.Salary = (SELECT MAX(Salary) FROM EMP_DATA)
);

--914...List employees whose salary is greater than the average salary in their department, but only in the "IT" department.

SELECT * FROM employee_data AS A WHERE A.salary >
(SELECT AVG(B.salary) FROM employee_data AS B
WHERE B.dept_name = 'IT'
);

--915...Find customers who have purchased all the products in the "Books" category.

SELECT C.First_name,C.Last_Name
FROM PROD_DATA AS P JOIN CUTOMER_DATA AS C ON P.Product_ID = P.Product_ID
WHERE P.Product_Type = 'Books'
GROUP BY C.First_name,C.Last_Name
HAVING COUNT(DISTINCT P.Product_ID) =
(SELECT COUNT(DISTINCT Product_ID) FROM PROD_DATA
  WHERE Product_Type = 'Books' );

--916...Write a query to find products that have been purchased by more customers than the average number of customers purchasing products.

SELECT 
C.First_name,
C.Last_Name,
COUNT(DISTINCT C.Product_id) AS NO_OF_CUSTOMER
FROM CUTOMER_DATA AS C JOIN PROD_DATA AS P
ON C.Product_id = P.Product_ID

GROUP BY 
C.First_name,
C.Last_Name

HAVING COUNT(DISTINCT C.Product_id) >
(
SELECT AVG(Customer_Count) FROM 
(SELECT COUNT(DISTINCT B.Product_id) AS Customer_Count FROM PROD_DATA AS B
GROUP BY Product_id
) AS FULL_TABLE
);

--917...List employees whose salary is less than the average salary for employees in the "Finance" department.

SELECT * FROM employee_data AS A WHERE A.salary < 
(SELECT AVG(salary) FROM employee_data WHERE dept_name = 'Finance');

--918...Write a query to find employees whose salary is in the top 10% of the highest salaries in the company.

WITH RankedSalaries AS (
    SELECT Salary,
           ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum,
           COUNT(*) OVER () AS TotalCount
    FROM employee_data
)
SELECT * 
FROM employee_data AS E
WHERE E.salary >= 
    (
        SELECT Salary
        FROM RankedSalaries
        WHERE RowNum = (TotalCount * 10 / 100) 
    );

--919...List customers who have made purchases greater than all purchases by customers in "California".

SELECT 
C.Product_id,
C.First_name,
C.Last_Name,
SUM(C.Quantity * P.Prod_Price) AS TOTAL_SALES
FROM employee_data AS E JOIN CUTOMER_DATA AS C ON E.first_name = E.last_name
JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE E.location = 'New Jennifer'
GROUP BY C.Product_id,
C.First_name,
C.Last_Name

HAVING SUM(C.Quantity * P.Prod_Price) >
(
SELECT MAX(ABF.TOTAL_PURCHASE) FROM 
(SELECT 
SUM(C.Quantity * P.Prod_Price) AS TOTAL_PURCHASE
FROM employee_data AS E JOIN CUTOMER_DATA AS C ON E.first_name = E.last_name
JOIN PROD_DATA AS P ON C.Product_id = P.Product_ID
WHERE E.location = 'New Jennifer'
GROUP BY C.Product_id
) AS ABF
);
---------------------------------------------------

SELECT 
    C.Product_id,
    C.First_name,
    C.Last_Name,
    SUM(C.Quantity * P.Prod_Price) AS TOTAL_SALES
FROM 
    CUTOMER_DATA AS C
JOIN 
    PROD_DATA AS P ON C.Product_id = P.Product_ID
JOIN 
    employee_data AS E ON E.first_name = E.last_name
WHERE 
    E.location = 'New Jennifer'
GROUP BY 
    C.Product_id,
    C.First_name,
    C.Last_Name
HAVING 
    SUM(C.Quantity * P.Prod_Price) >
    (
        SELECT MAX(ABF.TOTAL_PURCHASE) 
        FROM 
        (
            SELECT 
                SUM(C.Quantity * P.Prod_Price) AS TOTAL_PURCHASE
            FROM 
                CUTOMER_DATA AS C 
            JOIN 
                PROD_DATA AS P ON C.Product_id = P.Product_ID
            JOIN 
                employee_data AS E ON E.first_name = E.last_name
            WHERE 
                E.location = 'California'
            GROUP BY 
                C.Product_id
        ) AS ABF
    );

--920...Find employees who have a salary higher than all employees in the "Sales" department, 
--and were hired before the most recent employee in the "Sales" department.

SELECT 
    E.ID,
    E.First_Name,
    E.Last_Name,
    E.Salary,
    E.Hire_Date,
    E.dept_name
FROM 
    employee_data AS E
WHERE 
    E.Salary > ALL (
        SELECT Salary
        FROM employee_data
        WHERE dept_name = 'Sales'
    )
    AND E.Hire_Date < (
        SELECT MAX(Hire_Date)
        FROM employee_data
        WHERE dept_name = 'Sales'
    );

--921...Retrieve products that have been purchased by customers who spent more than the average total amount.

SELECT 
    P.Product_ID,
    P.Product_Name,
    P.Product_Type,
    SUM(C.Quantity * P.Prod_Price) AS Total_Purchase_Amount
FROM 
    CUTOMER_DATA AS C
JOIN 
    PROD_DATA AS P
    ON C.Product_ID = P.Product_ID
WHERE 
    C.Product_id IN (
        SELECT 
            C2.Product_id
        FROM 
            CUTOMER_DATA AS C2
        JOIN 
            PROD_DATA AS P2
            ON C2.Product_ID = P2.Product_ID
        GROUP BY 
            C2.Product_id
        HAVING 
            SUM(C2.Quantity * P2.Prod_Price) > (
                SELECT 
                    AVG(Total_Spent)
                FROM (
                    SELECT 
                        SUM(C3.Quantity * P3.Prod_Price) AS Total_Spent
                    FROM 
                        CUTOMER_DATA AS C3
                    JOIN 
                        PROD_DATA AS P3
                        ON C3.Product_ID = P3.Product_ID
                    GROUP BY 
                        C3.Product_id
                ) AS Avg_Spent
            )
    )
GROUP BY 
    P.Product_ID, 
    P.Product_Name, 
    P.Product_Type;

--922...List employees who belong to departments where the average salary is greater than the department with the highest salary.

select  a.full_name,a.salary ,avg(a.salary) as avg_salary,a.dept_name from employee_data as a 
group by a.full_name,a.salary ,a.dept_name
having avg(a.salary) > 
(select max(b.salary) from employee_data as b
group by b.dept_name
);

SELECT e.full_name, e.salary, d.avg_salary, e.dept_name
FROM employee_data e
JOIN (
    -- Subquery to get the average salary of each department
    SELECT dept_name, AVG(salary) AS avg_salary
    FROM employee_data
    GROUP BY dept_name
) d ON e.dept_name = d.dept_name
WHERE d.avg_salary > (
    -- Subquery to get the highest department average salary
    SELECT MAX(avg_salary)
    FROM (
        SELECT dept_name, AVG(salary) AS avg_salary
        FROM employee_data
        GROUP BY dept_name
    ) dept_avg
);

select count(*) from employee_data
select count(1) from employee_data



----------------------------------------------------------------------------------------------------------------------------------





SELECT * FROM employee_data
SELECT * FROM EMP_DATA
SELECT * FROM CUTOMER_DATA
SELECT * FROM PROD_DATA

SELECT COLUMN_NAME,DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'employee_data';
SELECT COLUMN_NAME,DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'CUTOMER_DATA';
SELECT COLUMN_NAME,DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'PROD_DATA';

-------------------------------------------
select * from [dbo].[cutomer_o]
select * from [dbo].[orders_product_o]
select * from [dbo].[flat_file_o]
-----
select * from product_o
select * from orders_o
-------------------------------------------
SELECT * FROM employee_data WHERE hire_date>= DATEADD(YEAR,-3,GETDATE());
SELECT * FROM employee_data WHERE  DATEDIFF(YEAR,hire_date,CAST(GETDATE() AS DATE)) <= 3;

SELECT * FROM (select *,
DENSE_RANK() over(order by salary desc ) as rank_salary
from employee_data
) as a where rank_salary = 2;


SELECT * FROM employee_data AS A WHERE 2 = 
(SELECT COUNT(DISTINCT B.salary) FROM employee_data AS B WHERE A.salary <= B.salary );

select * from for_me.dbo.CUTOMER_DATA


/*

Style Code	         Date Format	           Example
1	                 MM/DD/YYYY	               12/31/2025
3	                 DD/MM/YYYY	               31/12/2025
10	                 MM-DD-YYYY	               12-31-2025
11	                 YY/MM/DD	               25/12/31
12	                 YYMMDD	                   251231
14	                 YYYYMMDDHHMMSS	           20251231123045
20	                 YYYY-MM-DD	               2025-12-31
21	                 YYYY-MM-DD HH:MI:SS	   2025-12-31 12:30:45
22	                 YY-MM-DD	               25-12-31
23	                 YYYY-MM-DD	               2025-12-31
24	                 HH:MI:SS	               12:30:45
25	                 HH:MI:SS:MMM	           12:30:45:123
30	                 YYMMDD	                   251231
31	                 YYYY-MM-DD hh:mm:ss.mmm   2025-12-31 12:30:45.123

*/