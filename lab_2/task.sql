drop table Table1;
drop table Table2;
DROP TABLE NEW_TAB;
create table Table1 
(
	id int,
	var1 char,
	valid_from_dttm date,
	valid_to_dttm date
);

create table Table2 
(
	id int,
	var2 char,
	valid_from_dttm date,
	valid_to_dttm date
);


insert into Table1 (id, var1, valid_from_dttm, valid_to_dttm) values (3, 'A', '20180901', '20180920');
insert into Table1 (id, var1, valid_from_dttm, valid_to_dttm) values (3, 'B', '20180921', '20180925');
insert into Table1 (id, var1, valid_from_dttm, valid_to_dttm) values (1, 'B', '20180916', '59991231');
insert into Table1 (id, var1, valid_from_dttm, valid_to_dttm) values (1, 'A', '20180901', '20180915');
insert into Table1 (id, var1, valid_from_dttm, valid_to_dttm) values (2, 'A', '20180916', '20180926');
insert into Table1 (id, var1, valid_from_dttm, valid_to_dttm) values (3, 'C', '20180926', '59991231');

insert into Table2 (id, var2, valid_from_dttm, valid_to_dttm) values (1, 'A', '20180901', '20180918');
insert into Table2 (id, var2, valid_from_dttm, valid_to_dttm) values (1, 'B', '20180919', '59991231');
insert into Table2 (id, var2, valid_from_dttm, valid_to_dttm) values (3, 'A', '20180901', '20180924');
insert into Table2 (id, var2, valid_from_dttm, valid_to_dttm) values (2, 'B', '20180926', '59991216');
insert into Table2 (id, var2, valid_from_dttm, valid_to_dttm) values (3, 'B', '20180925', '59991231');











DROP TABLE COMMON_TAB;
DROP TABLE FROM_TAB;
DROP TABLE TO_TAB;
DROP TABLE COMMON_TAB2;
DROP TABLE NEW_DATE_TAB;
--SELECT *
--INTO COMMON_TAB2
--FROM TABLE1
--FULL OUTER JOIN TABLE2
--ON TABLE1.ID = TABLE2.ID
--;
SELECT *
INTO COMMON_TAB
FROM TABLE1
;

INSERT INTO COMMON_TAB
SELECT *
FROM TABLE2
;

SELECT ID, valid_from_dttm
INTO FROM_TAB
FROM COMMON_TAB
GROUP BY ID, valid_from_dttm
ORDER BY ID, valid_from_dttm
;
SELECT ID, valid_to_dttm
INTO TO_TAB
FROM COMMON_TAB
GROUP BY ID, valid_TO_dttm
ORDER BY ID, valid_TO_dttm
;
SELECT * 
FROM FROM_TAB;

SELECT * 
FROM TO_TAB;


SELECT *
FROM TABLE1
FULL JOIN TABLE2 
ON TABLE1.ID = TABLE2.ID
ORDER BY TABLE1.ID, TABLE1.VALID_FROM_DTTM