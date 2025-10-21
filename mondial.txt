-- alle flughäfen in AT
-- sigma country='A' (airport)
select * from airport where country = 'A';
-- name und code aller flughäfen in AT
-- π name, iatacode ( σ country = 'A' (airport) )
select name, iatacode from airport where country = 'A';

-- mondial
-- die namen und flächen aller flüsse  (die länger als 300 km) und seen (die größer als 2000 km²) sind
-- in sql und rel. algebra als hü bis zum nächsten mal

select name, area from lake ;
