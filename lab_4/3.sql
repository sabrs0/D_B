drop function if exists get_drugs_by_price(money, money);
create or replace function get_drugs_by_price(from_ int, to_ int) returns table (id int, product_amount int)as $$
import datetime
tab = plpy.execute("SELECT * FROM DELIVERY")
ans = []
for i in range(len(tab)):
	if (tab[i]["product_amount"] < to_ and tab[i]["product_amount"] > from_):
		ans.append({"id" : tab[i]["id"], "product_amount" : tab[i]["product_amount"]})
return ans;
$$ language plpython3u;

select * from get_drugs_by_price(5, 10);