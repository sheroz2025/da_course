--1.1
select 
	e.employee_id
	, concat_ws(' ', e.first_name, e.last_name) as full_name
	, count(c.customer_id) as customer_cnt
from employee e
	left join customer c
		on e.employee_id = c.support_rep_id 
group by 
	e.employee_id
	, concat_ws(' ', e.first_name, e.last_name)
order by customer_cnt desc ;
	
--1.2
select 
	e.employee_id
	, concat_ws(' ', e.first_name, e.last_name) as full_name
	, count(c.customer_id) as customer_cnt
	, round ((count(c.customer_id)*100.0 / (
		select 
			count(*)
		from customer)), 2) as customer_percentage
from employee e
	left join customer c
		on e.employee_id = c.support_rep_id 
group by 
	e.employee_id
	, concat_ws(' ', e.first_name, e.last_name)
order by customer_cnt desc ;

--2.
select 
	a.title as album_name
	, ar.name as artist_name
from album a
	join artist ar
		on a.artist_id = ar.artist_id 
where a.album_id not in (
	select
		distinct t.album_id
	from track t
		join invoice_line il 
			on t.track_id = il.track_id) ;

--3
select 
	e.employee_id
	, concat_ws(' ', e.first_name, e.last_name) as full_name
from employee e
	left join employee m on e.employee_id = m.reports_to
where m.reports_to is null
;

--4. 
select
	distinct t.track_id
	, t.name as track_id
from track t
	join invoice_line il
		on t.track_id = il.track_id 
	join invoice i 
		on il.invoice_id = i.invoice_id 
	join customer c 
		on i.customer_id = c.customer_id 
where c.country = 'USA'
	and t.track_id in(
		select distinct t2.track_id
		from track t2
			join invoice_line il2
				on t2.track_id = il2.track_id 
			join invoice i2 
				on il2.invoice_id = i2.invoice_id 
			join customer c2 
				on i2.customer_id = c2.customer_id
				where c2.country = 'Canada') ;
--5
select
	distinct t.track_id
	, t.name as track_id
from track t
	join invoice_line il
		on t.track_id = il.track_id 
	join invoice i 
		on il.invoice_id = i.invoice_id 
	join customer c 
		on i.customer_id = c.customer_id 
where c.country = 'Canada'
	and t.track_id not in(
		select distinct t2.track_id
		from track t2
			join invoice_line il2
				on t2.track_id = il2.track_id 
			join invoice i2 
				on il2.invoice_id = i2.invoice_id 
			join customer c2 
				on i2.customer_id = c2.customer_id
				where c2.country = 'USA') ;


	



