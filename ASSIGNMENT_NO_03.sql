CREATE TABLE Department_Details
(
Department_Name VARCHAR (50),
Department_Id VARCHAR (50)
);
INSERT INTO Department_Details (Department_Name,Department_Id)
VALUES  ('Production','10_Prod');
INSERT INTO Department_Details (Department_Name,Department_Id)
VALUES ('Research and Development','20_RD');
INSERT INTO Department_Details (Department_Name,Department_Id)
VALUES ('Purchasing','30_Purchase');
INSERT INTO Department_Details (Department_Name,Department_Id)
VALUES ('Marketing','40_Marketing');
INSERT INTO Department_Details (Department_Name,Department_Id)
VALUES ('Human Resource Management','50_HR');
INSERT INTO Department_Details (Department_Name,Department_Id)
VALUES ('Accounting and Finance','60_Acc_Fin');
INSERT INTO Department_Details (Department_Name,Department_Id)
VALUES ('Information Technology','70_IT');
SELECT*FROM Department_Details;
SELECT*FROM product_details;
SELECT*FROM Employee_Details;
SELECT*FROM customer_details;


-----que no 1------
SELECT MAX(Prod_Price) from product_details where Product_Type = 'bus'
-----que no 2------
SELECT MIN (PROD_PRICE) FROM Product_Details WHERE company_name = 'Ashok Leyland';
-----que no 3-----------------

SELECT*FROM Customer_Details WHERE FIRST_NAME LIKE 'H%';
---
SELECT CUST_ID, first_name, last_name, PRODUCT_ID, QUANTITY, 
       FORMAT(DATEADD(MONTH, 4, purchase_date), 'dd MMMM yyyy') AS purchase_date
FROM customer_details
WHERE first_name LIKE 'H%';

-----QUE NO 4-----
SELECT*FROM Customer_Details WHERE FIRST_NAME LIKE ('H%') OR FIRST_NAME LIKE ('I%') AND LAST_NAME LIKE ('%R') OR LAST_NAME LIKE ('%S');
------QUE NO 5------
SELECT DATEADD(MM,4,GETDATE () );
SELECT GETDATE();
SELECT DATENAME (MONTH,GETDATE ());
-----QUE NO 6------
SELECT*FROM Customer_Details WHERE FIRST_NAME = ('Grace');

SELECT*FROM Customer_Details WHERE FIRST_NAME LIKE UPPER ('GrAce');

------QUE NO 7
SELECT*FROM Customer_Details WHERE FIRST_NAME = ('grACe');
SELECT*FROM Customer_Details WHERE FIRST_NAME = ('gRacE');
------QUE NO 8----
SELECT LAST_NAME ,LEN (LAST_NAME) LENGTH_OF_NAME FROM Customer_Details;
SELECT LAST_NAME FROM Customer_Details WHERE LEN (LAST_NAME) >7; 
SELECT*FROM (SELECT LAST_NAME, CHARINDEX('U',LAST_NAME) FIVE_NAME FROM Customer_Details) ab WHERE FIVE_NAME=5;

---SELECT*FROM Customer_Details WHERE LAST_NAME IN-----
SELECT LAST_NAME,FIVE_NAME FROM (SELECT LAST_NAME,FIRST_NAME, CHARINDEX('U',LAST_NAME) FIVE_NAME 
FROM Customer_Details)ABC
WHERE LEN (LAST_NAME) >7 and FIVE_NAME = 5; 
SELECT * FROM Customer_Details WHERE LEN(LAST_NAME) > 7 AND LAST_NAME LIKE ('____U%' ) OR LAST_NAME LIKE ('____u%' ) ;
---QUE N0 9-----


SELECT left (FIRST_NAME, 1) CUSTOMER_NAME
FROM Customer_Details;

SELECT FIRST_NAME, LAST_NAME, SUBSTRING (FIRST_NAME, 1,1) CUSTOMER_NAME
FROM Customer_Details;

 SELECT CONCAT (left (FIRST_NAME, 1) ,' ', LAST_NAME) AS CUSTOMER_NAME FROM Customer_Details;

---QUE NO 10----
SELECT*FROM Customer_Details WHERE PRODUCT_ID IS NULL OR QUANTITY IS NULL;
-----QUE NO 11-----

