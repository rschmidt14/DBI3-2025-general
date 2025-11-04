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
  name text,
  ALTER int,
  pendler bool  
);

create table S (
  sid int,
  name text,
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

-- mengenvereinigung 
select * from l;
select * from s;

select * from l 
union
select * from s;

select * from l 
union
select * from lv;

-- die namen aller lehrer und schüler
-- π name (l) ∪ π name (s)
select name from l
union
select name from s;

-- π name (l ∪ s)
select distinct name from (select * from l union select * from s);

-- die namen aller lehrer und schüler, die pendler sind
select name from l where pendler = true
union
select name from s where pendler = true;

select * from (select * from l union select * from s) as ls;
select distinct name from (select * from l union select * from s) as ls where pendler = true;

-- mondial
-- die namen und flächen aller flüsse  (die länger als 300 km) und seen (die größer als 2000 km²) sind
-- in sql und rel. algebra als hü bis zum nächsten mal

select name, area from lake ;
select * from river;

