drop database if exists rk2_2;
create database rk2_2;

\c rk2_2;

create table driver(

	id integer not null primary key,
	drive_licence varchar(20) not null,
	phone_number varchar (15) not null,
	FIO varchar(100) not null,
	vehicle_id integer not null
);

create table vehicle(

	id integer not null primary key,
	mark varchar (50) not null,
	model varchar (50) not null,
	prod_date date not null,
	reg_date date not null
);

create table fee(

	id integer not null primary key,
	violation varchar(100) not null,
	fee money not null,
	warning varchar(100) not null
);

insert into fee (id, violation, fee, warning)
values (1, 'red light', 100.00::money,  'be careful');
insert into fee (id, violation, fee, warning)
values (2, 'seat belt', 200.00::money,  'be careful');
insert into fee (id, violation, fee, warning)
values (3, 'no medicine', 300.00::money, 'be careful');
insert into fee (id, violation, fee, warning)
values (4, 'no fire extinguisher',400.00::money,  'be careful');
insert into fee (id, violation, fee, warning)
values (5, 'over speed', 500.00::money, 'be careful');
insert into fee (id, violation, fee, warning)
values (6, 'didnt miss a pedestrian', 600.00::money,  'be careful');
insert into fee (id, violation, fee, warning)
values (7, 'bad drive', 700.00::money, 'be careful');
insert into fee (id, violation, fee, warning)
values (8, 'bad talk with police',800.00::money,  'be careful');
insert into fee (id, violation, fee, warning)
values (9, 'drug racing', 900.00::money, 'be careful');
insert into fee (id, violation, fee, warning)
values (10, 'you are black in usa', 1000.00::money, 'be careful');



insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (1, '000-001',  '+79991234567', 'Ivanov Ivan Ivanovich', 10);
insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (2, '000-002',  '+79991234567', 'Ivanov Petr Ivanovich', 9);
insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (3, '000-003',  '+79991234567', 'Ivanov Ivan Petrovich', 8);
insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (4, '000-004',  '+79991234567', 'Petrov Ivan Ivanovich', 7);
insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (5, '000-005',  '+79991234567', 'Petrov Petr Ivanovich', 6);
insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (6, '000-006',  '+79991234567', 'Petrov Petr Petrovich', 5);
insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (7, '000-007',  '+79991234567', 'Sidorov Ivan Ivanovich', 4);
insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (8, '000-008',  '+79991234567', 'Sidorov Sidor Ivanovich', 3);
insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (9, '000-009',  '+79991234567', 'Sidorov Sidor Sidorovich', 2);
insert into driver (id, drive_licence, phone_number, FIO, vehicle_id)
values (10, '000-010',  '+79991234567', 'Sidorov Ivan Petrovich', 1);



insert into vehicle (id, mark, model, prod_date, reg_date)
values (1, 'UAZ',  '2107', '01-01-1991'::date, '01-01-1995'::date);
insert into vehicle (id, mark, model, prod_date, reg_date)
values (2, 'UAZ',  '2108', '01-01-1998'::date, '01-01-2006'::date);
insert into vehicle (id, mark, model, prod_date, reg_date)
values (3, 'UAZ',  '2109', '01-01-1999'::date, '01-01-2007'::date);
insert into vehicle (id, mark, model, prod_date, reg_date)
values (4, 'UAZ',  '2110', '01-01-2000'::date, '01-01-2008'::date);
insert into vehicle (id, mark, model, prod_date, reg_date)
values (5, 'UAZ',  '2111', '01-01-2001'::date, '01-01-2009'::date);
insert into vehicle (id, mark, model, prod_date, reg_date)
values (6, 'UAZ',  '2112', '01-01-2002'::date, '01-01-2010'::date);
insert into vehicle (id, mark, model, prod_date, reg_date)
values (7, 'UAZ',  '2113', '01-01-2003'::date, '01-01-2013'::date);
insert into vehicle (id, mark, model, prod_date, reg_date)
values (8, 'UAZ',  '2114', '01-01-2004'::date, '01-01-2008'::date);
insert into vehicle (id, mark, model, prod_date, reg_date)
values (9, 'BMW',  'm5 competition', '01-01-2004'::date, '01-01-2009'::date);
insert into vehicle (id, mark, model, prod_date, reg_date)
values (10, 'Mercedes-benz',  'S 223', '01-01-2020'::date, '01-10-2020'::date);


alter table driver add constraint frgn_key_drvr foreign key(vehicle_id) references vehicle(id);
alter table fee add constraint chk_MONEEEY CHECK (fee >= 0.00::money);