USE [master]
GO

/****** Object:  Database [PiStoreDB]    Script Date: 2/22/2023 6:53:12 PM ******/
CREATE DATABASE [PiStoreDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PiStoreDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS05\MSSQL\DATA\PiStoreDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PiStoreDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS05\MSSQL\DATA\PiStoreDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PiStoreDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [PiStoreDB] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [PiStoreDB] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [PiStoreDB] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [PiStoreDB] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [PiStoreDB] SET ARITHABORT OFF 
GO

ALTER DATABASE [PiStoreDB] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [PiStoreDB] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [PiStoreDB] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [PiStoreDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [PiStoreDB] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [PiStoreDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [PiStoreDB] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [PiStoreDB] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [PiStoreDB] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [PiStoreDB] SET  DISABLE_BROKER 
GO

ALTER DATABASE [PiStoreDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [PiStoreDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [PiStoreDB] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [PiStoreDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [PiStoreDB] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [PiStoreDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [PiStoreDB] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [PiStoreDB] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [PiStoreDB] SET  MULTI_USER 
GO

ALTER DATABASE [PiStoreDB] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [PiStoreDB] SET DB_CHAINING OFF 
GO

ALTER DATABASE [PiStoreDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [PiStoreDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [PiStoreDB] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [PiStoreDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [PiStoreDB] SET QUERY_STORE = ON
GO

ALTER DATABASE [PiStoreDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [PiStoreDB] SET  READ_WRITE 
GO

GO
USE [PiStoreDB]
GO
/*EMPLOYEE*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE Employee (
	EmployeeID INT IDENTITY(1,1) NOT NULL,
	EmployeeName VARCHAR(100) NOT NULL,
	EmployeeEmail VARCHAR(100) NULL,
	EmployeePhone VARCHAR(10) NULL,
	EmployeeAddress VARCHAR(255) NULL,
	EmployeeSalary FLOAT,
	HireDate DATE NOT NULL,
CONSTRAINT PK_Employee PRIMARY KEY CLUSTERED 
(
	EmployeeID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/*CLIENT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE Client (
	ClientID INT IDENTITY(1,1) NOT NULL,
	ClientName VARCHAR(100) NOT NULL,
	ClientEmail VARCHAR(100) NULL,
	ClientPhone VARCHAR(10) NULL,
	ClientAddress VARCHAR(255) NULL,
CONSTRAINT PK_Client PRIMARY KEY CLUSTERED 
(
	ClientID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/*PRODUCT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE Product (
	ProductID INT IDENTITY(1,1) NOT NULL,
	ProductName VARCHAR(100) NOT NULL,
	ProductDescription VARCHAR(255) NULL,
	ProductPrice FLOAT,
	Quantity INT NULL,
CONSTRAINT PK_Product PRIMARY KEY CLUSTERED 
(
	ProductID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/*ORDERS*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE Orders(
	OrderID INT IDENTITY(1,1) NOT NULL,
	ClientID INT NOT NULL,
	EmployeeID INT NOT NULL,
	OrderDate DATE NOT NULL,
	TotalPrice FLOAT,
CONSTRAINT FK_Order_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
CONSTRAINT FK_Order_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
CONSTRAINT PK_Orders PRIMARY KEY CLUSTERED 
(
	OrderID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/*ORDERITEM*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE OrderItem (
	OrderItemID INT IDENTITY(1,1) NOT NULL,
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NULL,
CONSTRAINT FK_OrderItem_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
CONSTRAINT FK_OrderItem_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
CONSTRAINT PK_OrderItem PRIMARY KEY CLUSTERED 
(
	OrderItemID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/*BILL*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE Bill (
	BillID INT IDENTITY(1,1) NOT NULL,
	OrderID INT NOT NULL,
	ClientID INT NOT NULL,
	EmployeeID INT NOT NULL,
	BillDate DATE NOT NULL,
	TotalPrice FLOAT,
CONSTRAINT FK_Bill_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
CONSTRAINT FK_Bill_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
CONSTRAINT FK_Bill_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
CONSTRAINT PK_Bill PRIMARY KEY CLUSTERED 
(
	BillID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

SET IDENTITY_INSERT Employee OFF
INSERT Employee(EmployeeName, EmployeeEmail, EmployeePhone, EmployeeAddress, EmployeeSalary, HireDate) 
VALUES ('Trung Tin', 'trungtin@gmail.com', '0946615625', '19 My Tho', 20000000.00, '2022-08-11')
INSERT Employee(EmployeeName, EmployeeEmail, EmployeePhone, EmployeeAddress, EmployeeSalary, HireDate) 
VALUES ('Ngoc Yen', 'ngocyen@gmail.com', '0946580624', '08 Bac Giang', 30000000.00, '2022-12-19')
INSERT Employee(EmployeeName, EmployeeEmail, EmployeePhone, EmployeeAddress, EmployeeSalary, HireDate) 
VALUES ('Dinh Phong', 'dinhphong@gmail.com', '0923629987', '11 Ha Noi', 20000000.00, '2022-12-04')

SET IDENTITY_INSERT Client OFF
INSERT INTO Client (ClientName, ClientEmail, ClientPhone, ClientAddress)
VALUES ('Tuan Thanh','tuanthanh@gmail.com','0921931246','12 Ha Giang')
INSERT INTO Client (ClientName, ClientEmail, ClientPhone, ClientAddress)
VALUES ('Thanh Luan','thanhluan@gmail.com','0983465829','05 Lam Dong')
INSERT INTO Client (ClientName, ClientEmail, ClientPhone, ClientAddress)
VALUES ('Tuan Kiet','tuankiet@gmail.com','0123615452','56 Da Nang')

SET IDENTITY_INSERT Product OFF
INSERT INTO Product (ProductName, ProductDescription, ProductPrice, Quantity)
VALUES ('Mercedes G63 AMG', 'Mercedes car', 50000000, 3)
INSERT INTO Product (ProductName, ProductDescription, ProductPrice, Quantity)
VALUES ('Porsche Cayenne 2021', 'Porsche car', 45000000, 4)
INSERT INTO Product (ProductName, ProductDescription, ProductPrice, Quantity)
VALUES ('Lamborghini Aventador S Roadster', 'Lamborghini car', 60000000, 2)

SET IDENTITY_INSERT Orders OFF
INSERT INTO Orders (ClientID, EmployeeID, OrderDate, TotalPrice)
VALUES (1009,2,'2023-02-19', 60000000)
INSERT INTO Orders (ClientID, EmployeeID, OrderDate, TotalPrice)
VALUES (1010,3,'2020-01-23', 45000000)

SET IDENTITY_INSERT OrderItem OFF
INSERT INTO OrderItem (OrderID, ProductID, Quantity)
VALUES (17, 2, 1);
INSERT INTO OrderItem (OrderID, ProductID, Quantity)
VALUES (18, 3, 1);

SET IDENTITY_INSERT Bill OFF
INSERT INTO Bill (OrderID, ClientID, EmployeeID, BillDate, TotalPrice)
VALUES (18, 1010, 3, '2020-01-23', 45000000);
INSERT INTO Bill (OrderID, ClientID, EmployeeID, BillDate, TotalPrice)
VALUES (17, 1009, 2, '2023-02-19', 60000000);

/*View EMPLOYEE*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW View_Employee
AS
SELECT *
FROM Employee 
GO

/*Add EMPLOYEE*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.sp_AddEmployee
	@EmployeeID int = null,
	@EmployeeName varchar(100),
	@EmployeeEmail varchar(100), 
	@EmployeePhone varchar(10),
	@EmployeeAddress varchar(255), 
	@EmployeeSalary float,
	@HireDate DATE 
AS
BEGIN
	SET NOCOUNT ON;

     INSERT INTO PiStoreDB.dbo.Employee
           (EmployeeName, EmployeeID, EmployeeEmail, EmployeePhone, EmployeeAddress, EmployeeSalary, HireDate)
     VALUES
           (@EmployeeName, @EmployeeID, @EmployeeEmail, @EmployeePhone, @EmployeeAddress, @EmployeeSalary, @HireDate)
SELECT SCOPE_IDENTITY() AS EmployeeID
END
GO

/*Delete EMPLOYEE*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.sp_DeleteEmployee
	@EmployeeID int
AS
BEGIN
	SET NOCOUNT ON;

    DELETE FROM dbo.Employee
	WHERE EmployeeID = @EmployeeID
END
GO

/*Update EMPLOYEE*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.sp_UpdateEmployee
	@EmployeeID int,
	@EmployeeName varchar(100),
	@EmployeeEmail varchar(100), 
	@EmployeePhone varchar(10),
	@EmployeeAddress varchar(255), 
	@EmployeeSalary float,
	@HireDate DATE 
AS
BEGIN
	SET NOCOUNT ON;

    Update PiStoreDB.dbo.Employee
	set EmployeeName = @EmployeeName,
		EmployeeEmail = @EmployeeEmail,
		EmployeePhone = @EmployeePhone,
		EmployeeAddress = @EmployeeAddress,
		EmployeeSalary = @EmployeeSalary,
		HireDate = @HireDate
	where EmployeeID = @EmployeeID;
END
GO

/*View CLIENT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW View_Client
AS
SELECT *
FROM Client 
GO

/*Add CLIENT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.sp_AddClient
	@ClientID int = null,
	@ClientName varchar(100),
	@ClientEmail varchar(100), 
	@ClientPhone varchar(10),
	@ClientAddress varchar(255)
AS
BEGIN
	SET NOCOUNT ON;

     INSERT INTO PiStoreDB.dbo.Client
           (ClientName, ClientID, ClientEmail, ClientPhone, ClientAddress)
     VALUES
           (@ClientName, @ClientID, @ClientEmail, @ClientPhone, @ClientAddress)
SELECT SCOPE_IDENTITY() AS ClientID
END
GO

/*Delete CLIENT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.sp_DeleteClient
	@ClientID int
AS
BEGIN
	SET NOCOUNT ON;

    DELETE FROM dbo.Client
	WHERE ClientID = @ClientID
END
GO

/*Update CLIENT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_UpdateClient
	@ClientID int,
	@ClientName varchar(100),
	@ClientEmail varchar(100), 
	@ClientPhone varchar(10),
	@ClientAddress varchar(255)
AS
BEGIN
	SET NOCOUNT ON;

    Update PiStoreDB.dbo.Client
	set ClientName = @ClientName,
		ClientEmail = @ClientEmail,
		ClientPhone = @ClientPhone,
		ClientAddress = @ClientAddress
	where ClientID = @ClientID;
END
GO

/*View PRODUCT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW View_Product
AS
SELECT *
FROM Product
GO

/*Add PRODUCT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.sp_AddProduct
	@ProductID INT = NULL,
	@ProductName VARCHAR(100),
	@ProductDescription VARCHAR(255),
	@ProductPrice FLOAT,
	@Quantity INT
AS
BEGIN
	SET NOCOUNT ON;

     INSERT INTO PiStoreDB.dbo.Product
           (ProductID, ProductName, ProductDescription, ProductPrice, Quantity)
     VALUES
           (@ProductID, @ProductName, @ProductDescription, @ProductPrice, @Quantity)
SELECT SCOPE_IDENTITY() AS ProductID
END
GO

/*Delete PRODUCT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.sp_DeleteProduct
	@ProductID int
AS
BEGIN
	SET NOCOUNT ON;

    DELETE FROM dbo.Product
	WHERE ProductID = @ProductID
END
GO

/*Update PRODUCT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.sp_UpdateProduct
	@ProductID INT = NULL,
	@ProductName VARCHAR(100),
	@ProductDescription VARCHAR(255),
	@ProductPrice FLOAT,
	@Quantity INT
AS
BEGIN
	SET NOCOUNT ON;

    Update PiStoreDB.dbo.Product
	set ProductName = @ProductName,
		ProductDescription = @ProductDescription,
		ProductPrice = @ProductPrice,
		Quantity = @Quantity
	where ProductID = @ProductID;
END
GO

/*View ORDERS*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW View_Orders
AS
SELECT dbo.Orders.OrderID, dbo.Product.ProductName, dbo.OrderItem.Quantity, dbo.Client.ClientName, dbo.Orders.OrderDate, dbo.Orders.TotalPrice
FROM   OrderItem INNER JOIN
             dbo.Product ON dbo.OrderItem.ProductID = dbo.Product.ProductID INNER JOIN
             dbo.Orders ON dbo.OrderItem.OrderID = dbo.Orders.OrderID INNER JOIN
             dbo.Client ON dbo.Orders.ClientID = dbo.Client.ClientID
GO

/*ACCOUNT*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Account(
	[Username] nvarchar(250) NOT NULL,
	[Password] nvarchar(250) NOT NULL,
CONSTRAINT [PK_Username] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

INSERT Account ([Username],[Password]) VALUES (N'trungtin0811', N'123456')
INSERT Account ([Username],[Password]) VALUES (N'admin', N'123456')
Go

