select *
from invoice ;
--1
select 
	min(invoice_date) as first_purchase
	, max(invoice_date) as last_purchase
from invoice ;
--2
select 
	avg(total) as avg_check
from invoice 
where billing_country = 'USA' ;

--3
select 
	billing_city
from invoice 
group by billing_city 
having count(customer_id)>1;

select *
from customer ;
--4
select phone
from customer 
where phone not like '%(%' and phone  not like '%)%' ;
--5
select 
	initcap ('loren')|| ' '|| lower('ipsum'); 

select *
from track;
--6
select name
from track
where name like '%run%' ; 
--7
select 
	email
from customer 
where email like '%gmail%'
 ;
--8
select 
	name 
from track 
order by length(name) desc
limit 1 ; 

--9
select 
	extract ('month' from invoice_date) as month_id
	, sum(total) as sales_sum
from invoice 
where extract('year'from invoice_date)= 2021
group by month_id
order by month_id
;

--10
select 
	extract ('month' from invoice_date) as month_id
	, to_char (invoice_date, 'month') as month_name 
	, sum(total) as sales_sum
from invoice 
where extract('year'from invoice_date)= 2021
group by month_id, month_name
order by month_id
;

select *
from employee ; 

--11
select 
	first_name || ' '|| last_name as full_name
	, birth_date
	, extract('year' from age(current_date,birth_date))as age_now
from employee
order by birth_date
limit 3;
	
--12
SELECT 
	avg(extract(year from age((current_date + interval '3 years 4 month'), birth_date))) as avg_age_employee_infiture 
from employee ;

--13
select 
	extract(year from invoice_date) as sales_year
	, billing_country 
	, sum(total) as sales_sum
from invoice
group by sales_year, billing_country
having sum(total)> 20
order by sales_year, sales_sum desc ;


