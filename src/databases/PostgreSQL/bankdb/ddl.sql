/*----------------------------------------------------------------------------------------------------------------------
    Sınıf Çalışması: Bir banka sistemine bir parçası olan aşağıdaki veri tabanını bankappdb isminda oluşturunuz
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
create table customers (
    customer_id serial primary key,
    citizen_number char(11) unique check(length(citizen_number) = 11) not null,
    number varchar(9) unique not null,
    first_name varchar(100) not null,
    middle_name varchar(100),
    family_name varchar(100) not null,
    birth_date date not null,
    married boolean default(false) not null,
    phone_number char(14) not null
);

create table cards (
    card_number char(16) primary key,
    customer_id integer references customers(customer_id) not null,
    expiry_month integer check(1 <= expiry_month and expiry_month <= 12) not null,
    expiry_year integer check(expiry_year >= 0) not null,
    security_code char(3) not null
);

