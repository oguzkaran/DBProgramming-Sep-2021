/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıdaki tablolara göre yine aşağıdaki soruları yanıtlayınız
	Veritabanı ismi tennisclubappdb. Tablolar:
	- court_status
		- curt_status_id
		- description (Reserved, Available, Not Available)

	- court_types
		- curt_type_id
		- description (Open, Closed, OpenOrClosed)

	- courts 
		- court_id
		- name
		- court_status_id
		- court_type_id

	Sorular: 
		- Tüm kortların bilgilerini detaylı olarak getiren sorguyu yazınız
		- Tüm kortların bilgilerini detaylı olarak Türkçe karşılıkları ile getiren sorguyu yazınız	
----------------------------------------------------------------------------------------------------------------------*/
create database tennisclubappdb

go

use tennisclubappdb

go

create table court_status (
	court_status_id int primary key identity(1, 1),
	description nvarchar(32) not null
)

go

insert into court_status (description) 
values
('Reserved'),
('Available'),
('Not Available')

go

create table court_types (
	court_type_id int primary key identity(1, 1),
	description nvarchar(32) not null
)

go

insert into court_types (description) 
values
('Open'),
('Closed'),
('OpenOrClosed')

go

create table courts (
	court_id int primary key identity(1, 1),
	name nvarchar(100) not null,
	court_status_id int references court_status(court_status_id),
	court_type_id int references court_types(court_type_id),
)

go

-- Tüm kortların bilgilerini detaylı olarak getiren sorguyu yazınız

select 
	c.name, cs.description, ct.description
from 
court_status cs inner join courts c on cs.court_status_id = c.court_status_id
inner join court_types ct on ct.court_type_id = c.court_type_id

-- Tüm kortların bilgilerini detaylı olarak Türkçe karşılıkları ile getiren sorguyu yazınız	

select 
c.name,
case c.court_type_id
	when 1 then 'Açık'
	when 2 then 'Kapalı'
	else 'Açık veya Kapalı'
end,
case c.court_status_id
	when 1 then 'Rezerve Edilmiş'
	when 2 then 'Müsait'
	else 'Müsait değil'
end
from courts c


