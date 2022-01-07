/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıda açıklanan bankappdb veritabanını ve ilgili sorulara ilişkin kodları yazınız
	bankappdb veritabanının tabloları:
	- nationalities
		- id
		- description ('TC', 'US', ...)
	- customers
		- id
		- citizen_id
		- nationality_id
		- number
		- first_name
		- middle_name
		- family_name
		- email
		- is_alive
		- is_active
		- is_personnel
		- is_local
	- phone_types
		- id
		- description (GSM, Home, Work, Urgent...)
	- phones
		- id
		- customer_id
		- phone_type_id
		- phone
	- addresses
		- id
		- customer_id
		- description
	- card_types
		- id
		- description (Visa, Maestro, Master, ...)
	- cards
		- id
		- customer_id
		- number
		- expiry_date_month
		- expiry_date_year
		- cvv
		- card_type_id
		
	Sorular:
	1. Parametresi ile aldığı müşteri numarasına göre müşterinin aşağıdaki bilgilerini tablo biçiminde döndüren 
	get_card_info_by_customer_number fonksiyonunu yazınız
		1. Adı Soyadı
		2. Kart numarası: ilk 4(dört) hanesi gözücek şekilde. Geri kalanlar X olarak
		3. cvv: İlk karakteri gözükecek şekilde. Geri kalanlar * olarak
		4. Kart türünün yazısal karşılığı
		5. Kartın son kullanma tarihi bilgisi: aa/yyyy
		6. Kart sahibinin personel olup olmadığı bilgisi
		7. Kartın sahibinin yaşayıp yaşamadığı bilgisi

	2. Parametresi ile aldığı kart tür id'sine göre aktif olan ve yurt dışında ikamet eden müşterilerin aşağıdaki bilgilerini tablo
	biçiminde döndüren get_nonlocal_customer_info_by_card_type fonksiyonunu yazınız:
		1. Adı Soyadı
		2. Kart numarası: ilk 4(dört) hanesi gözücek şekilde. Geri kalanlar X olarak
		3. cvv: İlk karakteri gözükecek şekilde. Geri kalanlar * olarak
		4. Kart türünün yazısal karşılığı
		5. Kartın son kullanma tarihi bilgisi: aa/yyyy
		6. Kart sahibinin personel olup olmadığı bilgisi
		7. Kartın sahibinin yaşayıp yaşamadığı bilgisi
		8. Müşterini uyruğu
----------------------------------------------------------------------------------------------------------------------*/
create database bankappdb

go


use bankappdb

go

create table nationalities (
	nationality_id int primary key identity(1, 1),
	description nvarchar(20) not null
)

go


insert into nationalities (description) 
values 
('TC'),
('US'),
('UK')


go

create table customers (
	customer_id int primary key identity(1, 1),
	citizen_id char(20) unique not null,
	nationality_id int foreign key references nationalities(nationality_id) not null,
	number char(40) unique not null,
	first_name nvarchar(100) not null,
	middle_name nvarchar(100),
	family_name nvarchar(100) not null,
	email nvarchar(100) not null,
	is_alive bit not null,
	is_active bit not null,
	is_personnel bit not null,
	is_local bit not null
)

go

create table phone_types (
	phone_type_id int primary key identity(1, 1),
	description nvarchar(20) not null
)

go

insert into phone_types (description)
values
('GSM'), ('Home'), ('Work'), ('Urgent')

go

create table phones (
	phone_id int primary key identity(1, 1),
	customer_id int foreign key references customers(customer_id) not null,
	phone_type_id int foreign key references phone_types(phone_type_id) not null,
	phone varchar(14) not null
)

go

create table addresses (
	address_id int primary key identity(1, 1),
	customer_id int foreign key references customers(customer_id) not null,
	description nvarchar(max) not null
)

go

create table card_types (
	card_type_id int primary key identity(1, 1),
	description nvarchar(20) not null
)		

go

insert into card_types 
values
('Visa'), ('Maestro'), ('Master')
		

go

create table cards (
	card_id int primary key identity(1, 1),
	customer_id int foreign key references customers(customer_id) not null,
	number char(20) not null,
	expiry_date_month int check(1 <= expiry_date_month and expiry_date_month <= 12) not null,
	expiry_date_year int not null,
	cvv char(3) not null,
	card_type_id int foreign key references card_types(card_type_id) not null,
)

go

create function hide_text_right(@text nvarchar(max), @ch nchar(1), @n int)
returns nvarchar(max)
as
begin
	return LEFT(@text, @n) + REPLICATE(@ch, LEN(@text) - @n)
end

go

create function get_full_name(@first_name nvarchar(100), @middle_name nvarchar(100), @family_name nvarchar(100))
returns nvarchar(MAX)
as
begin
	return case 
			when @middle_name is not null then @first_name + ' ' + @middle_name 
			else @first_name
			end + ' ' + @family_name
end


go

create function get_status(@predicate bit, @true_str nvarchar(50), @false_str nvarchar(50))
returns nvarchar(50)
as
begin 
	return case @predicate
			when 1 then @true_str
			else @false_str
			end
end

go

-- 1
create function get_card_info_by_customer_number(@number char(40)) 
returns table
as
return (
	select 
	dbo.get_full_name(cu.first_name, cu.middle_name, cu.family_name) as fullname,
	dbo.hide_text_right(ca.number, 'X', 4) as card_number,
	dbo.hide_text_right(ca.cvv, '*', 1) cvv,
	ct.description as card_type,
	dbo.get_status(cu.is_personnel, 'PERSONEL', 'PERSONEL DEĞİL') as personnel_status,
	dbo.get_status(cu.is_alive, 'SAĞ', 'ÖLÜ') as alive_status
	from 
	customers cu inner join cards ca on cu.customer_id = ca.customer_id
	inner join card_types ct on ca.card_type_id = ct.card_type_id
	where cu.number = @number
)

go

