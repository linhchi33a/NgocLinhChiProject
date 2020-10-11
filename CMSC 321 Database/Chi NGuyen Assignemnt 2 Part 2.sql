-- 1a
SELECT d.Dname,d.Dnumber,AVG(e.Salary),COUNT(e.dno),e.dno
FROM 	EMPLOYEE AS e,
		DEPARTMENT AS d
WHERE e.Dno=d.Dnumber
GROUP BY e.Dno
HAVING AVG(e.Salary)>30000;

-- 2a
SELECT e.Fname,e.Lname
FROM Employee as e
WHERE e.Dno = (
	SELECT Dno
	FROM Employee
	WHERE salary = (SELECT MAX(salary)
					FROM employee));
-- 2b
SELECT E.Fname, E.Lname
FROM EMPLOYEE AS E
WHERE E.Super_ssn IN
(SELECT S.Ssn 
FROM EMPLOYEE AS S
WHERE s.Super_ssn = '888665555');

-- 2c
SELECT E.Fname, E.Lname
FROM Employee AS E
WHERE E.Salary >= 10000 + 
(	SELECT MIN(Salary) 
	FROM Employee);
    
-- 3a
SELECT d.Dname, e.Fname, e.Lname, e.Salary
FROM Employee as e
JOIN Department as d
WHERE e.Ssn=d.Mgr_ssn
GROUP BY d.Dnumber;

-- 3b
SELECT e.Fname, e.Lname, s.Fname, s.Lname, e.Salary
FROM Employee AS e, 
	 Employee AS s, 
     Department As d
WHERE e.super_ssn=s.ssn AND e.Dno=d.Dnumber AND d.Dname='Research';
	
-- 3c
SELECT p.Pname, d.Dname, COUNT(*) AS "HOURS"
FROM Project AS p,
	 Department AS d,
     Works_on AS w 
WHERE p.Dnum = d.Dnumber AND p.Pnumber = w.Pno
GROUP BY p.Pname;