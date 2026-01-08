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
select * from (select l.lname from l) where alter < 30;

select l.lname, alter from l;
select * from (select l.lname, alter from l) where alter < 30;

-- mengenvereinigung ---------------------------------------
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

-- π name (l ∪ s)-
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

-- alle lehrer und alle schüler
-- L ∪ S
select * from l
union 
select * from s;

-- alle namen von schülern und lehrern --> 6 Tupel
-- pi name (L) union pi name (s)
select name from l
union
select name from s;

--alle leherer namen ohne den namen von schülern --> 3 tupel
select name from l
except
select name from s;

--alle lehrer ohne die pendler mit mengendifferenz
select * from l 
except
select * from l where pendler = true;

----X-- kreuzprodukt-----------------------------------------

select * from l;
delete from l;
alter table l rename column name to lname;
alter table s rename column name to sname;

-- alle kombinationen von lehrernamen und schülernamen
--pi name(l) x pi name(s) --> 12 tupel

-- 4 tupel
select count(*) from l;
-- 3 tupel
select count(*) from s;

select lname from l;
select sname from s;
--- pi snamen lname(L x S) 
-- hier konflikt in relationer algebrea, weil gleiche attribute zb alter, pendler, id 
select lname, sname from l, s;

--funktioniert in sql
select * from l,s;
-- allerdings hier nihct
--alter ist nicht eindeutig leher alter und schüler alter ---> gleiche attributsname
select alter from l, s;

--pi lname(l) x pi sname(s)
select * from
(select lname from l),
(select sname from s);
----------------------------------------11.11.2025---------------------------

----todo alias und punktnotation

----Bsp. möglich Fahrgemeinschaften von Pendlern
--fehler: alias für l erforderlich
select * from l;
select * from l as fahrer, l as beifahrer;
select * from l as fahrer, l as beifahrer;

--qualifizierten attrinutnamen
select lname, pendler from l;
select l.lname, l.pendler from l;
select fahrer.lname, fahrer.pendler from l as fahrer;

select fahrer.lname, beifahrer.lname from l as fahrer, l as beifahrer where
fahrer.pendler = true and beifahrer.pendler = true;

--moritz zum pendler ändern
update l set pendler = true where lname = 'Moritz';

select fahrer.lname, beifahrer.lname from l as fahrer, l as beifahrer where
fahrer.pendler = true and beifahrer.pendler = true and 
--fahrer.lname != beifahrer.lname
fahrer.lid > beifahrer.lid;

---Welche Fächer unterrichtet Max?
select * from l, lv where l.lid = lv.id;
select l.lname, lv.fach, lv.stunden, lv.jahr  from l, lv where l.lid = lv.id and l.lname = 'Max';

------ DB-NEU -----------

drop table if exists lv cascade;
drop table if exists s cascade;
drop table if exists l cascade;

create table LV (
  id int references l,
  fach char,
  stunden int,
  jahr int,
  primary key(id, fach, jahr)
);

create table L (
  id int primary key,
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


-- ok 
select name, fach from l, lv where l.id = lv.id;

-- namenskonflikt
select id, fach from l, lv where l.id = lv.id;
-- lösung: vollqualifizierter attributname
select l.id, fach from l, lv where l.id = lv.id;

select * from l a, l b;
select * from l a, (select id id2, lname name2, alter alter2, pendler pendler2 from l);

select * from lv;
select id, fach, stunden, jahr from lv;

--p lid <|- id(LV)
select id as lid, fach, stunden, jahr from lv;
--(p lid <|- id(lv)) x L
select * from(select id as lid, fach, stunden, jahr from lv), l;
-----	ACHTUNG UMBENENNUNG IN SQL NICHT ERFORDERLICH nur für das theorethische
select * from l, lv;

select * from l, lv where lname = 'Max' and l.id = lv.id;

--alter -> vereinen
alter table s add kv int;
alter table s add foreign key (kv) references l;
select * from s;
alter table s rename sid to id;
update s set kv = 3 where id < 21;
update s set kv = 4 where id > 20;

-- die namen aller schüler und die id des kvs
select sname, kv from s;
select s.sname, s.kv from s;

-- die namen aller schüler und die namen des kvs
select * from s, l where l.id =s.kv;
select s.name schuler, l. name lehrer from l, s where l.id = s.kv;

-- die namen aller schüler und die namen und das alter des kvs
select s.name schuler, l. name lehrer, l.alter from l, s where l.id = s.kv;

-- wie viele Schüler haben Gabi als kv?
select * from l, s where l.id = s.kv;
select count(*) as anzahl_schueler from l, s where l.id = s.kv and l.name = 'Gabi';

--was ist das durchschnittsalter aller personen in der schule
select sum(alter)/count(*), avg(alter) from 
(select id, lname, alter from l
union 
select id, sname, alter from s);

--- einfache Unterabfragn mit Mondial-Datenbank
select * from city;
--besp für in, alle städte in albeanien
select * from city where country = 'AL';
--alle städte in albanien oder griehchenland
select * from city where country = 'AL' or country = 'GR';
select * from city where country in ('AL', 'GR');

--alle attribute der befölkerungsmössig kleinsten stadt ohne die verwendung von order und limit
--statt dessen kann min() und in verwendet werden
select min(population) from city where population > 0;
select name from city where population = 50;
---in einaem befehl
select name from city where population = (
select min(population) from city where population > 0);

---alle infos zum land indem Adamstown liegt, nicht nur den country code
select * from city where name = 'Adamstown';
select * from country;

--unterabfrage für fremdschlüssel
--es werden keine informationen aus der  tabelle
select * from country where code = (
	select country from city where name = 'Adamstown'
);

----------lösung mit kreuzprodukt, nur name und population vom country
select co.name, co.population from city ci, country co
where ci.country = co.code and ci.name = 'Adamstown';

--- Neue Version 2 mit FK

drop table if exists lv cascade;
drop table if exists s cascade;
drop table if exists l cascade;

create table L (
  id int primary key,
  name text,
  ALTER int,
  pendler bool  
);

create table LV (
  id int references l,
  fach char,
  stunden int,
  jahr int,
  lid int,
  primary key(id, fach, jahr),
  foreign key(lid) references L
);

insert into l values
(1, 'Max', 25, true),
(2, 'Fritz', 31, false),
(3, 'Gabi', 31, true),
(4, 'Moritz', 33, false);

insert into lv values 
(1, 'D', 4, 2022, 1),
(1, 'E', 4, 2022, 1),
(2, 'E', 6, 2022, 2),
(3, 'D', 2, 2022, 3);

select l.name, lv.fach, lv.stunden from l join lv on l.id = lv.lid where lv.fach = 'E';

