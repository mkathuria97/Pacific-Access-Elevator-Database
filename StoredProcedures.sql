Mayank

Stored Procedures

1) Insert Project

go
CREATE PROCEDURE uspInsert_Project
@ProjectName varchar(50),
@ProjectDescription varchar(200),
@ProjectReceivedDate date,
@ScheduledStartDate date,
@ScheduledEndDate date,
@PlannedCost money,
@ActualStartDate date,
@ActualEndDate date,
@ModifiedDate date,
@CustomerName varchar(50)
AS
DECLARE @CustomerID INT
SET @CustomerID = (SELECT CustomerID FROM Customer
                   WHERE CustomerName = @CustomerName)
BEGIN TRAN T1
IF @CustomerID IS NULL
    BEGIN
         INSERT INTO Customer(CustomerName, CustomerDescription, CustomerTypeID)
         VALUES(@CustomerName, NULL, NULL)
    SET @CustomerID = (SELECT Scope_Identity())
    END
INSERT INTO Project(ProjectName, ProjectDescription, ProjectReceivedDate, ScheduledStartDate, ScheduledEndDate, PlannedCost, ActualStartDate, ActualEndDate, ModifiedDate, CustomerID)
VALUES(@ProjectName, @ProjectDescription, @ProjectReceivedDate, @ScheduledStartDate, @ScheduledStartDate, @PlannedCost, @ActualStartDate, @ActualEndDate, @ModifiedDate, @CustomerID)
IF @@ERROR <> 0
  ROLLBACK TRAN T1
ELSE
    COMMIT TRAN T1

2) Insert Purchase Order

go
CREATE PROCEDURE uspInsert_PurchaseOrder
@OrderQuantity smallint,
@SubTotal money,
@AdvancedPayment money,
@TaxAmt money,
@OrderDate date,
@DueDate date,
@VendorName varchar(50)
AS
DECLARE @VendorID INT
SET @VendorId = (SELECT VendorID FROM VENDOR where VendorName = @VendorName)
IF @VendorID IS NULL
begin
	insert into vendor(VendorName)
	values(@VendorName)
	set @VendorID = (SELECT SCOPE_IDENTITY())
end
begin tran t1
INSERT INTO PurchaseOrder(OrderedQuantity, SubTotal, AdvancedPayment, TaxAmt, OrderDate, DueDate, VendorID)
values(@OrderQuantity, @SubTotal, @AdvancedPayment, @TaxAmt, @OrderDate, @DueDate, @VendorID)
IF @@ERROR <> 0
 ROLLBACK TRAN T1
ELSE
     COMMIT TRAN T1

Check Constraint

1) Manage Delivery Date

go
CREATE FUNCTION fnManageDate()
RETURNS INT
AS
BEGIN
DECLARE @RET int = 0
IF EXISTS(SELECT COUNT(*) FROM PurchaseOrder PO
JOIN PurchaseOrder_Delivery POD ON  PO.PurchaseOrderID = POD.PurchaseOrderID
JOIN ProductDelivery PD ON PD.DeliveryID =	POD.DeliveryID
WHERE PO.OrderDate > PD.StartDate OR PO.DueDate < PD.EndDate
GROUP BY PO.PurchaseOrderID
HAVING COUNT(*) > 1)
SET @RET = 1
RETURN @RET
END

go
ALTER TABLE ProductDelivery
ADD CONSTRAINT ck_TimeCheck
CHECK(fnManageDate() = 0)

Collin Frietzsche

Stored Procedures

1) Insert Employee

CREATE Proc uspAddEmployee
@EmpFName varchar(50),
@EmpLName varchar(50),
@EmpDOB date,
@Gender char(1),
@Salary money,
@MartialStatus char(1),
@VacHours int,
@SickLeaveHours int
AS
BEGIN TRAN
  INSERT INTO Employee(EmpFName, EmpLName, DateOfBirth, Gender, Salary, MartialStatus, VacationHours, SickLeaveHours)
    VALUES (@EmpFName, @EmpLName, @EmpDOB, @Gender, @Salary, @MartialStatus, @VacHours, @SickLeaveHours)

IF @@ERROR <> 0
  Rollback TRAN
ELSE
  Commit TRAN

2) Insert Product

CREATE PROC uspAddCustomer
@CustName varchar(50),
@CustDesc varchar(200),
@CustTypeName varchar(50)
AS
DECLARE @CustTypeID int
SET @CustTypeID = (SELECT CT.CustomerTypeID FROM CustomerType CT
                WHERE CT.CustTypeName = @CustTypeName)
BEGIN TRAN
  IF @CustTypeID IS NULL
    BEGIN
      INSERT INTO CustomerType(CustTypeName)
        VALUES(@CustTypeName)
      SET @CustTypeID = (SELECT SCOPE_IDENTITY())
    END
  INSERT INTO Customer(CustomerName, CustomerDescription, CustomerTypeID)
    VALUES(@CustName, @CustDesc, @CustTypeID)

IF @@ERROR <> 0
  Rollback TRAN
ELSE
  Commit TRAN

Check Constraint

1) Check (with no check) Employees can't work on more than two projects

GO
CREATE FUNCTION fnNoMoreThanTwo()
RETURNS INT
AS
BEGIN
DECLARE @Ret int = 0
  BEGIN
    IF EXISTS (
      SELECT E.EmployeeID, count(P.ProjectID)
      FROM Project P
        JOIN Employee_Project EP ON P.ProjectID = EP.ProjectID
        JOIN Employee E ON EP.EmployeeID = E.EmployeeID
      GROUP BY E.EmployeeID
      HAVING count(P.ProjectID) > 2
    )
    SET @Ret = 1
  END
RETURN @Ret
END

GO
ALTER TABLE Employee with nocheck
ADD CONSTRAINT addCheckNoMoreThanTwo
CHECK([dbo].[fnNoMoreThanTwo]() = 0)
