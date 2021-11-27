drop procedure if exists third_task(text, text);
drop function if exists third_task(text, text);

create or replace function third_task(base_name text, tab_name text) returns setof pg_indexes as $$
begin
	return query
	select *
	from pg_indexes
	where tablename = tab_name;
end;
$$ language PLPGSQL; 

select * from third_task('rk2', 'employer');