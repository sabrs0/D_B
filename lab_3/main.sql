--\i 'C:/users/siraz/Desktop/bmstu/3_course/DB/lab_3/main.sql'
--1. Скалярная функция/
select '1) skalar func';
create or replace function avg_price_by_country(country text)
returns numeric as $$
declare avg_price numeric;
begin
	select sum(price) / count(id)
	into avg_price
	from drug
	where made_in_country = country;
	
	return avg_price;
	
end;
$$ LANGUAGE PLPGSQL;

select *
from avg_price_by_country('United States of America');

--2 Подставляемая табличная функция
select '2) inner table func';
create or replace function  usa_drugs_by_price(price_ numeric)
returns table (name_ text, price__ numeric, country_ text) as $$

	select name::text, price::numeric, made_in_country::text
	from drug
	where made_in_country = 'United States of America' and price < price_::money;
$$ language SQL;

select * from usa_drugs_by_price(40.00);

--3) Многооператорная табличная функция
select '3) multioperated table func';
create or replace function cntrs_and_ffty(cntrs text[])
returns table (country_ text, price_ numeric, name_ text) as $$
declare text_ind text default '';
begin
	--drop table tmptab if exists;
	create temp table tmptab (country text, price numeric, name text);
	foreach text_ind in ARRAY $1 LOOP
	IF EXISTS (
                SELECT made_in_country
                FROM drug
                WHERE made_in_country = text_ind and drug.price < 200::money
            )
    THEN
            insert into tmptab (country, price, name)
			select made_in_country, price, name
			from drug
			where made_in_country = text_ind and price < 200::money;
    --ELSE
    --        RAISE NOTICE 'Player with %  was not found', text_ind;
	END IF;
    END LOOP;
	return query 
	select * from tmptab;
END;
$$ LANGUAGE PLPGSQL;


select * from cntrs_and_ffty(ARRAY['United States of America', 'Nigeria']);


--4) рекурсивная функция 
select '4) recursive func';
create or replace function drug_by_date_with_fridge(date_ text)
returns table (id_ int, name_ varchar(100), date__ date) as $$
begin

	drop table if exists drug_tmp;
	
	create table drug_tmp as(
		SELECT * 
		FROM DRUG
		ORDER BY EXPIRATION_DATE);

	return query
	WITH RECURSIVE FRESH_DRUGS  AS
	(
		SELECT ID, NAME, EXPIRATION_DATE 
		FROM drug_tmp
		WHERE EXPIRATION_DATE = (SELECT MIN(EXPIRATION_DATE) FROM drug_tmp)
		UNION 
		SELECT ID, NAME, EXPIRATION_DATE
		FROM drug_tmp
		WHERE EXPIRATION_DATE <= date_::DATE AND ID IN 	(	SELECT DRUG_ID 
																	FROM DELIVERY
																	WHERE ROUTE_ID IN 	(	SELECT ID 
																							FROM ROUTE
																							WHERE MED_FRIDGE = 1::BOOLEAN)
																)
						
	)
	SELECT ID, NAME, EXPIRATION_DATE
	FROM FRESH_DRUGS;
end;
$$ LANGUAGE PLPGSQL;

select * from drug_by_date_with_fridge('2025-01-01');




-- 5)Хранимая процедура без параметров или с параметрами; (уменьшить\увеличить на 15 % цену на лекарства, срок которых кончится в 2023 году) 
select '5)';
create or replace function count_percent (price_ float8, percent float8)
returns float8 as $$
declare percent_part float8;
begin 
	percent_part = price_ / 100 * percent;
	return percent_part;
end;
$$ LANGUAGE PLPGSQL;
	
create or replace procedure reduce_price_for_olds() 
as $$
declare percent_part float8;
begin
	update drug
	set price = (price::numeric::float8 - (select * from count_percent(price::numeric::float8, 15.00::float8)))::numeric::money
	where expiration_date <= '2023-01-01'::date;
end;
$$ LANGUAGE PLPGSQL;
create or replace procedure increase_price_for_olds() 
as $$
declare percent_part float8;
begin
	update drug
	set price = (price::numeric::float8 + (select * from count_percent(price::numeric::float8, 15.00::float8)))::numeric::money
	where expiration_date <= '2023-01-01'::date;
