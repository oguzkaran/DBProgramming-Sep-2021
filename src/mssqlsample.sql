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
create function get_full_text(@s1 nvarchar(max), @s2 nvarchar(max), @s3 nvarchar(max))
returns nvarchar(max)
as
begin
	declare @full_text nvarchar(max) = ''

	if @s1 is not null
		set @full_text = @s1

	if @s2 is not null
	begin
		if @full_text <> ''
			set @full_text = @full_text + ' '
		
		set @full_text = @full_text + @s2
	end

	if @s3 is not null
	begin
		if @full_text <> ''
			set @full_text = @full_text + ' '
		
		set @full_text = @full_text + @s3
	end		


	return @full_text
end

go


create function get_marital_status_text_tr(@status int)
returns nvarchar(8)
as
begin
	return  case @status
		when 0 then 'evli'
		when 1 then 'bekar'
		when 2 then 'boşanmış'
		else 'belirsiz'
		end	
end



go

create table people (
	person_id int identity(1, 1) primary key,
	citizen_id char(11) not null,
	first_name nvarchar(100) not null,
	middle_name nvarchar(100),
	family_name nvarchar(100) not null,
	marital_status int not null
)

go

create function get_person_by_id(@person_id int)
returns table
as
return (
	select citizen_id, 
	dbo.get_full_text(first_name, middle_name, family_name) as fullname,
	dbo.get_marital_status_text_tr(marital_status) as marital_status
	from people where person_id = @person_id
)

go


select * from get_person_by_id(1015)