SELECT * FROM (SELECT A.*, DATENAME (YEAR,PURCHASE_DATE) YEAR FROM Customer_Details A ) AB
WHERE YEAR = '2008' ;
-----QUE NO 12---------
SELECT DATENAME (MONTH,PURCHASE_DATE) FROM Customer_Details;
SELECT PRODUCT_ID,MONTH FROM (SELECT A.*,DATENAME (MONTH,PURCHASE_DATE) MONTH FROM Customer_Details A)  AB  WHERE MONTH LIKE 'AUGUST';
select avg (Product_id) from Customer_Details WHERE Purchase_Date like '%08%';
SELECT AVG(PRODUCT_ID) FROM	Customer_Details WHERE DATEPART (month,purchase_Date)=08;
----QUE NO 13-------
SELECT*FROM product_details;
SELECT MAX(Prod_Price) from product_details;
SELECT MIN(Prod_Price) from product_details;
SELECT MAX(Prod_Price)-MIN(Prod_Price) DIFFERENCE from product_details;
---QUE NO 14----
/*The cast() funcation convert value of any type into specific datatype*/
select cast (22.36 as int);
----QUE NO 15------
SELECT * FROM (SELECT A.*, DATENAME (YEAR,PURCHASE_DATE) YEAR FROM Customer_Details A ) AB
WHERE YEAR <> '2008' OR YEAR <>'1995' OR YEAR <>'2001';
------QUE NO 16------
/*Global temporary table name is stared with double hash ("##") before the table name.
Global temporary table is access in all connection.
Global temporary table destroy when last connection referecing yhe table closed.
if you close the connection that has create the global tem_table then the global will auto delec*/
create table ##using_id
(n_id int,
na_me varchar(12)
);
----QUE NO 17-------
create table emp_details_primary_key
(
EMP_ID INT, 
EMP_FIRST_NAME VARCHAR(20),
EMP_LAST_NAME VARCHAR(20), 
EMP_EMAIL_ID VARCHAR(20),
EMP_SALARY NUMERIC,
primary key(EMP_ID,EMP_EMAIL_ID)
);

create table emp_details_unique_key
(
EMP_ID INT unique ,
EMP_FIRST_NAME VARCHAR(20),
EMP_LAST_NAME VARCHAR(20), 
EMP_EMAIL_ID VARCHAR(20)unique , 
EMP_SALARY NUMERIC
);

CREATE TABLE F_Key_parent_table	
(
DEPT_ID	INTEGER PRIMARY KEY,
DEPT_NAME VARCHAR(20)NOT NULL
);

CREATE TABLE  F_Key_Child_table
( e_id INT PRIMARY KEY,
  dept_id INT NOT NULL,
  quantity INT,
  min_level INT,
  max_level INT,
  FOREIGN KEY (dept_id) REFERENCES F_Key_parent_table (dept_id) ON DELETE CASCADE
);
CREATE TABLE F_Key_parent_table2	
(
DEPT_ID	INTEGER PRIMARY KEY ,
DEPT_NAME VARCHAR(20)NOT NULL
);

CREATE TABLE  F_Key_Child_table2
( e_id INT PRIMARY KEY,
  dept_id INT NULL,
  quantity INT,
  min_level INT,
  max_level INT,
  FOREIGN KEY (dept_id) REFERENCES F_Key_parent_table2 (dept_id) ON DELETE SET NULL
);
--DIFFERENCE BETWEEN PRIMARY KEY, FOREIGN KEY & UNIQUE KEY
--PRIMARY KEY:-
--1.We can apply primary key only once in a table
--2.Primary key must contains unique values.
--3.NULL values are not acceptable. 
--4.Primary key is a clustered index.

--FOREIGN KEY- It is used to link the two tables together.
--Foreign key is a field in one table that always refers to the primary key in another table.
--Multiple null is acceptable in Foreign key.
--You can apply Foreign key multiple times in a single table.
--Foreign key do not create automatically an index, clustered or non-clustered.

--UNIQUE CONSTRAINT:-
--1.We can apply unique constraints multiple times in a single table.
--2.Only accept the unique or different values.
--3.May have multiple NULL values.
--4.Unique key is unique non-clustered index.
---------QUE NO 18-------

CREATE TABLE CUST_NAME_01
(First_name VARCHAR(150) NULL,
Last_Name VARCHAR(150) NULL,
Customer_Name VARCHAR (150) NULL
);

