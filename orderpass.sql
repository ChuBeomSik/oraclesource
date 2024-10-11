CREATE TABLE cafe
(
  cafeCode  NVARCHAR2(20) NOT NULL,
  name      NVARCHAR2(10) NOT NULL,
  president VARCHAR2(10)  NOT NULL,
  tel       NVARCHAR2(20) NOT NULL,
  loc       NVARCHAR2(30) NOT NULL,
  CONSTRAINT PK_cafe PRIMARY KEY (cafeCode)
);

ALTER TABLE cafe
  ADD CONSTRAINT UQ_name UNIQUE (name);

ALTER TABLE cafe
  ADD CONSTRAINT UQ_president UNIQUE (president);

ALTER TABLE cafe
  ADD CONSTRAINT UQ_tel UNIQUE (tel);

ALTER TABLE cafe
  ADD CONSTRAINT UQ_loc UNIQUE (loc);

CREATE TABLE customer
(
  id         NVARCHAR2(20) NOT NULL,
  pwd        NVARCHAR2(20) NOT NULL,
  name       VARCHAR2(10)  NOT NULL,
  residentNo NVARCHAR2(30) NOT NULL,
  phoneNo    VARCHAR2(20)  NOT NULL,
  addr       NVARCHAR2(30),
  orderNo    NUMBER(10)    NOT NULL,
  CONSTRAINT PK_customer PRIMARY KEY (id)
);



ALTER TABLE customer
  ADD CONSTRAINT UQ_pwd UNIQUE (pwd);

ALTER TABLE customer
  ADD CONSTRAINT UQ_residentNo UNIQUE (residentNo);

ALTER TABLE customer
  ADD CONSTRAINT UQ_phoneNo UNIQUE (phoneNo);

ALTER TABLE customer
  ADD CONSTRAINT UQ_addr UNIQUE (addr);

ALTER TABLE customer
  ADD CONSTRAINT UQ_orderNo UNIQUE (orderNo);

CREATE TABLE hotIce
(
  menuNo      NUMBER(10)    NOT NULL,
  temperature NVARCHAR2(10) NOT NULL
);

ALTER TABLE hotIce
  ADD CONSTRAINT UQ_menuNo UNIQUE (menuNo);

ALTER TABLE hotIce
  ADD CONSTRAINT UQ_temperature UNIQUE (temperature);

CREATE TABLE menu
(
  menuNo  NUMBER(10)    NOT NULL,
  name    NVARCHAR2(20) NOT NULL,
  price   NUMBER(30)    NOT NULL,
  orderNo NUMBER(10)    NOT NULL,
  CONSTRAINT PK_menu PRIMARY KEY (menuNo)
);

CREATE TABLE orders
(
  orderNo  NUMBER(10)    NOT NULL,
  cafeCode NVARCHAR2(20) NOT NULL,
  CONSTRAINT PK_orders PRIMARY KEY (orderNo)
);

ALTER TABLE customer
  ADD CONSTRAINT FK_orders_TO_customer
    FOREIGN KEY (orderNo)
    REFERENCES orders (orderNo);

ALTER TABLE orders
  ADD CONSTRAINT FK_cafe_TO_orders
    FOREIGN KEY (cafeCode)
    REFERENCES cafe (cafeCode);

ALTER TABLE menu
  ADD CONSTRAINT FK_orders_TO_menu
    FOREIGN KEY (orderNo)
    REFERENCES orders (orderNo);

ALTER TABLE hotIce
  ADD CONSTRAINT FK_menu_TO_hotIce
    FOREIGN KEY (menuNo)
    REFERENCES menu (menuNo);