end;
$$ LANGUAGE PLPGSQL;
call increase_price_for_olds();
select 'before reduce:';
select id, price
from drug
where expiration_date <= '2023-01-01';
call reduce_price_for_olds();
select 'after reduce:';
select id, price
from drug
where expiration_date <= '2023-01-01';
--6) Рекурсивную хранимую процедуру или хранимую процедур с рекурсивным ОТВ;
select '6)';
select 'before boost:';
create table drug_tmp_2 as(
		SELECT * 
		FROM DRUG
		where expiration_date < '2025-01-01'
		ORDER BY price);
select id, price
from drug_tmp_2
where id < 50;
create or replace procedure rec_increase_price(id_ int)
as $$
begin
	update drug_tmp_2
	set price = (price::numeric::float8 + (select * from count_percent(price::numeric::float8, 15.00::float8)))::numeric::money
	where id = id_;
	
	if (id_ < 50)
		then call rec_increase_price(id_ + 1);
	end if;
end;
$$ LANGUAGE PLPGSQL;

call rec_increase_price(1); 
select 'after boost:';
select id, price
from drug_tmp_2
where id < 50;
drop table drug_tmp_2;
--7)  Хранимую процедуру с курсором
select '7)';

create or replace procedure drug_renaming(old_drug_name text, new_drug_name text) as $$
declare
	cur cursor for 
					select * 
					from drug
					where name = old_drug_name;
	name_row record;
begin
	
	open cur;
	loop
		fetch cur into name_row;
		exit when not found;
		update drug
		set name = new_drug_name
		where drug.id = name_row.id;
	end loop;
	close cur;
end;
$$ LANGUAGE PLPGSQL;
call drug_renaming('Adderall', 'Adderall_2000');

select 'AFTER RENAMING:';
select id, name
	from drug
	where name = 'Adderall_2000';
call drug_renaming('Adderall_2000','Adderall');
	
--8)   Хранимую процедуру доступа к метаданным
select '8)';
create or replace procedure get_constraints_by_tablename(tab_name text) as $$
declare
	constraint_ text;
begin
	for constraint_ in
		select constraint_name
		from information_schema.table_constraints
		where table_name = tab_name
	loop
		RAISE NOTICE 'Table with name % has constraint %!', tab_name, constraint_;
	end loop;
end;
$$ LANGUAGE PLPGSQL;

call get_constraints_by_tablename('drug');
	




--9)   Триггер AFTER
select '9)';
create table drug_tmp_2 as(
		SELECT * 
		FROM DRUG
		where expiration_date < '2025-01-01'
		ORDER BY price);
		
create or replace function msg_update() returns trigger as $$
begin 
	raise notice 'update on table drug_tmp_2 with values % % % % % % %', new.id ,new.name, new.company, new.price , new.made_in_country , new.transport_reqs , new.expiration_date; 
	return new;
end;
$$ language 'plpgsql'; 

drop trigger if exists echo_update  ON drug_tmp_2;

create trigger echo_update
after update 
on drug_tmp_2
for each row
execute procedure msg_update();



update drug_tmp_2
set name = 'askorbinka'
where id = 1;

drop table drug_tmp_2;

--10)   Триггер INSTEAD OF
select '10)';
create or replace view drug_tmp_view as
		SELECT * 
		FROM DRUG
		--ORDER BY price
		limit 10;
		
select id, name
from drug_tmp_view;
create or replace function ins_msg_update() returns trigger as $$
begin 
	raise notice 'attempt to update but view drug_tmp_view is not changed';-- with values % % % % % % %', new.id ,new.name, new.company, new.price , new.made_in_country , new.transport_reqs , new.expiration_date; 
	return new;
end;
$$ language 'plpgsql'; 

drop trigger if exists ins_echo_update  ON drug_tmp_view;

create trigger ins_echo_update
INSTEAD OF  update 
on drug_tmp_view
for each row
execute procedure ins_msg_update();



update drug_tmp_view
set name = 'ibuprofen'
where id = 2;
select id, name
from drug_tmp_view;
--drop view drug_tmp_view;



	