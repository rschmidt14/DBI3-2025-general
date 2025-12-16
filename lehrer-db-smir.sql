drop table if exists lv cascade;
drop table if exists s cascade;
drop table if exists l cascade;

create table LV (
  lid int,
  fach char,
  stunden int,
  jahr int
);

create table L (
  id int,
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

-- self join mit kreuzprodukt L x L
-- Bsp. möglich Fahrgemeinschaften von Pendlern

-- fehler: alias bzw. umbenennung für l erforderlich
select * from l,l;
select * from l as fahrer,l as beifahrer;
select * from l as fahrer,l as beifahrer;

-- qualifizierten attributnamen
select lname, pendler from l;
select l.lname, l.pendler from l;
select fahrer.lname, fahrer.pendler from l as fahrer;

select fahrer.lname, beifahrer.lname from l as fahrer, l as beifahrer where 
fahrer.pendler = true and beifahrer.pendler = true;

-- moritz zum pendler ändern
update l set pendler = true where lname = 'Moritz';

select fahrer.lname, beifahrer.lname from l as fahrer, l as beifahrer where 
fahrer.pendler = true and beifahrer.pendler = true and 
--fahrer.lname != beifahrer.lname
fahrer.id > beifahrer.id;

--welche faecher unterrichtet max
select * from l,lv where l.id = lv.lid;
select l.lname, lv.fach, lv.stunden, lv.jahr from l,lv where l.id = lv.lid and l.lname = 'Max';


--- DB neu

drop table if exists lv cascade;
drop table if exists s cascade;
drop table if exists l cascade;

create table LV (
  id int references l,
  fach char,
  stunden int,
  jahr int,
  primary key (id, fach, jahr)
);

create table L (
  id int primary key,
  name text,
  ALTER int,
  pendler bool  
);

create table S (
  id int primary key,
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

-- ok
select name, fach from l,lv where l.id = lv.id;
-- namenskonflikt
select id, name, fach from l,lv where l.id = lv.id;
-- loesung vollstaendig qualifizierter attributname
select l.id, name, fach from l,lv where l.id = lv.id;

select * from l a, l b;
select * from l a, (select id id2, name name2, alter alter2, pendler pendler2 from l);

select * from lv;
select id, fach, stunden, jahr from lv;
-- Schritte
-- ρ lid ← id (LV)
select id as lid, fach, stunden, jahr from lv;
-- (ρ lid ← id (LV)) X L
select * from (select id as lid, fach, stunden, jahr from lv), l;
-- Achtung! umbenennung in SQL nicht erforderlich
select * from l, lv;
-- π name, fach, stunden, jar ( σ name = 'Max' ∧ lid = id ( (ρ lid ← id (LV) ) X L) )
select name, fach, stunden, jahr from l, lv where name = 'Max' and l.id = lv.id;

alter table s add kv int;
alter table s add foreign key (kv) references l;
select * from s;
update s set kv = 3 where id < 21;
update s set kv = 4 where id > 20;

select * from l;
select * from s;
--die namen aller schueler und die id des kvs
select name, kv from s;
select s.name, s.kv from s;
--die namen aller schueler und die namen des kvs
-- achtung sch(lxs)
select * from l,s where l.id = s.kv;
select s.name schueler, l.name lehrer from l,s where l.id = s.kv;
--die namen aller schueler und die namen und das alter des kvs
select s.name schueler, l.name lehrer, l.alter from l,s where l.id = s.kv;
--wie viele schueler haben gabi als kv
select count(*) as anz_schuler from l,s where l.id = s.kv and l.name = 'Gabi';
--was ist das durchschnittsalter aller personen in der schule

select sum(alter)/count(*) v1, avg(alter) v2, sum(alter)::decimal/count(*) v3 from
(select id, name, alter from l
union
select id, name, alter from s);

--- einfache Unterabfragen mit Mondial
select * from city;
-- bsp fuer in, alle staedte in albanien
select * from city where country = 'AL';
-- alle staedte in albanien oder griechenland
select * from city where country = 'AL' or country = 'GR';
select * from city where country in ('AL', 'GR');

-- alle attribute der befoelkerungsmaessig kleinsten stadt ohne die verwendung von order und limit
-- statt dessen kann min() verwendet werden
select * from city where population = 0;
select min(population) from city where population > 0;
select name from city where population = 56;

select name from city where population = (
  select min(population) from city where population > 0
);

-- alle informationen zum land in dem Adamstown liegt, nicht nur den Country Code
select * from city where name = 'Adamstown';
select * from country;

-- unterabfrage fuer fremdschluessel
-- es werden keine informationen aus der tabelle city angezeigt
select * from country where code = (
  select country from city where name = 'Adamstown'
);

-- loesung mit kreuzprodukt, nur name und population vom country
select co.name, co.population from city ci, country co
where ci.country = co.code and ci.name = 'Adamstown';

-- üben für den 1. Test
-- Lehrer DB (in SQL und rel. Algebra )
-- Alle Schüler (Name), die Gabi als KV haben mit einer Unterabfrage
select * from s;
select * from l;

select name from s where kv = (
  select id from l where l.name = 'Gabi'
);

select s.name from l,s where l.id = s.kv and l.name = 'Gabi';

-- Einfügen der der Relation [unterrichtet]

drop table if exists lv cascade;
drop table if exists s cascade;
drop table if exists l cascade;
drop table if exists u cascade;


create table LV (
  id int primary key,
  fach char,
  stunden int,
  jahr int
);

create table L (
  id int primary key,
  name text,
  ALTER int,
  pendler bool  
);

create table U (
  lid int references l,
  lvid int references lv
);

insert into l values
(1, 'Max', 25, true),
(2, 'Fritz', 31, false),
(3, 'Gabi', 31, true),
(4, 'Moritz', 33, false);

insert into lv values 
(1, 'D', 4, 2022), --max
(2, 'E', 4, 2022), --max
(3, 'E', 6, 2022), --fritz
(4, 'D', 2, 2022); --gabi

insert into u values
(1, 1),
(1, 2),
(2, 3),
(3, 4);

-- Alle Lehrer die ein Fach unterrichten mit Kreuzprodukt und Unterabfrage
select distinct l.name from l,u,lv where u.lid = l.id and u.lvid = lv.id; 

select l.name from l where l.id in (
  select lid from u
);

-- Einschränken auf alle Englischlehrer
select distinct l.name from l,u,lv where u.lid = l.id and u.lvid = lv.id and lv.fach = 'E'; 

select l.name from l where l.id in (
  select lid from u where lvid in (
    select id from lv where fach = 'E'
  )
);

-- Mondial DB
-- Die Codes aller Länder die in keiner Organisation Mitglied sind
select * from country;
select * from organization;
select * from ismember;
select distinct type from ismember;

-- version mit unterabfrage
select name from country where code in (
  select code from country 
  except
  select country from ismember
);

--select name from country where population = (
--  select max(population) from country
--);


select country.name from country, 
(select code from country 
except
select country from ismember) as nm
where country.code = nm.code;


-- Die Namen aller Länder, die in keiner Organisation Mitglied sind
-- In welchen Organisationen ist Österreich Mitglied? Lsg. mit Join und Unterabfrage
