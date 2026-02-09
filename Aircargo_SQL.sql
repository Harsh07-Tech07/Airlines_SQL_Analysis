-- Confirm correct database and table exist
create database aircargo ;
show databases ;
use aircargo ;

-- Check row count in each table
select count(*) from customer ;
select count(*) from passengers_on_flights ;
select count(*) from routes ;
select count(*) from ticket_details ;

describe customer ;

-- Modifying the data structure of loaded file

-- For customer table
alter table customer
modify customer_id int not null auto_increment primary key,
modify first_name varchar(20) not null,
modify last_name varchar(20) not null,
modify date_of_birth date not null,
modify gender char(1) not null ;

-- For passengers_on_flights table
alter table passengers_on_flights
add column pof_id int auto_increment primary key,
modify customer_id int not null,
modify aircraft_id varchar(10) not null,
modify route_id int not null,
modify depart char(3) not null,
modify arrival char(3) not null,
modify seat_num char(4) not null,
modify class_id varchar(15) not null,
modify travel_date date not null,
modify flight_num int not null,
add constraint fk_pof foreign key (customer_id) references customer(customer_id) ;

alter table passengers_on_flights
add constraint fk_passengers_route foreign key (route_id) references routes(route_id) ;

describe passengers_on_flights ;

-- For routes table
alter table routes
modify route_id int not null unique primary key,
modify flight_num int constraint chk_1 check (flight_num is not null),
modify origin_airport char(3) not null,
modify destination_airport char(3) not null,
modify aircraft_id varchar(10) not null,
modify distance_miles int not null constraint check_2 check (distance_miles > 0) ;

describe routes ;

-- For ticket_details table
alter table ticket_details
add column tkt_id int auto_increment primary key,
modify p_date date not null,
modify customer_id int not null,
modify aircraft_id varchar(10) not null,
modify class_id varchar(15) not null,
modify no_of_tickets int not null,
modify a_code char(3) not null,
modify Price_per_ticket decimal(5,2) not null,
modify brand varchar(30) not null,
add constraint fk_tkt_dts foreign key (customer_id) references customer(customer_id) ;

describe ticket_details ;

# Part 1 (core business KPIs)
-- Revenue,Tickets, Demand, Pricing

-- Total revenue
select
	sum(no_of_tickets *Price_per_ticket) as total_revenue
from ticket_details ;

-- Total tickets sold
select 
	sum(no_of_tickets) as total_tickets_sold
from ticket_details ;

-- Average ticket price
select 
	round(avg(Price_per_ticket), 2) as avg_ticket_price
from ticket_details ;

-- Total passenger trips
select 
	count(*) as total_passenger_trips
from passengers_on_flights ;

-- Avg tickets per booking 
select 
	round(avg(no_of_tickets), 2) as avg_tickets_per_booking
from ticket_details ;

# Part 2 (Customer analysis)

-- Customers (gender split)
select gender,
	count(*) as total_customers
from customer 
group by gender ;

-- Age distribution of ustomers
select 
	floor(datediff(curdate(), date_of_birth)/365) as age,
    count(*) as total_customers
from customer 
group by age 
order by age ;

-- Flights taken per customer (frequency)
select customer_id,
	count(*) as total_flights
from passengers_on_flights
group by customer_id
order by total_flights desc ;

-- Top frequent flyers(top 5)
select customer_id,
	count(*) as total_flights
from passengers_on_flights
group by customer_id
order by total_flights desc
limit 5 ;

-- Revenue per customer
select c.customer_id,
	concat(c.first_name,' ',c.last_name) as full_name,
    sum(t.no_of_tickets * t.Price_per_ticket) as total_revenue
from customer c
join ticket_details t
on c.customer_id = t.customer_id
group by c.customer_id,full_name
order by total_revenue desc ;
    
-- Frequency vs Revenue
select p.customer_id,
    count(p.pof_id) as total_flights,
    sum(t.no_of_tickets * t.Price_per_ticket) as total_revenue
from passengers_on_flights p
join ticket_details t
on p.customer_id = t.customer_id 
group by p.customer_id
order by total_revenue desc ;

# Part 3 (Class & Pricing analysis)

select * from ticket_details ;

