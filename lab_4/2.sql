create or replace function my_sum(state int, val int ) returns int as $$
	return state + val;
$$ language plpython3u;
create aggregate my_aggr_sum(int)
(
	sfunc = my_sum,
	stype = int,
	initcond = 0
	
);
select my_aggr_sum(product_amount) from DELIVERY;