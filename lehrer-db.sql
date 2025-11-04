drop table if exists lv cascade;
drop table if exists s cascade;
drop table if exists l cascade;

create table LV (
  id int,
  fach char,
  stunden int,
  jahr int
);

create table L (
  lid int,
  lname text,
  ALTER int,
  pendler bool  
);

create table S (
  sid int,
  sname text,
  alter int,
  pendler bool
);

truncate l;
insert into l values
(1, 'Max', 25, true),
(2, 'Fritz', 31, false),
(3, 'Gabi', 31, true),
(4, 'Moritz', 33, false);

insert into lv values 
(1, 'D', 4, 2022),
(1, 'E', 4, 2022),
(2, 'E', 6, 2022),
(3, 'D', 2, 2022);

insert into s values
(10, 'Susi', 15, false),
(20, 'Sepp', 16, false),
(30, 'Max', 16, true);

select * from l;
-- pi id (L)
select lid from l;
select lid, lname from l;
select alter from l;
select distinct alter from l;

-- sigma alter<0 (L)
select * from l where alter < 30;

-- pi lname ( sigma alter<30 (L) )
select lname from l where alter < 30;

-- column "alter" does not exist
select * from (select lname from l) where alter < 30;

select lname, alter from l;
select * from (select lname, alter from l) where alter < 30;

-- alle lehrer und alle schüler -> 7 tupel
-- L ∪ S
select * from l 
union
select * from s;

alter table l rename column lname to name;
alter table s rename column sname to name;

-- alle namen von lehrern und schülern -> 6 tupel
-- π name (L) ∪ π name (S)
select name from l
union 
select name from s;

-- alle namen von lehrern, die keine namen von schülern sind -> 3 tupel
-- π name (L) ∪ π name (S)
select name from l
except 
select name from s;

-- alle lehrer ohne die pendler mit mengendifferenz
select * from l 
except
select * from l where pendler = true;

select * from l;

alter table l rename column name to lname;
alter table s rename column name to sname;

-- alle kombinationen von lehrernamen und schülernamen
-- π name (L) x π name (S)
-- 4 
select count(*) from l;
-- 3
select count(*) from s;

--  π sname, sname (L x S)
-- hier konflikt in rel. algebra, weil gleiche attribute, z.B. alter, pendler, id
select lname, sname from l,s;

-- funktioniert in sql
select * from l,s;
-- allerdings hier nicht mehr
-- alter ist nicht eindeutig
select alter from l,s;

-- π sname (L) x π lname (S)
select * from 
(select lname from l),
(select sname from s);

-- todo alias und punktnotation




