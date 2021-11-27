DROP DATABASE IF EXISTS shop;

CREATE DATABASE shop;

\c shop;

CREATE TABLE customer
(
    id integer NOT NULL PRIMARY KEY,
    name varchar(100)  NOT NULL,
    location varchar(100) NOT NULL,
    male_female boolean,
    birth_date date
);

CREATE TABLE drug
(
    id integer NOT NULL PRIMARY KEY,
    name varchar(200)  NOT NULL,
    company varchar(200) NOT NULL,
    price money NOT NULL,
    made_in_country varchar(100) NOT NULL,
	transport_reqs varchar(10) NOT NULL,
	expiration_date date
);

CREATE TABLE route
(
    id integer NOT NULL PRIMARY KEY,
    from_ varchar(70)  NOT NULL,
    to_ varchar(70) NOT NULL,
    transport varchar(70) NOT NULL,
	transport_type varchar(5) NOT NULL,
	med_fridge boolean NOT NULL,
    hours integer NOT NULL
);

CREATE TABLE delivery
(
    id integer NOT NULL PRIMARY KEY,
    customer_id integer NOT NULL,
	foreign key (customer_id) references customer(id),
    drug_id integer NOT NULL,
	foreign key (drug_id) references drug(id),
    route_id integer NOT NULL,
    foreign key (route_id) references route(id),
	product_amount integer NOT NULL
);
\i 'C:/users/siraz/Desktop/bmstu/3_course/DB/lab_1/sqls/alter.sql'
\i 'C:/users/siraz/Desktop/bmstu/3_course/DB/lab_1/sqls/copying.sql'