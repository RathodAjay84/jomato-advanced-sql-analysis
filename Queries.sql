create database Assignment3

use Assignment3

create table jomato
(
OrderId int, 
RestaurantName varchar(255), 
RestaurantType varchar(255), 
Rating float,
No_of_Rating int, 
AverageCost int,
Onlineorder varchar(255), 
TableBooking varchar(255), 
CuisinesType varchar(255), 
Area varchar(255), 
LocalAddress varchar(255), 
DeliveryTime int
)

select * from jomato

bulk insert dbo.jomato
from 'C:\Users\user\OneDrive\Attachments\jomato.csv'
with
(
format = 'csv',
firstrow = 2
)

select * from jomato 

create procedure GetRestaurantWithBooking
as
begin
select restaurantname, restauranttype, cuisinestype 
from jomato 
where TableBooking <> '0'
end

exec GetRestaurantWithBooking

select * from jomato

begin transaction

update jomato 
set cuisinestype = 'Cafeteria' 
where lower(cuisinestype) = 'cafe'

select * from jomato
where cuisinestype in ('Cafe','Cafeteria')

rollback transaction

select * from jomato

with rankedareas as (
    select area, rating, 
    row_number() over (order by rating desc) as RowNumber 
    from jomato
)
select top(5) area, rating, RowNumber 
from rankedareas 
order by rating desc

select * from jomato

declare @i int
set @i = 1

while (@i <= 50)
begin
print cast(@i as varchar(10))
set @i = @i + 1 
end

select * from jomato

create view top5_rating as 
select top(5) restaurantname, rating, area 
from jomato 
order by rating desc

select * from top5_rating

-- trigger
create trigger trg_InsertMessage
on jomato
after insert
as
begin
print 'New record inserted successfully!'
end

--THE END--