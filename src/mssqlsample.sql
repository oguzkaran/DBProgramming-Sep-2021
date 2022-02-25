/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıda açıklanan 
	Tablolar:
		- devices
			- id
			- name
			- host
		- ports
			- id
			- device_id
			- port_num

	- Parametresi ile aldığı isim, host ve bir tane port numarasına göre cihazı ve port numarasını ekleyen
	sp_insert_device_with_port isimli procedure'ü yazınız

	- Procedure numarasının daha önce eklenip eklenmediğini ve port numarasının [1024, 65536] aralığında olduğunu 
	kontrol edecektir. 

	- Hata durumlarında tüm işlemler geri alınacaktır

	- Procedure transaction safe yapılacaktır
----------------------------------------------------------------------------------------------------------------------*/

create table students (
	student_id int primary key identity(1, 1),
	name nvarchar(300) not null,
	citizen_id char(11) unique check(LEN(citizen_id) = 11) not null,
	birth_date date not null
)


begin tran

declare @status int = 0

delete from students where student_id = 8

set @status = @@ERROR

if @status <> 0
	goto END_TRANSACTION

insert into students (name, citizen_id, birth_date) values ('Ayşe', '12345678900', '1978-05-13')

set @status = @@ERROR

if @status <> 0
	goto END_TRANSACTION

select @@IDENTITY

commit tran

END_TRANSACTION:
	if @status <> 0
		rollback tran

-- ...


 select * from students


