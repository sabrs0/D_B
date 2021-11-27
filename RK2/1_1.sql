--\i 'C:/Users/siraz/Desktop/bmstu/3_course/DB/RK2/1.sql'
drop database if exists rk2;
create database rk2;
\c rk2;


create table employer
(
	id integer not null primary key,
	departament_id integer not null,
	post varchar(100) not null,
	FIO varchar (100) not null,
	salary money not null
);

create table departament(

	id integer not null primary key,
	name varchar(100),
	phone_number varchar(15),
	manager_id int not null,
	foreign key (manager_id) references employer(id) 

);

create table medicine
(

	id integer not null primary key,
	name varchar(100) not null,
	instruction varchar(100) not null,
	price money not null

);


insert into medicine (id, name, instruction, price)
values (1, 'Ibuprofen', '2 times a day legal for pregnant', 50.00::numeric::money);
insert into medicine (id, name, instruction, price)
values (2, 'piracetam', '1 or 2 times a day legal for pregnant', 52.00::numeric::money);
insert into medicine (id, name, instruction, price)
values (3, 'lamistil gel', ' 3 times a day illegal for pregnant', 54.00::numeric::money);
insert into medicine (id, name, instruction, price)
values (4, 'citramone', '2 times a day legal for pregnant', 55.00::numeric::money);
insert into medicine (id, name, instruction, price)
values (5, 'caffeine', '4 times a day legal for pregnant', 56.00::numeric::money);
insert into medicine (id, name, instruction, price)
values (6, 'vasobral', '1 time a day legal for everyone', 58.00::numeric::money);
insert into medicine (id, name, instruction, price)
values (7, 'askorkine', '2 times a day legal for kids', 60.00::numeric::money);
insert into medicine (id, name, instruction, price)
values (8, 'cardiomagnil', '2 times a day legal for old fellas', 40.00::numeric::money);
insert into medicine (id, name, instruction, price)
values (9, 'naiz', '2 times a day legal for everyone', 30.00::numeric::money);
insert into medicine (id, name, instruction, price)
values (10, 'pentalgine', '2 times a day legal for pregnant', 30.00::numeric::money);









insert into employer (id, departament_id, post, FIO, salary)
values (1, 10, 'CEO', 'Ivanov Ivan Ivanovich', 10000.00::numeric::money);
insert into employer (id, departament_id, post, FIO, salary)
values (2, 9, 'CEO', 'Petrov Petr Petrovich', 10000.00::numeric::money);
insert into employer (id, departament_id, post, FIO, salary)
values (3, 8, 'manager', 'Sidorov Sidor Sidorovich', 5000.00::numeric::money);
insert into employer (id, departament_id, post, FIO, salary)
values (4, 7, 'manager', 'Olegov Oleg Olegovich', 5000.00::numeric::money);
insert into employer (id, departament_id, post, FIO, salary)
values (5, 6, 'seller', 'Mihailov Mihail Mihailovich', 1000.00::numeric::money);
insert into employer (id, departament_id, post, FIO, salary)
values (6, 5, 'seller', 'Gadzhiev Gadzhi Gadzhievich', 1000.00::numeric::money);
insert into employer (id, departament_id, post, FIO, salary)
values (7, 4, 'trainee', 'Ivyaev Iiya Ilyiich', 500.00::numeric::money);
insert into employer (id, departament_id, post, FIO, salary)
values (8, 3, 'trainee', 'Antonov Anton Antonovich', 500.00::numeric::money);
insert into employer (id, departament_id, post, FIO, salary)
values (9, 2, 'cleaner', 'Alexandrov Alexander Alexandrovich', 100.00::numeric::money);
insert into employer (id, departament_id, post, FIO, salary)
values (10, 1, 'cleaner', 'Semenov Semen Semenovich', 100.00::numeric::money);







insert into departament (id, name, phone_number, manager_id)
values (1, 'headquarter1', '+71234567890', 10);
insert into departament (id, name, phone_number, manager_id)
values (2, 'headquarter2', '+71235678901', 9);
insert into departament (id, name, phone_number, manager_id)
values (3, 'hr1', '+71236789012', 8);
insert into departament (id, name, phone_number, manager_id)
values (4, 'hr2', '+71237890123', 7);
insert into departament (id, name, phone_number, manager_id)
values (5, 'sales1', '+71238901234', 6);
insert into departament (id, name, phone_number, manager_id)
values (6, 'sales2', '+71239012345', 5);
insert into departament (id, name, phone_number, manager_id)
values (7, 'sales3', '+71230123456', 4);
insert into departament (id, name, phone_number, manager_id)
values (8, 'sales4', '+71231234567', 3);
insert into departament (id, name, phone_number, manager_id)
values (9, 'sales5', '+71232345678', 2);
insert into departament (id, name, phone_number, manager_id)
values (10, 'sales5', '+71233456789', 1);

alter table employer add constraint frgh_key_empl foreign key (departament_id) references departament(id);

CREATE INDEX ON employer ((lower(FIO)));