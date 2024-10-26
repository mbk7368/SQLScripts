
CREATE DATABASE CashierApp;
USE CashierApp;



CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY ,
    FullName VARCHAR(100) NOT NULL ,
    EmployeeRole VARCHAR(30),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(30),
    Salary DECIMAL(7,2),
    HireDate Date,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE Customers(
    CustomerID INT AUTO_INCREMENT PRIMARY KEY  ,
    CustomerName VARCHAR(50) NOT NULL , 
    CutomerPhone VARCHAR(20),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE Categories(
    CategoryID INT AUTO_INCREMENT PRIMARY KEY , 
    NAME VARCHAR(50) NOT NULL,
    CategoryDescription TEXT
    );

CREATE TABLE Products(
    ProductID INT AUTO_INCREMENT PRIMARY KEY , 
    CategoryID INT,
    NAME  VARCHAR(50) NOT NULL, 
    PRICE DECIMAL(5,2) NOT NULL,
    Description TEXT,
    StockQuantity INT DEFAULT 0,
    CreatedAt TIMESTAMP CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP CURRENT_TIMESTAMP ON UPDATE TIMESTAMP CURRENT_TIMESTAMP,
    --References
    FOREIGN KEY (CategoryID) REFERENCE Categories(CategoryID)
    );

CREATE TABLE Inventories (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY, 
    ProductID INT NOT NULL, 
    STOCK INT DEFAULT 0,
    UpdatedAt TIMESTAMP CURRENT_TIMESTAMP ON UPDATE TIMESTAMP CURRENT_TIMESTAMP,
    --References
    FOREIGN KEY (ProductID) REFERENCE Products(ProductID)
    );

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY , 
    EmployeeID INT NOT NULL, 
    CustomerID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PaymentStatus ENUM('Pending','Paid','Canceled') DEFAULT 'Panding',
    TotalAmount DECIMAL(9,2) NOT NULL,
    DiscountApplied DECIMAL(9,2),
    --References
    FOREIGN KEY (EmployeeID) REFERENCE Employees(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCE Customers(CustomerID)
    );

CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY , 
    EmployeeID INT NOT NULL, 
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    ORDERID INT NOT NULL  , 
    ItemPrice DECIMAL(9,2),
    ItemQuantity INT NOT NULL,
    ItemTotalPrice DECIMAL(9,2),
    --References
    FOREIGN KEY (OrderID) REFERENCE Orders(OrderID),
    FOREIGN KEY (EmployeeID) REFERENCE Employees(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCE Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCE Products(ProductID)
    );

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY, 
    OrderID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PAYMENTTYPE ENUM('Cash','Credit') DEFAULT 'Cash', 
    PaymentValue DECIMAL(9,2) NOT NULL  ,
    --References
    FOREIGN KEY (OrderID) REFERENCE Orders(OrderID),  
    );

CREATE TABLE Discounts (
    DiscountID INT AUTO_INCREMENT PRIMARY KEY , 
    OrderID INT NOT NULL,
    DiscountValue DECIMAL(9,2),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    --References
    FOREIGN KEY (OrderID) REFERENCE Orders(OrderID),
    );

CREATE TABLE Logs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    ActionType VARCHAR(50),
    Description TEXT,
    CreateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    --References
    FOREIGN KEY (EmployeeID) REFERENCE Employees(EmployeeID)
    );

