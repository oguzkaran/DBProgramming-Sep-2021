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
	- MAT 101 dersi için öğrencilerin sayını notlara göre gruplayarak getiren sorgu
	- Kredi toplamları 100'den büyük olan öğrencilerin bilgilerini getiren sorgu
	- Dersleri alan öğrencilerin sayısını derse göre gruplayan sorgu
	- Dersi 3'den fazla kez alan öğrencilerin kayıt olduğu derleri gruplayan sorgu
	- Dersi 3'den fazla kez alan öğrencinin kayıt olduğu derslerin not ortalamasını getiren sorgu
----------------------------------------------------------------------------------------------------------------------*/

