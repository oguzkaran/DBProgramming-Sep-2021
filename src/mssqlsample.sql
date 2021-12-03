/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Açıklanan fonksiyonları yazınız ve aşağıdaki tablo ile test ediniz:
		people
			- person_id
			- citizen_id
			- first_name
			- middle_name
			- family_name
			- marital_status
	- Parametresi ile aldığı 3(üç) tane yazıyı aralarına boşluk koyarak birleştirn ancak null değer varsa veya tamamı boşluk (whitespace)
	karakterleri içeriyorsa yazıya dahil etmeyen get_full_text fonksiyonunu yazınız

	- Parametresi ile aldığı person_id bilgisine göre citizen_id ve marital_status_text bilgilerini tablo olarak
	döndüren get_person_by_id fonksiyonunu yazınız
----------------------------------------------------------------------------------------------------------------------*/
create function get_marital_status_text_tr(@status int)
returns nvarchar(8)
as
begin		
	if @status = 0
		return 'evli'

	if @status = 1
		return 'bekar'

	if @status = 2
		return 'boşanmış'

	return 'belirsiz'		
end


go 

create table people (
	person_id int identity(1, 1) primary key,
	citizen_id char(11) not null,
	name nvarchar(100) not null,
	family_name nvarchar(100) not null,
	marital_status int not null
)


go

select dbo.hide_text_right(citizen_id, '*', 1) as citizen_id, 
dbo.hide_text_right(name, '*', 1) + ' '  +  dbo.hide_text_right(family_name, '*', 1) as fullname,
dbo.get_marital_status_text_tr(marital_status), marital_status
from people where marital_status is not null