INSERT INTO CUST_NAME_01 (First_name,Last_Name,Customer_Name)
VALUES (null,null,'E Cornish');
INSERT INTO CUST_NAME_01 (First_name,Last_Name,Customer_Name)
VALUES ('Faith',null,'F Davidson');
INSERT INTO CUST_NAME_01 (First_name,Last_Name,Customer_Name)
VALUES (null,'Davies',null);
INSERT INTO CUST_NAME_01 (First_name,Last_Name,Customer_Name)
VALUES (null,null,'F Dickens');
INSERT INTO CUST_NAME_01 (First_name,Last_Name,Customer_Name)
VALUES (null,null,'G Dowd');
INSERT INTO CUST_NAME_01 (First_name,Last_Name,Customer_Name)
VALUES (null,'Duncan','G Duncan');
SELECT*FROM CUST_NAME_01;
SELECT A.*, COALESCE(FIRST_NAME,  LAST_NAME, CUSTOMER_NAME) FirstNotNullValue FROM CUST_NAME_01 A;

SELECT FIRST_NAME from CUST_NAME_01 where FIRST_NAME is not null
union
select LAST_NAME from CUST_NAME_01 where LAST_NAME is not null
union
select CUSTOMER_NAME from CUST_NAME_01  where CUSTOMER_NAME is not null;


-------QUE NO 19--------
SELECT*FROM customer_details;
SELECT DATENAME (MONTH,PURCHASE_DATE) MONTH_NAME FROM customer_details;
SELECT concat( FIRST_NAME,' ',LAST_NAME,' ',DATENAME (MONTH,PURCHASE_DATE)) Customer_Name_Purchase_Month  FROM customer_details;

SELECT FIRST_NAME +' '+ LAST_NAME +' '+ DATENAME(MONTH,PURCHASE_DATE) Customer_Name_Purchase_Month 
from Customer_Details;

----QUE NO 20------
SELECT*FROM Customer_Details WHERE Purchase_Date like '%07___' and datepart (year,purchase_date)=2001
SELECT SUM(Quantity) Quantity FROM Customer_Details WHERE datepart (month,purchase_date)=7  and datepart (year,purchase_date)=2001;


SELECT SUM(Quantity) Quantity FROM Customer_Details WHERE Purchase_Date like '%07___';
---QUE NO 21--------
SELECT COUNT(QUANTITY) FROM Customer_Details;
SELECT COUNT (*) TOTAL_ROW_COUNT,COUNT(QUANTITY) NOTNULL_ROW_COUNT, COUNT(DISTINCT QUANTITY)DISTINCT_ROW_COUNT from Customer_Details; 
SELECT COUNT (*) NULL_ROW_COUNT FROM Customer_Details WHERE QUANTITY IS NULL;
SELECT COUNT (*) NOTNULL_ROW_COUNT FROM Customer_Details WHERE QUANTITY IS NOT NULL;
select APPROX_COUNT_DISTINCT(QUANTITY) from Customer_Details;
-----QUE NO 22-------
SELECT DATENAME (YEAR,GETDATE ());
SELECT DATENAME (YEAR,PURCHASE_DATE) YEAR_DATE FROM Customer_Details;

SELECT A.*, DATEDIFF (YEAR,PURCHASE_DATE,GETDATE() ) YEAR_DATE   from Customer_Details A;
-----QUE NO 23-------
SELECT*FROM product_details;

SELECT A.*, CASE
WHEN PROD_PRICE <=50000 then 'Grade D'
WHEN PROD_PRICE BETWEEN 50000 AND 100000 then 'Grade C'
WHEN PROD_PRICE BETWEEN 100000 AND 120000  then 'Grade B'
WHEN PROD_PRICE BETWEEN 1200000 AND 1800000 then 'Grade A'END
AS Product_Grade FROM product_details A;
------QUE NO 24-------
SELECT*FROM Customer_Details;
SELECT F.*, DATENAME (WEEKDAY,PURCHASE_DATE) Purchase_Day FROM Customer_Details F;
----QUE NO 25-----
SELECT CURRENT_USER CURRENTUSER;
SELECT USER_NAME() CURRENTUSER;
----QUE NO 26----
SELECT MAX(Prod_Price)-MIN(Prod_Price) DIFFERENCE from product_details;
----QUE NO 27-----
SELECT*FROM Customer_Details WHERE CUST_ID % 2=0;

SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY Cust_ID) AS RowNum
    FROM Customer_Details
) AS MyDerivedTable
WHERE MyDerivedTable.RowNum % 2 =0
/*SELECT*FROM Customer_Details WHERE CUST_ID % 2=1;*/

