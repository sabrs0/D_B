drop table if exists drug_tmp;
create  table drug_tmp as(
		SELECT id, name, price 
		FROM DRUG
		WHERE ID < 11);
		--ORDER BY price;


create  table drug_tmp_log as(
		SELECT id, name, price 
		FROM DRUG
		WHERE ID < 0);
		--ORDER BY price;
		
		
		
DROP FUNCTION msg_insertion();
create or replace function log_update() returns trigger as $$
plpy.execute("INSERT INTO {} VALUES ('{}', '{}', '{}');".format('drug_tmp_log', TD['new']['id'], TD['new']['name'], TD['new']['price']))
return None;
$$ language plpython3u; 


drop trigger if exists log_update on drug_tmp;
create  trigger echo_insertion
AFTER update
on drug_tmp
for row
execute procedure log_update();


update  drug_tmp 
set name = 'hello'
where id = 2;
select * from drug_tmp_log;
drop TABLE drug_tmp;