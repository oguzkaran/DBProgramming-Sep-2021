/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: students tablosuna yaşı 18'den büyük olan öğrenci insert edilmeye çalışılırsa older_students
	tabosuna ekleyen insert trigger'ı yazınız.
	Açıklamalar:
		- older_students için de aynı trigger yazılmalıdır
		- Trigger içerisinde hangi tabloya ekleme yapılıyorsa diğer tablodan o citizen_id bilgisinin varlığı kontrol
		edilmelidir, varsa ekleme yapılmamalıdır
----------------------------------------------------------------------------------------------------------------------*/

create table students (
	citizen_id char(11) primary key,
	name nvarchar(100) not null,
	birth_date date not null
)

go

create table older_students (
	citizen_id char(11) primary key,
	name nvarchar(100) not null,
	birth_date date not null
)

go

create trigger t_insert_student_instead_of on students
instead of insert
as
begin
	declare @birth_date date = (select birth_date from inserted)
	declare @age real = DATEDIFF(DAY, @birth_date, GETDATE()) / 365.

	if @age > 18
		insert into older_students (birth_date, citizen_id, name) (select birth_date, citizen_id, name from inserted)
	else
		insert into students (birth_date, citizen_id, name) (select birth_date, citizen_id, name from inserted)
end


go

insert into students (name, birth_date, citizen_id) values ('Oğuz Karan', '1976-09-10', '12345678912')
insert into students (name, birth_date, citizen_id) values ('Ali Veli', '2019-09-10', '12345678913')

select * from older_students
select * from students