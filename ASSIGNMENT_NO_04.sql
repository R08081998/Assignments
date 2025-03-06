CREATE DATABASE ASSIGNMENT_NO_4;
-------QUE NO 01--------
SELECT COUNT (PROD) AS NO_OFF FROM CUST_PROD;
SELECT*FROM customer_details WHERE FIRST_NAME ='HEATHER';
SELECT*FROM CUST;
SELECT PROD,NAME, COUNT(*) FROM CUST_PROD GROUP BY PROD,NAME;
SELECT NAME,PROD, COUNT(*)AS COUNT_TABLE FROM CUST_PROD  NAME WHERE NAME>1

SELECT FIRST_NAME,PRODUCT_ID,QUANTITY, COUNT(*) AS C_COUNT FROM customer_details
GROUP BY FIRST_NAME,PRODUCT_ID,QUANTITY HAVING COUNT (QUANTITY)>1;

SELECT FIRST_NAME, PRODUCT_ID, SUM(QUANTITY) AS TOTAL_QUANTITY
FROM customer_details
GROUP BY FIRST_NAME, PRODUCT_ID
HAVING SUM(QUANTITY) > 1;

-------databricks/pyspark-------
from pyspark.sql.functions import count,sum,col
spark = SparkSession.builder.appName("example").getOrCreate()
df_who_prod_mt1prod = df_cust22.groupby(df_cust22.Cust_id,df_cust22.First_name,df_cust22.Product_id,df_cust22.Quantity).agg(count("Product_id").alias("number_of_quantity"))
df_morethan = df_who_prod_mt1prod.filter(col("number_of_quantity")>1)
display(df_morethan)
-------------
select * into new_table_name 
  from sourace_table 
     where 2=5;


------QUE NO 02-----------
SELECT FIRST_NAME,PRODUCT_ID,QUANTITY, COUNT(*) C_PRODUCT FROM customer_details 
GROUP BY  FIRST_NAME,PRODUCT_ID,QUANTITY HAVING COUNT (QUANTITY)>1;
SELECT FIRST_NAME,PRODUCT_ID,QUANTITY, COUNT(*) C_PRODUCT FROM customer_details WHERE PRODUCT_ID IS NOT NULL
GROUP BY  FIRST_NAME,PRODUCT_ID,QUANTITY HAVING SUM (QUANTITY)>1;

-------QUE NO 3---------------

SELECT*FROM customer_details;

SELECT FIRST_NAME,LAST_NAME FROM customer_details WHERE PRODUCT_ID IS NULL;


-----QUE NO 04------
SELECT PROD,NM,NAME, ID,NO FROM CUST INNER JOIN CUST_PROD ON ID=NO;
SELECT PROD,NM,NAME FROM CUST INNER JOIN CUST_PROD ON ID=NO WHERE NM IN ('FAITH','FIONA')
SELECT PROD,NM,NAME,ID,NO FROM CUST LEFT OUTER JOIN CUST_PROD ON ID=NO ORDER BY ID;
SELECT PROD,NM,NAME FROM CUST RIGHT OUTER JOIN CUST_PROD ON ID=NO;
SELECT PROD,NM,NAME FROM CUST FULL OUTER JOIN CUST_PROD ON ID=NO;
SELECT PROD,NM,NAME FROM CUST CROSS JOIN CUST_PROD ;

SELECT*FROM CUST ORDER BY ID;
SELECT*FROM CUST_PROD;


------QUE NO 05------
SELECT * FROM CUST INNER JOIN CUST_PROD ON NM=NAME;
SELECT * FROM CUST INNER JOIN CUST_PROD ON  ID=NO;

SELECT * FROM CUST LEFT JOIN CUST_PROD ON ID=NO  
SELECT * FROM CUST LEFT JOIN CUST_PROD ON NM=NAME 

SELECT * FROM CUST RIGHT JOIN CUST_PROD ON ID=NO  ;
SELECT * FROM CUST RIGHT JOIN CUST_PROD ON  NM=NAME;

SELECT * FROM CUST CROSS JOIN CUST_PROD ;
--------QUE NO 06--------
SELECT*FROM customer_details; 
SELECT*FROM product_detail;

