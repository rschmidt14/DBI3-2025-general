drop table if exists lv;
drop table if exists s;
drop table if exists l;

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

