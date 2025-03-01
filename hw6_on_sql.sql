select *
from customer ;

select *
from invoice ;

create table hw_invoice as
select 
	i.customer_id
	, concat_ws(' ', c.first_name, c.last_name) as full_name
	, extract(year from i.invoice_date) * 100 +extract(month from i.invoice_date) as monthkey
	, sum(i.total) as total
	from invoice i
	inner join customer c 
		on i.invoice_id = c.customer_id
group by 
	i.customer_id
	, concat_ws(' ', c.first_name, c.last_name)
	, monthkey 
order by i.customer_id ;

--1.2; 1.3; 1.4; 1.5
select 
	hwi. *
	, round(total * 100 / sum(total) over (partition by monthkey), 2) as monthly_sales_percent
	, sum(total) over (
		partition by customer_id, round(monthkey/100) 
		order by monthkey)
		as running_total 
	, round(avg(total) over ( 
		partition by customer_id
		order by monthkey rows between 2 preceding and current row), 2) as moving_avg
	, lag(total) over ( 
		partition by customer_id order by monthkey) as prev_period
	, (total -lag(total) over ( 
		partition by customer_id order by monthkey)) as period_diff
from hw_invoice hwi ;

--2
with album_sales as (
    select 
        extract(year from i.invoice_date) as year,
        a.title as album_title,
        ar.name as artist_name,
        count(il.track_id) as tracks_sold
    from invoice i
    inner join  invoice_line il on i.invoice_id = il.invoice_id
    inner join  track t on il.track_id = t.track_id
    inner join  album a on t.album_id = a.album_id
    inner join  artist ar on a.artist_id = ar.artist_id
    group by year, album_title, artist_name
),
ranked_albums as (
    select 
        year,
        album_title,
        artist_name,
        tracks_sold,
        rank() over (partition by year order by tracks_sold desc) as rnk
    from album_sales
)
select 
    year, album_title, artist_name, tracks_sold
from ranked_albums
where rnk <= 3;


--3.1
select 
	e.employee_id 
	, concat_ws(' ', e.first_name, e.last_name) as full_name
	, count(c.customer_id) as client_cnt
from employee e
	left join customer c 
		on e.employee_id = c.support_rep_id
group by 
	e.employee_id
	, full_name;

--3.2
select 
	e.employee_id 
	, concat_ws(' ', e.first_name, e.last_name) as full_name
	, count(c.customer_id) as client_cnt
	, round(count(c.customer_id)*100 / (
		select count(*)
		from customer),2) as percentage_clients
from employee e
	left join customer c 
		on e.employee_id = c.support_rep_id
group by 
	e.employee_id
	, full_name
order by 
	client_cnt desc
;


--4.
select 
	c.customer_id 
	, concat_ws(' ', c.first_name, c.last_name) as full_name
	, min(i.invoice_date) as first_purchase_date
	, max(i.invoice_date) as last_purchase_date
	, extract(year from max(i.invoice_date)) -extract(year from min(i.invoice_date)) as years
from customer c
	inner join invoice i  
		on c.customer_id = i.customer_id
group by 
	c.customer_id
	, full_name
order by years ;

