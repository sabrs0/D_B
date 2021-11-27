--\i 'C:/Users/siraz/Desktop/bmstu/3_course/DB/lab_5/main.sql'
--to 'C:/Users/siraz/Desktop/bmstu/3_course/DB/lab_5/tmp/tmp_table.json';
select '1)';
\t
\a
\o C:/tmp/customer.json
select row_to_json(u)
from customer u;

\o C:/tmp/drug.json
select row_to_json(u)
from drug u;

\o C:/tmp/route.json
select row_to_json(u)
from route u;

\o C:/tmp/delivery.json
select row_to_json(u)
from delivery u;
\o
\t off
\pset format aligned

select '2, 3)';

drop table if exists tmp_json_drug;
create temp table tmp_json_drug(
	data jsonb
);


\copy tmp_json_drug(data) from 'C:/tmp/drug.json';
drop table if exists tmp_drug;
create table tmp_drug as
(
		select * from drug
		where id < 0
);

insert into tmp_drug (id, name, company, price, made_in_country, transport_reqs, expiration_date)
select (data->>'id')::int, data->>'name', data->>'company', (data->>'price')::money, data->>'made_in_country', data->>'transport_reqs', (data->>'expiration_date')::date
from tmp_json_drug;

select * 
from tmp_drug;



select '4_1), 4_2)';

select data->>'id' as id, data->>'name' as name
from tmp_json_drug
where data->>'name' like '%Ibuprofen%';

select '4_3)';
drop procedure if exists if_exists_drug(date);
drop function if exists if_exists_drug(date);
create or replace function if_exists_drug(date_ date) returns setof  tmp_json_drug as $$
begin
	
	return query select *
		from tmp_json_drug
		where (data->>'expiration_date')::date < date_;
	if NOT found then
	raise notice 'No drug with such date %', date_;
	end if;
end;
$$ LANGUAGE PLPGSQL;

select * from if_exists_drug('01-01-2019'::date);

select '4_4)';

drop table if exists tmp_json_drug_1;
create temp table tmp_json_drug_1(
	data jsonb
);


\copy tmp_json_drug_1(data) from 'C:/tmp/drug.json';

drop table if exists tmp_json_customer_1;
create temp table tmp_json_customer_1(
	data jsonb
);


\copy tmp_json_customer_1(data) from 'C:/tmp/customer.json';


update tmp_json_drug_1 set 
data = jsonb_set(data::jsonb, '{name}', '"IBUPROFEN_20000"', true )
where data->>'name' like '%Ibuprofen%';




select data->>'name'
from tmp_json_drug_1
where data->>'name' like '%IBUPROFEN_20000%';

select '4_5)';

select *
from jsonb_array_elements(
    '[
    {"name": "Ibuprofen", "price": "50"},
    {"name": "Piracetam", "price": "60"}
    ]'
);