------QUE NO 28------
SELECT DATENAME (WEEKDAY,GETDATE());
------QUE NO 29-------
-- The ISNULL function in SQL Server is used to replace NULL values with a specified value. 
--It takes two arguments: 
--If the expression is NULL, the ISNULL function returns the replacement value; otherwise, it returns 
--the original expression.
 CREATE TABLE NULL_VALUE_REPLACE
 (
 F_NAME VARCHAR(25),
 SALARY NUMERIC(20)
 );
 INSERT INTO NULL_VALUE_REPLACE (F_NAME,SALARY) VALUES ('NULL',20000);
 INSERT INTO NULL_VALUE_REPLACE (F_NAME,SALARY) VALUES ('RUSHI',NULL);
 SELECT*FROM NULL_VALUE_REPLACE;
 SELECT  ISNULL(SALARY,5) SALARY, F_NAME from NULL_VALUE_REPLACE;
  SELECT  ISNULL(F_NAME,2) F_NAME, SALARY from NULL_VALUE_REPLACE;

  ----QUE NO 30------
  SELECT*FROM Customer_Details;
  SELECT S.*, ISNULL (QUANTITY+10,10) Updated_Quantity FROM Customer_Details S;

    SELECT S.*, COALESCE (QUANTITY+10,10) Updated_Quantity FROM Customer_Details S;
  ----QUE NO 31------
  SELECT LTRIM(FIRST_NAME) FROM Customer_Details;
  SELECT RTRIM(FIRST_NAME) FROM Customer_Details;
  -----QUE NO 32----
  CREATE TABLE CUST_NAME_FULL
  (
  Customer_name VARCHAR(30)
  );
  INSERT INTO CUST_NAME_FULL VALUES ('Emma Cornish');
  SELECT*FROM CUST_NAME_FULL;
  
  SELECT  PARSENAME (REPLACE (Customer_name,' ','.'),2) AS FIRST_NAME,
  PARSENAME (REPLACE (Customer_name,' ','.'),1) AS LAST_NAME FROM CUST_NAME_FULL; 

  SELECT 
    LEFT(Customer_name, CHARINDEX(' ', Customer_name) - 1) AS First_Name,
    RIGHT(Customer_name, LEN(Customer_name) - CHARINDEX(' ', Customer_name)) AS Last_Name
FROM 
    CUST_NAME_FULL


  select customer_name,SUBSTRING(customer_name,1,CHARINDEX(' ',customer_name)-1) First_Name,
SUBSTRING(customer_name,CHARINDEX(' ',customer_name)+1,LEN(customer_name)) Last_Name from CUST_NAME_FULL;


  -----QUE NO 33-------
  CREATE TABLE KNOW_NAME
  (F_NAME VARCHAR(20)
  );
INSERT INTO KNOW_NAME VALUES ('Emma');
INSERT INTO KNOW_NAME VALUES ('Faith');
INSERT INTO KNOW_NAME VALUES ('Felicity');
INSERT INTO KNOW_NAME VALUES ('Fiona');
INSERT INTO KNOW_NAME VALUES ('Gabrielle');
INSERT INTO KNOW_NAME VALUES ('Grace');
SELECT*FROM KNOW_NAME;

select F_NAME,replace(F_NAME,SUBSTRING(F_NAME,1,4),CONCAT(SUBSTRING(F_NAME,1,4),SUBSTRING(F_NAME,4,1)))
from KNOW_NAME;

----QUE NO 34-----
--The DATEPART function extracts a specific part (such as year, month, day, hour, etc.) from a given 
--date or time value.

SELECT*FROM Customer_Details;
--For Ex:- 
SELECT c.*, DATEPART(MONTH,purchase_date) MONTH FROM Customer_Details c;
--2. CONVERT:
--The CONVERT function is used to convert a value from one data type to another.
--Syntax:-
--:- CONVERT(data_type(length), expression, style)
--for Ex:-
--Suppose we have a table called "Customer_Details" with a column named "purchase_date" that stores the 
--date when each employee was hired. We want to retrieve the hire dates in the "yyyy-mm-dd" format.
select CONVERT(varchar,purchase_date,23) from Customer_Details;
--In this example, the CONVERT function is used to convert the purchase_date column to a varchar data
--type with format 23, which represents the "yyyy-mm-dd" format. The result will be a list of hire dates 
--in the desired format.
--3.CAST:
--The CAST function is used to explicitly convert a value from one data type to another.
--Example:
--Suppose we have a table called "Products" with a column named "Price" that stores the price of each
--product as a decimal. We want to retrieve the price as an integer.
--Syntax:- CAST(expression AS datatype(length)).
--For Ex:- SELECT CAST(Price AS INT) AS IntegerPrice FROM Products;
--In this example, the CAST function is used to convert the Price column from a decimal data type to an
--integer data type. The result will be a list of prices as integers.

