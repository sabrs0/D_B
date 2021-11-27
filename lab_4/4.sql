create or replace procedure my_upd_txt(tab_name text, column_name text, id text, new_val text)as $$
upd = "update ";
set_ = " set ";
plpy.execute(upd + tab_name + set_ + column_name + " = \'" + new_val + "\' where id = \'" +  str(id) + "\'");
$$ language plpython3u; 



call my_upd_txt('drug', 'name', '1', 'Ibuprofen');