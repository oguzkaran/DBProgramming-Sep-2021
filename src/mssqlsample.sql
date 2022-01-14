/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıda belirtilen people, people_younger ve people_older isimli tablolara göre soruları 
	yanıtlayınız

	- people
		citizen_id p.k.
		name
		surname
		birth_date
		address

	- people_younger
		citizen_id p.k.
		name
		surname
		birth_date
		address
	- people_older
		citizen_id p.k.
		name
		surname
		birth_date
		address
	Sorular:
		- Paremetresi ile aldığı person bilgilerine göre, yine parametresi iki tane yaş bilgisinden harektle birinci 
		yaş bilgisinden küçük olan kişileri people_younger, birinci ve ikinci yaş bilgisi arasındaki kişileri people
		tablosuna, ikinci yaş bilgisinden büyük olan kişileri ise people_older tablosuna ekleyen stored procedure'ü 
		yazınız. 	
----------------------------------------------------------------------------------------------------------------------*/

create table people (
	citizen_id char(11) primary key,
	name nvarchar(100) not null,
	surname nvarchar(100) not null,
	birth_date date not null,
	address nvarchar(max) not null
)

go

create table people_younger (
	citizen_id char(11) primary key,
	name nvarchar(100) not null,
	surname nvarchar(100) not null,
	birth_date date not null,
	address nvarchar(max) not null
)

go

create table people_older (
	citizen_id char(11) primary key,
	name nvarchar(100) not null,
	surname nvarchar(100) not null,
	birth_date date not null,
	address nvarchar(max) not null
)

go

create procedure sp_insert_person(@citizen_id char(11), @name nvarchar(100), @surname nvarchar(100), @birth_date date, @address nvarchar(max), @min_age real, @max_age real)
as
begin
	declare @age real = DATEDIFF(DAY, @birth_date, GETDATE()) / 365.

	if @age < @min_age
		insert into people_younger (citizen_id, name, surname, birth_date, address) values (@citizen_id, @name, @surname, @birth_date, @address)
	else if @age < @max_age
		insert into people (citizen_id, name, surname, birth_date, address) values (@citizen_id, @name, @surname, @birth_date, @address)
	else
		insert into people_older (citizen_id, name, surname, birth_date, address) values (@citizen_id, @name, @surname, @birth_date, @address)
end

go

exec sp_insert_person '12345678912', 'Oğuz', 'Karan', '1976-09-10', 'Riva', 18, 65

exec sp_insert_person '12345678912', 'Oğuz', 'Karan', '1976-09-10', 'Riva', 18, 65