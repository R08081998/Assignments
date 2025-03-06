CREATE TABLE Employee_Details					
(E_id INT,
F_name VARCHAR (20),
Dept_id VARCHAR (30),
Email_id VARCHAR (80),
Salary DECIMAL (20,2),
Hire_Date DATE);

SELECT*FROM Employee_Details;
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (101,'Abigail','10_Prod','Abigail_Abraham@priory.com',99446,'06-25-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (102,'Alexandra','10_Prod','Alexandra_Allan@priory.com',35106,'06-26-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (103,'Alison','10_Prod','Alison_Alsop@priory.com',60137,'06-27-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (104,'Amanda','10_Prod','Amanda_Anderson@priory.com',34888,'06-28-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (105,'Amelia','10_Prod','Amelia_Arnold@priory.com',22362,'06-29-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (106,'Amy','20_RD','Amy_Avery@priory.com',46237,'06-30-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (107,'Andrea','20_RD','Andrea_Bailey@priory.com',9347,'07-02-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (108,'Angela','20_RD','Angela_Baker@priory.com',27937,'07-03-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (109,'Anna','20_RD','Anna_Ball@priory.com',63958,'07-04-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (110,'Anne','20_RD','Anne_Bell@priory.com',NULL,'07-05-1995')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (111,'Audrey','20_RD','Audrey_Berry@priory.com',24070,'06-24-1997')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (112,'Ava','20_RD','Ava_Black@priory.com',58388,'07-01-1999')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (113,'Bella','20_RD','Bella_Blake@priory.com','81680','07-06-2000')
INSERT INTO Employee_Details (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
VALUES (114,'Bernadette','20_RD','Bernadette_Bond@priory.com',68857,'07-07-2000')
INSERT INTO Employee_Details (E_id,	F_name,Email_id,Salary,Hire_Date)
VALUES (115,'Carol','Carol_Bower@priory.com',35346,'07-08-2000');
INSERT INTO Employee_Details (E_id,	F_name,Email_id,Salary,Hire_Date)
VALUES ( 116,'Caroline','Caroline_Brown@priory.com',80291,'07-09-2000')

/*INSERT INTO Employee_Details (E_id,	F_name,Email_id,Salary,Hire_Date)
VALUES ( 117,'NULL','Caroline_Brown@priory.com',80291,'07-09-2000')*/

SELECT * FROM Employee_Details;
DELETE FROM Employee_Details WHERE E_id = 115
 ------QUE 11--------
SELECT * FROM Employee_Details WHERE SALARY > 55900;
-------QUE 12-----------
SELECT * FROM Employee_Details WHERE  SALARY >55900 AND SALARY < 85000;

SELECT * FROM Employee_Details WHERE (SALARY BETWEEN 55900 AND 85000);

---------QUE 13---------
SELECT * FROM Employee_Details WHERE F_NAME LIKE 'A%';
--------SELECT * FROM Employee_Details WHERE F_NAME LIKE '%A';
-------------SELECT * FROM Employee_Details WHERE F_NAME LIKE '%A%';

--------------QUE 22-------
select  'CURRENT_TIMESTAMP' ;
-------que 23--------

SELECT * FROM Employee_Details WHERE Dept_id <> '20_RD';
------------SELECT * FROM Employee_Details WHERE Dept_id != '20_RD';
---------QUE 24------

SELECT * FROM Employee_Details WHERE Dept_id IS NULL;

/*SELECT * FROM Employee_Details WHERE  F_NAME = 'NULL';

DELETE FROM Employee_Details WHERE  F_NAME = 'NULL';
BEGIN TRAN
DELETE FROM Employee_Details WHERE Dept_id = '20_RD'AND F_NAME LIKE 'A%';

SELECT * FROM Employee_Details
BEGIN TRAN 
ROLLBACK*/
-------que 25--------

SELECT* FROM Employee_Details WHERE Dept_id = '20_RD'AND F_NAME LIKE 'A%';


/*UPDATE Employee_Details SET F_NAME= 'RANN' WHERE E_id= 101;

UPDATE Employee_Details SET F_NAME= 'RANN' WHERE Email_id= 'ABC@GMAIL.COM' ;


UPDATE Employee_Details SET F_NAME= 'Abigail', SALARY=30000 WHERE E_id= 101;

DELETE FROM Employee_Details WHERE F_NAME = 'RANN';

UPDATE Employee_Details SET SALARY= 99446;

TRUNCATE TABLE Employee_Details;*/

---QUE 26------

SELECT*FROM Employee_Details;

SELECT*INTO EMP_DETAILS FROM Employee_Details;

SELECT*FROM EMP_DETAILS;

--------QUE 27--------
/*SELECT*INTO EMP_DETAILS_20RD FROM Employee_Details
WHERE Dept_id='20_RD';

SELECT*FROM EMP_DETAILS_20RD;

SELECT*FROM EMP_DETAILS_20RD WHERE Dept_id='20_RD';

DROP TABLE EMP_DETAILS_20RD;*/

SELECT*INTO EMP_DETAILS_20RD FROM Employee_Details
WHERE Dept_id='20_RD';


SELECT*FROM EMP_DETAILS_20RD;

------QUE 28------
/*SELECT * FROM EMP_DETAILS_20RD;
INSERT INTO EMP_DETAILS_20RD (E_id,	F_name,Dept_id,Email_id,Salary,Hire_Date)
SELECT E_id,F_name,DEPT_ID,Email_id,Salary,Hire_Date FROM EMP_DETAILS;

DROP TABLE EMP_DETAILS_20RD;*/

INSERT EMP_DETAILS_20RD (E_id,F_name,Dept_id,Email_id,Salary,Hire_Date)
SELECT E_id,F_name,Dept_id,Email_id,Salary,Hire_Date FROM EMP_DETAILS;

SELECT * FROM EMP_DETAILS_20RD;

------QUE 29---------

SELECT*FROM Employee_Details WHERE (SALARY BETWEEN 25000 AND 50000) AND Dept_id='20_RD';

------QUE 30---------

SELECT*FROM Employee_Details WHERE SALARY IS NULL;

-----QUE 31---------

SELECT*FROM Employee_Details WHERE E_ID=106 OR E_ID=111;

-------QUE 32----------

EXEC SP_RENAME 'EMP_DETAILS_20RD','EMP_DETAILS_20'; 

/*EXEC SP_RENAME 'Employee_Details.F_NAME','FI_NAME','COLUMN';
EXEC SP_RENAME 'Employee_Details.FI_NAME','F_NAME','COLUMN';*/

------QUE 33-------
SELECT*FROM EMP_DETAILS;

ALTER TABLE EMP_DETAILS
ADD GENDER VARCHAR (10);

-----QUE 34-------
ALTER TABLE EMP_DETAILS
DROP COLUMN GENDER;

-----QUE 35--------
SELECT*FROM EMP_DETAILS;

UPDATE EMP_DETAILS SET F_NAME ='Johnny', EMAIL_ID='Perterson@gmail.com' WHERE E_ID=108; 

------QUE 36---------
SELECT*FROM Employee_Details;

DELETE FROM Employee_Details WHERE SALARY > 50000 OR F_NAME LIKE 'C%'

-----QUE 37-------

DELETE EMP_DETAILS_20 ;

------QUE 43----
EXEC SP_RENAME 'Employee_Details.F_NAME','FIRST_NAME';