--Note: The CAST function is more suitable for converting between compatible data types, while the CONVERT
--function provides more flexibility for formatting date and time values.

--These functions are powerful tools in SQL Server for manipulating and converting date and time values to 
--meet specific requirements in queries and reports.
-----QUE NO 35-----
SELECT*FROM Customer_Details where purchase_date LIKE'1995%' or purchase_date LIKE '2008%' AND
First_name like '%a%' or Last_Name like '%s';
------QUE NO 36---------
SELECT*FROM Customer_Details WHERE MONTH(purchase_date) = MONTH(GETDATE());

------QUE NO 37------
SELECT purchase_date FROM Customer_Details;
CREATE TABLE DATE_DETAILS
(
DAY_ VARCHAR(30),
MONTH_ VARCHAR(30),
YEAR_ VARCHAR(30)
);
INSERT DATE_DETAILS (DAY_,MONTH_,YEAR_) 
SELECT 
DATENAME (DAY,purchase_date),
DATENAME (MONTH,purchase_date),
DATENAME (YEAR,purchase_date) FROM Customer_Details;
SELECT*FROM DATE_DETAILS;

----QUE NO 38------
CREATE TABLE Prod_Info
(Product_Name VARCHAR(30),
Prod_Price NUMERIC(20),
Prod_Price_Grade VARCHAR(10)
);
INSERT INTO Prod_Info (Product_Name,Prod_Price,Prod_Price_Grade)
VALUES  ('12M',744643,'');
INSERT INTO Prod_Info (Product_Name,Prod_Price,Prod_Price_Grade)
VALUES  ('12M FESLF',1346136,'');
INSERT INTO Prod_Info (Product_Name,Prod_Price,Prod_Price_Grade)
VALUES  ('Viking',879128,'');
INSERT INTO Prod_Info (Product_Name,Prod_Price,Prod_Price_Grade)
VALUES  ('Cheetah',713266,'');
INSERT INTO Prod_Info (Product_Name,Prod_Price,Prod_Price_Grade)
VALUES  ('Eagle',1499708,'');
INSERT INTO Prod_Info (Product_Name,Prod_Price,Prod_Price_Grade)
VALUES ('Electric Bus',1206710,'');
INSERT INTO Prod_Info (Product_Name,Prod_Price,Prod_Price_Grade)
VALUES ('Freedom',768974,'');
INSERT INTO Prod_Info (Product_Name,Prod_Price,Prod_Price_Grade)
VALUES ('Hawk',628910,'');
INSERT INTO Prod_Info (Product_Name,Prod_Price,Prod_Price_Grade)
VALUES ('Hybus',1058608,'');

SELECT*FROM Prod_Info;
UPDATE Prod_Info SET Prod_Price_Grade= CASE
WHEN Prod_Price < 1000000 THEN   'B'
WHEN Prod_Price > 1000000 THEN   'A' END;

-----QUE NO 39-----
SELECT*FROM Customer_Details;
SELECT First_name,Last_Name INTO Customer_Details_01 FROM Customer_Details;
SELECT First_name,Last_Name ,IIF (LEN(First_name+Last_Name)>=12,Last_Name,CONCAT (First_name,' ',Last_Name)) Customer_name 
FROM Customer_Details_01;

SELECT*FROM Customer_Details_01;
---QUE NO 40-----
CREATE TABLE GENDER_ALL
(
First_name VARCHAR(32),
Gender CHAR
);
INSERT INTO GENDER_ALL (First_name,Gender)
VALUES ('Vaishali','M'),('Rohit','F'),('Neha','M'),('Ravi','F'),('Sujeet','F');
SELECT*FROM GENDER_ALL;
UPDATE GENDER_ALL SET Gender = CASE
WHEN Gender ='M' THEN 'F'
WHEN Gender ='F' THEN 'M'END;
-----QUE NO 41------
CREATE TABLE EMP_EMAIL
(
EMAIL_ID VARCHAR (MAX)
);
INSERT INTO EMP_EMAIL
VALUES ('Abigail_Abraham@priori.com'),('Amelia_Arnold@priori.com'),('Andrea_Bailey@gmail.com'),('Angela_Baker@gmail.com'),
('Audrey_Berry@rediff.com'),('Ava_Black@info.com'),('Bella_Blake@infotech.com'),('Bernadette_Bond@priori.com'),('Bernadette_jessy@prioriinfotech.com'),
('minal_brett@prioriinfotech.com'),('Carol_Bower@prioriinfotech.com'),('brayan_Brown@yahoo.com'),('sam_kantor@yahoo.com'),
('Mellisa_Brown@gmail.com'),('Caroline_Brown@yahoo.com'),('Alexandra_Allan@prioriinfotech.com');


