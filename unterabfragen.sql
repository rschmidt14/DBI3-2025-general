select * from professoren;
select persnr from professoren where name = 'Sokrates';

-- Unterabfrage mit einem Resultat
-- arithmetische Vergleiche mit >, <, =, !=, <=, <= möglich
-- alle von sokrates
select titel from vorlesungen where gelesenvon = (select persnr from professoren where name = 'Sokrates');
-- alle die nicht von sokrates gelesen werden
select titel from vorlesungen where gelesenvon != (select persnr from professoren where name = 'Sokrates');
-- alle die von Profs mit einer größeren persnr als der von Sokrates gelesen werden
select titel from vorlesungen where gelesenvon > (select persnr from professoren where name = 'Sokrates');

-- Unterabfragen mit mehreren Ergebniszeilen
-- 2137

select * from professoren order by persnr;

select persnr from professoren where name in ('Kant');
select * from vorlesungen;

--IN: Prüft, ob ein Wert im Ergebnis der Unterabfrage enthalten ist.
--ANY und SOME: Prüfen, ob irgendeine Ergebniszeile der Unterabfrage eine Vergleichsbedingung der Hauptabfrage erfüllt. Die Operatoren sind =, <, <=, >, 
--EXISTS: Prüft, ob mindestens eine Zeile der Unterabfrage eine Bedingung erfüllt.

-- ANY, SOME, ALL werten Theta-Operatoren genannt

--ALL: Prüft, ob alle Zeilen den Operator erfüllen. 

-- alle vorlesungen, die von 2125 oder 2137 (= 'Sokrates', 'Kant') gelesen werden
select titel from vorlesungen where gelesenvon in (select persnr from professoren where name in ('Sokrates', 'Kant'));

-- alle vorlesungen, die von 2125 oder 2137 (= 'Sokrates', 'Kant') gelesen werden
-- alle vorlesunge bei denen gelesen von = 2125 oder 2137 
select titel from vorlesungen where gelesenvon = any (select persnr from professoren where name = 'Sokrates');

-- fehler, da > Vergleich nicht mit einer Liste gemacht werden kann, nur bei einzelnen Werten
select titel from vorlesungen where gelesenvon > (select persnr from professoren where name in ('Sokrates', 'Kant'));

-- alle vorlesungen, die von einer persnr größer 2125 (oder 2137) gelesen werden
select titel from vorlesungen where gelesenvon > any (select persnr from professoren where name in ('Sokrates', 'Kant'));
select titel from vorlesungen where gelesenvon > any (select persnr from professoren where name in ('Sokrates', 'Russel'));

-- alle vorlesungen, die von einer persnr größer 2137 (und 2125) gelesen werden
select titel from vorlesungen where gelesenvon > all (select persnr from professoren where name in ('Sokrates', 'Kant'));
select titel from vorlesungen where gelesenvon > all (select persnr from professoren where name in ('Sokrates', 'Russel'));

--select * from studenten 
-- jonas
select * from studenten where matrnr = 25403;
select note from pruefen where matrnr = 25403;
select * from pruefen where note < all (select note from pruefen where matrnr = 25403);

-- in und not in
select * from professoren  where persnr in (2125, 2126);
select titel from vorlesungen where gelesenvon not in (2125, 2126);
select titel from vorlesungen where gelesenvon != all (select persnr from professoren where persnr in (2125, 2126));

-- Abfragen mit IN bisher unkorreliert
-- Abfragen mit IN können auch mit EXISTS ausgedrückt werden -> das sind korrelierte Abfragen

-- IN -> Unterabfrage liefert ein Attribut (pernr)
select titel from vorlesungen where gelesenvon in (select persnr from professoren where name in ('Sokrates', 'Kant'));

-- EXISTS -> prüft auf Existenz, dh. wird ein Tupel zurückgelierert oder NULL
select * from professoren where name in ('Sokrates', 'Kant');
-- prüfung auf persnr wird in die Unterabfrage gezogen
select * from vorlesungen;

-- 2125
select persnr from professoren where name = 'Sokrates';
-- Abfrage über PersNr
select titel from vorlesungen v where v.gelesenvon = 2125;
-- Abfrage mit IN
select titel from vorlesungen where gelesenvon = (select persnr from professoren where name in ('Sokrates'));
-- Fehler: Abfrage mit EXISTS ohne Korrelation
-- Exists evaluiert immer zu TRUE
select titel from vorlesungen v where exists (
  select * from professoren where name in ('Sokrates')
);
--select * from professoren where name in ('Sokrates') ;
-- Gibt es einen Prof. Sokrates (P) und ist die persnr von p = dem Wert von gelesen_von der aktuellen vorlesung  
select titel from vorlesungen v where exists (
  select * from professoren p where name in ('Sokrates') and v.gelesenvon = p.persnr 
);

-- 1) Selektiere ein Tupel aus Vorlesungen (tv1) 
-- 2) Selektiere alle Professoren, die 'Sokrates' oder 'Kant' heißen -> 2 Tupel und
-- 3) Selektiere daraus nur die tupel bei denen tv1.gelesenvon = persnr ist -> 1 oder 0 Tupel
-- 4) Wenn ein Resultat existiert, wird tv1 in die Ergebnisrelation aufgenommen
-- 5) Weiter mit Schritt 1, nächstes Tupel  

select titel from vorlesungen v where exists (
  select * from professoren p where p.name in ('Sokrates', 'Kant') and v.gelesenvon = p.persnr 
);

select * from assistenten;

-- Alle Professoren die einen Assistenten haben mit IN und EXISTS
select name from professoren p where p.persnr in (
  select boss from assistenten 
);

select name from professoren p where p.persnr not in (
  select boss from assistenten 
);

select * from professoren p;
select name from professoren p where exists (
  select * from assistenten a where a.boss = p.persnr 
);

select name from professoren p where not exists (
  select * from assistenten a where a.boss = p.persnr 
);

-- Profs ohne assistenten mit all
select name from professoren p where p.persnr != all (
  select a.boss from assistenten a
);

-- Profs mit assistenten mit any
select name from professoren p where p.persnr = any (
  select a.boss from assistenten a
);

-- todo: über git teilen

