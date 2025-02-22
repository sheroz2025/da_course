 /*
 Имя: Шероз
 Фамилия: Гуломалиев 
 Описание задачи: sql - запросы к таблице track из базы chinook
 */
 select 
 	 name ,
 	 genre_id 
 from track;
 
 select 
 	name as song ,
 	unit_price as price,
 	composer as author
 from track ;
 
 select 
 	name, (milliseconds / 60000.0) as duration_in_minutes 
 from track 
 order by duration_in_minutes desc ;
 
 select 
 	name , 
 	genre_id
 from track 
 limit 15 ; 
 
 select *
 from track 
 limit 100 
 offset 49 ;
 
 select 
 	name 
 from track 
 where bytes > (100* 1048576) ; 
 
 select 
 	name ,
 	composer 
 from track 
 where composer <> 'U2' 
 limit 11
 offset 9 ;
select 
sum(total)
, avg(total)
, min(total)
, max(total)
, count(total) 

from invoice ;

select 
	country 
	, state 
	, count as (customer_id) as customer_cnt
from customer 
group by 
	country 
	, state ;