SELECT Cust_id,First_name,Last_Name,Quantity,customer_details.PRODUCT_ID FROM customer_details  LEFT JOIN product_detail  ON customer_details.PRODUCT_ID=product_detail.PRODUCT_ID
WHERE (customer_details.PRODUCT_ID IS NOT NULL AND product_detail.PRODUCT_ID IS NULL);

SELECT Cust_id,First_name,Last_Name,Quantity FROM customer_details AS CU  LEFT JOIN product_detail AS PR  ON CU.PRODUCT_ID=PR.PRODUCT_ID;

------QUE NO 07------------
/*
01.it is used to minimize the multiple OR conditions.
02.It compares the values between subquery (child query) and parent query.
03.It scans all values inside the IN block.
04.can return TRUE, FALSE, or NULL. Hence, we can use it to compare NULL values.
05.We can use it on subqueries as well as with values.
06.It executes faster when the subquery result is less.
07.SELECT col_names 
FROM tab_name 
WHERE col_name IN (subquery);
EXISTS
01. determines whether the value will be returned or not.
02.It does not compare the values between subquery and parent query.
03.It stops for further execution once the single positive condition is met.
04.It returns either TRUE or FALSE. Hence, we cannot use it to compare NULL values.
05.We can use it only on subqueries.
06.It executes faster when the subquery result is large,
It is more efficient than IN because it processes Boolean values rather than values itself.
07.SELECT col_names
FROM tab_name
WHERE [NOT] EXISTS (subquery);*/

-------QUE NO 08-----------
SELECT*FROM employee_details ;
SELECT*FROM customer_details; 
SELECT*FROM product_detail;

SELECT*FROM customer_details INNER JOIN product_detail ON customer_details.PRODUCT_ID=product_detail.PRODUCT_ID;
SELECT*FROM product_detail INNER JOIN customer_details ON product_detail.PRODUCT_ID=customer_details.PRODUCT_ID;


SELECT*FROM employee_details JOIN customer_details ON employee_details.FIRST_NAME=customer_details.FIRST_NAME
JOIN product_detail ON product_detail.PRODUCT_ID=customer_details.PRODUCT_ID WHERE PRODUCT_TYPE = 'BUS' ;

SELECT employee_details.EMP_ID,customer_details.FIRST_NAME,product_detail.PRODUCT_TYPE FROM employee_details JOIN customer_details ON employee_details.FIRST_NAME=customer_details.FIRST_NAME
JOIN product_detail ON product_detail.PRODUCT_ID=customer_details.PRODUCT_ID WHERE PRODUCT_TYPE = 'BUS' ;




SELECT FIRST_NAME FROM employee_details WHERE SALARY > 10000 GROUP BY FIRST_NAME ORDER BY FIRST_NAME;
SELECT FIRST_NAME,SALARY,LAST_NAME FROM employee_details WHERE SALARY > 10000 GROUP BY FIRST_NAME,SALARY,LAST_NAME ;


---------QUE NO 09------
SELECT*FROM employee_details ;
SELECT*FROM employee_details WHERE DEPARTMENT_ID NOT IN ('20_R&D','60_ACC_FIN','70_IT');
-------QUE NO 10-------
SELECT*FROM employee_details WHERE SALARY MAX(SALARY)-MIN(SALARY);

SELECT MAX(SALARY) FROM employee_details;
SELECT Min(SALARY) FROM employee_details;
SELECT*FROM employee_details WHERE SALARY > MAX(SALARY)-MIN(SALARY)

SELECT*FROM employee_details WHERE SALARY > (SELECT (MAX(SALARY)-MIN(SALARY)) FROM employee_details);

---------QUE NO 11------------
select*from tab1;
select*from tab2;
SELECT*FROM TAB1 AS A INNER JOIN TAB2 AS B ON A.ID=B.ID AND A.NM=B.NM;
SELECT*FROM TAB1 AS A LEFT OUTER JOIN TAB2 AS B ON A.ID=B.ID AND A.NM=B.NM;
SELECT*FROM TAB1 AS A RIGHT OUTER JOIN TAB2 AS B ON A.ID=B.ID AND A.NM=B.NM;
SELECT*FROM TAB1 AS A FULL OUTER JOIN TAB2 AS B ON A.ID=B.ID AND A.NM=B.NM;
SELECT*FROM TAB1 AS A CROSS  JOIN TAB2 AS B ;

