alter table drug add constraint chk_money CHECK (price > '0'::int::money);
alter table delivery add CONSTRAINT unique_chk_delivery_foreign_ids UNIQUE (customer_id, drug_id, route_id);
alter table customer add constraint chk_date CHECK (birth_date > '1900-01-01'::date);
alter table route add constraint chk_route_time CHECK (hours < 100);
alter table delivery add constraint chk_prod_amount CHECK (product_amount > 0);
alter table drug add constraint chk_date_expir CHECK (expiration_date >= now()::date);