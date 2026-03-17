--
create table person (
  pid int primary key,
  name varchar,
  photo varchar
);

-- insert ist nur dauerhaft, da Auto-Commit aktiviert ist
insert into person values (1, 'Mike', '/photo1.jpg');
select * from person;
delete from person;
-- auto-commit auf manual commit umstellen!
insert into person values (1, 'Mike', '/photo1.jpg');
commit; --rollback;
insert into person values (2, 'Sue', '/photo2.jpg');
commit;
delete from person;
rollback;
delete from person where name = 'Mike';
commit;
-- eine transaktion ist atomar, kann aber mehrere DB-Operatinen beinhalten.
-- alle operationen sind entweder erfolgreich oder werden zurückgerollt
delete from person; 
commit;

begin;
insert into person values (1, 'Mike', '/photo1.jpg');
insert into person values (2, 'Sue', '/photo2.jpg');
commit;
select * from person;

delete from person; 
commit;

-- rollback beider Operationen bei Fehler, weil Transaktion atomar
begin;
insert into person values (1, 'Mike', '/photo1.jpg');
insert into person values (1, 'Sue', '/photo2.jpg');
commit;

drop table person; 

-- verletzt die referenzielle integrität, tabelle picture existiert nicht
create table person (
  pid int primary key,
  name varchar,
  photo varchar references picture
);
---

create table picture (
  id int primary key,
  content bytea 
);

create table person (
  pid int primary key,
  name varchar,
  photo int references picture
);

---
drop table if exists picture;
drop table if exists person;

create table picture (
  id int primary key,
  content bytea,
--  pid int references person
  pid int 
);

create table person (
  pid int primary key,
  name varchar,
  photo int references picture
);

-- constraint wird im nachhinein eingefügt
alter table picture add foreign key (pid) references person;

-- chicken / egg problem
-- insert into picture values (1, null, 1);

insert into picture values (1, null, null);
insert into person values (1, 'Mike', 1);
update picture set pid = 1 where id = 1;

-- initialer versuch mit transaktion  
-- Ziel: kein nachträgliches update der datensätze erforderlich

-- problem fremdschlüssel
delete from person;
delete from picture;

delete pid from picture;
delete photo from person;

begin;
insert into picture values (10, '/photo1.jpg', 1);
insert into person values (1, 'Mike', 10);
commit;


-- lösung mit transaktion / kein nachträgliches update der datensätze erforderlich

-- verzögern der überprüfung der integritätsbedingungen (also auch der ref. integrität) ans ende der transaktion