-- Tickets sold by class
select class_id,
	sum(no_of_tickets) as total_tickets_sold
from ticket_details
group by class_id
order by total_tickets_sold desc ;

-- Revenue by class
select class_id,
	sum(no_of_tickets * Price_per_ticket) as total_revenue
from ticket_details
group by class_id
order by total_revenue desc ;

-- Average ticket price per class
select class_id,
	round(avg(Price_per_ticket), 2) as avg_ticket_price
from ticket_details
group by class_id ;

-- revenue contribution % by class
select class_id,
	round(sum(no_of_tickets * Price_per_ticket) * 100 /
    (select sum(no_of_tickets * Price_per_ticket) from ticket_details), 2
    ) as revenue_percentage
from ticket_details
group by class_id
order by revenue_percentage desc ;

-- Brand wise pricing check
select brand, class_id,
	round(avg(Price_per_ticket), 2) as avg_price
from ticket_details 
group by brand, class_id
order by avg_price desc ;

# Part 5 (Route & Flight analysis)

select * from routes ;
select * from ticket_details ;

-- Passenger demand by route
select route_id,
	count(*) as total_passenger_trips
from passengers_on_flights 
group by route_id ;

-- Top 5 most traveled routes 
select 
	r.route_id, r.origin_airport, r.destination_airport,
    count(p.pof_id) as total_passenger_trips
from routes r
join passengers_on_flights p
on r.route_id = p.route_id
group by r.route_id, r.origin_airport, r.destination_airport
order by total_passenger_trips desc 
limit 5 ;

-- Longest routes
select 
	route_id, origin_airport, destination_airport, distance_miles
from routes
order by distance_miles desc
limit 5 ;

-- Route categorization (short/medium/long)
select 
	case 
		when distance_miles < 1000 then 'Short distance'
        when distance_miles between 1000 and 3000 then 'Medium distance'
        else 'Long distance'
	end as route_types,
    count(*) as total_routes
from routes 
group by route_types ;

-- Passenger demand by route type
select 
	case 
		when r.distance_miles < 1000 then 'Short distance'
        when r.distance_miles between 1000 and 3000 then 'Medium distance'
        else 'Long distance'
	end as route_types,
    count(p.pof_id) as passrnger_trips
from routes r 
join passengers_on_flights p 
on r.route_id = p.route_id
group by route_types
order by passrnger_trips desc ;

# Part 6 (Which routes and customers actually make money)

select 
	p.route_id,
    r.origin_airport,
    r.destination_airport,
    sum(t.no_of_tickets * t.Price_per_ticket) as route_revenue
from passengers_on_flights p 
join ticket_details t 
on p.customer_id = t.customer_id
join routes r 
on p.route_id = r.route_id
group by p.route_id, r.origin_airport, r.destination_airport
order by route_revenue desc ;

-- High demand but low revenue routes
select 
	p.route_id,
    count(p.pof_id) as passenger_trips,
    sum(t.no_of_tickets * t.Price_per_ticket) as total_revenue
from passengers_on_flights p 
join ticket_details t
on p.customer_id = t.customer_id
group by p.route_id 
order by passenger_trips desc, total_revenue asc ;

-- Customer class preference
select 
	c.customer_id,
    concat(c.first_name,' ', c.last_name) as full_name,
    t.class_id,
    count(*) as bookings
from customer c 
join ticket_details t 
on c.customer_id = t.customer_id
group by c.customer_id, full_name, t.class_id
order by bookings desc ;

-- Revenue contribution by customer & class 
select 
	c.customer_id, t.class_id,
	sum(t.no_of_tickets * t.Price_per_ticket) as revenue
from customer c 
join ticket_details t 
on c.customer_id = t.customer_id 
group by c.customer_id, t.class_id 
order by revenue desc ;

-- Long distance route revenue performance
select 
	r.route_id, r.origin_airport, r.destination_airport, r.distance_miles,
	sum(t.no_of_tickets * t.Price_per_ticket) as total_revenue
from routes r 
join passengers_on_flights p 
on r.route_id = p.route_id 
join ticket_details t 
on p.customer_id = t.customer_id 
where r.distance_miles > 3000 
group by r.route_id, r.origin_airport, r.destination_airport, r.distance_miles 
order by total_revenue desc ;