-------QUE NO 12---------
/*WHERE 
01.Filter table based data catering to specific condition.
02.Applicable without GROUP BY clause.
03.it is only use Row functions.
04. in this clauses Select, update and delete statements.
05.Applied before GROUP BY clause.
06.Used with single row operations such as Upper, Lower and so on.

HAVING
01.Group based data under set condition.
02.Does not function without GROUP BY clause.
03.Column functions.
04.Only select statement.
05.Used after GROUP BY clause.
06.Applicable with multiple row functions such as Sum, count and so on
SELECT NAME COUNT FROM CUST_PROD GROUP BY NAME HAVING COUNT (PROD)>1;
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);*/

------------que no 13---------
self join
A self join is a regular join, but the table is joined with itself.
SELECT NM,NAME FROM CUST_PROD,CUST WHERE NAME IS NOT NULL AND NM IS NOT NULL;


------------QUE NO 14--------------
SELECT*FROM Curr_Prod_Price;
SELECT AVG(PROD_PRICE) AS AVG_PRICE FROM Curr_Prod_Price;
SELECT COUNT(PROD_PRICE) AS COUNT_PRICE FROM Curr_Prod_Price;
SELECT SUM(PRODUCT_TYPE) AS SUM_PRICE FROM Curr_Prod_Price;
SELECT COUNT(NULL) AS COUNT_PRICE FROM Curr_Prod_Price;

SELECT COUNT(1) A ,AVG(prod_price) B ,COUNT(prod_price) C ,sum(product_type) D ,count(distinct product_type) E  FROM Curr_Prod_Price;

-----------QUE NO 15------
SELECT*FROM Salesman_Remaining_Target;
SELECT*FROM Salesman_Target;
SELECT*FROM Salesman_Sale;

SELECT P.NAME,(P.TARGET-TOTAL_SALES) REMAINING_TARGET FROM SALESMAN_TARGET P INNER JOIN
(SELECT S.NAME,SUM(S.SALE)TOTAL_SALES FROM SALESMAN_TARGET T INNER JOIN SALESMAN_SALE S
ON(T.NAME=S.NAME) GROUP BY S.NAME)K ON(P.NAME=K.NAME);

----------QUE NO 16------------
SELECT*FROM employee_details ;
SELECT 
COUNT (CASE WHEN salary < 2000 THEN 1 ELSE NULL END) count1,
COUNT (CASE WHEN salary BETWEEN 2001 AND 4000 THEN 1 ELSE NULL END) count2,
COUNT (CASE WHEN salary > 4000 THEN 1 ELSE NULL END) count3
FROM employee_details;

----------QUE NO 17-------
SELECT*FROM employee_details ;
SELECT*FROM customer_details; 
SELECT*FROM product_detail;

SELECT DEPARTMENT_ID, COUNT(*) FROM employee_details GROUP BY DEPARTMENT_ID HAVING COUNT(*)  <1;

--------QUE NO 18----------
SELECT*FROM Employee_Details01;
SELECT*FROM Department_Details_18;
-----01-----------
SELECT DEPARTMENT_ID,AVG (SALARY),SUM(SALARY) FROM Employee_Details01
 JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID  GROUP BY DEPARTMENT_ID;

SELECT Accounting_and_Finance,AVG (SALARY),SUM(SALARY) FROM Employee_Details01 JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
GROUP BY Accounting_and_Finance;

--------02-----------
SELECT Accounting_and_Finance,DEPARTMENT_ID FROM Department_Details_18 JOIN Employee_Details01 ON DEPARTMENT_ID=DEPT_ID  
GROUP BY Accounting_and_Finance,DEPARTMENT_ID HAVING
COUNT (DEPARTMENT_ID) >1;

SELECT Accounting_and_Finance,COUNT(FIRST_NAME) AS Number_of_Emp FROM Department_Details_18 JOIN Employee_Details01 ON DEPARTMENT_ID=DEPT_ID  
GROUP BY Accounting_and_Finance HAVING
COUNT (FIRST_NAME) >1;
SELECT*FROM Employee_Details01;
SELECT*FROM Department_Details_18;

