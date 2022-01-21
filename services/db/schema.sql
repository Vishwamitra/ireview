CREATE TABLE PRODUCT
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

CREATE TABLE REVIEW
(
  ReviewID INT NOT NULL,
  ProductID INT NOT NULL,
  Reviewer VARCHAR(100) NOT NULL,
  ReviewPriceQuality INT NOT NULL,
  ReviewUX INT NOT NULL,
  ReviewSummary VARCHAR(1000) NOT NULL,
  ReviewDescription VARCHAR(1000) NOT NULL,
  ReviewTime DATETIME NOT NULL,
  PRIMARY KEY (ReviewID),
  FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

INSERT INTO PRODUCT
VALUES(1,'IPX2020','iPhone X','This is the DESCRITION','Summary',999.0,9.0);
INSERT INTO PRODUCT
VALUES(2,'IPX2021','iPhone X-II','This is a DESCRITION','Summary',1000.0, 10.0);
INSERT INTO REVIEW
VALUES(1,1,'Joe',7,8,'summary','description','2020-01-01 12:00:00');

ALTER USER 'root' IDENTIFIED WITH mysql_native_password BY 'password';

flush privileges;
