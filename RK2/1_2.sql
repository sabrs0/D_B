select '1)';

select id, FIO, salary,
case
	when salary::numeric > 500.00 then 'Valuable'
	else 'Unvaluable'
end as Val
from employer;


select '2)';

select FIO, post, avg(salary::numeric) over (partition by post)
from employer;


select '3)';

select name, price::numeric
from medicine
group by name, price::numeric
having price::numeric < (select avg(price::numeric) from medicine);