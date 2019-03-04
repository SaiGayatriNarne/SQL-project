-----------------------------CREATING UF TABLE---------------------------------

CREATE TABLE UNIT_FRANCHISEE (
UF_ID CHAR(8),
UF_Name VARCHAR(40),
UF_Phone_Number INT,
UF_Email_ID VARCHAR(30),
UF_Street_Address VARCHAR(30),
UF_State VARCHAR(30),
UF_Zipcode INT,
UF_Pancard CHAR(10)
);

ALTER TABLE UNIT_FRANCHISEE
ADD CONSTRAINT UF_PK PRIMARY KEY (UF_ID);

ALTER TABLE UNIT_FRANCHISEE MODIFY UF_Name NOT NULL;
ALTER TABLE UNIT_FRANCHISEE MODIFY UF_Phone_Number NOT NULL;
ALTER TABLE UNIT_FRANCHISEE MODIFY UF_Email_ID NOT NULL;
ALTER TABLE UNIT_FRANCHISEE MODIFY UF_Street_Address NOT NULL;
ALTER TABLE UNIT_FRANCHISEE MODIFY UF_State NOT NULL;
ALTER TABLE UNIT_FRANCHISEE MODIFY UF_Zipcode NOT NULL;
ALTER TABLE UNIT_FRANCHISEE MODIFY UF_Pancard NOT NULL;

ALTER TABLE UNIT_FRANCHISEE
ADD CONSTRAINT UF_Unique UNIQUE (UF_Pancard);


----------------------------------PURCHASE ORDER-------------------------
CREATE TABLE PURCHASE_ORDER (
Order_ID CHAR(8),
UF_ID CHAR(8),
Order_date Date
);

ALTER TABLE PURCHASE_ORDER
ADD CONSTRAINT PO_PK PRIMARY KEY (Order_ID);

ALTER TABLE PURCHASE_ORDER
ADD CONSTRAINT FK_to_PO
FOREIGN KEY (UF_ID)
REFERENCES UNIT_FRANCHISEE (UF_ID);

ALTER TABLE PURCHASE_ORDER MODIFY UF_ID NOT NULL;
ALTER TABLE PURCHASE_ORDER MODIFY Order_date NOT NULL;

-----------------------------------INVOICE---------------------------
CREATE TABLE INVOICE 
(
Invoice_ID CHAR(8),
Order_ID CHAR(8),
Invoice_Amount NUMBER,
Invoice_Date DATE
);

ALTER TABLE INVOICE
ADD CONSTRAINT inv_pk PRIMARY KEY (Invoice_ID);

ALTER TABLE INVOICE
ADD CONSTRAINT fk_to_inv 
FOREIGN KEY (Order_ID)
REFERENCES PURCHASE_ORDER (Order_ID);

ALTER TABLE INVOICE MODIFY Order_ID NOT NULL;
ALTER TABLE INVOICE MODIFY Invoice_Amount NOT NULL;
ALTER TABLE INVOICE MODIFY Invoice_Date NOT NULL;

------------------------------------PAYMENT--------------------------
CREATE TABLE PAYMENT
(
Payment_ID Varchar2(15),
Invoice_ID CHAR(8),
Payment_Date DATE
);

ALTER TABLE PAYMENT
ADD CONSTRAINT pay_pk PRIMARY KEY (Payment_ID);

ALTER TABLE PAYMENT 
ADD CONSTRAINT fk_to_pay FOREIGN KEY (Invoice_ID)
REFERENCES INVOICE (Invoice_ID);

ALTER TABLE PAYMENT MODIFY Invoice_ID NOT NULL;
ALTER TABLE PAYMENT MODIFY Payment_Date NOT NULL;

------------------------------------SHIPPING---------------------------------------------
CREATE TABLE SHIPPING(
Shipping_ID CHAR(8),
Order_ID CHAR(8),
Shipping_Date DATE
);

ALTER TABLE SHIPPING
ADD CONSTRAINT Ship_pk PRIMARY KEY (Shipping_ID);

ALTER TABLE SHIPPING 
ADD CONSTRAINT fk_to_ship FOREIGN KEY (Order_ID)
REFERENCES PURCHASE_ORDER (Order_ID);

ALTER TABLE SHIPPING MODIFY Shipping_Date NOT NULL;
ALTER TABLE SHIPPING MODIFY Order_ID NOT NULL;

