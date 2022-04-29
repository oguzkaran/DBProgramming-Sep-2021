/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıdaki tabloları schooldb veritabanında oluşturunuz
	- students
		- student_id
		- citizen_number
		- first_name
		- middle_name
		- last_name
		- birth_date
		- address
	 - lectures
		- lecture_code char(7) primary key
		- name
		- credits
	- grades
		- grade_id
		- description
		- value
	- enrolls
		- enroll_id
		- student_id
		- lecture_code
		- grade_id

	Harf notları aşağıdaki gibi olabilir:
	AA	-> 4.0
	BA	-> 3.5
	BB	-> 3.0
	CB	-> 2.5
	CC	-> 2.0
	DC	-> 1.5
	DD	-> 1.0
	FD	-> 0.5
	FF	-> 0.0
	NA	-> -1
	P	-> -1
	Bu bilgilere göre 
	- MAT 101 dersi için öğrencilerin sayısını notlara göre gruplayarak getiren sorgu
	- Kredi toplamları 100'den büyük olan öğrencilerin bilgilerini getiren sorgu
	- Her bir dersi alan öğrencilerin sayısını veren sorgu
	- Dersi 3'den fazla kez alan öğrencilerin kayıt olduğu dersleri gruplayan sorgu
	- Dersi 3'den fazla kez alan öğrencinin kayıt olduğu derslerin not ortalamasını getiren sorgu

	Aşağıdaki örnekte function, procedure view'ler için yetki verildiğine dikkat ediniz. Bu durumda umut isimli login
	tablolara erişemez ancak yetki verilen function, procedure ve view'lar işlem yapabilir. Örneği inceleyiniz
----------------------------------------------------------------------------------------------------------------------*/

create database dbprogs21_schooldb;

go

use dbprogs21_schooldb;

go

create table students(
	student_id int primary key identity(1, 1),
	citizen_number char(30) not null,
	first_name nvarchar(100) not null,
	middle_name nvarchar(100),
	last_name nvarchar(100) not null,
	birth_date date not null,
	address nvarchar(max) not null
)

go

create table lectures(
	lecture_code char(7) primary key,
	name nvarchar(100) not null,
	credits int not null
)

go

create table grades (
	grade_id int primary key identity(1, 1),
	description char(2) not null,
	value real not null
)


go

insert into grades (description, value) 
values
('AA', 4.0),
('BA', 3.5),
('BB', 3.0),
('CB', 2.5),
('CC', 2.0),
('DC', 1.5),
('DD', 1.0),
('FD', 0.5),
('FF', 0.0),
('NA', -1),
('P', -1)

go

create table enrolls (
	enroll_id int primary key identity(1, 1),
	student_id int foreign key references students(student_id) not null,
	lecture_code char(7) foreign key references lectures(lecture_code) not null,
	grade_id int foreign key references grades(grade_id) not null,
) 


go

create procedure sp_insert_lecture(@lecture_code char(7), @name nvarchar(100), @credits int)
as
begin
	if @credits > 0
		insert into lectures (lecture_code, name, credits) values (@lecture_code, @name, @credits)
end

go

-- MAT 101 dersi için öğrencilerin sayısını notlara göre gruplayarak getiren sorgu

create function get_students_grade_count_by_lecture_code(@lecture_code char(7))
returns table
as
return (
	select g.description, count(*) as count from enrolls e inner join grades g on g.grade_id=e.grade_id
	where e.lecture_code = @lecture_code group by g.description
)


go

-- Kredi toplamları 100'den büyük olan öğrencilerin bilgilerini getiren sorgu
-- TODO: write function and give permission to umut
select s.citizen_number, sum(lec.credits), s.first_name + ' ' + s.last_name 
from lectures lec inner join enrolls e on e.lecture_code = lec.lecture_code
inner join students s on e.student_id = s.student_id where e.grade_id <= 5
group by s.citizen_number, s.first_name + ' ' + s.last_name having sum(lec.credits) > 100

go

-- Her bir dersi alan öğrencilerin sayısını veren sorgu
create view v_students_group_by_lecture
as
select lec.lecture_code, lec.name, count(*) as count
from lectures lec inner join enrolls e on e.lecture_code = lec.lecture_code
group by lec.lecture_code, lec.name



go
-- Dersi 3'den fazla kez alan öğrencilerin kayıt olduğu dersleri gruplayan sorgu
-- TODO: write function and give permission to umut
select lec.lecture_code, lec.name, count(*) 
from lectures lec inner join enrolls e on e.lecture_code = lec.lecture_code
group by lec.lecture_code, lec.name having count(*) > 3 order by lec.lecture_code


go

-- Dersi 3'den fazla kez alan öğrencinin kayıt olduğu derslerin not ortalamasını getiren sorgu
-- TODO: write function and give permission to umut
select lec.lecture_code, lec.name, avg(lec.credits * g.value) 
from lectures lec inner join enrolls e on e.lecture_code = lec.lecture_code
inner join grades g on g.grade_id=e.grade_id
group by lec.lecture_code, lec.name having count(*) > 3 order by lec.lecture_code


go


-- Login ddl

create login umut with password='123456'

go

use dbprogs21_schooldb

go

create user umut

go

grant select on get_students_grade_count_by_lecture_code to umut

go

grant execute on sp_insert_lecture to umut

go

grant select on v_students_group_by_lecture to umut