---------03-------------

SELECT Accounting_and_Finance ,COUNT(DEPARTMENT_ID) AS Number_of_Emp FROM Employee_Details01 JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
WHERE Accounting_and_Finance='Production'
GROUP BY Accounting_and_Finance;

SELECT * FROM Employee_Details01 JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
WHERE Accounting_and_Finance='Production';
--------04--------------

SELECT FIRST_NAME,Accounting_and_Finance FROM Employee_Details01 JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
WHERE FIRST_NAME IN ('Emily','Diana')
GROUP BY FIRST_NAME,Accounting_and_Finance;

--------05----------
SELECT DEPARTMENT_ID, SUM(SALARY) AS SUM_SALARY FROM Employee_Details01 JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
WHERE DEPARTMENT_ID =10 OR DEPARTMENT_ID=20
GROUP BY DEPARTMENT_ID ;

---------06---------------
SELECT DEPARTMENT_ID,Accounting_and_Finance  FROM Employee_Details01 RIGHT OUTER JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
WHERE DEPARTMENT_ID =20 OR DEPARTMENT_ID=50
GROUP BY DEPARTMENT_ID,Accounting_and_Finance ;

---------07-------------
SELECT Emp_Id,First_Name,Last_Name,Salary,Dept_id  FROM Employee_Details01  JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
WHERE Accounting_and_Finance='Research and Development' AND SALARY >5000
GROUP BY Emp_Id,First_Name,Last_Name,Salary,Dept_id ;

----------08---------
SELECT Emp_Id, COUNT(Emp_Id) AS EMP_COUNT  FROM Employee_Details01  JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
WHERE Accounting_and_Finance='Research and Development' AND SALARY >5000
GROUP BY Emp_Id ;

SELECT COUNT(Emp_Id) AS EMP_COUNT  FROM Employee_Details01  JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
WHERE Accounting_and_Finance='Research and Development' AND SALARY >5000;

-------------QUE NO 19-------------
CREATE TABLE Employee_Details_NO_19
(Emp_Id INT,
First_Name VARCHAR(100),
Last_Name VARCHAR (100),
Salary NUMERIC (12)
);
INSERT INTO Employee_Details_NO_19 (Emp_Id,First_Name,Last_Name,Salary)
VALUES (121,'Diana','Campbell',5900);
INSERT INTO Employee_Details_NO_19 (Emp_Id,First_Name,Last_Name,Salary)
VALUES (122,'Diane','Carr',7800);
INSERT INTO Employee_Details_NO_19 (Emp_Id,First_Name,Last_Name,Salary)
VALUES (123,'Donna','Chapman',9600);
INSERT INTO Employee_Details_NO_19 (Emp_Id,First_Name,Last_Name,Salary)
VALUES (124,'Dorothy','Churchill',7800);
INSERT INTO Employee_Details_NO_19 (Emp_Id,First_Name,Last_Name,Salary)
VALUES (125,'Elizabeth','Clark',4500);
INSERT INTO Employee_Details_NO_19 (Emp_Id,First_Name,Last_Name,Salary)
VALUES (123,'Donna','Chapman',9600);
INSERT INTO Employee_Details_NO_19 (Emp_Id,First_Name,Last_Name,Salary)
VALUES (124,'Dorothy','Churchill',7800);
INSERT INTO Employee_Details_NO_19 (Emp_Id,First_Name,Last_Name,Salary)
VALUES (124,'Dorothy','Churchill',7800);

SELECT*FROM Employee_Details_NO_19;

SELECT EMP_ID,  COUNT (EMP_ID) AS C_EMP_ID
FROM Employee_Details_NO_19 GROUP BY EMP_ID HAVING COUNT(EMP_ID)>1;

SELECT Emp_Id,First_Name,Last_Name,Salary, COUNT (*) AS C_INT FROM Employee_Details_NO_19
GROUP BY Emp_Id,First_Name,Last_Name,Salary HAVING COUNT(*)>1;
---------------USING GROUP BY CLAUSE--------
DELETE FROM Employee_Details_NO_19 WHERE Emp_Id NOT IN 
(SELECT MAX(Emp_Id) FROM Employee_Details_NO_19 GROUP BY Emp_Id, First_Name,Last_Name,Salary);

