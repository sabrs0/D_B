select '2)';

drop table if exists tmp_json_drug;
create TEMP table tmp_json_drug(
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