create type dot as(
	
	x double precision,
	y double precision,
	z double precision
);
DROP FUNCTION create_dot(double precision,double precision,double precision);
create or replace function create_dot(x_ double precision, y_ double precision, z_ double precision) 
returns setof dot as $$
	return ([x_, y_, z_],);
$$ language plpython3u;
select * from create_dot(1,2,3);