drop table if exists lv cascade;
drop table if exists s cascade;
drop table if exists l cascade;

create table L (
  lid int primary key,
  name text,
  ALTER int,
  pendler bool  
);

create table LV (
  lid int references L,
  fach char,
  stunden int,
  jahr int,
  primary key (lid, fach, jahr)
);

create table S (
  sid int primary key,
  name text,
  alter int,
  pendler bool,
  lid int references L
);

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