-------------------VENDOR---------------------------------------
CREATE TABLE VENDOR
(
Vendor_ID CHAR(8),
Vendor_Name VARCHAR2(30),
Vendor_Phone_Number int,
Vendor_Email_ID Varchar2(30),
Vendor_Street_Address Varchar2(30),
Vendor_State Varchar2(30),
Vendor_Zipcode int
);

ALTER TABLE VENDOR MODIFY Vendor_Name NOT NULL;
ALTER TABLE VENDOR MODIFY Vendor_Phone_Number NOT NULL;
ALTER TABLE VENDOR MODIFY Vendor_Email_ID NOT NULL;
ALTER TABLE VENDOR MODIFY Vendor_Street_Address NOT NULL;
ALTER TABLE VENDOR MODIFY Vendor_State NOT NULL;
ALTER TABLE VENDOR MODIFY Vendor_Zipcode NOT NULL;

ALTER TABLE VENDOR
ADD CONSTRAINT pk_vendor PRIMARY KEY (Vendor_ID);

-------------------PRODUCT----------------------------------------
CREATE TABLE PRODUCT 
(
Product_ID Char(8),
Vendor_ID Char(8),
Product_Type Varchar2(20),
Product_Name Varchar2(20),
Product_Quantity int,
Product_Price NUMBER
);

ALTER TABLE PRODUCT 
ADD CONSTRAINT pk_prod PRIMARY KEY (Product_ID);

ALTER TABLE PRODUCT
ADD CONSTRAINT fk_to_prod FOREIGN KEY (Vendor_ID)
REFERENCES VENDOR(Vendor_ID);

ALTER TABLE PRODUCT MODIFY Vendor_ID NOT NULL;
ALTER TABLE PRODUCT MODIFY Product_Type NOT NULL;
ALTER TABLE PRODUCT MODIFY Product_Name NOT NULL;
ALTER TABLE PRODUCT MODIFY Product_Quantity NOT NULL;
ALTER TABLE PRODUCT MODIFY Product_Price NOT NULL;
ALTER TABLE PRODUCT DROP COLUMN Product_Quantity;

-------------------PRODUCT _PO _ASSOCIATIVE------------------
CREATE TABLE PRODUCT_PO
(
Product_ID CHAR(8),
Order_ID CHAR(8)
);

ALTER TABLE PRODUCT_PO ADD Product_Quantity int;
ALTER TABLE PRODUCT_PO
ADD CONSTRAINT pk_prod_po PRIMARY KEY (Product_ID,Order_ID);

ALTER TABLE PRODUCT_PO
ADD CONSTRAINT Fk_prodpo_to_PO FOREIGN KEY (Order_ID)
REFERENCES PURCHASE_ORDER (Order_ID);

ALTER TABLE PRODUCT_PO
ADD CONSTRAINT Fk_prodpo_to_prod FOREIGN KEY (Product_ID)
REFERENCES PRODUCT (Product_ID);

------------------------------------------------------------------------
COMMIT;

--------------------DATA INSERTION------------------------------------
-------------------------------INSERTING INTO UNIT FRANCHISEE----------------------------------------
INSERT into UNIT_FRANCHISEE VALUES ('TT000001','FreshClock',8121866683,'freshclock@gmail.com','Seethammadhara','AP',530013,'ANJPM1970L');
INSERT into UNIT_FRANCHISEE VALUES ('TT000002',	'Ishaanvi Foods',8885866683,'ishaanvifoods@gmail.com','R.K.Beach','AP',530016,'ADJDG1580P');
INSERT into UNIT_FRANCHISEE VALUES ('TT000003',	'Ardent 7',	9010940949,	'ardent@gmail.com',	'Kondapur','TS',500081,'AQIWE3780Q');
INSERT into UNIT_FRANCHISEE VALUES ('TT000004',	'Wayside Group', 7799692226,'waysidegroup@gmail.com','Banjara Hills','TS',500034,'ARISE1240Z');
INSERT into UNIT_FRANCHISEE VALUES ('TT000005','Comley Foods',9550511114,'comleyfoods@gmail.com','Raheja Mindspace','TS',500081,'AWBIE1240P');
INSERT into UNIT_FRANCHISEE VALUES ('TT000006','Sadhana Foods',9787748792,'sadhanafoods@gmail.com','M.G.Road','AP',520001,'AQINP1360M');
INSERT into UNIT_FRANCHISEE VALUES ('TT000007','Travancore Foods',9889211106,'travancorefoods@gmail.com','Jubilee Hills','TS','500033','APLNO1450M');
INSERT into UNIT_FRANCHISEE VALUES ('TT000008','Vivantha Hospitality',9542211118,'vivanthahospitality@gmail.com','MVP Colony','AP',530016,'AVIVA7890P');
INSERT into UNIT_FRANCHISEE VALUES ('TT000009','Gram Foods',9848038392,'gramfoods@gmail.com','Rushikonda','AP',530018,'AGRAM0987F');
INSERT into UNIT_FRANCHISEE VALUES ('TT000010','Super 7',7287890923,'super@gmail.com','Brindavan Garden','AP',510017,'ASUPE3456Y');