----------------USE CTE AND ROW NUMBER-----
WITH DUPLICATE_CTE AS (
SELECT Emp_Id,First_Name,Last_Name,Salary, ROW_NUMBER() OVER (PARTITION BY First_Name,Last_Name,Salary ORDER BY Emp_Id)
AS DUP_COUNT FROM Employee_Details_NO_19
) 
DELETE FROM DUPLICATE_CTE WHERE DUP_COUNT >1;

---------QUE NO 20---------------
SELECT*FROM Employee_Details_NO_19;

SELECT TOP 1*FROM Employee_Details_NO_19
ORDER BY Emp_Id DESC

--------QUE NO 21--------
SELECT TOP 3 *FROM Employee_Details_NO_19;
 
 --------QUE NO 22----
 SELECT TOP 50 PERCENT * FROM Employee_Details_NO_19 ;
 ---------QUE NO 23----------
 WITH NTH_VALUE AS (
 SELECT*,ROW_NUMBER() OVER (ORDER BY FIRST_NAME) AS C_F_NAME FROM Employee_Details_NO_19)
 SELECT*FROM NTH_VALUE WHERE C_F_NAME=3;
---------QUE NO 24----------
-----------01-------
SELECT*FROM Employee_Details_QUE_NO_24;

SELECT*FROM Employee_Details_QUE_NO_24 WHERE SALARY > (SELECT SALARY FROM Employee_Details_QUE_NO_24 WHERE FIRST_NAME = 'Felicity' AND LAST_NAME = 'Davies');

SELECT FIRST_NAME,LAST_NAME FROM Employee_Details_QUE_NO_24
WHERE SALARY > (SELECT SALARY FROM Employee_Details_QUE_NO_24 WHERE FIRST_NAME = 'Felicity' AND LAST_NAME = 'Davies');
-----------02----------------
SELECT * FROM Employee_Details_QUE_NO_24   WHERE JOB_ID = 'supervisor';

SELECT  MAX(SALARY) AS MAX_SALARY  FROM Employee_Details_QUE_NO_24   WHERE JOB_ID = 'supervisor';

-----------03---------------
SELECT FIRST_NAME,LAST_NAME,JOB_ID FROM Employee_Details_QUE_NO_24
WHERE JOB_ID= (SELECT JOB_ID FROM Employee_Details_QUE_NO_24 WHERE FIRST_NAME = 'Emma ' AND LAST_NAME = 'Cornish');

SELECT * FROM Employee_Details_QUE_NO_24
WHERE JOB_ID= (SELECT JOB_ID FROM Employee_Details_QUE_NO_24 WHERE FIRST_NAME = 'Emma ' AND LAST_NAME = 'Cornish');

---------04--------------------
SELECT * FROM Employee_Details_QUE_NO_24;


SELECT MAX(SALARY) FROM Employee_Details_QUE_NO_24;
SELECT  AVG(SALARY) FROM Employee_Details_QUE_NO_24;

SELECT EMP_ID,FIRST_NAME,LAST_NAME,JOB_ID,SALARY,DEPT_ID, MAX(SALARY)AS M_SALARY ,AVG (SALARY) AS AVG_SALARY FROM Employee_Details_QUE_NO_24
GROUP BY EMP_ID,FIRST_NAME,LAST_NAME,JOB_ID,SALARY,DEPT_ID;

SELECT*FROM Employee_Details_QUE_NO_24 WHERE SALARY >  (SELECT AVG (SALARY) FROM Employee_Details_QUE_NO_24 );

---------------05-----------------

SELECT JOB_ID ,MAX(SALARY) FROM Employee_Details_QUE_NO_24 GROUP BY JOB_ID;

--------------06------------
SELECT  EMP_ID,FIRST_NAME,LAST_NAME,JOB_ID,SALARY,DEPT_ID, MAX(SALARY) AS MAX_SAL FROM Employee_Details_QUE_NO_24  GROUP BY EMP_ID,FIRST_NAME,LAST_NAME,JOB_ID,SALARY,DEPT_ID;