SELECT 
    EMAIL_ID,
    SUBSTRING(
        EMAIL_ID, 
        CHARINDEX('@', EMAIL_ID) + 1, 
        CHARINDEX('.', EMAIL_ID + '.') - CHARINDEX('@', EMAIL_ID) - 1
    ) AS Domain_Name
FROM EMP_EMAIL;

SELECT 
    EMAIL_ID ,
    SUBSTRING(EMAIL_ID FROM POSITION('@' IN EMAIL_ID) + 1 FOR POSITION('.' IN EMAIL_ID || '.') - POSITION('@' IN EMAIL_ID) - 1) AS Domain_Name
FROM EMP_EMAIL;

----QUE NO 42------
---a. String Function:-
-----1. ASCII:- 
--The ASCII function returns the ASCII code value of a character.
SELECT ASCII('A') AS AsciiValue;
--2.CHAR:
--The CHAR function returns the character corresponding to a specified ASCII code value.
SELECT CHAR(65) AS Character;
--3.CHARINDEX:
--The CHARINDEX function returns the starting position of a substring within a string.
SELECT CHARINDEX('E', 'RUSHIKESH') AS Position;
--4. CONCAT:
--The CONCAT function concatenates two or more strings together.
SELECT CONCAT('Hello', ' ', 'World') AS ConcatenatedString;
--5. CONCAT_WS:
--The CONCAT_WS function concatenates strings together with a specified separator.
SELECT CONCAT_WS(' ', 'RUSHIKESH', 'BHISE', '08') AS ConcatenatedString;
--This query concatenates the strings 'John', 'Doe', and '42' with a comma separator, 
--resulting in 'John,Doe,42'.
--6. DIFFERENCE:
--The DIFFERENCE function measures the difference between two strings using the SOUNDEX algorithm.
SELECT DIFFERENCE('Hello', 'Halo') AS DifferenceValue;
--This query calculates the difference between the strings 'Hello' and 'Halo' using the SOUNDEX algorithm,
--resulting in a difference value of 2.
--7. FORMAT:
--The FORMAT function formats a value with a specified format.
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd') AS FormattedDate;
--This query formats the current date and time using the specified format 'yyyy-MM-dd', 
--resulting in a formatted date string.
--Note: The FORMAT function is available starting from SQL Server 2012.
--8. LEFT:
--The LEFT function returns a specified number of characters from the beginning of a string.
SELECT LEFT('Hello World', 5) AS LeftString;
SELECT right('Hello World', 5) AS LeftString;

