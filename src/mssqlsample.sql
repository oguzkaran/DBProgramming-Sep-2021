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
		- ccv
		- card_type_id
		
	Sorular:
	- Parametresi ile aldığı müşteri numarasına göre müşterinin aşağıdaki bilgilerini tablo biçiminde döndüren 
	get_card_info_by_customer_number fonksiyonunu yazınız
		1. Adı Soyadı
		2. Kart numarası: ilk 4(dört) hanesi gözücek şekilde. Geri kalanlar X olarak
		3. ccv: İlk karakteri gözükecek şekilde. Geri kalanlar * olarak
		4. Kart türünün yazısal karşılığı
		5. Kartın son kullanma tarihi bilgisi: aa/yyyy
		6. Kart sahibinin personel olup olmadığı bilgisi
		7. Kartın sahibinin yaşayıp yaşamadığı bilgisi

	- Parametresi ile aldığı kart tür id'sine göre aktif olan ve yurt dışında ikamet eden müşterilerin aşağıdaki bilgilerini tablo
	biçiminde döndüren get_nonlocal_customer_info_by_card_type fonksiyonunu yazınız:
		1. Adı Soyadı
		2. Kart numarası: ilk 4(dört) hanesi gözücek şekilde. Geri kalanlar X olarak
		3. ccv: İlk karakteri gözükecek şekilde. Geri kalanlar * olarak
		4. Kart türünün yazısal karşılığı
		5. Kartın son kullanma tarihi bilgisi: aa/yyyy
		6. Kart sahibinin personel olup olmadığı bilgisi
		7. Kartın sahibinin yaşayıp yaşamadığı bilgisi
		8. Müşterini uyruğu



----------------------------------------------------------------------------------------------------------------------*/
