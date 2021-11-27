--\i 'C:/users/siraz/Desktop/bmstu/3_course/DB/lab_4/1.sql'
DROP FUNCTION if exists transport_req_by_name(text);
CREATE EXTENSION plpython3u;
create or replace function transport_req_by_name(drug_name text)
returns text as $$
	ans = "No drug with such name"
	drugs = plpy.execute("SELECT * FROM DRUG")
	print(len(drugs))
	for i in range(len(drugs)):
		if (drugs[i]["name"] == drug_name):
			ans = drugs[i]["transport_reqs"]
	return ans;
$$ language plpython3u;
select * from transport_req_by_name('Adderall');
			