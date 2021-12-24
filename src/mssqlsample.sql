/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıdaki verilen tabloya ilişkin istenenleri yapınız. Tablo schollappdb veritabanı içerisinde
	olacaktır
	students:
		-citizen_id
		- first_name
		- middle_name
		- family_name
		- birth_date
		- register_date

	İstenen Sorgular:
		Not: İstenen tüm sorgular tablo döndüren fonksiyonlar biçiminde yazılacaktır
		- Okul dönemi Eylül ve Haziran arası olmak üzere doğum günü okul dönemi içerisinde olan öğrencileri 
		yaşlarıyla birlikte getiren sorgu

		- Doğum ay bilgisi kayıt ayı ile aynı olan öğrenciler getiren sorgu

		- Parametresi ile aldığı doğum tarihi bilgisine göre, doğum günü geçmiş ise -1, doğum günü henüz gelmemiş ise 1
		ve o gün doğum günü ise sıfır döndüren get_birth_day_status isimli fonksiyonu yazınız

		- Parametresi aldığı doğum tarihi bilgisine göre doğum gününe göre aşağıdaki gibi bir Türkçe mesaj döndüren
		get_birth_day_message fonksiyonunu yazınız:
		Doğum günü geçmiş ise "Geçmiş doğum gününüz kutlu olsun"
		Doğum günü henüz gelmemişse "Doğum gününüz şimdiden kutlu olsun"
		Doğum günü ise "Doğum gününüz kutlu olsun"

		Bu fonksiyonu sorgu içerisinde kullanarak test edebilirsiniz

		- Parametresi ile aldığı yaş eşik değerine göre eşik değerinden büyük ve küçük olanları yine parametresi ile
		aldığı iki yazı ile gösteren sorguyu döndüren get_students_with_age_status fonksiyonunu yazınız.
		Örneğin:
			select * from dbo.get_students_with_age_status(18, 'Reşit', 'Reşit Değil')		
----------------------------------------------------------------------------------------------------------------------*/
declare @month int = 2
declare @year int = 2020

declare @date date = DATEFROMPARTS(@year, @month, 1)
select EOMONTH(@date)