SELECT JOB_ID ,MAX(SALARY) FROM Employee_Details_QUE_NO_24 GROUP BY JOB_ID;

-----------07------------

SELECT * FROM Employee_Details_QUE_NO_24
WHERE JOB_ID= (SELECT JOB_ID FROM Employee_Details_QUE_NO_24 WHERE FIRST_NAME = 'Felicity ' AND LAST_NAME = 'Davies');

SELECT*FROM Employee_Details_QUE_NO_24 WHERE SALARY > (SELECT SALARY FROM Employee_Details_QUE_NO_24 WHERE FIRST_NAME = 'Felicity' AND LAST_NAME = 'Davies');


SELECT *FROM (SELECT * FROM Employee_Details_QUE_NO_24
WHERE JOB_ID= (SELECT JOB_ID FROM Employee_Details_QUE_NO_24 WHERE FIRST_NAME = 'Felicity ' AND LAST_NAME = 'Davies')) AS ABC
WHERE SALARY > (SELECT SALARY FROM Employee_Details_QUE_NO_24 WHERE FIRST_NAME = 'Felicity' AND LAST_NAME = 'Davies');

--------08------------
SELECT MAX (SALARY) FROM Employee_Details_QUE_NO_24;

------------09--------------
SELECT JOB_ID,  (AVG (SALARY)) FROM Employee_Details_QUE_NO_24 GROUP BY JOB_ID;

SELECT JOB_ID,  MAX (AVG (SALARY)) AS RANJU FROM Employee_Details_QUE_NO_24 GROUP BY JOB_ID;

-----------------10--------------
SELECT COUNT(*) FROM Employee_Details_QUE_NO_24;
SELECT COUNT(*) FROM Department_Details_18;
SELECT * FROM Department_Details_18;
SELECT * FROM Employee_Details_QUE_NO_24 ;

SELECT EMP_ID,FIRST_NAME,LAST_NAME,JOB_ID,SALARY,ACCOUNTING_AND_FINANCE  FROM Employee_Details_QUE_NO_24 JOIN Department_Details_18 ON DEPT_ID=DEPARTMENT_ID 
GROUP BY EMP_ID,FIRST_NAME,LAST_NAME,JOB_ID,SALARY,ACCOUNTING_AND_FINANCE ;

SELECT EMP_ID,FIRST_NAME,LAST_NAME,JOB_ID,SALARY,DEPT_ID ,ACCOUNTING_AND_FINANCE,DEPARTMENT_ID, COUNT(*) AS FULL_COUNT FROM Employee_Details_QUE_NO_24,Department_Details_18
GROUP BY EMP_ID,FIRST_NAME,LAST_NAME,JOB_ID,SALARY,DEPT_ID,ACCOUNTING_AND_FINANCE,DEPARTMENT_ID;

SELECT COUNT(*) FROM Employee_Details_QUE_NO_24
UNION ALL
SELECT COUNT(*) FROM Department_Details_18;



----------------11-----------------
SELECT * FROM Employee_Details_QUE_NO_24 ;
SELECT DEPT_ID,JOB_ID,COUNT(*) AS C_COUNT FROM Employee_Details_QUE_NO_24 GROUP BY DEPT_ID,JOB_ID;

--------------12------------

SELECT DEPT_ID ,COUNT(DEPT_ID) AS S_COUNT FROM Employee_Details_QUE_NO_24 WHERE DEPT_ID IN 
(SELECT DEPT_ID FROM Employee_Details_QUE_NO_24 GROUP BY DEPT_ID HAVING COUNT(*) IN
(SELECT MAX (MY_COUNT) FROM  (SELECT COUNT(*) MY_COUNT FROM Employee_Details_QUE_NO_24 GROUP BY DEPT_ID)A)) GROUP BY DEPT_ID;

SELECT MAX(COUNT(*)) MY_COUNT FROM Employee_Details_QUE_NO_24 GROUP BY DEPT_ID ;

