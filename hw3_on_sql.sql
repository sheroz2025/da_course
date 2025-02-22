--1. Creating new schema 'store'
create schema if not exists store ;
set search_path to store ;
select current_schema ;

--2 creating new table 'customers'
create table if not exists customers(
	customer_id serial
	, customer_name varcshar(50) not null
	, email varchar(260)
	, address text
	, primary key (customer_id)
	);

--3 filling the table customers
insert into store.customers (customer_name, email, address)
select 
	first_name || ' '|| last_name as customer_name
	, email
	, country || ' ' || state || ' ' || city || ' ' || address as address
from public.customer ;

--4 creating a new table 'products'
create table if not exists products (
	product_id serial
	, product_name varchar(100) not null
	, price numeric not null 
	, primary key (product_id)) ;

--5 fillint the table 'products'
insert into store.products(product_name, price)
values
	('Ноутбук Lenovo Thinkpad', 12000)
	, ('Мышь для компьютера, беспроводная', 90)
	, ('Подставка для ноутбука', 300)
	, ('Шнур электрический для ПК', 160);

select *
from products;

--6 creating a new table 'sales'
create table if not exists sales(
	sale_id serial
	, sale_timestamp timestamp default current_timestamp not null
	, customer_id int not null
	, product_id int not null 
	, quantity int default 1 not null
	, primary key (sale_id)
	, foreign key (customer_id) references store.customers(customer_id)
	, foreign key (product_id) references store.products(product_id) );

--7 fillig the table 'sales'
insert into sales(customer_id, product_id, quantity)
values 
	(3, 4, 1)
	, (56, 2, 3)
	, (11, 2, 1)
	, (31, 2, 1)
	, (24, 2, 3)
	, (27, 2, 1)
	, (37, 3, 2)
	, (35, 1, 2)
	, (21, 1, 2)
	, (31, 2, 2)
	, (15, 1, 1)
	, (29, 2, 1)
	, (12, 2, 1);

--8 adding new column to table sales
alter table sales add column discount numeric default 0;

update sales 
set discount = 0.2
where product_id = 1; 


--9 creating v_usa_customers
create view v_usa_customers as
select *
from customers 
where address like 'USA%'; 

