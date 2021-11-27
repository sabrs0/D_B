--CREATE EXTENSION plpython3u;

create or replace function echo_upd_driver() returns trigger as $$
begin
	raise notice 'DRIVER UPDATED';
	return new;
end;
$$ language PLPGSQL;

drop trigger if exists trig_ on driver;
create trigger trig_
after update
on driver
for each row
execute procedure echo_upd_driver();

create or replace function drop_trigs() returns int as $$
declare
	n int;
	name_ text;
begin
	n = 0;
	for name_ in 
		select trigger_name from information_schema.triggers where trigger_catalog = current_database()
	loop
		drop trigger if exists name_ on name_.event_object_table;
		raise notice 'Trigger % was dropped', name_;
		n = n + 1;
	end loop;
	return n;
end;
$$ language PLPGSQL;

select * from drop_trigs();



















select '4_3)';
create or replace function show_checks(dbname text) returns void as $$
declare name_ text;
begin
	for name_ in 	select constraint_name 
					from information_schema.check_constraints
					where constraint_catalog = current_database()--dbname
	loop
		raise notice 'check constraint with name %', name_;
	end loop;
end;
$$ language PLPGSQL;

select * from show_checks(current_database());
	
	
	
	
	
	
	
	
	
	