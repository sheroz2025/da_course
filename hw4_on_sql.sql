select *
from employee ;
 
-- 1. 
select 
	employee_id 
	, first_name || ' ' || last_name as full_name
	, title
	, reports_to as manager_id
	, (select 
		first_name || ' ' || last_name || ', ' || title 
	from employee 
	where emplyee_id = reports_to) as manafer_info
from employee ;

-- 2.
select 
	invoice_id
	, invoice_date
	, extract (year from invoice_date)*100 +extract (month from invoice_date) as monthkey
	, customer_id
	, total
from invoice 
where total>
	(select avg(total)
	from invoice
	where extract (year from invoice_date) = 2023)
	and extract (year from invoice_date) = 2023;

--3.
select 
	invoice_id
	, invoice_date
	, extract (year from invoice_date)*100 +extract (month from invoice_date) as monthkey
	, customer_id
	, (select email 
		from customer 
		where customer.customer_id = invoice.customer_id) AS email
	, total
from invoice 
where total>
	(select avg(total)
	from invoice
	where extract (year from invoice_date) = 2023)
	and extract (year from invoice_date) = 2023;

--4.
select *
from (
	select 
	invoice_id
	, invoice_date
	, extract (year from invoice_date)*100 +extract (month from invoice_date) as monthkey
	, customer_id
	, (select email 
		from customer 
		where customer.customer_id = invoice.customer_id) AS email
	, total
from invoice 
where total>
	(select avg(total)
	from invoice
	where extract (year from invoice_date) = 2023)
	and extract (year from invoice_date) = 2023) as without_gmail
where email not like '%@gmail.com';
 

--5.
select 
	total 
	, (total /(
	select sum(total)
	from invoice
	where extract (year from invoice_date)= 2024)* 100) as percent_of_total
from invoice 
where extract (year from invoice_date)= 2024;

--6.
select 
	customer_id 
	, sum(total) as total_spend
	, (sum(total) /(
	select sum(total)
	from invoice
	where extract (year from invoice_date)= 2024)* 100) as percent_of_total
from invoice 
where extract (year from invoice_date)= 2024
group by customer_id;

