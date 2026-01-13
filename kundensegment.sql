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

