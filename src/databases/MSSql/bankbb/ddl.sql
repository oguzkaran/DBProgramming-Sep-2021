/*----------------------------------------------------------------------------------------------------------------------
    Sınıf Çalışması: Bir banka sistemine bir parçası olan aşağıdaki veri tabanını bankappdb isminde oluşturunuz
    Müşteri bilgileri aşağıdaki gibi olacaktır:
  - T.C. Kimlik numarası
  - Müşteri Numarası
  - Adı
  - İkinci Adı
  - Soyadı
  - Doğum Tarihi
  - Medeni Durumu
  - Telefon Numarası

  Kart bilgileri aşağıdaki gibi olacaktır
  - Kart Numarası
  - Son kullanma ay bilgisi
  - Son kullanma yıl bilgisi
  - security_code

  Not: Bu veritabanı ileride normalize edilecektir
----------------------------------------------------------------------------------------------------------------------*/

create database bankdb

go

use bankdb

go

create table customers (
	customer_id int primary key identity(1, 1),
	citizen_number char(11) unique check(len(citizen_number) = 11) not null,
	number varchar(9) unique not null,
	first_name nvarchar(100) not null,
	middle_name nvarchar(100),
	family_name nvarchar(100) not null,
	birthdate date not null,
	married bit default(0) not null,
	phone_number char(14) not null
)

go

create table cards (
	card_number char(16) primary key,
	customer_id int foreign key references customers(customer_id) not null,
	expiry_month int check(1 <= expiry_month and expiry_month <= 12) not null,
	expiry_year integer check(expiry_year >= 0) not null,
    security_code char(3) not null
)
