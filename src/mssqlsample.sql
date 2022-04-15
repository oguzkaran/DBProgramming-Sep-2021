/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıdaki veritabanını oluşturunuz ve sorulara ilişkin stored procedure (sp)'ları yazınız.
	cities:
		- city_id
		- name
	patients:
		- patient_id
		- name 
		- city_id
		- birth_date
	relations:
		- relation_id
		- description (Annesi, Babası, Çocuğu, Teyzesi, Halası, Amcası, Dayısı, Yeğeni, Kuzeni vs)
	companions:
		- companion_id
		- name
		- patient_id
		- relation_id 
	
	Sorular:
	1. Tüm patient_id'lere ilişkin hastaların isimlerini büyük harfe çeviren sp'yi yazınız
	2. İl id'sine göre hastaların refakatçi isimlerini küçük harfe çeviren sp'yi yazınız
	3. Belirli bir yaştan büyük olan hastaların refakatçi ve kendi isimlerini büyük harfe çeviren sp'yi yazınız
----------------------------------------------------------------------------------------------------------------------*/
create database patientscaredb

go

use patientscaredb

go

create table cities (
	city_id int primary key identity(1, 1),
	description nvarchar(50) not null
)

go

create table relations (
	relation_id int primary key identity(1, 1),
	description nvarchar(50) not null
)

go

create table patients (
	patient_id int primary key identity(1, 1),
	name nvarchar(100) not null,
	city_id int foreign key references cities(city_id),
	birth_date date not null
)

go

create table companions (
	companion_id int primary key identity(1, 1),
	name nvarchar(100) not null,
	patient_id int foreign key references patients(patient_id),
	relation_id int foreign key references relations(relation_id)
)

go

-- 1

create procedure sp_make_patients_name_upper 
as 
begin
	update patients set name = UPPER(name)	
end

go

-- 2

create procedure sp_make_companion_names_lower_by_city_id(@city_id int) --TODO: transaction safe yapınız
as
begin
	declare crs_patients cursor for select patient_id from patients where city_id = @city_id
	open crs_patients
	declare @patient_id int

	fetch next from crs_patients into @patient_id	

	while @@FETCH_STATUS = 0
	begin
		declare crs_companions cursor for select companion_id from companions where patient_id = @patient_id
		open crs_companions
		declare @companion_id int

		fetch next from crs_companions into @companion_id

		while @@FETCH_STATUS = 0
		begin
			update companions set name = LOWER(name) where companion_id = @companion_id
			fetch next from crs_companions into @companion_id
		end

		close crs_companions
		deallocate crs_companions
		fetch next from crs_patients into @patient_id	
	end

	close crs_patients
	deallocate crs_patients
end





