create schema if not exists feuerstein;

drop table if exists kunde cascade;
drop table if exists bestellung cascade;
drop table if exists ware cascade;
drop table if exists bestellpos cascade;
drop table if exists haendler cascade;
drop table if exists versand cascade;

create table kunde (
  knr int primary key,
  kname text,
  plz int
);

create table bestellung (
  bnr int primary key,
  bdatum text,
  knr int references kunde,
  bsum int
);

create table ware (
  wid char primary key,
  name text,
  preis int
);

create table bestellpos (
  bnr int references bestellung,
  wid char references ware,
  anzahl int,
  primary key (bnr, wid) 
);

create table haendler (
  hid char primary key,
  name text, 
  plz int
);

create table versand (
  bnr int primary key references bestellung,
  hid char references haendler,
  vdatum text
);

insert into kunde values
(1, 'Fred', 10),
(2, 'Wilma', 10),
(3, 'Barney', 11);

insert into bestellung values
(17, '1.1', 1, 0),
(18, '1.1', 1, 0),
(19, '2.1', 3, 0);

insert into ware values
('a', 'Dino Ei', 5),
('b', 'Keule kl.', 7),
('c', 'Keule gr.', 10),
('d', 'Schleuder', 8);

insert into bestellpos values
(17, 'a', 2),
(17, 'b', 1),
(18, 'a', 5),
(19, 'b', 1),
(19, 'c', 1);

insert into haendler values
('x', 'Stein-KG', 10),
('y', 'Billighöhle', 11),
('z', 'Ur-Gut', 12);

insert into versand values 
(17, 'x', '1.1'),
(18, 'x', '1.1'),
(19, 'y', '5.1');

