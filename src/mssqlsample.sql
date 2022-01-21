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

create database shoppingdb

go

use shoppingdb

go

create table categories (
	category_id int primary key identity(1, 1),
	description nvarchar(50) not null
)

go

insert into categories (description) values ('Electronics'), ('Wear'), ('Auto')


go

create table products (
	product_id int primary key identity(1, 1),
	category_id int foreign key references categories(category_id),
	code varchar(100) unique not null,
	name nvarchar(100) not null,
	stock int check(stock >= 0) not null,
	cost money not null,
	price money not null
)

go

-- Stokta bulunan ürünleri ketegorilerine göre gruplanlayarak kar-zarar durumunu veren sorgu
select SUM(p.stock * (p.price - p.cost)), c.description from products p inner join categories c on p.category_id=c.category_id
where p.stock > 0 group by c.category_id, c.description

-- Stokta bulunan ürünleri kategorilerine göre gruplayarak en çok kar getiren ürünlerin fiyatlarını veren sorgu
select MAX(p.stock * (p.price - p.cost)), c.description from products p inner join categories c on p.category_id=c.category_id
where p.stock > 0 group by c.category_id, c.description having MAX(p.stock * (p.price - p.cost)) > 0

-- Stokta bulunan ürünleri kategorilerine göre gruplayarak en çok kar getiren ürünlerden maksimum karları 20000 den büyük olanların fiyatlarını veren sorgu
select MAX(p.stock * (p.price - p.cost)), c.description from products p inner join categories c on p.category_id=c.category_id
where p.stock > 0 group by c.category_id, c.description having MAX(p.stock * (p.price - p.cost)) > 20000