--This query returns the first five characters from the string 'Hello World', resulting in 'Hello'.
--9. LEN:
--The LEN function returns the length (number of characters) of a string.
SELECT LEN('Hello World') AS StringLength
SELECT LEN('HelloWorld') AS StringLength;---IN CASE REMOVE HELLO WORLD SPACE
--This query returns the length of the string 'Hello World', which is 11.
--10. LOWER:
--The LOWER function converts a string to lowercase.
SELECT LOWER('Hello') AS LowercaseString;
--This query converts the string 'Hello' to lowercase, resulting in 'hello'.
--11. LTRIM:
--The LTRIM function removes leading spaces from a string.
SELECT LTRIM('   Hello') AS TrimmedString;
--This query removes the leading spaces from the string ' Hello', resulting in 'Hello'.
--12. REPLACE:
--The REPLACE function replaces all occurrences of a substring within a string with a new substring.
SELECT REPLACE('Hello World', 'World', 'Universe') AS ReplacedString;
--This query replaces all occurrences of the substring 'World' with 'Universe' within the string
--'Hello World', resulting in 'Hello Universe'.
--13. REPLICATE: The REPLICATE function is used to repeat a specific string a certain number of times. 
--It takes two parameters: the string to be repeated and the number of times to repeat it.
SELECT REPLICATE('Hello', 3) AS Result;
--14. REVERSE: The REVERSE function is used to reverse the order of characters in a given string.
SELECT REVERSE('Hello') AS Result;
--15. RIGHT: The RIGHT function returns a specified number of characters from the right side of a string.
SELECT RIGHT('Hello', 3) AS Result;
--16. SOUNDEX: The SOUNDEX function converts a string into a four-character code based on the way it sounds.
--It is commonly used for phonetic matching of strings.
SELECT SOUNDEX('Smith') AS Result;
--17. TRIM: The TRIM function is used to remove leading and trailing spaces (or other specified characters)
--from a string.
SELECT TRIM('   Hello   ') AS Result;
--18. SUBSTRING: The SUBSTRING function is used to extract a portion of a string based on a specified 
--starting position and length.
SELECT SUBSTRING('Hello World', -1, 5) AS Result;
--19. TRANSLATE: The TRANSLATE function is used to replace characters in a string with a specified 
--replacement character.
SELECT TRANSLATE('Hello', 'elo', '123') AS Result;
--20. UPPER: The UPPER function converts all characters in a string to uppercase.
SELECT UPPER('Hello') AS Result;
--21. STRING_AGG: The STRING_AGG function is used to concatenate values from multiple rows into a single 
--string, with an optional separator.
SELECT STRING_AGG(FIRST_NAME, ' ') AS Result FROM Customer_Details;
--B) Math/Numeric Function:-
--1. ABS: The ABS function returns the absolute (positive) value of a given numeric expression.
SELECT ABS(-10) AS Result;
--2. FLOOR: The FLOOR function returns the largest integer less than or equal to a given numeric expression.
SELECT FLOOR(3.8) AS Result;
--3. POWER: The POWER function raises a given number to the power of another number.
SELECT POWER(2, 3) AS Result;
--4. RAND: The RAND function returns a random float value between 0 and 1.
SELECT RAND() AS Result;
--5. ROUND: The ROUND function is used to round a numeric expression to a specified number of decimal places.
SELECT ROUND(3.14159, 2) AS Result;
--6. SQRT: The SQRT function returns the square root of a given numeric expression.
 SELECT SQRT(16) AS Result;
--C) Conversion Functions
--1. CAST: The CAST function is used to convert a value of one data type to another data type. 
--syntax: CAST(expression AS data_type).
SELECT CAST('10' AS INT) AS Result;
--2. CONVERT: The CONVERT function is used to convert a value of one data type to another data type.
-- syntax: CONVERT(data_type, expression [, style]).
SELECT CONVERT(INT, '20') AS Result;
--The CONVERT function also allows an optional third parameter, the style, which specifies the format 
--of the converted value for certain data types like dates. 
SELECT CONVERT(DATE, '2021-09-15', 120) AS Result;
--D) Date Functions:-
---1. CURRENT_TIMESTAMP function
--is used to retrieve the current date and time as a timestamp. It returns the current system
--date and time in the datetime data type.
SELECT CURRENT_TIMESTAMP AS CurrentDateTime;
--2. GETDATE: The GETDATE function returns the current system date and time.
SELECT GETDATE() AS CurrentDateTime;
--3. DATEADD: The DATEADD function adds a specified interval to a date. It takes three parameters:
--the interval to add, the number of intervals to add, and the date.
SELECT DATEADD(DAY, 7, GETDATE()) AS FutureDate;
--4. DATEDIFF: The DATEDIFF function calculates the difference between two dates in a specified interval. 
--It takes three parameters: the interval to measure, the start date, and the end date.
SELECT DATEDIFF(DAY, '2023-06-01', '2023-06-15') AS DaysDifference;
--5.DATEPART: The DATEPART function extracts a specific part (e.g., year, month, day) from a 
SELECT DATEPART(YEAR, '2023-07-06') AS Year;
--6.DAY: The DAY function is used to extract the day component from a given date. 
--It returns an integer value representing the day of the month.
SELECT DAY('2023-07-06') AS DayOfMonth;
--7. ISDATE: The ISDATE function is used to check whether a given expression can be converted to a 
--valid date. It returns 1 if the expression is a valid date, and 0 if it is not.
SELECT ISDATE('2023-07-06') AS IsValidDate;
--E) Data type Functions
--1. IDENT_CURRENT() function 
--is used to retrieve the last identity value generated for a specific table in the current session
--and scope. The function takes the table name or object name as a parameter and returns the last
--identity value inserted into that table.
SELECT IDENT_CURRENT('dbo.MyTable') AS LastIdentityValue;
--It's important to note that the IDENT_CURRENT() function is session-specific and returns the identity
--value generated within the current session and scope. If you need to obtain the last identity value
--generated in a different session or scope, you can use other functions such as SCOPE_IDENTITY() 
--or @@IDENTITY.
--2. IDENT_SEED():-
-- is used to retrieve the seed value of an identity column in a table. The seed value represents the
--starting value of the identity column.
SELECT IDENT_SEED('dbo.MyTable') AS IdentitySeed;
--3. IDENT_INCR() function is used to retrieve the increment value of an identity column in a table.
--The increment value represents the amount by which the identity column increases for each new row.
SELECT IDENT_INCR('dbo.MyTable') AS IdentityIncrement;

