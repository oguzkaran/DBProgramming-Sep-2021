/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıdaki verilen tabloya ilişkin istenenleri yapınız. Tablo schoolappdb veritabanı içerisinde
	olacaktır
	students:
		- citizen_id
		- first_name
		- middle_name
		- family_name
		- birth_date
		- register_date

	İstenen Sorgular:
		Not: İstenen tüm sorgular tablo döndüren fonksiyonlar biçiminde yazılacaktır
		1. Okul dönemi Eylül ve Haziran arası olmak üzere doğum günü okul dönemi içerisinde doğmuş olan öğrencileri 
		yaşlarıyla birlikte getiren sorgu

		2. Doğum ay bilgisi kayıt ayı ile aynı olan öğrenciler getiren sorgu

		3. Parametresi ile aldığı doğum tarihi bilgisine göre, doğum günü geçmiş ise -1, doğum günü henüz gelmemiş ise 1
		ve o gün doğum günü ise sıfır döndüren get_birth_day_status isimli fonksiyonu yazınız

		4. Parametresi aldığı doğum tarihi bilgisine göre doğum gününe göre aşağıdaki gibi bir Türkçe mesaj döndüren
		get_birth_day_message fonksiyonunu yazınız:
		Doğum günü geçmiş ise "Geçmiş doğum gününüz kutlu olsun"
		Doğum günü henüz gelmemişse "Doğum gününüz şimdiden kutlu olsun"
		Doğum günü ise "Doğum gününüz kutlu olsun"

		Bu fonksiyonu sorgu içerisinde kullanarak test edebilirsiniz

		5. Parametresi ile aldığı yaş eşik değerine göre eşik değerinden büyük ve küçük olanları yine parametresi ile
		aldığı iki yazı ile gösteren sorguyu döndüren get_students_with_age_status fonksiyonunu yazınız.
		Örneğin:
			select * from dbo.get_students_with_age_status(18, 'Reşit', 'Reşit Değil')		
----------------------------------------------------------------------------------------------------------------------*/

create database schoolappdb

go

use schoolappdb

go

create table students (
	citizen_id char(20) primary key,	
	first_name nvarchar(100) not null,
	middle_name nvarchar(100),
	family_name nvarchar(100) not null,
	birth_date date not null,
	register_date date not null
	-- ...
)

go

create function get_age(@birth_date date)
returns real
as
begin
	return DATEDIFF(DAY, @birth_date, SYSDATETIME()) / 365.
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

-- 1

create function get_students_born_in(@start_month int, @end_month int)
returns table
as
return (
	select 
	dbo.get_full_name(first_name, middle_name, family_name) as fullname,
	citizen_id,
	dbo.get_age(birth_date) as age,
	birth_date
	-- ...
	from  students
	where MONTH(birth_date) between @start_month and @end_month
)

go

select * from students