SELECT DEPT_ID,COUNT(*)EMP_COUNT FROM Employee_Details_QUE_NO_24 GROUP BY DEPT_ID 
HAVING COUNT(*) IN (SELECT MAX (MY_COUNT) FROM  (SELECT COUNT(*) MY_COUNT
FROM Employee_Details_QUE_NO_24 GROUP BY DEPT_ID)A);

------------13----------
SELECT SUM(SALARY)TOTAL_SALARY, MAX(SALARY)MAXIMUM_SALARY, PERCENTAGE(SALARY) FROM Employee_Details_QUE_NO_24;
SELECT COUNT(SALARY) FROM Employee_Details_QUE_NO_24;
SELECT SUM(SALARY)TOTAL_SALARY, MAX(SALARY)MAXIMUM_SALARY,COUNT(SALARY)T_COUNT FROM Employee_Details_QUE_NO_24;

SELECT TOTAL_SALARY,MAXIMUM_SALARY,round ((MAXIMUM_SALARY/TOTAL_SALARY)*100,2) PERCENTAGE_OF_SAL FROM
(SELECT SUM(SALARY)TOTAL_SALARY, MAX(SALARY)MAXIMUM_SALARY FROM Employee_Details_QUE_NO_24)A;

select*from Employee_Details_QUE_NO_24

/*
SELECT (576/100)*15
SELECT 15*75

SELECT (15/576)*100
SELECT 576/15
*/

---------------14-----

SELECT*FROM Employee_Details_QUE_NO_24 WHERE SALARY= 
(SELECT MAX (SALARY) FROM Employee_Details_QUE_NO_24 WHERE JOB_ID='supervisor' ) AND JOB_ID='supervisor';
-----------------15---------
SELECT MAX (SALARY)  FROM  Employee_Details_QUE_NO_24 ;
SELECT *  FROM  Employee_Details_QUE_NO_24 WHERE SALARY=89000;
SELECT *  FROM Employee_Details_QUE_NO_24 ORDER BY SALARY DESC;
SELECT TOP 2 * FROM Employee_Details_QUE_NO_24 ORDER BY SALARY DESC;

SELECT MAX(SALARY) AS SALARY FROM Employee_Details_QUE_NO_24 WHERE SALARY < (SELECT MAX(SALARY) FROM Employee_Details_QUE_NO_24);

-------------16--------------
SELECT MAX(SALARY) FROM Employee_Details_QUE_NO_24 WHERE SALARY <
(SELECT MAX(SALARY) FROM Employee_Details_QUE_NO_24);

SELECT*FROM Employee_Details_QUE_NO_24 WHERE SALARY IN 
(
SELECT MAX(SALARY) FROM Employee_Details_QUE_NO_24 WHERE SALARY <
(SELECT MAX(SALARY) FROM Employee_Details_QUE_NO_24));

-------------17-----------------

SELECT 1 NUM, 'employee' TEXT 
UNION
SELECT (NULL) NUM, 'departments';

-----QUE NO 25----------
SELECT 1 NUM, 'employee' TEXT 
UNION
SELECT (NULL) NUM, 'departments' TEXT;

---------QUE NO 26---------
SELECT JOB_ID
 FROM Employee_Details_QUE_NO_24
UNION ALL
SELECT job_id
FROM job_history
ORDER BY 2;


---------QUE NO 27--------------------
SELECT*FROM Department_Details_NO_27;


 SELECT *, CASE
              WHEN DEPARTMENT_ID = '10_Prod' THEN 'Ten_Prod'  
			  WHEN DEPARTMENT_ID = '20_RD' THEN 'Twenty_RD'
			  WHEN DEPARTMENT_ID = '30_Purchase' THEN 'Thirty_Purchase'
			  WHEN DEPARTMENT_ID = '40_Marketing' THEN 'Fourty_Marketing'
			  WHEN DEPARTMENT_ID = '50_HR' THEN 'Fifty_HR'
			  WHEN DEPARTMENT_ID = '60_Acc_Fin' THEN 'Sixty_Acc_Fin'
			  WHEN DEPARTMENT_ID = '70_IT' THEN 'Seventy_IT'
			  WHEN DEPARTMENT_ID = '80_Sales' THEN 'eighty_sales'
			  END DEPARTMENT_ID FROM Department_Details_NO_27;

