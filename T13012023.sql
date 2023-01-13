CREATE DATABASE EmployeeDB
GO

USE EmployeeDB
GO

CREATE TABLE Department(
	DepartId INT NOT NULL,
	DepartName VARCHAR(50) NOT null,
	Description VARCHAR(100) NOT NULL,
)
ALTER TABLE dbo.Department ADD CONSTRAINT PK_DepartId PRIMARY KEY(DepartId)

CREATE TABLE Employee(
	EmpCode char(6) NOT NULL ,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
	Birthday smalldatetime NOT NULL,
	Gender Bit DEFAULT(1),
	Address varchar(100),
	DepartID Int NOT NULL,
	Salary Money
)
ALTER TABLE  dbo.Employee ADD CONSTRAINT PK_EmpCode PRIMARY KEY(EmpCode)
ALTER TABLE dbo.Employee ADD CONSTRAINT FK_DepartID FOREIGN KEY (DepartID) REFERENCES dbo.Department(DepartId)

INSERT INTO dbo.Department VALUES(1001, 'khoa 1', 'Description 1')
INSERT INTO dbo.Department VALUES(1002, 'khoa 2', 'Description 2')
INSERT INTO dbo.Department VALUES(1003, 'khoa 3', 'Description 3')

INSERT INTO dbo.Employee VALUES('A00', 'Alex', 'nguyen', '19950101', 1, 'VietNam', 1001, 1000)
INSERT INTO dbo.Employee VALUES('A11', 'John', 'nguyen', '19950101', 1, 'VietNam', 1003, 1500)
INSERT INTO dbo.Employee VALUES('A22', 'Wison', 'nguyen', '19950101', 1, 'VietNam', 1002, 2000)

UPDATE dbo.Employee
SET Salary = Salary + Salary / 100 * 10
 
ALTER TABLE dbo.Employee ADD CONSTRAINT Check_Salary CHECK(Salary > 0)

CREATE OR ALTER	 TRIGGER tg_chkBirthday
ON dbo.Employee
FOR INSERT, UPDATE
AS
	BEGIN
		IF EXISTS(SELECT * FROM inserted  WHERE DAY(Birthday) <=  23)
		BEGIN
			PRINT('birthday must be greater than 23')
			ROLLBACK TRANSACTION
        END
    END

INSERT INTO dbo.Employee VALUES('A23', 'Wison', 'nguyen', '19950128', 1, 'VietNam', 1002, 2000)

CREATE INDEX IX_DepartmentName ON dbo.Department(DepartName)

CREATE VIEW Detail_Employee AS
SELECT dbo.Employee.EmpCode, Employee.FirstName, dbo.Employee.LastName, Department.DepartName  FROM dbo.Employee 
INNER JOIN dbo.Department
ON Department.DepartId = Employee.DepartID


CREATE OR ALTER PROCEDURE sp_getAllEmp 
(
	@DepartId int
)
AS
	BEGIN
		SELECT * FROM dbo.Employee 
		WHERE DepartID = @DepartId
    END

CREATE OR ALTER PROCEDURE sp_delDept  
(
	@EmpCode CHAR(6)
)
AS
	BEGIN
		DELETE  FROM dbo.Employee 
		WHERE EmpCode = @EmpCode
    END
z
