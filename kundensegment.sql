-- Kundensegment (Join auf Ungleichheit -> kein Equi Join)
-- =============

drop table if exists kunde;
drop table if exists segment;

-- kdnr, vn, nn, alter
create table kunde (
  name text,
  alter int
);

-- id, alter, typ, naechster
create table segment (
  alter int,
  typ text
);

insert into kunde values
('Elvis', 1),
('Basti', 11),
('Kevin', 15),
('Ernst', 25),
('Max', 35),
('Susi', 45),
('Gabi', 55),
('Toni', 61)
;

insert into segment values
(2, 'Baby'),
(12, 'Kind'),
(25, 'Jung'),
(50, 'Mittel'),
(80, 'UE50');

--alle babies
--subselect
select * from kunde where alter <= (select alter from segment where typ = 'Baby');
select * from kunde, segment where typ = 'Baby';


select k.name, s.typ from kunde k, segment s where s.typ = 'Baby' and k.alter <= s.alter;
--allle die jung sind
---sehr schwer
select k.name, s.typ from kunde k, segment s where s.typ = 'Jung' and k.alter <= s.alter;

select * from kunde k, segment so,  segment su;alter select 

select k.name, k.alter, so.typ, so.alter, su.typ, su.alter from kunde k, segment su, segment so
where 
k.alter <= so.alter and so.typ = 'Jung' and
k.alter > su.alter and su.typ = 'Kind';

---intersect

select name from city
intersect
select name from country;

select * from l;
select * from s;

select lname, alter from l
intersect
select sname, alter from s;

--name intersection
select lname from l
intersect
select sname from s;

------------------join------------------
drop table if exits a;
drop table if exits b;

create table a(x int, y int, z int);
create table b(u int, v int, w int);
insert into a values (0,1,1), (0,0,0), (1,1,0);
insert into b values (0,1,0), (0,1,1), (1,0,0);

select * from a, b where y = u;
select * from a join b on y = u;
select * from a join b on a.y = b.u;


---lehrere db
select * from l;
select * from lv;

--alle lehrer (name) mit lv(fach, stunden) mit JOIN
select l.lname, lv.fach, lv.stunden from l join lv  on l.id = lv.id;
--nur die Englischlehrer
select l.lname, lv.fach, lv.stunden from l join lv  on l.id = lv.id where lv.fach = 'E';

------Neue Version








select * from kunde where alter <= 
	(select alter from segment where typ = 'Kind') and 
		alter > (select alter from segment where typ = 'Baby');
--mit kreutzprodukt wichtig es gibt hier keine fremschlüsselbeziehungen 
--daher join auf ungleichiet
select * from kunde k, segment s where k.alter <= s.alter and s.typ = 'Baby';
select k.name from kunde k, segment s where k.alter <= s.alter and s.typ='Baby';
select k.name, s.typ from kunde k, segment s where k.alter <= s.alter and s.typ='Baby';



