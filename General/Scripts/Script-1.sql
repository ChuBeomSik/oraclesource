CREATE TABLE usertbl(
	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	age number(3) NOT NULL,
	email varchar(20) NOT null
)

INSERT INTO USERTBL values('hong123','홍길동', 'hong123',25,'hong123@gmail.com');