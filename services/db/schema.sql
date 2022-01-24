CREATE TABLE Product
(
  ProductID INT NOT NULL,
  ProductCode VARCHAR(20) NOT NULL,
  ProductName VARCHAR(200) NOT NULL,
  ProductDescription VARCHAR(1000) NOT NULL,
  ProductSummary VARCHAR(1000) NOT NULL,
  ProductPrice FLOAT NOT NULL,
  ProductVAT FLOAT NOT NULL,
  PRIMARY KEY (ProductID),
  UNIQUE (ProductCode)
);

CREATE TABLE Review
(
  ReviewID INT AUTO_INCREMENT,
  ProductID INT NOT NULL,
  Reviewer VARCHAR(100) NOT NULL,
  ReviewPriceQuality INT NOT NULL,
  ReviewSummary VARCHAR(1000) NOT NULL,
  ReviewDescription VARCHAR(1000) NOT NULL,
  ReviewTime DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ReviewID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO Product VALUES(1,'IPX2021','iPhone X','This is the DESCRITION','Summary', 999.0, 9.0);
INSERT INTO Product VALUES(2,'IPX2022','iPod','This is a DESCRITION','Summary', 250.0, 10.0);
INSERT INTO Product VALUES(3,'IPX2023','MacBook','This is the DESCRITION','Summary', 1099.0, 9.0);
INSERT INTO Product VALUES(4,'IPX2024','Samsung S3','This is a DESCRITION','Summary', 1000.0, 10.0);
INSERT INTO Product VALUES(5,'IPX2025','AirPods','This is the DESCRITION','Summary', 999.0, 9.0);
INSERT INTO Product VALUES(6,'IPX2026','Windows Laptop','This is a DESCRITION','Summary', 1000.0, 10.0);
INSERT INTO Product VALUES(7,'IPX2027','Apple watch','This is the DESCRITION','Summary', 999.0, 9.0);
INSERT INTO Product VALUES(8,'IPX2028','Apple Air Tag','This is a DESCRITION','Summary', 1000.0, 10.0);

ALTER USER 'root' IDENTIFIED WITH mysql_native_password BY 'password';

flush privileges;