select '1)';
select *
from fee
where fee::numeric between 500.00::numeric and 800.00::numeric;

select '2)';
select violation, avg(fee::numeric) over (partition by violation)
from fee;

select '3)';
select *
from driver D join (select * from vehicle) as VV on D.vehicle_id = VV.id;