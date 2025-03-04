
CREATE TABLE book
(
	bookid               INTEGER NOT NULL,
	bookname             VARCHAR(40) NULL,
	price                INTEGER NULL,
	pubname              VARCHAR(40) NULL
);



ALTER TABLE book
ADD PRIMARY KEY (bookid);



CREATE TABLE customer
(
	name                 VARCHAR(40) NOT NULL,
	addr                 VARCHAR(40) NOT NULL,
	phone                VARCHAR(40) NULL,
	custid               INTEGER NOT NULL
);



ALTER TABLE customer
ADD PRIMARY KEY (custid);



CREATE TABLE orders
(
	orderid              INTEGER NOT NULL,
	orderdate            DATE NULL,
	saleprice            INTEGER NULL,
	bookid               INTEGER NULL,
	custid               INTEGER NULL
);



ALTER TABLE orders
ADD PRIMARY KEY (orderid);



CREATE TABLE publisher
(
	pubname              VARCHAR(40) NOT NULL,
	stname               VARCHAR(40) NOT NULL,
	officephone          VARCHAR(30) NOT NULL
);



ALTER TABLE publisher
ADD PRIMARY KEY (pubname);



ALTER TABLE book
ADD FOREIGN KEY R_1 (pubname) REFERENCES publisher (pubname);



ALTER TABLE orders
ADD FOREIGN KEY R_5 (bookid) REFERENCES book (bookid);



ALTER TABLE orders
ADD FOREIGN KEY R_6 (custid) REFERENCES customer (custid);