--F) LOGICAL FUNCTIONS:-
--1. CHOOSE:-is used to select and return a value from a list of expressions based on an index value.
--It allows you to specify multiple expressions and choose one based on the provided index.
--CHOOSE(index, expression1, expression2, ..., expressionN)
SELECT CHOOSE(2, 'Apple', 'Banana', 'Orange', 'Mango') AS SelectedFruit;
--2. IIF():-
--he IIF() function is a logical function that allows you to perform a conditional evaluation and 
--return different values based on a specified condition. It is similar to the traditional 
--IF-ELSE statement and provides a compact way to write conditional expressions.
--IIF(condition, value_if_true, value_if_false)
SELECT IIF(Quantity > 10, 'In Stock', 'Out of Stock') AS StockStatus FROM product_details;

--G) EXPRESSION FUNCTION:-
--1. CASE:- 
--the CASE expression is a versatile and powerful construct that allows you to perform conditional
--evaluations and return different values based on specified conditions. It provides a way to 
--create conditional logic within a query or statement.
--a.Simple CASE expression:-
--The simple CASE expression compares an expression against a set of values and returns a
--result based on the matching condition.
CASE expression
   WHEN value1 THEN result1
   WHEN value2 THEN result2
   ...
   ELSE resultN
END
--Ex:-
SELECT OrderID,
       CASE ShipCountry
          WHEN 'USA' THEN 'Domestic'
          WHEN 'Canada' THEN 'Domestic'
          ELSE 'International'
       END AS ShipmentType
FROM Orders;

--2.earched CASE expression:
--The searched CASE expression evaluates multiple conditions and returns a result based on the first
--condition that matches.
CASE
   WHEN condition1 THEN result1
   WHEN condition2 THEN result2
   ...
   ELSE resultN
END

--EX:-
SELECT OrderID,
       CASE
          WHEN ShipCity = 'New York' THEN 'East'
          WHEN ShipCity = 'Los Angeles' THEN 'West'
          ELSE 'Other'
       END AS Region
FROM Orders;

--2. COALESCE ():- 
--the COALESCE() function is used to return the first non-null expression from a list of expressions.
--It is commonly used to provide a fallback value when dealing with null values in SQL queries.
--COALESCE(expression1, expression2, ..., expressionN)
SELECT COALESCE(ProductName, 'N/A') AS ProductName FROM product_details;

--3. NULLIF():-
--the NULLIF() function is used to compare two expressions and return null if they are equal. 
--It is typically used to handle specific scenarios where you want to replace a specific value with null.
--NULLIF(expression1, expression2)
SELECT NULLIF(Quantity, 0) AS AdjustedQuantity FROM Products;

--2. AGGRIGATE FUNCTIONS:-
--1. SUM():-The SUM function calculates the sum of a set of values.
SELECT SUM(SalesAmount) AS TotalSales FROM (TABLE_NAME);
--2. COUNT: The COUNT function counts the number of rows or non-null values in a column.
SELECT COUNT(*) AS TotalOrders FROM (TABLE_NAME);
--3. AVG: The AVG function calculates the average of a set of values.
SELECT AVG(Price) AS AveragePrice FROM (TABLE_NAME);
--4. MIN: The MIN function returns the minimum value from a set of values.
SELECT MIN(Quantity) AS MinimumQuantity FROM (TABLE_NAME);
--5. MAX: The MAX function returns the maximum value from a set of values.
SELECT MAX(Price) AS MaximumPrice FROM (TABLE_NAME);
