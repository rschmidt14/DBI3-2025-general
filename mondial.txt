-- alle flughäfen in AT
-- sigma country='A' (airport)
select * from airport where country = 'A';
-- name und code aller flughäfen in AT
-- π name, iatacode ( σ country = 'A' (airport) )
select name, iatacode from airport where country = 'A';

