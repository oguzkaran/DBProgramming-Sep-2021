/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Basit bir çoktan seçmeliyarışmaya ilişkin aşağıdaki veritabanının oluşturunuz. Tüm soruların
	değişken sayıda seçenekleri olacaktır

	levels
		- level_id
		- description
	questions:
		- question_id
		- description
		- level_id
		- answer_index
	options:
		- option_id
		- description
		- question_id
	Buna göre:
	1. Her çalıştırıldığında herhangi bir seviyeden rasgele bir soru getiren sorguyu yazınız
	2. TODO: Parametresi ile aldığı level_id bilgisine göre rasgele bir soru getiren sorguya ilişkin fonksiyonu yazınız
----------------------------------------------------------------------------------------------------------------------*/
create database competitionappdb

go

use competitionappdb

go

create table levels (
	level_id int primary key identity(1, 1),
	description nvarchar(32) not null
)

go

insert into levels (description) values ('Başlangıç'), ('Orta'), ('İleri')

go

create table questions (
	question_id int primary key identity(1, 1),
	description nvarchar(MAX) not null,
	level_id int foreign key references levels(level_id) not null,
	answer_index int not null
)

go

create table options (
	option_id int primary key identity(1, 1),
	description nvarchar(32) not null,
	question_id int foreign key references questions(question_id) not null
)

go


create view v_get_random
as
select rand() as random

go

create function random_int(@min int, @max int) --[min, max)
returns int
begin
	declare @random float
	set @random = (select random from v_get_random)
	return floor(@random * (@max - @min) + @min)
end


go

-- 1. 
create function get_random_question()
returns int
as
begin
	declare @result int = 0
	declare @question_id int = 0
	declare crs_questions cursor scroll for select question_id from questions
	open crs_questions

	declare @max int = (select COUNT(*) from questions) + 1
	declare @min int = 1
	declare @index int = dbo.random_int(@min, @max)

	fetch absolute @index from crs_questions into @question_id

	if @@FETCH_STATUS = 0
		set @result = @question_id

	close crs_questions
	deallocate crs_questions

	return @result
end


go

create function get_question_details_by_id(@question_id int)
returns table
as
return (
	select q.description
	from 
	questions q inner join options o on q.question_id = o.question_id where q.question_id = @question_id
)





