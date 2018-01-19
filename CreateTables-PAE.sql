CREATE DATABASE [cafPacificAccess]
GO
USE [cafPacificAccess]
GO
CREATE TABLE [dbo].[VendorType] (
[VendorTypeID] int identity(1,1) primary key NOT NULL,
[VendorTypeName] varchar(50) NOT NULL,
[VendorTypeDescription] varchar(200) NULL
)
CREATE TABLE [dbo].[EmployeeContact] (
[EmpContactID] int identity(1,1) primary key NOT NULL,
[EmpContactNumber] int NOT NULL,
[EmployeeID] int NOT NULL,
[EmpContactTypeID] int NULL
)
CREATE TABLE [dbo].[Product_PurchaseOrder] (
[LineItemID] int identity(1,1) primary key NOT NULL,
[PurchaseOrderID] int NOT NULL,
[ProductID] int NOT NULL
)
CREATE TABLE [dbo].[CustomerContactType] (
[CustContactTypeID] int identity(1,1) primary key NOT NULL,
[ContactTypeName] varchar(50) NULL,
[ContactTypeDescription] varchar(200) NULL
)
CREATE TABLE [dbo].[Project_DelayReasons] (
[ProjectDelayID] int identity(1,1) primary key NOT NULL,
[ProjectID] int NOT NULL,
[DelayReasonID] int NOT NULL
)
CREATE TABLE [dbo].[DelayReasons] (
[DelayReasonID] int identity(1,1) primary key NOT NULL,
[Name] varchar(50) NOT NULL,
[DelayDescription] varchar(200) NULL
)
CREATE TABLE [dbo].[CustomerType] (
[CustomerTypeID] int identity(1,1) primary key NOT NULL,
[CustTypeName] varchar(50) NULL,
[CustTypeDescription] varchar(200) NULL
)
CREATE TABLE [dbo].[Customer] (
[CustomerID] int identity(1,1) primary key NOT NULL,
[CustomerName] varchar(50) NOT NULL,
[CustomerDescription] varchar(200) NULL,
[CustomerTypeID] int NULL
)
CREATE TABLE [dbo].[Vendor] (
[VendorID] int identity(1,1) primary key NOT NULL,
[VendorName] varchar(50) NOT NULL,
[VendorTypeID] int NULL
)
CREATE TABLE [dbo].[ProductType] (
[ProductTypeID] int identity(1,1) primary key NOT NULL,
[ProductTypeName] varchar(50) NULL,
[ProductTypeDescription] varchar(200) NULL
)
CREATE TABLE [dbo].[EmployeePositionHistory] (
[PositionHistoryID] int identity(1,1) primary key NOT NULL,
[EmployeeID] int NOT NULL,
[PositionID] int NOT NULL,
[HireDate] date NOT NULL,
[StartDate] date NOT NULL,
[EndDate] date NULL,
CONSTRAINT chk_EmpDate CHECK (StartDate < EndDate)
)
CREATE TABLE [dbo].[Position] (
[PositionID] int identity(1,1) primary key NOT NULL,
[PositionName] varchar(50) NOT NULL,
[PositionDescription] varchar(200) NULL
)
CREATE TABLE [dbo].[Product] (
[ProductID] int identity(1,1) primary key NOT NULL,
[ProductName] varchar(50) NOT NULL,
[ProductDescription] varchar(50) NULL,
[UnitPrice] money NULL,
[ProductTypeID] int NULL,
CONSTRAINT chk_ProductPrice CHECK (UnitPrice > 0)
)
CREATE TABLE [dbo].[PurchaseOrder_Delivery] (
[DeliveryStatusID] int identity(1,1) primary key NOT NULL,
[PurchaseOrderID] int NOT NULL,
[DeliveryID] int NOT NULL
)
CREATE TABLE [dbo].[VendorAddress] (
[VendorAddressID] int identity(1,1) primary key NOT NULL,
[VendorAddress] varchar(200) NOT NULL,
[VendorCity] varchar(50) NOT NULL,
[VendorState] char(2) NOT NULL,
[VendorZip] int NOT NULL,
[VendorID] int NOT NULL
)
CREATE TABLE [dbo].[ProductDelivery] (
[DeliveryID] int identity(1,1) primary key NOT NULL,
[DeliveryName] varchar(50) NOT NULL,
[StartPoint] varchar(50) NOT NULL,
[Destination] varchar(50) NOT NULL,
[StartDate] date NOT NULL,
[EndDate] date NOT NULL,
[RequiredDate] date NOT NULL,
[Freight] money NOT NULL,
[ModifiedDate] date NULL,
[DeliveryTypeID] int NULL,
CONSTRAINT chk_DeliveryDetails CHECK (StartDate < EndDate AND Freight >= 0)
)
CREATE TABLE [dbo].[DeliveryType] (
[DeliveryTypeID] int identity(1,1) primary key NOT NULL,
[DeliveryTypeName] varchar(50) NULL,
[DeliveryTypeDescription] varchar(200) NULL,
)
CREATE TABLE [dbo].[Employee_Project] (
[ProjectEmployeeID] int identity(1,1) primary key NOT NULL,
[EmployeeID] int NOT NULL,
[ProjectID] int NOT NULL
)
CREATE TABLE [dbo].[Employee] (
[EmployeeID] int identity(1,1) primary key NOT NULL,
[EmpFName] varchar(50) NOT NULL,
[EmpLName] varchar(50) NOT NULL,
[DateOfBirth] date NOT NULL,
[Gender] char(1) NOT NULL,
[Salary] money NULL,
[MartialStatus] char(1) NULL,
[VacationHours] int NULL,
[SickLeaveHours] int NULL,
[ModifiedDate] date NULL,
CONSTRAINT chk_EmpDetails CHECK (VacationHours >= 0 AND SickLeaveHours >=0 AND Salary >=0)
)
CREATE TABLE [dbo].[VendorContactType] (
[VendorContactTypeID] int identity(1,1) primary key NOT NULL,
[ContactTypeName] varchar(50) NULL,
[ContactTypeDescription] varchar(200) NULL
)
CREATE TABLE [dbo].[VendorContact] (
[VendorContactID] int identity(1,1) primary key NOT NULL,
[VendorContactNumber] int NOT NULL,
[VendorContactTypeID] int NULL,
[VendorID] int NOT NULL
)
CREATE TABLE [dbo].[EmployeeContactType] (
[EmpContactTypeID] int identity(1,1) primary key NOT NULL,
[ContactTypeName] varchar(50) NULL,
[ContactTypeDescription] varchar(200) NULL
)
CREATE TABLE [dbo].[CustomerAddress] (
[CustomerAddressID] int identity(1,1) primary key NOT NULL,
[CustomerAddress] varchar(200) NOT NULL,
[CustomerCity] varchar(50) NOT NULL,
[CustomerState] char(2) NOT NULL,
[CustomerZip] int NOT NULL,
[CustomerID] int NOT NULL
)
CREATE TABLE [dbo].[CustomerContact] (
[CustContactID] int identity(1,1) primary key NOT NULL,
[CustContactNumber] int NOT NULL,
[CustomerID] int NOT NULL,
[CustContactTypeID] int NULL
)
CREATE TABLE [dbo].[PurchaseOrder] (
[PurchaseOrderID] int identity(1,1) primary key NOT NULL,
[OrderedQuantity] int NOT NULL,
[SubTotal] money NOT NULL,
[AdvancedPayment] money NOT NULL,
[TaxAmt] money NOT NULL,
[OrderDate] date NOT NULL,
[DueDate] date NOT NULL,
[VendorID] int NOT NULL,
CONSTRAINT chk_PurchaseOrderDetails CHECK (OrderDate < DueDate AND AdvancedPayment <= SubTotal AND TaxAmt < SubTotal)
)
CREATE TABLE [dbo].[Product_Project] (
[AssetID] int identity(1,1) primary key NOT NULL,
[ProductID] int NOT NULL,
[ProjectID] int NOT NULL
)
CREATE TABLE [dbo].[Project] (
[ProjectID] int identity(1,1) primary key NOT NULL,
[ProjectName] varchar(50) NOT NULL,
[ProjectDescription] varchar(50) NULL,
[ProjectReceivedDate] date NOT NULL,
[ScheduledStartDate] date NULL,
[ScheduledEndDate] date NULL,
[PlannedCost] money NULL,
[ActualStartDate] date NULL,
[ActualEndDate] date NULL,
[ModifiedDate] date NULL,
[CustomerID] int NOT NULL
)
CREATE TABLE [dbo].[Skill] (
[SkillID] int identity(1,1) primary key NOT NULL,
[SkillName] varchar(50) NULL,
[SkillDescription] varchar(200) NULL
)
CREATE TABLE [dbo].[EmployeeAddress] (
[EmpAddressID] int identity(1,1) primary key NOT NULL,
[EmpAddress] varchar(50) NOT NULL,
[EmpCity] varchar(50) NOT NULL,
[EmpState] char(2) NOT NULL,
[EmpZip] int NOT NULL,
[EmployeeID] int NOT NULL
)
CREATE TABLE [dbo].[Employee_Skill] (
[ToolbeltID] int identity(1,1) primary key NOT NULL,
[SkillID] int NOT NULL,
[EmployeeID] int NOT NULL
)
CREATE TABLE [dbo].[DailyTimeRecord] (
[EmployeeID] int identity(1,1) primary key NOT NULL,
[TimeID] int NOT NULL,
[Date] date NULL,
[StartTime] time(7) NULL,
[EndTime] time(7) NULL,
[Day] char(3) NULL,
CONSTRAINT chk_EmpDailyTime CHECK (StartTime < EndTime)
)
ALTER TABLE [dbo].[EmployeeContact] ADD CONSTRAINT [Employee_EmployeeContact_FK1] FOREIGN KEY (
[EmployeeID]
)
REFERENCES [dbo].[Employee] (
[EmployeeID]
)
ALTER TABLE [dbo].[EmployeeContact] ADD CONSTRAINT [EmployeeContactType_EmployeeContact_FK1] FOREIGN KEY (
[EmpContactTypeID]
)
REFERENCES [dbo].[EmployeeContactType] (
[EmpContactTypeID]
)
ALTER TABLE [dbo].[Product_PurchaseOrder] ADD CONSTRAINT [PurchaseOrder_Product_PurchaseOrder_FK1] FOREIGN KEY (
[PurchaseOrderID]
)
REFERENCES [dbo].[PurchaseOrder] (
[PurchaseOrderID]
)
ALTER TABLE [dbo].[Product_PurchaseOrder] ADD CONSTRAINT [Product_Product_PurchaseOrder_FK1] FOREIGN KEY (
[ProductID]
)
REFERENCES [dbo].[Product] (
[ProductID]
)
ALTER TABLE [dbo].[Project_DelayReasons] ADD CONSTRAINT [Project_Project_DelayReasons_FK1] FOREIGN KEY (
[ProjectID]
)
REFERENCES [dbo].[Project] (
[ProjectID]
)
ALTER TABLE [dbo].[Project_DelayReasons] ADD CONSTRAINT [DelayReasons_Project_DelayReasons_FK1] FOREIGN KEY (
[DelayReasonID]
)
REFERENCES [dbo].[DelayReasons] (
[DelayReasonID]
)
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [CustomerType_Customer_FK1] FOREIGN KEY (
[CustomerTypeID]
)
REFERENCES [dbo].[CustomerType] (
[CustomerTypeID]
)
ALTER TABLE [dbo].[Vendor] ADD CONSTRAINT [VendorType_Vendor_FK1] FOREIGN KEY (
[VendorTypeID]
)
REFERENCES [dbo].[VendorType] (
[VendorTypeID]
)
ALTER TABLE [dbo].[EmployeePositionHistory] ADD CONSTRAINT [Employee_EmployeePositionHistory_FK1] FOREIGN KEY (
[EmployeeID]
)
REFERENCES [dbo].[Employee] (
[EmployeeID]
)
ALTER TABLE [dbo].[EmployeePositionHistory] ADD CONSTRAINT [Position_EmployeePositionHistory_FK1] FOREIGN KEY (
[PositionID]
)
REFERENCES [dbo].[Position] (
[PositionID]
)
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [ProductType_Product_FK1] FOREIGN KEY (
[ProductTypeID]
)
REFERENCES [dbo].[ProductType] (
[ProductTypeID]
)
ALTER TABLE [dbo].[PurchaseOrder_Delivery] ADD CONSTRAINT [ProductDelivery_PurchaseOrder_Delivery_FK1] FOREIGN KEY (
[DeliveryID]
)
REFERENCES [dbo].[ProductDelivery] (
[DeliveryID]
)
ALTER TABLE [dbo].[PurchaseOrder_Delivery] ADD CONSTRAINT [PurchaseOrder_PurchaseOrder_Delivery_FK1] FOREIGN KEY (
[PurchaseOrderID]
)
REFERENCES [dbo].[PurchaseOrder] (
[PurchaseOrderID]
)
ALTER TABLE [dbo].[VendorAddress] ADD CONSTRAINT [Vendor_VendorAddress_FK1] FOREIGN KEY (
[VendorID]
)
REFERENCES [dbo].[Vendor] (
[VendorID]
)
ALTER TABLE [dbo].[ProductDelivery] ADD CONSTRAINT [DeliveryType_ProductDelivery_FK1] FOREIGN KEY (
[DeliveryTypeID]
)
REFERENCES [dbo].[DeliveryType] (
[DeliveryTypeID]
)
ALTER TABLE [dbo].[Employee_Project] ADD CONSTRAINT [Project_Employee_Project_FK1] FOREIGN KEY (
[ProjectID]
)
REFERENCES [dbo].[Project] (
[ProjectID]
)
ALTER TABLE [dbo].[Employee_Project] ADD CONSTRAINT [Employee_Employee_Project_FK1] FOREIGN KEY (
[EmployeeID]
)
REFERENCES [dbo].[Employee] (
[EmployeeID]
)
ALTER TABLE [dbo].[VendorContact] ADD CONSTRAINT [VendorContactType_VendorContact_FK1] FOREIGN KEY (
[VendorContactTypeID]
)
REFERENCES [dbo].[VendorContactType] (
[VendorContactTypeID]
)
ALTER TABLE [dbo].[VendorContact] ADD CONSTRAINT [Vendor_VendorContact_FK1] FOREIGN KEY (
[VendorID]
)
REFERENCES [dbo].[Vendor] (
[VendorID]
)
ALTER TABLE [dbo].[CustomerAddress] ADD CONSTRAINT [Customer_CustomerAddress_FK1] FOREIGN KEY (
[CustomerID]
)
REFERENCES [dbo].[Customer] (
[CustomerID]
)
ALTER TABLE [dbo].[CustomerContact] ADD CONSTRAINT [Customer_CustomerContact_FK1] FOREIGN KEY (
[CustomerID]
)
REFERENCES [dbo].[Customer] (
[CustomerID]
)
ALTER TABLE [dbo].[CustomerContact] ADD CONSTRAINT [CustomerContactType_CustomerContact_FK1] FOREIGN KEY (
[CustContactTypeID]
)
REFERENCES [dbo].[CustomerContactType] (
[CustContactTypeID]
)
ALTER TABLE [dbo].[PurchaseOrder] ADD CONSTRAINT [Vendor_PurchaseOrder_FK1] FOREIGN KEY (
[VendorID]
)
REFERENCES [dbo].[Vendor] (
[VendorID]
)
ALTER TABLE [dbo].[Product_Project] ADD CONSTRAINT [Product_Product_Project_FK1] FOREIGN KEY (
[ProductID]
)
REFERENCES [dbo].[Product] (
[ProductID]
)
ALTER TABLE [dbo].[Product_Project] ADD CONSTRAINT [Project_Product_Project_FK1] FOREIGN KEY (
[ProjectID]
)
REFERENCES [dbo].[Project] (
[ProjectID]
)
ALTER TABLE [dbo].[Project] ADD CONSTRAINT [Customer_Project_FK1] FOREIGN KEY (
[CustomerID]
)
REFERENCES [dbo].[Customer] (
[CustomerID]
)
ALTER TABLE [dbo].[EmployeeAddress] ADD CONSTRAINT [Employee_EmployeeAddress_FK1] FOREIGN KEY (
[EmployeeID]
)
REFERENCES [dbo].[Employee] (
[EmployeeID]
)
ALTER TABLE [dbo].[Employee_Skill] ADD CONSTRAINT [Skill_Employee_Skill_FK1] FOREIGN KEY (
[SkillID]
)
REFERENCES [dbo].[Skill] (
[SkillID]
)
ALTER TABLE [dbo].[Employee_Skill] ADD CONSTRAINT [Employee_Employee_Skill_FK1] FOREIGN KEY (
[EmployeeID]
)
REFERENCES [dbo].[Employee] (
[EmployeeID]
)
ALTER TABLE [dbo].[DailyTimeRecord] ADD CONSTRAINT [Employee_DailyTimeRecord_FK1] FOREIGN KEY (
[EmployeeID]
)
REFERENCES [dbo].[Employee] (
[EmployeeID]
)
