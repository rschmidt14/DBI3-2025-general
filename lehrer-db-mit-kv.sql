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
  id int,
  name text,
  ALTER int,
  pendler bool  
);

create table S (
  sid int,
  name text,
  alter int,
  pendler bool,
  kv int
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
(10, 'Susi', 15, false, 1),
(20, 'Sepp', 16, false, 3),
(30, 'Max', 16, true, 3);