------------------------------INSERTING INTO PURCHASE ORDER------------------------
INSERT INTO PURCHASE_ORDER VALUES ('PO000001','TT000001',to_date('01-JAN-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000002','TT000002',to_date('20-JAN-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000003','TT000003',to_date('25-JAN-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000004','TT000004',to_date('01-FEB-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000005','TT000005',to_date('07-FEB-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000006','TT000006',to_date('09-FEB-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000007','TT000007',to_date('13-FEB-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000008','TT000008',to_date('15-FEB-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000009','TT000009',to_date('18-FEB-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000010','TT000010',to_date('19-MAR-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000011','TT000001',to_date('01-MAR-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000012','TT000002',to_date('05-MAR-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000013','TT000002',to_date('10-MAR-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000014','TT000004',to_date('15-MAR-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000015','TT000005',to_date('20-MAR-17','DD-MON-YY'));
INSERT INTO PURCHASE_ORDER VALUES ('PO000016','TT000002',to_date('21-MAR-17','DD-MON-YY'));

-----------------------INSERTING INTO INVOICE------------------------------------------------
INSERT into INVOICE VALUES ('IN000001','PO000001',90000,to_date('15-Jan-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000002','PO000002',190000,to_date('30-Jan-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000003','PO000003',75000,to_date ('5-Feb-17', 'DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000004',	'PO000004',	160000, to_date('10-Feb-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000005',	'PO000005',	186000,	to_date('17-Feb-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000006',	'PO000006',	179000,	to_date('19-Feb-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000007',	'PO000007',189000,	to_date ('23-Feb-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000008',	'PO000008',165000, to_date('25-Feb-17', 'DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000009',	'PO000009',115000, to_date('1-Mar-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000010',	'PO000010',110000,to_date('29-Mar-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000011',	'PO000011',98000,to_date('10-Mar-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000012',	'PO000012',200000,to_date('15-Mar-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000013',	'PO000013',168000,to_date('20-Mar-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000014',	'PO000014',95000, to_date('25-Mar-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000015',	'PO000015',85000,to_date('30-Mar-17','DD-MON-YY'));
INSERT into INVOICE VALUES ('IN000016',	'PO000016',250000,to_date('1-Apr-17','DD-MON-YY'));

--------------------------------inserting into payment------------------------

INSERT INTO PAYMENT VALUES ('PT000001','IN000001',to_date('25-JAN-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000002','IN000002',to_date('15-FEB-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000003','IN000003',to_date('20-FEB-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000004','IN000004',to_date('22-FEB-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000005','IN000005',to_date('27-FEB-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000006','IN000006',to_date('26-FEB-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000007','IN000007',to_date('02-MAR-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000008','IN000008',to_date('10-MAR-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000009','IN000009',to_date('15-MAR-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000010','IN000010',to_date('10-APR-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000011','IN000011',to_date('20-MAR-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000012','IN000012',to_date('25-MAR-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000013','IN000013',to_date('30-MAR-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000014','IN000014',to_date('15-APR-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000015','IN000015',to_date('10-APR-17','DD-MON-YY'));
INSERT INTO PAYMENT VALUES ('PT000016','IN000016',to_date('19-APR-17','DD-MON-YY'));

--------------------------------INSERTING INTO SHIPPING-----------------------------
INSERT INTO SHIPPING VALUES ('SH000001','PO000001',to_date('30-JAN-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000002','PO000002',to_date('20-FEB-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000003','PO000003',to_date('25-FEB-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000004','PO000004',to_date('27-FEB-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000005','PO000005',to_date('03-MAR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000006','PO000006',to_date('04-MAR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000007','PO000007',to_date('07-MAR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000008','PO000008',to_date('15-MAR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000009','PO000009',to_date('20-MAR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000010','PO000010',to_date('15-APR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000011','PO000011',to_date('25-MAR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000012','PO000012',to_date('30-MAR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000013','PO000013',to_date('05-APR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000014','PO000014',to_date('20-APR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000015','PO000015',to_date('15-APR-17','DD-MON-YY'));
INSERT INTO SHIPPING VALUES ('SH000016','PO000016',to_date('26-APR-17','DD-MON-YY'));

--------------------------------inserting into vendor------------------
INSERT INTO VENDOR VALUES ('A0000001','Alekhya',9848032919,'alekhya123@yahoo.com','Ganesh Nagar,Hyderabad','TS',531007);
INSERT INTO VENDOR VALUES ('A0000002','Priya',9390246780,'Priya1996@gmail.com','Gandhi Chowk,Khammam','TS',530023);
INSERT INTO VENDOR VALUES ('A0000003', 'Gayatri',9873982763,'gaya3@gmail.com','Karthikeya Colony,Vizag','AP',560098);
INSERT INTO VENDOR VALUES ('A0000004',	'Rishitha',	8882472767,	'rishitha.1@yahoo.com',	'Cross roads,Vijayawada','AP',540007);
INSERT INTO VENDOR VALUES ('A0000005','Shruthi',9876457388,'shruti.tadamiri@yahoo.com','Subedari,Warangal',	'TS',510002);
INSERT INTO VENDOR VALUES ('A0000006','Sarvani',9239847567,'sarvaniviswanadha.pp@gmail.com','37 Road No 4, Nellore','AP',523908);

----------------------------------INSERTING INTO PRODUCT---------------------------------
INSERT INTO PRODUCT VALUES ('TA01','A0000001','Tea','Green Tea',2000);
INSERT INTO PRODUCT VALUES ('TA02','A0000001','Tea','White Tea',5000);
INSERT INTO PRODUCT VALUES ('TA03','A0000003','Tea','Oolong Tea',7000);
INSERT INTO PRODUCT VALUES ('TA04','A0000004','Tea','Lemon Grass',3000);
INSERT INTO PRODUCT VALUES ('CA01','A0000005','Chai','Kullad Chai',4000);
INSERT INTO PRODUCT VALUES ('CA02','A0000006','Chai','Adhrak Chai',6000);
INSERT INTO PRODUCT VALUES ('PA01','A0000003','Paper Packaging','Straw',5000);
INSERT INTO PRODUCT VALUES ('PA02','A0000004','Paper Packaging','Takaway Glass',3000);
INSERT INTO PRODUCT VALUES ('PA03','A0000006','Paper Packaging','Brown Paper Bag',9000);
INSERT INTO PRODUCT VALUES ('MA01','A0000005','Merchandise','Redzen',8000);
INSERT INTO PRODUCT VALUES ('MA02','A0000005','Merchandise','Orange Spice',7000);
INSERT INTO PRODUCT VALUES ('MA03','A0000003','Merchandise','Jasmine Green',9000);
INSERT INTO PRODUCT VALUES ('SA01','A0000006','Seasoning','Peri Peri',5000);
INSERT INTO PRODUCT VALUES ('SA02','A0000003','Seasoning','Smoked',6000);
INSERT INTO PRODUCT VALUES ('SA03','A0000001','Seasoning','Marinade',4000);
INSERT INTO PRODUCT VALUES ('SA04','A0000006','Seasoning','Green Chutney',6000);

-------------------------------------inserting into prod_po associative------------------
INSERT INTO PRODUCT_PO VALUES ('TA01','PO000001',4);
INSERT INTO PRODUCT_PO VALUES ('CA01','PO000001',7);
INSERT INTO PRODUCT_PO VALUES ('MA01','PO000001',3);
INSERT INTO PRODUCT_PO VALUES ('SA01','PO000001',3);
INSERT INTO PRODUCT_PO VALUES ('TA02','PO000002',6);
INSERT INTO PRODUCT_PO VALUES ('PA02','PO000002',2);
INSERT INTO PRODUCT_PO VALUES ('MA02','PO000002',4);
INSERT INTO PRODUCT_PO VALUES ('SA02','PO000002',8);
INSERT INTO PRODUCT_PO VALUES ('TA03','PO000002',9);
INSERT INTO PRODUCT_PO VALUES ('CA02','PO000001',3);
INSERT INTO PRODUCT_PO VALUES ('MA03','PO000001',2);
INSERT INTO PRODUCT_PO VALUES ('PA03','PO000001',5);
INSERT INTO PRODUCT_PO VALUES ('TA03','PO000001',9);
INSERT INTO PRODUCT_PO VALUES ('TA02','PO000001',6);
INSERT INTO PRODUCT_PO VALUES ('MA01','PO000002',8);
INSERT INTO PRODUCT_PO VALUES ('PA01','PO000001',2);
INSERT INTO PRODUCT_PO VALUES ('TA04','PO000001',3);
INSERT INTO PRODUCT_PO VALUES ('SA02','PO000001',1);
INSERT INTO PRODUCT_PO VALUES ('MA02','PO000001',3);
INSERT INTO PRODUCT_PO VALUES ('SA04','PO000005',7);
INSERT INTO PRODUCT_PO VALUES ('PA03','PO000005',6);
INSERT INTO PRODUCT_PO VALUES ('CA01','PO000005',5);
INSERT INTO PRODUCT_PO VALUES ('MA03','PO000006',9);
INSERT INTO PRODUCT_PO VALUES ('TA01','PO000006',8);
INSERT INTO PRODUCT_PO VALUES ('SA04','PO000007',5);
INSERT INTO PRODUCT_PO VALUES ('MA03','PO000007',3);
INSERT INTO PRODUCT_PO VALUES ('PA02','PO000007',1);
INSERT INTO PRODUCT_PO VALUES ('TA01','PO000008',3);
INSERT INTO PRODUCT_PO VALUES ('CA02','PO000008',4);
INSERT INTO PRODUCT_PO VALUES ('PA03','PO000008',5);
INSERT INTO PRODUCT_PO VALUES ('MA03','PO000008',6);
INSERT INTO PRODUCT_PO VALUES ('SA04','PO000008',7);
INSERT INTO PRODUCT_PO VALUES ('MA03','PO000009',8);
INSERT INTO PRODUCT_PO VALUES ('TA01','PO000010',1);
INSERT INTO PRODUCT_PO VALUES ('PA01','PO000010',3);
INSERT INTO PRODUCT_PO VALUES ('MA01','PO000010',4);
INSERT INTO PRODUCT_PO VALUES ('SA01','PO000010',5);
INSERT INTO PRODUCT_PO VALUES ('TA02','PO000010',4);
INSERT INTO PRODUCT_PO VALUES ('CA02','PO000010',3);
INSERT INTO PRODUCT_PO VALUES ('MA02','PO000010',6);
INSERT INTO PRODUCT_PO VALUES ('SA02','PO000010',7);
INSERT INTO PRODUCT_PO VALUES ('TA03','PO000011',8);
INSERT INTO PRODUCT_PO VALUES ('PA01','PO000011',3);
INSERT INTO PRODUCT_PO VALUES ('MA03','PO000012',3);
INSERT INTO PRODUCT_PO VALUES ('SA03','PO000012',4);
INSERT INTO PRODUCT_PO VALUES ('TA03','PO000012',6);
INSERT INTO PRODUCT_PO VALUES ('TA01','PO000013',8);
INSERT INTO PRODUCT_PO VALUES ('PA01','PO000013',9);
INSERT INTO PRODUCT_PO VALUES ('SA01','PO000013',2);
INSERT INTO PRODUCT_PO VALUES ('TA04','PO000013',6);
INSERT INTO PRODUCT_PO VALUES ('TA01','PO000014',7);
INSERT INTO PRODUCT_PO VALUES ('MA03','PO000014',8);
INSERT INTO PRODUCT_PO VALUES ('SA04','PO000014',3);
INSERT INTO PRODUCT_PO VALUES ('TA03','PO000014',4);
INSERT INTO PRODUCT_PO VALUES ('CA01','PO000015',3);
INSERT INTO PRODUCT_PO VALUES ('MA03','PO000015',6);
INSERT INTO PRODUCT_PO VALUES ('TA01','PO000015',4);
INSERT INTO PRODUCT_PO VALUES ('SA04','PO000015',5);
INSERT INTO PRODUCT_PO VALUES ('MA03','PO000016',8);
INSERT INTO PRODUCT_PO VALUES ('PA02','PO000016',9);
INSERT INTO PRODUCT_PO VALUES ('TA01','PO000016',2);
INSERT INTO PRODUCT_PO VALUES ('CA02','PO000016',2);
INSERT INTO PRODUCT_PO VALUES ('PA03','PO000016',4);

COMMIT;


