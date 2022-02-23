/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: studenst tablosuna yaşı 18'den büyük olan öğrenci insert edilmeye çalışılırsa students_older
	tabosuna ekleyene insert trigger'ı yazınız
----------------------------------------------------------------------------------------------------------------------*/

create table students (
	student_id int primary key identity(1, 1),
	name nvarchar(100) not null,
	birth_date date not null
)

go

